<?php

include('include/config.php');
include('classes/databasePDO.php');
include('classes/class.search.php');
include('classes/class.searchEngine.php');

initSQL($config);

echo "\nPlease enter at least the first 3 letters of the lodging you are searching for and press enter to start: \n";

$handler = fopen('php://stdin','r');
$toSearch = trim(fgets($handler));
fclose($handler);

if(empty($toSearch)){
	echo "\nNo text provided. Ending.\n";
	exit(0);
}

if(strlen($toSearch)<3){
	echo "\nMinimum length size must be 3 characters.\n";
}

$clean = filter_var($toSearch,FILTER_SANITIZE_STRING);
mb_internal_encoding("UTF-8");
$results = SearchEngine::performSearch(mb_substr($clean,0,3));

if(count($results)==0){
	echo "No results found. Ending.\n";
	exit(0);
}

echo	"Match(s) found!\n".
		"------------\n";
foreach($results as $result){	
	echo $result."\n";
}

exit(0);