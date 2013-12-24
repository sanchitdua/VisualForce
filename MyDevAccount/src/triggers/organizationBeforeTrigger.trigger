trigger organizationBeforeTrigger on Organization__c (before insert, before update) {

	// The records which are going to be created or udpated are availed from "new" property of Trigger class
	List<Organization__c> orgList = Trigger.new;
	
	// Custom logic for making the Map<Id, Organization__c> collection
	Map<id, Organization__c> orgmap = new Map<Id, Organization__c>();
	
	
	for(Organization__c org: orgList){
		
		system.debug(''+org.CoLocationId__c); 
		
		orgMap.put(org.Id, org);
	}
	
	// END Custom logic for making the Map<Id, Organization__c> collection
	
	// From Trigger.newMap property we may avail the same as the custom logic defined above;
	Map<id, Organization__c> orgTriggerMap = Trigger.newMap;
	
	
	// The records which are going to be created or updated
	for ( Organization__c org: Trigger.new) {
		// org.addError('The Trigger is caught with error.');
		
	} // END for
}