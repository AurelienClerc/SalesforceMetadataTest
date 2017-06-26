trigger Leads on Lead (after delete, after insert, after update, before delete, before insert, before update) {
	TriggerFactory.createHandler(Lead.SobjectType);
}