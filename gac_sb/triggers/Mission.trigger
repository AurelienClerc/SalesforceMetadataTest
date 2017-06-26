trigger Mission on Mission__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
	TriggerFactory.createHandler(Mission__c.sObjectType);
}