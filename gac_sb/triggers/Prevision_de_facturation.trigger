trigger Prevision_de_facturation on Prevision_de_facturation__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
	TriggerFactory.createHandler(Prevision_de_facturation__c.sObjectType);
}