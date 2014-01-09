global class BatchTest1 implements Database.Batchable<sObject>{
	global Database.Querylocator start(Database.BatchableContext bc){
        system.debug('BatchTest1 start() invoked.');
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }
    global void execute(Database.BatchableContext bc, List<sObject> scope){
    	system.debug('BatchTest1 excute() invoked.');
    }
    global void finish(Database.BatchableContext bc){
    	system.debug('BatchTest1 finish() invoked.');
        system.debug('invoking the BatchTest2 ...');
        BatchTest2 bt = new BatchTest2();
        Database.executeBatch(bt);
        system.debug('invocation done for BatchTest2.');
    }
}