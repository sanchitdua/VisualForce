global class BatchTest1Schedulable implements Schedulable{
    global void execute(SchedulableContext sc){
    	BatchTest1 bt = new BatchTest1();
        Database.executeBatch(bt);
        
    }
}