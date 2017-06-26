trigger INNOdepensePersonnel on INNOdepensePersonnel__c (before insert, before update, after delete, after insert, after undelete, after update) {
	TriggerFactory.createHandler(INNOdepensePersonnel__c.sObjectType);
}