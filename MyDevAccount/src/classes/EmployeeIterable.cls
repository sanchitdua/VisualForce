global  class EmployeeIterable implements Iterable<sObject>{
	// override 
	global Iterator<sObject> iterator(){
		return new EmployeeIterator();
	}
}