trigger RollupSalaries on Employee__c (before update, before insert, before delete) {
	
	if(!Trigger.isDelete){
		
		List<Organization__c> orgToUpdate = new List<Organization__c>();
	
		List<Employee__c> newRecords = new List<Employee__c>();
		
		Set<Id> orgIds = new Set<Id>();
		// employee ids 
		Set<Id> empIds = new Set<Id>();
		
		// upcoming records going to be updated
		for(Employee__c emp:  Trigger.new){
			if(emp.OrgId__c != null){
				newRecords.add(emp);
				orgIds.add(emp.OrgId__c);
				empIds.add(emp.id);
			}
		}
	
		
		// Querying over the beloging parent records for making Salary Summary Operations
		List<Organization__c> orgList = [SELECT id, name, SalarySum__c FROM Organization__c WHERE id in: orgIds];
		
		// Querying over the already present Employee Records under the same Organization
		List<Employee__c> empOldList = [
					SELECT 
						id, name, Salary__c, Job__c, OrgId__c 
							FROM 
								Employee__c 
									WHERE 
										id not in: empIds 
											and 
										OrgId__c in: orgIds];
		
		
		system.debug('number of old employees: '+empOldList.size());
		
		// reference of Parent with the summation of salaries
		Map<Id, Decimal> idWithSum = new Map<Id, Decimal>(); 
		// --> This collection is going to hold the Organization reference with the sum of salary
		
		
		// Iterating over the upcoming records again to obtain the Salary summary
		for(Employee__c emp: newRecords){
			// means the map doesn't contain a record belonging to this parent reference
			if(idWithSum.get(emp.OrgId__c) == null){
				idWithSum.put(emp.OrgId__c, emp.Salary__c);
			} else{
				Decimal empSalary = idWithSum.get(emp.OrgId__c);
				empSalary = empSalary + emp.Salary__c;
				idWithSum.put(emp.OrgId__c, empSalary);
			}
		}
		
		// Iterating over the already records again to obtain the Salary summary
		for(Employee__c emp: empOldList){
			system.debug('iterating over the old employees: '+emp.Name);
			// means the map doesn't contain a record belonging to this parent reference
			if(idWithSum.get(emp.OrgId__c) == null){
				idWithSum.put(emp.OrgId__c, emp.Salary__c);
			} else{
				Decimal empSalary = idWithSum.get(emp.OrgId__c);
				empSalary = empSalary + emp.Salary__c;
				idWithSum.put(emp.OrgId__c, empSalary);
			}
		}
		
		
		// Iterating over the belonging Organizations to do the summation of salaries
		for(Organization__c org: orgList){
			Organization__c toUpdate = new Organization__c();
			toUpdate = org;
			if(idWithSum.containsKey(org.Id)){
				org.SalarySum__c = idWithSum.get(toUpdate.Id);
				orgToUpdate.add(toUpdate);
			}
		}
		
		if(orgToUpdate != null){
			if(orgToUpdate.size()>0	){
				update orgToUpdate;
			}
		}
			
	}
}