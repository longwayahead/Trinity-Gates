<?php
class Database {
	public static $instance = null;

	private  	$_pdo = null,
				$_query = null,
				$_error = false,
				$_results = null,
				$_count = 0,
				$_whereString = null;


	private function __construct() {
		try {
			$this->_pdo = new PDO('mysql:host=localhost;dbname=open_gate','root','');
		} catch(PDOExeption $e) {
			die($e->getMessage());
		}
	}

	public static function getInstance() {
		// Already an instance of this? Return, if not, create.
		if(!isset(self::$instance)) {
			self::$instance = new Database();
		}
		return self::$instance;
	}

	public function query($sql, $params = array()) {
		$this->_results = null;
		$this->_count = 0;
		$this->_whereString = null;
		$this->_error = false;
		if($this->_query = $this->_pdo->prepare($sql)) {
			$x = 1;
			if(count($params)) {

				foreach($params as $param) {
					foreach($param as $value) {
						$this->_query->bindValue($x, $value);
						$x++;
					}
				}
			}

			if($this->_query->execute()) {
				$this->_results = $this->_query->fetchAll(PDO::FETCH_OBJ);
				$this->_count = $this->_query->rowCount();
			} else {
				$this->_error = true;
			}
		}

		return $this;
	}

	public function insert($table, $fields = array()) {
		$keys 	= array_keys($fields);
		$values = null;
		$x 		= 1;

		foreach($fields as $value) {
			$values .= "?";
			if($x < count($fields)) {
				$values .= ', ';
			}
			$x++;
		}

		$sql = "INSERT INTO {$table} (`" . implode('`, `', $keys) . "`) VALUES ({$values})";

		if(!$this->query($sql, [$fields])->error()) {
			return true;
		}

		return false;
	}

	public function update($table, $fields = array(), $whereArray = array()) {
		$set 	= null;
		$x		= 1;
		foreach($fields as $name => $value) {
			$set .= "{$name} = ?";
			if($x < count($fields)) {
				$set .= ', ';
			}
			$x++;
		}

		$where = $this->where($whereArray);

		$binds = array_merge($fields, $where[1]);

		$sql = "UPDATE {$table} SET {$set} WHERE {$where[0]}";
		if(!$this->query($sql, [$binds])->error()) {
			return true;
		}

		return false;
	}

	public function where($whereArr = array()) { //where[0] = sql. where[1] = params for binding
		$whereString = $this->_whereString;
		foreach($whereArr as $key=>$value) {

			if(count($value) === 3) {
				$operators = array('=', '>', '<', '>=', '<=', '<>', 'LIKE');

				$field 		= $value[0];
				$operator 	= $value[1];
				$values[] 	= $value[2];
				if(in_array($operator, $operators)) {
					$whereString .= $field . $operator . "?";
				}
			}
			if($key != array_search(end($whereArr), $whereArr)) {
				$whereString .= " AND ";
			}
		}
		$where[0] = $whereString;
		$where[1] = $values;
		return $where;
	}

	public function results() {
		// Return result object
		return $this->_results;
	}

	public function first() {
		return $this->_results[0];
	}

	public function count() {
		// Return count
		return $this->_count;
	}

	public function error() {
		return $this->_error;
	}
}

class Holidays {
  private $_db,
          $_url = "http://www.webcal.fi/cal.php?id=212&format=json&start_year=current_year&end_year=2021&tz=Europe%2FDublin";

  public function __construct() {
    $this->_db = Database::getInstance();
  }

  public function populate() {
    $url = $this->_url;
    $file = json_decode(file_get_contents($this->_url));
    foreach($file as $f) {
      $this->_db->insert('holidays', array('date' => $f->date, 'name' => $f->name));
    }
  }
}


class Gates {
  private $_db;
  public $day;

