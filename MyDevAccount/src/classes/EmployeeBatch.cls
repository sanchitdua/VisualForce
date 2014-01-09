global class EmployeeBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
	
	// ▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄
    // ▀▄▀▄   initialState is the initial state of the class. 										     ▀▄▀▄
    // ▀▄▀▄   You cannot use it to pass information between instances of the class during execution      ▀▄▀▄
    // ▀▄▀▄   of the batch job. For example, if you changed the value of initialState in execute,        ▀▄▀▄
    // ▀▄▀▄   the second chunk of processed records would not be able to access the new value:           ▀▄▀▄
    // ▀▄▀▄   only the initial value would be accessible.                                                ▀▄▀▄
    // ▀▄▀▄   ref: http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_batch_interface.htm ▀▄▀▄
    // ▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄
    
    // We try to implement the Datatabase.Stateful or not, the initialState is going to be obtained in the finish() method.
	private final boolean initialState;
	
	// variables
	global List<String> employeeNames;
	
	public EmployeeBatch(){
		initialState = false;
	} // END init()
	
	// intentionally supplied "true"
	public EmployeeBatch(Boolean iState){
		this.initialState = iState;
	} // End init(Boolean initialState)
	
	
	// First method 
	global Database.Querylocator start(Database.BatchableContext bc){
		system.debug('start() method invoked.');
		return Database.getQueryLocator('SELECT id, name, city__c, zipcode__c, FirstName__c, LastName__c, JobTitleId__c from Employee__c WHERE zipCode__c <> NULL limit 10'); // 50 million records
	}
	
	/* global Iterable<sObject> start(Database.BatchableContext bc){
		return new EmployeeIterable(); 
	}*/
	// Second method
	global void execute(Database.BatchableContext bc, List<sObject> scope){ 
			
        	
        	List<Employee__c> empList = (List<Employee__c>)scope;
			List<Employee__c> empToUpdate = new List<Employee__c>();
			for(Employee__c emp: empList){
				GeoFutureCallout.callout(emp.ZipCode__c);
                emp.City__c = GeoFutureCallout.cityName;
                    
				empToUpdate.add(emp);
			}
        	update empToUpdate;
			/* system.debug('execute() method invoked.');
			List<Employee__c> empList = (List<Employee__c>)scope;
			
			for(Employee__c emp: empList){
				emp.JobTitleID__c = emp.Name;
				employeeNames.add(emp.FirstName__c+' '+emp.LastName__c);
				
			}
			update empList;
			// As far as my understanding the initialState can be used to get the value of the variable at class level 
			// first time. we can even obtain those inside the final method.
			system.debug(initialState ? 'Yes' : 'No'); */
			
	}
	
	// Third method
	global void finish(Database.BatchableContext bc){
		system.debug('finish of EmployeeBatch invoked.');
		// Test the following statement by removing the Database.Stateful, it would also return "true", while the variable named "employeeNames" can't be obtained in finish() method if the Database.Stateful is not implemented.
		system.debug(initialState ? 'Yes' : 'No');
		// The employees are only obtained if and only if the Database.Stateful is implemented.
		
		if(employeeNames != null && !employeeNames.isEmpty()){
			system.debug('The employees are: ');
			Iterator<String> itr = employeeNames.iterator();
		
			while(itr.hasNext()){
				String str = itr.next();
				
				system.debug('EmployeeName: '+str);
				
			}
		}
		else{
			system.debug('No employees exists.');
		}	
		system.debug('calling the next batch ...');
		// EmployeeBatch2 eb = new EmployeeBatch2(employeeNames);
		// Database.executeBatch(eb);
	}
	
}