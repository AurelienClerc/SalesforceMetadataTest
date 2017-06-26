trigger INNOdepensePrestation on INNOdepensePrestation__c (before insert, after insert, after update, after delete, after undelete) {
	TriggerFactory.createHandler(INNOdepensePrestation__c.sObjectType);
}