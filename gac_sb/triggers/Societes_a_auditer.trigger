trigger Societes_a_auditer on Societe_a_auditer__c (after delete, after insert, after update, before delete, before insert, before update) {
	TriggerFactory.createHandler(Societe_a_auditer__c.sObjectType);
}