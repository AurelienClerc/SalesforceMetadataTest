trigger INNOmission on INNOmission__c (before insert, before update) {
	TriggerFactory.createHandler(INNOmission__c.sObjectType);
}