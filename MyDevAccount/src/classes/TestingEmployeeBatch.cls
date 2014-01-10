@isTest
public class TestingEmployeeBatch{
    
    public class DataProvider{
        Map<String, RecordType> empNameAndRecordType = new Map<String, RecordType>();
        Integer parentCount = 0;
        Integer childCount = 0;
        public DataProvider(){
        	List<RecordType> rtList = [SELECT name from RecordType where sObjectType='Employee__c' ];
            for(RecordType rt: rtList){
            	empNameAndRecordType.put(rt.Name, rt);
            }
        }
        
        public String getRecordTypeId(String rtName){
            RecordType rt = null;
            for(String empName: empNameAndRecordType.keySet()){
                if(empNameAndRecordType.containsKey(empName)){
                	rt = empNameAndRecordType.get(empName);
                    break;
                }
            }
            return (String)rt.id;
        }
        
        public void createEmployees(){
            List<Employee__c> empToInsert = new List<Employee__c>();
            for(Integer i=1; i<=10; i++){
            	empToInsert.add(new Employee__c(
                					name='emp-'+i, recordTypeId=getRecordTypeId('Super'), zipCode__c = ''+i
                					));
            }        
            insert empToInsert;
            parentCount = empToInsert.size();
            
            List<Employee__c> deptEmpToInsert = new List<Employee__c>();
            Integer counter=1;
            for(Employee__c emp: empToInsert){
            	deptEmpToInsert.add(new Employee__c(
                					name='emp-'+counter, recordTypeId=getRecordTypeId('Department'),
                    				zipCode__c = emp.zipCode__c,
                    				Super_Employee__c = Id.valueOf('a01900000095euLAAQ')
                					));
                counter++;
            }        
            insert deptEmpToInsert;
            childCount = deptEmpToInsert.size();
            system.debug('deptEmpToInsert: '+deptEmpToInsert);
            
        }
        
    }
    
    // @isTest (apply this annotation if testmethod keyword not specified)
    static testmethod void empTest(){
    	
    	Profile p = [select id from Profile where name='Standard User'];
    	User u = new User(
    						alias = 'standt',
    						email = ''
    					);
    	
    	
    	
        DataProvider dp = new DataProvider();
        dp.createEmployees();
        
        Test.startTest();
        EmployeeBatch.isTest = true;
        EmployeeBatch.isAnotherTest = true;
    	EmployeeBatch eb = new EmployeeBatch();
        new EmployeeBatch(true);
        Database.executeBatch(eb);
        
        EmployeeBatch.isTest = true;
        EmployeeBatch.isAnotherTest = false;
        eb = new EmployeeBatch();
        // new EmployeeBatch(true);
        Database.executeBatch(eb);
        
        System.assertEquals( dp.parentCount, dp.childCount );
        
        
        Test.stopTest();
    }
}