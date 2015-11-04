<?php

/**
 * Class representing a search engine
 * 
 * @author Pere
 * 
 */

class SearchEngine {
	
	/*
	 * Get a string of terms to search, search them against some texts stored in database and return a list of matching texts, with highlighted keywords
	 */
	public static function performSearch($textToSearch){
		$search = new Search($textToSearch);
		$search->perform();
		return $search->results;
	}
}
