trigger INNOvalorisation on INNOvalo__c (after update, after insert, after delete) {

   	TriggerFactory.createHandler(INNOvalo__c.sObjectType);

}