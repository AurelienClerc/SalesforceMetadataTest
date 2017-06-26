trigger INNOamortissement on INNOamortissement__c (before insert, before update) {
	TriggerFactory.createHandler(INNOamortissement__c.sObjectType);
}