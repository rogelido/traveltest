<html>
<?php

include('include/config.php');
include('classes/databasePDO.php');
include('classes/class.search.php');
include('classes/class.searchEngine.php');

initSQL($config);

$handler = fopen('php://stdin','r');
$toSearch = "وا";
mb_internal_encoding("UTF-8");
$results = SearchEngine::performSearch(mb_substr($toSearch,0,3));

if(count($results)==0){
	echo "Keyword(s) not found. Ending.\n";
	exit(0);
}

echo "<pre>Match found!\n".
	"------------\n</pre>";

foreach($results as $result){
	echo $result."\n";
}
?>
</html><?php
exit(0);