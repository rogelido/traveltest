<?php

// global variables
$msq = NULL;

// Initalizes the SQL connection based on global config variables
function initSQL($config) {
	global $msq;
	if ($msq != NULL) return;
	
	$connString0 = 'mysql:host='.$config['bdaHost'].';dbname='.$config['bdaName'].';charset='.$config['charset'];
	$connString1 = $config['bdaUser'];
	$connString2 = $config['bdaPass'];
	try {
		$msq = new PDO($connString0,$connString1,$connString2);
	}
	catch(Exception $e){
		throw new Exception('Error intentando crear la conexión a la base de datos'); //
	}
	$msq->exec("SET NAMES ".$config['charset']);
	return true;
}

/*
 * @return new record id if successfull if INSERT; true if UPDATE
 */
function dbPrepareCommit($query, $arra){
	global $msq;
	$sth = $msq->prepare($query);
	$resp = @$sth->execute($arra);
	if($resp===false) {
		throw new PDOException("Unable to prepare and insert in database: ".$query."\n");
	}
	if(substr(strtoupper(trim($query)),0,6)=="INSERT"){
		return $msq->lastInsertId();
	}
	else { // UPDATE
		return true;
	}
}

/*
 * @return full table using prepared statements
 */
function dbPrepareGetTable($query, $arra){
	global $msq;
	$stmt = $msq->prepare($query);
    $resp = @$stmt->execute($arra);    
	if ($resp===false) {
		throw new PDOException("Unable to obtain rows: ".$query."\n");
	}
	$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
	return $rows;
}

function getRow($query){
	global $msq; 
	$qres=$msq->query($query);
	if ($qres===false) {
		$k = $msq->errorInfo();
		throw new PDOException("Unable to get row"); //: ".$query."; ".$k."\n");
	}
	$res = $qres->fetch();
	return $res;
}

/*
 * @return full list of matching rows
 */
function getTable($query) {
	global $msq; 
	$qres=$msq->query($query);
	if ($qres===false) {
		$k = $msq->errorInfo();
		throw new PDOException("Unable to get rows"); //: ".$query."; ".$k."\n");
	}
	$res = $qres->fetchAll(PDO::FETCH_ASSOC);
	return $res;
}


