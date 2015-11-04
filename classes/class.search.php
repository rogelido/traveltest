<?php

/**
 * Represents a search against a database
 *
 * @author Pere
 */

class Search {
	
	public $textToSearch;
	public $results = array();
	public $stablishmentTypeList = array();
	
	function __construct($textToSearch){
		$this->textToSearch = $textToSearch;
		$this->getConcretStsTableNames();
	}
	
	private function getConcretStsTableNames(){
		$this->stablishmentTypeList = array();
		$SQL =	"SELECT * FROM stablishTypes ".
				"ORDER BY name ASC";
		$rows = getTable($SQL);
		foreach($rows as $row){
			$this->stablishmentTypeList[$row['id']] = $row['tableName'];
		}
	}
	
	/*
	 * Performs a search and gets its matching results
	 */
	public function perform(){	
		$values = array(0 => '%'.addcslashes($this->textToSearch, '%_\\').'%');
		
		$SQL =	"SELECT s.*, st.name AS stName, st.tableName, st.id as stId ".
				"FROM stablishments s ".
				"LEFT JOIN stablishTypes st ".
				"ON s.type_id = st.id ".
				"WHERE s.name LIKE ? ".
				"ORDER BY s.name ASC";				
		try {
			$rows = dbPrepareGetTable($SQL,$values);
		}
		catch(Exception $e){
			throw new Exception('Unable to obtain results from database when trying to perform a search query. '.$e->getMessage());
		}
		
		foreach($rows as $row){
			$line = ucfirst($row['stName'])." ".$row['name'].", ";
			if(strtolower($row['stName'])=='hotel'){
				$row2 = $this->completeInfoForHotel($row['concreteSt_id']);
				$line.= $row2['stars'].' estrella(s), '.$row2['description'];
			}
			else{
				$row2 = $this->completeInfoForApart($row['concreteSt_id']);
				$line.= $row2['availableRooms'].', apartamento(s), '.$row2['adultCapacity'].' adulto(s)';
			}
			$line.= ", ".$row['city'].", ".$row['prov'];
			$this->results[] = $line;
		}
	}

	private function completeInfoForHotel($hotelId){
		$SQL =	"SELECT h.*, sr.description, sr.adultCapacity ".
				"FROM hotels h ".
				"LEFT JOIN standardRooms sr ".
				"ON h.standardRoom_id = sr.id ".
				"WHERE h.id = ".$hotelId;
		try{
			$row = getRow($SQL);
		} 
		catch (Exception $e) {
			Throw new Exception("Unable to get hotel info from database");
		}
		if(!$row){
			Throw new Exception("An hotel doesn't exist in the database");
		}
		return $row;
	}

	private function completeInfoForApart($apartId){
		$SQL =	"SELECT * FROM apartments a ".
				"WHERE id = ".$apartId;
		try{
			$row = getRow($SQL);
		} 
		catch (Exception $e) {
			Throw new Exception("Unable to get apartment info from database");
		}
		if(!$row){
			Throw new Exception("An apartment doesn't exist in the database");
		}
		return $row;
	}
}
