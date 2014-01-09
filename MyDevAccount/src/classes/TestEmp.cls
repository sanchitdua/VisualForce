@isTest
private class TestEmp{
    // variables
    static void triggerUnitTest(){
    	Test.startTest();
        	// insert, update or delete
        	// SOQL Query for my triggers
        	TestEmp.unitTest();
        Test.stopTest();
    }
    
    static void unitTest(){
    	Test.startTest(); // refresh my governere limits only once
        	
        	// refresh my governere
        
        Test.stopTest(); // only once
        
        // post assertions
        
        
        Map<String, Emp> empMap = new Map<String, Emp>();
        for(integer i =1 ; i<10; i++){
            empMap.put( 'emp-'+i,
                    new Emp(i, 'emp-'+i, 'job-'+i)
            );
        }
		Emp e = empMap.get('emp-1');
        
        Emp empToCompare = new Emp(1, 'emp-1', 'job-1');
        
        
        if(e.equals(empToCompare)){
        system.debug('The employees are equal.');
        
        }
    }
}