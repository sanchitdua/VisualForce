public class ApexScheduler implements Schedulable{
    public void execute(SchedulableContext sc){
        system.debug('triggerid: '+sc.getTriggerId());
        // 1). Querying over the CronTrigger object
        CronTrigger ct = [SELECT 
                          	CronExpression, EndTime, TimesTriggered, State, NextFireTime, Id, StartTime 
                         	 FROM 
                          		CronTrigger where id=: sc.getTriggerId()];
        system.debug('$$ The current state of job is: '+ct.State+' which is fired at: '+ct.startTime+' going to end: '+ct.EndTime+' with cronExpression:  '+ct.CronExpression );
    	
       
       	ct = [SELECT 
              id, CronJobDetailId, CronJobDetail.Name, CronJobDetail.JObType 
              	FROM CronTrigger order by createddate limit 1];
        system.debug('## The current state of job is: '+' which is fired at: '+ct.startTime+' going to end: '+ct.EndTime+' with cronExpression:  '+ct.CronExpression );
    	
        CronJobDetail cjd = [SELECT id, name, jobType from cronJobDetail where id =: ct.CronJobDetailId];
        system.debug('The details are: '+cjd.name+'\t jobType: '+cjd.JobType );
        
        // seconds, minutes, hours, days, weeek of day, month, year
        new ApexToSchedule();
        
        
    }
}