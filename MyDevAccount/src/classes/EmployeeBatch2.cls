global class EmployeeBatch2 implements Database.Batchable<sObject> {

	List<String> employeeNames;
	public EmployeeBatch2(){}
	
	public EmployeeBatch2(List<String> employeeNames){
		this.employeeNames = employeeNames;
	}

	// First method 
	global Database.Querylocator start(Database.BatchableContext bc){
		system.debug('start() method of EmployeeBatch2 invoked.');
		
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
		return Database.getQueryLocator('SELECT id, name, FirstName__c, LastName__c, DepartmentId__c from Employee__c'); // 50 million records
	}

	/* global Iterable<sObject> start(Database.BatchableContext bc){
		return new 
	}*/
	// Second method
	global void execute(Database.BatchableContext bc, List<sObject> scope){
			system.debug('execute() method of EmployeeBatch2 invoked.');
			List<Employee__c> empList = (List<Employee__c>)scope;
			
			Set<String> empNames = new Set<String>();
			empNames.addAll(employeeNames);
			
			for(Employee__c emp: empList){
				if(empNames.contains(emp.FirstName__c+' '+emp.LastName__c))
					emp.DepartmentId__c = 1;
			}
			update empList;
	}
	
	// Third method
	global void finish(Database.BatchableContext bc){
		system.debug('finish of of EmployeeBatch2 invoked.');
	}
	

}