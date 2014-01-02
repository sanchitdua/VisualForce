global class EmployeeIterator implements Iterator<sObject>{
	
	sObject[] results;
	Integer index;
	
	global EmployeeIterator(){
		index = 0;
		String query ='select id, name, jobTitleId__c from Employee__c';
		results = Database.query(query);
	} // END init
	
	// Override
	global boolean hasNext(){
		return results!=null && results.isEmpty() && index<results.size();	
	}
	
	// Override
	global sObject next(){
		return results[index+2];
	}
	
}