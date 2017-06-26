trigger INNOequipeConsulting on INNOequipeConsulting__c (after delete, after insert, after update/*,before delete, before insert, before update*/) {
	TriggerFactory.createHandler(INNOequipeConsulting__c.sObjectType);
}