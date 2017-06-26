trigger Facture on Facture__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
	TriggerFactory.createHandler(Facture__c.sObjectType);
}