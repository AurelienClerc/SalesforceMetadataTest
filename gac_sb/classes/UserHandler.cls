public without sharing class UserHandler implements ITrigger {
	
	public void bulkBefore(){
	}
	
	public void bulkAfter(){
	}
		
	public void beforeInsert(SObject so){
		User u = (User) so;
		u.locale__c = u.LocaleSidKey;
		if(u.IsActive && (u.DCR__c != null  || u.DR__c !=null))
			u.Approbateur_commerce__c = (u.DCR__c != null ? u.DCR__c : u.DR__c);	
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
		User u = (User) so;
		u.locale__c = u.LocaleSidKey;
		if(u.IsActive && (u.DCR__c != null  || u.DR__c !=null))
			u.Approbateur_commerce__c = (u.DCR__c != null ? u.DCR__c : u.DR__c);
	}
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
	}
	
	public void afterDelete(SObject so){
	}
	
	/**
	 * andFinally
	 *
	 * This method is called once all records have been processed by the trigger. Use this 
	 * method to accomplish any final operations such as creation or updates of other records.
	 */
	public void andFinally(){
	}
	
	
	static testMethod void testUserDml(){
		List<User> dcrs = [Select id, profileId from user where isActive = true limit 2];
		User u = new User(userName = 'test-synefo@global-approach-consulting.com',lastName = 'test' ,email = 'test@test.com',alias = 'ttest',TimeZoneSidKey = 'Europe/Paris',LanguageLocaleKey = 'fr', profileId = dcrs.get(0).profileId, LocaleSidKey ='fr_FR_EURO', EmailEncodingKey = 'ISO-8859-1',isActive = true, 
			DCR__c = dcrs.get(0).ID, DR__c = dcrs.get(1).ID);
		insert u;
		u = [select id,Approbateur_commerce__c,DCR__c,DR__c from User where id = :u.id][0]; 
		system.assertEquals(u.Approbateur_commerce__c,dcrs.get(0).id);
		u.DCR__c = null;
		update u;
		u = [select id,Approbateur_commerce__c,DCR__c,DR__c from User where id = :u.id][0]; 
		system.assertEquals(u.Approbateur_commerce__c,dcrs.get(1).id);
		
		//Code coverage
		UserHandler handler = new UserHandler();
		handler.beforeDelete((sObject) u);
		handler.afterDelete((sObject) u);
	}
}