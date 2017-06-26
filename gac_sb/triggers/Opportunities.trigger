trigger Opportunities on Opportunity (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
	triggerFactory.createHandler(Opportunity.sObjectType);
}