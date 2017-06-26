@isTest
private class ContactMailTAT_Test {
   public static testMethod void testContactSchedule() {
    Test.StartTest();
    ContactMailTATScheduler sh = new ContactMailTATScheduler();
        String sch = '0 0 23 * * ?';
        system.schedule('Test Contact Check', sch, sh);
    Test.stopTest();
  }
  
  public static testMethod void testBatch(){
     ContactMailTATBatchContext BA01 = new ContactMailTATBatchContext();
       database.executeBatch(BA01,50);  //Batch size de 10 pour ce WebService
  }
  
  
  public static TestMethod void testContactMailTAT(){
     Id devName = [SELECT Id from RecordType where DeveloperName = 'FRANCE_ACCOUNT' AND SobjectType = 'Account'].id;
     User u = [Select id from user where Profile.Name = 'FR - Tech - Consultant - TAT' LIMIT 1];
    
    Account[] acs = new Account[]{
      new Account(Name = 'Test 1',Consultant_mission_T_A_T__c = u.id,Siret__c='12345678900001',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',recordTypeId = devName),
      new Account(Name = 'Test 2',Consultant_mission_T_A_T__c = u.id,Siret__c='12345678800002',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',recordTypeId = devName),
      new Account(Name = 'Test 3',Consultant_mission_T_A_T__c = u.id,Siret__c='12345678700003',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',recordTypeId = devName)
    };
    insert acs;
    Contact[] cs = new Contact[]{
      new Contact(LastName = 'Test',Actif__c='Actif',Email = 'test@test.com',Cible_e_mail_T_A_T__c = true,accountId = acs.get(0).id),
      new Contact(LastName = 'Test 2',Actif__c='Actif',Email = 'test2@test.com',Cible_e_mail_T_A_T__c = true,accountId = acs.get(1).id),
      new Contact(LastName = 'Test 3',Actif__c='Actif',Email = 'test3@test.com',Cible_e_mail_T_A_T__c = true,accountId = acs.get(2).id)
    };
    insert cs;
    
    
     
     //Test sans relance
     new ContactMailTAT(cs,false);
  }
  public static TestMethod void testContactMailTATRelance(){
     Id devName = [SELECT Id from RecordType where DeveloperName = 'FRANCE_ACCOUNT' AND SobjectType = 'Account'].id;
     User u = [Select id from user where Profile.Name = 'FR - Tech - Consultant - TAT' LIMIT 1];
    
    Account[] acs = new Account[]{
      new Account(Name = 'Test 1',Consultant_mission_T_A_T__c = u.id,Siret__c='12345678900001',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',recordTypeId = devName),
      new Account(Name = 'Test 2',Consultant_mission_T_A_T__c = u.id,Siret__c='12345678800002',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',recordTypeId = devName),
      new Account(Name = 'Test 3',Consultant_mission_T_A_T__c = u.id,Siret__c='12345678700003',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',recordTypeId = devName)
    };
    insert acs;
    Contact[] cs = new Contact[]{
      new Contact(LastName = 'Test',Actif__c='Actif',Email = 'test@test.com',Cible_e_mail_T_A_T__c = true,accountId = acs.get(0).id),
      new Contact(LastName = 'Test 2',Actif__c='Actif',Email = 'test2@test.com',Cible_e_mail_T_A_T__c = true,accountId = acs.get(1).id),
      new Contact(LastName = 'Test 3',Actif__c='Actif',Email = 'test3@test.com',Cible_e_mail_T_A_T__c = true,accountId = acs.get(2).id)
    };
    insert cs;
    
    
     
     //Test sans relance
     new ContactMailTAT(cs,true);
  }
}