<?php
$regex = '/^([a-zA-Z0-9\/]?)+[a-zA-Z0-9_]+\.{1}[a-z]+$/';  /// test for file name validity (not complete)
$delimieter = array('|', "\t");

if (preg_match($regex, $argv[1]) === 1 && preg_match($regex, $argv[2]) === 1)
{
    try
    {
        $values = array();
        $s1 = new SplFileObject($argv[1], 'r');
        $s1->setFlags(SplFileObject::SKIP_EMPTY | SplFileObject::DROP_NEW_LINE);
        if ($s1->isFile() && $s1->isReadable())
        {
            $s1->seek(1);
            while(($row = $s1->fgetcsv($delimieter[0]))) 
            {
                $data = array($row[7], $row[8]);
                if (!in_array($data, $values))
                {
                    $values[] = $data;
                    
                }
            }
            unset($row);
            usort($values, function($a, $b)
            {
                return $a[0] > $b[0];
            });
            
            try
            {
                $s2 = new SplFileObject($argv[2], 'w');
                $s2->fputcsv(array('id', 'code'), $delimieter[1]);
                
                foreach ($values as $data) {
                    $s2->fputcsv($data, "\t");
                }
            } catch (RuntimeException $e)
            {
                echo $e->getMessage();
                exit($e->severity);
            } finally {
                unset($s2);
            }
            
            unset($data, $values);
        }
    } catch (RuntimeException $e)
    {
        echo $e->getMessage();
        exit($e->severity);
    }
    unset($e, $s1);
}
unset($regex, $delimieter);

//var_dump(memory_get_peak_usage(TRUE));

exit(0);