  public function __construct() {
    $this->_db = Database::getInstance();
  }
  public function get() {
    $out = $this->_db->query("SELECT g.id, g.name, g.latitude, g.longitude,
					IF(m.id IS NULL, tb.time_from, x.time_from) as time_from,
					IF(m.id IS NULL, tb.time_until, x.time_until) as time_until
					FROM gates g

					LEFT JOIN (times t, days d, time_blocks tb, dates u) ON (t.gate_id = g.id AND d.id = t.day AND tb.id = t.time AND u.id = t.date AND (MONTH(CURDATE()) BETWEEN MONTH(u.date_from) AND MONTH(u.date_until) AND DAY(CURDATE()) BETWEEN DAY(u.date_from) AND DAY(u.date_until)) AND CURTIME() BETWEEN tb.time_from and tb.time_until AND
						(
							CASE CURDATE()
								WHEN (SELECT date from holidays WHERE date = CURDATE() AND EXISTS(SELECT * from times LEFT JOIN days ON days.id = times.day WHERE days.hol = 1 AND times.gate_id = g.id)) THEN d.hol = 1
							ELSE
								CASE DAYOFWEEK(NOW())
									WHEN 1 THEN d.sun = 1
									WHEN 2 THEN d.mon = 1
									WHEN 3 THEN d.tue = 1
									WHEN 4 THEN d.wed = 1
									WHEN 5 THEN d.thu = 1
									WHEN 6 THEN d.fri= 1
									WHEN 7 THEN d.sat = 1
								END
							END
						)
					)
					LEFT JOIN (times m, dates q) ON (q.id = m.date AND CURDATE() BETWEEN q.date_from and q.date_until AND m.gate_id = g.id)
					LEFT JOIN (times b, dates i, time_blocks x) ON (b.gate_id = g.id AND i.id = b.date AND x.id = b.time AND CURDATE() BETWEEN i.date_from AND i.date_until AND CURTIME() BETWEEN x.time_from AND x.time_until)
					GROUP BY g.id

  ");

    if($out->count()) {
      return $out->results();
    }

  }

}
?>


    <?php


    try{
      $g = new Gates;
			$gates = $g->get();
			// echo '<pre>';
			// print_r($gates);
			// echo '</pre>';
			$map = null;
			 foreach($gates as $gate) {

				 $map .= '[\'' . $gate->name . '\', ' . $gate->latitude . ', ' . $gate->longitude . ', \'';

				 $map .= ($gate->time_from != null) ?  date('g.ia', strtotime($gate->time_from)) : '';
				  $map .= '\', \'';
					 $map .= ($gate->time_until != null) ? date('g.ia', strtotime($gate->time_until)) : '';
					 $map .= '\', ';
				 $map .= ($gate->time_from != null) ? '\'green-dot.png\'' : '\'red-dot.png\'';
				 $map .= ']';
				 if($gate != end($gates)) {
				 	$map .= ',';
				 }
			 }


    } catch(Exception $e) {
      echo $e->getMessage();
    }

    ?>

		<!DOCTYPE html>
		<html>
		  <head>
		    <title>Trinity Gates	</title>
		    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
		    <meta charset="utf-8">
				<meta name="apple-mobile-web-app-capable" content="yes">
				<script src="http://maps.google.com/maps/api/js"
          type="text/javascript"></script>
		    <style>
		      html, body {
		        height: 100%;
		        margin: 0;
		        padding: 0;
		      }
		      #map {
		        height: 100%;
		      }
		    </style>
		  </head>
		  <body>
				<body>
  <div id="map"></div>

  <script type="text/javascript">
    var gates = [
			<?php echo $map; ?>
    ];

		var markersURL = 'http://maps.google.com/mapfiles/ms/icons/';



		  var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 16,
      center: new google.maps.LatLng(53.343743, -6.254356),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
    	disableDefaultUI: true
    });

    var infowindow = new google.maps.InfoWindow();

    var marker, i;

    for (i = 0; i < gates.length; i++) {
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(gates[i][1], gates[i][2]),
        map: map,
				icon: markersURL + gates[i][5]
      });




      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
					if(gates[i][3] != 0) {
						infowindow.setContent('<div><strong>' + gates[i][0] + '</strong><br>Closes at ' + gates[i][4] + '</div>');
					} else {
						infowindow.setContent('<div><strong>' + gates[i][0] + '</strong><br>Closed</div>');
					}
          infowindow.open(map, marker);
        }
      })(marker, i));
    }

  </script>

		  </body>
		</html>
