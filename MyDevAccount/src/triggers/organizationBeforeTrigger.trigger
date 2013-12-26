trigger organizationBeforeTrigger on Organization__c (before insert, before update, 
													after insert, after update) {
	RestrictingOrgTriggerExecution rote = new RestrictingOrgTriggerExecution();
	
	if( !RestrictingOrgTriggerExecution.isAfterOrIsUpdate ){
		// All the after events
		if(Trigger.isAfter){
			
			if(Trigger.isInsert)
				system.debug('the after trigger is fired for insert'); // 2nd statement
			if(Trigger.isUpdate){
				system.debug(Trigger.size); // returning the number of records for that particular context
				system.debug('the after trigger is fired for update'); // 4th satement
				RestrictingOrgTriggerExecution.isAfterUpdate = true;
			}
		}	
		// All the before eventsm
		if(Trigger.isBefore){
			if(Trigger.isUpdate){
				system.debug('the before trigger is fired for update'); // 3rd statement
				RestrictingOrgTriggerExecution.isBeforeUpdate = true;
			}
			if(Trigger.isInsert)
				system.debug('the before trigger is fired for insert'); // 1st statement
		}
			
	}
	
	if( RestrictingOrgTriggerExecution.isAfterUpdate && RestrictingOrgTriggerExecution.isBeforeUpdate ){
		RestrictingOrgTriggerExecution.isAfterOrIsUpdate = true;
	}
}