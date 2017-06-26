trigger Tasks on Task (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
	if(!ContactMailTAT.IgnoreTaskTrigger)	//EDIT DIDIER 05/03/2014 : Send mail avec setSaveAsActivity = true créée une tache par email, ce qui déclenche 800 fois ce trigger et fait des CPU Exceptions
		TriggerFactory.createHandler(Task.sObjectType);
}