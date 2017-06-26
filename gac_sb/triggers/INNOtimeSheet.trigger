trigger INNOtimeSheet on INNOtimeSheet__c (after delete, after insert, after undelete, after update) {
    TriggerFactory.createHandler(INNOtimeSheet__c.sObjectType);
}