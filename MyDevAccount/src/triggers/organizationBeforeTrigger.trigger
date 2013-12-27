trigger organizationBeforeTrigger on Organization__c (before insert, before update, 
													after insert, after update) {
	RestrictingOrgTriggerExecution rote = new RestrictingOrgTriggerExecution();
	
	if( !RestrictingOrgTriggerExecution.isAfterOrIsUpdate ){
		// All the after events
		if(Trigger.isAfter){
			if(Trigger.isInsert){
				system.debug('the after trigger is fired for insert'); // 2nd statement
				system.debug('in after insert context: '+Trigger.new);
				system.debug('in after insert newMap: '+Trigger.newMap);
				system.debug('in after insert old: '+Trigger.old);
				system.debug('in after insert oldMap: '+Trigger.oldMap);
				
			
			}
			if(Trigger.isUpdate){
				system.debug('the after trigger is fired for update'); // 4th satement
				
				system.debug('in after update context: '+Trigger.new);
				system.debug('in after insert newMap: '+Trigger.newMap);
				system.debug('in after insert old: '+Trigger.old);
				system.debug('in after insert oldMap: '+Trigger.oldMap);
				
				//system.debug(Trigger.size); // returning the number of records for that particular context
				// system.debug('the after trigger is fired for update'); // 4th satement
				RestrictingOrgTriggerExecution.isAfterUpdate = true;
			}
		}	
		// All the before eventsm
		if(Trigger.isBefore){
			if(Trigger.isUpdate){
				system.debug('the before trigger is fired for update'); // 3rd statement
				system.debug('in before update old: '+Trigger.old);
				system.debug('in before update oldMap: '+Trigger.oldMap);
				
				RestrictingOrgTriggerExecution.isBeforeUpdate = true;
			}
			if(Trigger.isInsert){
				system.debug('the before trigger is fired for insert'); // 1st statement
				
				system.debug('in before insert old: '+Trigger.old);
				system.debug('in before insert oldMap: '+Trigger.oldMap);
				
				
			}
		}
			
	}
	
	if( RestrictingOrgTriggerExecution.isAfterUpdate && RestrictingOrgTriggerExecution.isBeforeUpdate ){
		RestrictingOrgTriggerExecution.isAfterOrIsUpdate = true;
	}
}