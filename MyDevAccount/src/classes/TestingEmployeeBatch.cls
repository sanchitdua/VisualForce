@isTest
public class TestingEmployeeBatch{
    
    public class DataProvider{
        Map<String, RecordType> empNameAndRecordType = new Map<String, RecordType>();
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
                }
            }
            return (String)rt.id;
        }
        
        public void createEmployees(){
            List<Employee__c> empToInsert = new List<Employee__c>();
            for(Integer i=1; i<=10; i++){
            	empToInsert.add(new Employee__c(
                					name='emp-'+i, recordTypeId=getRecordTypeId('Super')
                					));
            }        
            insert empToInsert;
            
            
            List<Employee__c> DeptEmpToInsert = new List<Employee__c>();
            Integer counter=1;
            for(Employee__c emp: empToInsert){
            	empToInsert.add(new Employee__c(
                					name='emp-'+counter, recordTypeId=getRecordTypeId('Department'),
                    				Super_Employee__c = emp.id
                					));
                counter++;
            }        
            insert deptEmpToInsert;
            
        }
        
    }
    
    // @isTest (apply this annotation if testmethod keyword not specified)
    static testmethod void empTest(){
        DataProvider dp = new DataProvider();
        dp.createEmployees();
        Test.startTest();
    	EmployeeBatch eb = new EmployeeBatch();
        Database.executeBatch(eb);
        Test.stopTest();
    }
}