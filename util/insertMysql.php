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
		
		echo "Using State TIGER 2015 SHP File " . $this->sqlOpt->file . "\n";
		echo "Inserting as user " . $this->sqlOpt->user . "\n";
		echo "Using database name " . $this->sqlOpt->name . "\n";
		echo "Using table for state data " . $this->sqlOpt->table_state . "\n";
		echo "Using table for state boundaries " . $this->sqlOpt->table_boundaries . "\n";
	}
	
	private function shpOp() {
		if (is_readable( $this->sqlOpt->file )) {
			$finfo = new finfo (FILEINFO_MIME);
			$pathInfo = pathinfo ( $this->sqlOpt->file );
			if ($finfo->file ( $this->sqlOpt->file ) !== 'application/octet-stream; charset=binary' || 
					$pathInfo ['extension'] !== 'shp') {
				echo "File must be a ESRI Shape File\n";
				exit ( ( int ) '-' . __LINE__ );
			}
			unset ( $finfo );
		} else {
			echo "Unable to open file\n";
			exit ( ( int ) '-' . __LINE__ );
		}
		
		$shpFile = realpath ( $this->sqlOpt->file );
		
		$tmpCsvFileState = sys_get_temp_dir().'/insertMysql_state.csv';
		
		if ($this->createCSV ( $shpFile, $tmpCsvFileState ) < 0) {
			echo "Unable to create CSV file of TIGER State information\n";
			exit ( (int)'-'.__LINE__ );
		} else {
			echo "Created CSV file of TIGER State information\n";
		}
		
		$tmpCsvFileBound = sys_get_temp_dir().'/insertMysql_bound.csv';
		try
		{
			$tmpCsvFile = new SplFileObject($tmpCsvFileBound, 'w');
				
			if ($this->createGeom ( $shpFile, $tmpCsvFile) < 0) {
				echo "Unable to create Geometry files of TIGER State information\n";
				exit ((int)'-'.__LINE__);
			} else {
				echo "Created Geometry files of TIGER State information\n";
			}
			
		} catch (RuntimeException $e)
		{
			exit((int) '-'.\common\logging\Logger::obj ()->writeException ( $e ) );
		} finally {
			unset($this->tmpCsvFile);
		}
		
		return [$tmpCsvFileState, $tmpCsvFileBound];
	}
	
	private function createCSV($shpFile, $tmpCsvFile) {
		$cmd = 'ogr2ogr -f CSV ' . escapeshellarg($tmpCsvFile) . ' ' .  escapeshellarg($shpFile);
		\common\logging\Logger::obj()->write('Running command: '.$cmd);
		passthru ( $cmd, $ret );
		
		return $ret;
	}
	
	private function createGeom($shpFile, SplFileObject $tmpCsvFile) {
		// get feature count
		ob_start();
		$cmd = 'ogrinfo  -so '. escapeshellarg($shpFile).'  tl_2015_us_state';
		\common\logging\Logger::obj()->write('Running command: '.$cmd);
		passthru( $cmd, $ret);
		$output = ob_get_contents();
		ob_end_clean();
		
		if (preg_match('/Feature\sCount:\s(\d+)/', $output, $matches) === 1 && 
				($fids = filter_var($matches[1], FILTER_VALIDATE_INT))) {
			
			\common\logging\Logger::obj()->write('Features: '.$fids);
			
			for ($fid = 0; $fid < $fids; $fid++) {
				ob_start();
				$cmd = 'ogrinfo -fid '. $fid.' '. escapeshellarg($shpFile).' tl_2015_us_state | grep POLYGON';

				\common\logging\Logger::obj()->write('Running command: '.$cmd);
				passthru($cmd, $ret );
				if ($ret >= 0) {
					\common\logging\Logger::obj()->write('Writing Feature: '.$fid);
					$output = trim(ob_get_contents());
					$tmpCsvFile->fputcsv([$fid, $output]);
				} else {
					echo "Unable to write feature $fid to output file\n";
				}
				ob_end_clean();
			}
		} else {
			echo "Unable to determine the feature count of the shape file\n";
			exit((int)'-'.__LINE__);
		}
		
		return $ret;
	}
	
	public function run() {
		$db = db::obj ();
		
		list($tmpCsvFileState, $tmpCsvFileBound) = $this->shpOp();
		
		try {
			$f = new SplFileObject ( $tmpCsvFileState, 'r' );
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
				} catch ( \RuntimeException $e ) {
					\common\logging\Logger::obj ()->writeException ( $e );
				}
			}
			unset ( $row, $values );
		} catch ( RuntimeException $e ) {
			exit ((int)'-'. \common\logging\Logger::obj ()->writeException ( $e ) );
		} finally {
			unset ( $f, $md5, $fileName );
		}
		unset ( $db );
		unlink($tmpCsvFileState);
		unlink($tmpCsvFileBound);
	}
}

$its = new InsertTigerState ( $opt );
$its->run ();

