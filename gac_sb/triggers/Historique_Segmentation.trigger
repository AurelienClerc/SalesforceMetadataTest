trigger Historique_Segmentation on Historique_Segmentation__c (after delete, after insert, after update,before delete, before insert, before update,after undelete) {
    	TriggerFactory.createHandler(Historique_Segmentation__c.sObjectType);
}