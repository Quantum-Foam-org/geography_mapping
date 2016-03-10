<?php
$common_php_dir = realpath ( '../../../php_common' );
$common_autoload_file = $common_php_dir . '/autoload.php';
require ($common_autoload_file);

$php_cli_dir = realpath ( '../../../php_cli' );
$php_cli_autoload_file = $php_cli_dir . '/autoload.php';
require ($php_cli_autoload_file);

use \common\curl\Main as curl;
use \cli\classes as cli;
use \common\db\Main as db;

$config = common\Config::obj ( __DIR__ . '/config/config.ini' );
class SqlOpt extends cli\Flag {
	protected $user;
	protected $pass;
	protected $name;
	protected $table_state;
	protected $table_boundaries;
	protected $file = - 1;
	protected $config = array (
			'user' => array (
					FILTER_UNSAFE_RAW 
			),
			'pass' => array (
					FILTER_UNSAFE_RAW 
			),
			'name' => array (
					FILTER_SANITIZE_STRING 
			),
			'table_state' => array (
					FILTER_SANITIZE_STRING 
			),
			'table_boundaries' => array (
					FILTER_SANITIZE_STRING 
			),
			'file' => array (
					FILTER_SANITIZE_STRING 
			) 
	);
}

$opt = new SqlOpt ();

$opt->exchangeArray ( array_slice ( $argv, 1 ) );

$dbopts = [ 
		'user',
		'pass',
		'name',
		'table_state',
		'table_boundaries' 
];
foreach ( $dbopts as $k => $dbopt ) {
	if (! $opt->{$dbopt}) {
		if (isset ( $config->system ['db_' . $dbopt] ) && strlen ( $config->system ['db_' . $dbopt] ) > 0) {
			$opt->{$dbopt} = $config->system ['db_' . $dbopt];
		} else {
			echo "Set --{$dbopt} to continue\n";
			exit ( ( int ) '-' . ($k + 1) );
		}
	}
}

if ($opt->file === - 1 || $opt->file === FALSE) {
	echo "You can set a file by using --file that will store the contents of the query into a file\n";
	exit ( ( int ) '-' . ++ $k );
}

define ( 'DB_DSN', 'mysql:host=localhost;dbname=' . $opt->name );
define ( 'DB_USER_NAME', $opt->user );
define ( 'DB_USER_PASS', $opt->pass );
class InsertTigerState {																		
	private $sqlOpt;

	public function __construct(SqlOpt $opt) {
		$this->sqlOpt = $opt;
		
		echo "Using TIGER 2015 File " . $this->sqlOpt->file . "\n";
		echo "Inserting as user " . $this->sqlOpt->user . "\n";
		echo "Using database name " . $this->sqlOpt->name . "\n";
		echo "Using table for state data " . $this->sqlOpt->table_state . "\n";
		echo "Using table for state boundaries " . $this->sqlOpt->table_boundaries . "\n";
	}
	public function run() {
		$db = db::obj ();
		try {
			$f = new SplFileObject ( $this->sqlOpt->file, 'r' );
			$f->setFlags ( SplFileObject::SKIP_EMPTY | SplFileObject::DROP_NEW_LINE );
			$headers = array_slice ( array_map ( function ($v) {
				return strtolower ( $v );
			}, $f->fgetcsv () ), 0, 12 );
			$headers [] = 'intptlatlon';
			$db->query ( 'TRUNCATE TABLE ' . $this->sqlOpt->table_state );
			while ( ($row = $f->fgetcsv ()) ) {
				$values = array_slice ( $row, 0, 12 );
				$point = "ST_PointFromText('POINT({$row[12]} {$row[13]})')";
				try {
					$sth = $db->getSth ( 'INSERT INTO `' . $this->sqlOpt->table_state . '` (`' . implode ( '`, `', $headers ) . '`) VALUES(?' . str_repeat ( ', ?', count ( $values ) - 1 ) . ', ' . $point . ')', $values );
				}
	            catch ( \RuntimeException $e ) {
	            	\common\logging\Logger::obj()->writeException($e);
	            }
			}
			unset ( $row, $values );
		} catch ( RuntimeException $e ) {
			echo $e->getMessage ();
			exit ( $e->severity );
		} finally {
			unset ( $f, $md5, $fileName );
		}
		unset ( $db );
	}
}

$its = new InsertTigerState ( $opt );
$its->run ();

