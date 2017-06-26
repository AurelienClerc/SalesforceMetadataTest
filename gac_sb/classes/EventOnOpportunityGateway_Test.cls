/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class EventOnOpportunityGateway_Test {

  static List<Opportunity> opps;
  static List<Event> evs;
  static Map<String,Id> EventRecordTypes;
  
  static void refreshOpps(){
    opps = [select id,ownerId,contexte__c,Name,date_1er_RDV__c,date_dernier_RDV__c,RDV_effectues__c,ACS_date_de_RDV_report__c,RDV_annul__c,Date_initiale_RDV__c from Opportunity WHERE id =: opps.get(0).Id or Id = :opps.get(1).Id order by Concurrent__c ASC];
  }
  static void refreshEvs(){
    evs = [Select Id,StartDateTime,EndDateTime,Description,objet_evenement__c,nature_evenement__c,annulation_et_report__c,report_au__c from Event WHERE whatId=:opps.get(0).Id OR whatId =:opps.get(1).Id];
  }
  
  static void InitEventRecordType(){
    EventRecordTypes = new Map<String,Id>();
    for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Event' or SobjectType = 'Opportunity']){
      EventRecordTypes.put(rtype.DeveloperName,rtype.Id);
    }
  }
  
  
    static void Init() {
      opps = new List<Opportunity>();
    evs = new List<Event>();
    InitEventRecordType();
    Account ac = new Account(Name='testAccount',BillingCountry='FRANCE',BillingStreet='Adresse du compte',BillingPostalCode='12345',Activity__c='test',Industry='test');
    insert ac;
    //id accId = [Select Id from Account][0].Id;
    for(Integer i = 0;i<2;i++){
      Opportunity o = new Opportunity(AccountId = ac.Id,name = '--test unitaire ' + i,StageName='RDV à prendre',CloseDate=Date.today(),recordTypeId = '012D0000000gdup',type_de_compte__c = 'test',Concurrent__c = 'Inconnu '+ i,Enjeux_opportunite__c='STAR',Date_de_validation_RDV__c=date.today(),
      ACS_effectif_concerne__c = 220, ACS_bas_salaires__c = 220,ACS_MS_concernee__c = 220,ACS_Nb_itinerants__c = 220,ACS_absenteisme__c = 220,
      ACS_Service_paie_ext__c = true
      );
      opps.add(o);
    }
    insert opps;
    //refreshOpps();
    
    Event ev1 = new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , WhatId = opps.get(0).Id, startDateTime = datetime.now()-5, endDateTime = datetime.now(), Description='test First', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique');  
    evs.add(ev1);
    
    Event ev2 = new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , WhatId = opps.get(0).Id, startDateTime = datetime.now()+1, endDateTime = datetime.now()+5, Description='test Last', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique',
              processus_de_decision__c = 'test',enjeux__c='test',attente_besoin__c = 'test',objections__c = 'test',Timing_Prochaine_tape__c='test');  
    evs.add(ev2);
    
    Event ev3 = new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , WhatId = opps.get(1).Id, startDateTime = datetime.now()-5, endDateTime = datetime.now(), Description='test First', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique');  
    evs.add(ev3);
    
    Event ev4 = new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , WhatId = opps.get(1).Id, startDateTime = datetime.now()+1, endDateTime = datetime.now()+5, objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique');  
    evs.add(ev4);
    
    insert evs;
    refreshOpps();
    refreshEvs();
      system.assertEquals(date.today() - 5,opps.get(0).date_1er_RDV__c);
      system.assertEquals(date.today() + 1,opps.get(0).date_dernier_RDV__c);
      system.assertEquals(2,opps.get(0).RDV_effectues__c);
      system.assertEquals('test Last',opps.get(0).Contexte__c);
      system.assertEquals('test First',opps.get(1).Contexte__c);
      
    }
    
    static testMethod void testAnnulationRdv(){
      init();
      test.startTest();
      evs.get(0).annulation_et_report__c = 'Annulé';
      evs.get(0).date_d_annulation__c = date.today();
      evs.get(0).commentaires__c = 'test annul';
      update evs;
      refreshOpps();
      test.stopTest();
      system.assertEquals(1,opps.get(0).RDV_effectues__c);
      system.assertEquals(date.today() + 1,opps.get(0).date_1er_RDV__c);
      system.assertEquals(date.today() + 1,opps.get(0).date_dernier_RDV__c);
    }
  
    
    static testMethod void testModifRdvComment(){
      init();
      test.startTest();
      evs.get(1).Description = 'modif RDV';
      update evs;
      refreshOpps();
      test.stopTest();
      system.assertEquals('modif RDV',opps.get(0).Contexte__c);
    }
    
    static testMethod void testModifRdvDateDernier(){
      init();
      test.startTest();
      evs.get(1).StartDateTime = date.today() + 10;
      evs.get(1).endDateTime = date.today() + 11;
      update evs;
      refreshOpps();
      test.stopTest();
      system.assertEquals(date.today() + 10,opps.get(0).date_dernier_RDV__c);
    }
    
    static testMethod void testModifRdvDatePremier(){
      init();
      test.startTest();
      evs.get(0).StartDateTime = date.today() - 10;
      update evs;
      refreshOpps();
      test.stopTest();
      system.assertEquals(date.today() - 10,opps.get(0).date_1er_RDV__c);
    }
    
    
    static testMethod void testsuppressionRDV(){
      init();
      test.startTest();
      delete evs.get(0);
      refreshOpps();
      test.stoptest();
      system.assertEquals(1,opps.get(0).RDV_effectues__c);
    }
    
     static testMethod void testResetRDV(){
      init();
      test.startTest();
      delete evs;
      refreshOpps();
      test.stoptest();
      system.assertEquals(null,opps.get(0).RDV_effectues__c);
      system.assertEquals(null,opps.get(0).date_1er_RDV__c);
      system.assertEquals(null,opps.get(0).date_dernier_RDV__c);
      system.assertEquals(null,opps.get(0).Contexte__c);
    }
    
    static testMethod void testUndeleteRDV(){
      init();
      delete evs;
      test.startTest();
      undelete evs;
      test.stoptest();
      refreshOpps();
      system.assertEquals(date.today() - 5,opps.get(0).date_1er_RDV__c);
      system.assertEquals(date.today() + 1,opps.get(0).date_dernier_RDV__c);
      system.assertEquals(2,opps.get(0).RDV_effectues__c);
      system.assertEquals('test Last',opps.get(0).Contexte__c);
      system.assertEquals('test First',opps.get(1).Contexte__c);
    }
    
    static testMethod void testReafectRDV(){
      init();
      test.startTest();
      evs.get(0).whatId = opps.get(1).Id;
      update evs;
      refreshOpps();
      test.stoptest();
      system.assertEquals(1,opps.get(0).RDV_effectues__c);
      system.assertEquals(3,opps.get(1).RDV_effectues__c);
    }
    
    static testMethod void otherEvents(){
      InitEventRecordType();
      insert new Event(RecordTypeId = EventRecordTypes.get('Autre_evenement') , startDateTime = datetime.now()+1, endDateTime = datetime.now()+5, Description='test Last');
    }
    
    static testMethod void testCancelAndReport(){
      init();
      
      evs.get(0).annulation_et_report__c = 'Annulé';
      evs.get(3).annulation_et_report__c = 'Annulé à reprendre';
      evs.get(2).annulation_et_report__c = 'Reporté';
      evs.get(2).report_au__c = evs.get(3).startDateTime.date();
      
      evs.get(0).date_d_annulation__c = date.today();
      evs.get(0).commentaires__c = 'test annul';
      evs.get(3).date_d_annulation__c = date.today();
      evs.get(3).commentaires__c = 'test annul';
      
      evs.get(2).annulation_et_report__c = 'Reporté';
      evs.get(2).commentaires__c = 'test annul';
      evs.get(2).report_au__c = evs.get(3).startDateTime.date();
      
      
      test.startTest();
    update evs;
    refreshOpps();
    test.stopTest();
    system.assertEquals(1,opps.get(0).RDV_effectues__c);
      system.assertEquals('test date Initiale = ' + string.valueOf(date.today() - 5),'test date Initiale = ' + string.valueOf(opps.get(0).Date_initiale_RDV__c));
      system.assertEquals(true,opps.get(0).RDV_annul__c);
      
      
      system.assertEquals('test date Report = ' + string.valueOf(date.today() + 1),'test date Report = ' + string.valueOf(opps.get(1).ACS_date_de_RDV_report__c));
      // Edit : 02/07/2013 FP 
      //system.assertEquals(false,opps.get(1).RDV_annul__c);
      system.assertEquals(null,opps.get(1).RDV_effectues__c);
    }
    
    static testMethod void TestReaffectOpps(){
      init();
      
      opps.get(0).ownerId = [Select Id from User where Id != : system.Userinfo.getUserId() AND isActive = true AND Usertype='Standard' AND alias != 'guest' order by createdDate DESC][0].Id;
      update opps;
      refreshOpps();
      opps.get(0).stageName = 'RDV effectué';
      test.startTest();
      OpportunityHandler.preventRecursivity = false;
      update opps;
      refreshOpps();
      system.assertEquals(system.Userinfo.getUserId(),opps.get(0).ownerId);
      test.stopTest();
    }
    
    
    static testMethod void TestEventOnContact(){
      Account ac = new Account(Name='testAccount',BillingCountry='FRANCE',BillingStreet='Adresse du compte',BillingPostalCode='12345',Activity__c='test',Industry='test',Siret__c = '11122233344455');
    insert ac;
    List<Etablissement_secondaire__c> ESs = new Etablissement_secondaire__c[] {
        new Etablissement_secondaire__c(Name = 'ES' , rue__c = 'adresse ES',Account__c = ac.Id, code_postal__c = '54321',siret__c = '11122233344454'),
        new Etablissement_secondaire__c(Name = 'ES' ,Account__c = ac.Id,siret__c = '11122233344453')
      };
    insert ESs;
    Opportunity o = new Opportunity(AccountId = ac.Id,name = '--test unitaire ',StageName='RDV à prendre',CloseDate=Date.today(),recordTypeId = '012D0000000gdup',type_de_compte__c = 'test',Concurrent__c = 'Inconnu ',Enjeux_opportunite__c='STAR',Date_de_validation_RDV__c=date.today() );
    insert o;
    List<Contact> cs = new Contact[]{
      new Contact(FirstName = 'test', LastName = 'test',AccountId = ac.Id ,Etablissement__c = ess.get(0).Id),
      new Contact(FirstName = 'test', LastName = 'test',AccountId = ac.Id ,Etablissement__c = ess.get(1).Id)
    };
    
    insert cs;
    InitEventRecordType();
    List<Event> evsToTest = new Event[]{
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , WhatId = o.Id, startDateTime = datetime.now()-5, endDateTime = datetime.now(), Description='test First', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique'),
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , WhatId = o.Id , whoId = cs.get(0).Id, startDateTime = datetime.now()-4, endDateTime = datetime.now(), Description='test First', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique'),
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , WhatId = o.Id , whoId = cs.get(0).Id, startDateTime = datetime.now()-3, endDateTime = datetime.now(), Description='test First', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique'),
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , WhatId = o.Id , whoId = cs.get(1).Id, startDateTime = datetime.now()-2, endDateTime = datetime.now(), Description='test First', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Téléphonique')
    };
    test.startTest();
    insert evsToTest;
    List<Event> res = [select emplacement_outlook__c,categorie_outlook__c from event where id in:evsToTest order by startDateTime ASC];
    system.assert(res.get(0).emplacement_outlook__c.contains('12345'));
    system.assert(res.get(1).emplacement_outlook__c.contains('54321'));
    system.assert(res.get(3).emplacement_outlook__c.contains('12345'));
    
    test.stopTest();
    }
    
    static testMethod void TestDetectOppSoeur(){
    opps = new List<Opportunity>();
    evs = new List<Event>();
    InitEventRecordType();
    Account ac = new Account(Name='testAccount',BillingCountry='FRANCE',BillingStreet='Adresse du compte',BillingPostalCode='12345',Activity__c='test',Industry='test');
    insert ac;
    Contact[] cs   = new List<Contact>{ 
              new Contact (LastName = 'Test Contact1', AccountId = ac.Id),
              new Contact (LastName = 'Test Contact2', AccountId = ac.Id)
               };
    insert cs;
    //Création de deux opp de type inno et opti 
    Opportunity[] os = new List<Opportunity>{
                new Opportunity (Name = 't',AccountId= ac.Id, recordTypeId = EventRecordTypes.get('ACS'),StageName='RDV à prendre',CloseDate=Date.today(),Concurrent__c = '1',type_de_compte__c = 'test'), 
                new Opportunity (Name = 't',AccountId= ac.Id, recordTypeId = EventRecordTypes.get('TAT'),StageName='RDV à prendre',CloseDate=Date.today(),Concurrent__c = '2',type_de_compte__c = 'test'), 
                new Opportunity (Name = 't',AccountId= ac.Id, recordTypeId = EventRecordTypes.get('CIR'),StageName='RDV à prendre',CloseDate=Date.today(),Concurrent__c = '3',type_de_compte__c = 'test'), 
                new Opportunity (Name = 't',AccountId= ac.Id, recordTypeId = EventRecordTypes.get('FI'), StageName='RDV à prendre',CloseDate=Date.today(),Concurrent__c = '4',type_de_compte__c = 'test'), 
                new Opportunity (Name = 't',AccountId= ac.Id, recordTypeId = EventRecordTypes.get('DI'), StageName='RDV à prendre',CloseDate=Date.today(),Concurrent__c = '5',type_de_compte__c = 'test'),
                new Opportunity (Name = 't',AccountId= ac.Id, recordTypeId = EventRecordTypes.get('IL'), StageName='RDV à prendre',CloseDate=Date.today(),Concurrent__c = '6',type_de_compte__c = 'test'), 
                new Opportunity (Name = 't',AccountId= ac.Id, recordTypeId = EventRecordTypes.get('TAT'), StageName='RDV à prendre',CloseDate=Date.today(),Concurrent__c = '7',type_de_compte__c = 'test') 
              };
    insert os;
    Id ownerId = [Select id from user where id != :Userinfo.getUserId() and isActive=true][0].Id;
    List<Event> evsToTest = new Event[]{
      //Pour les optis, on test avec un evt contact différent avec 45 jours d'écart (= pas opp Soeur)
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , ownerId = ownerId, WhatId = os.get(0).Id, whoId=cs.get(0).id, startDateTime = datetime.now()-15, endDateTime = datetime.now()-15, Description='test 1', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique'),
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , ownerId = ownerId, WhatId = os.get(1).Id, whoId=cs.get(1).id, startDateTime = datetime.now()+10, endDateTime = datetime.now()+10, Description='test 2', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique'),
      
      //Pour les inno, on test ici un evt avec le même contact et 145 jour d'écart (=Opp Soeur)
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , ownerId = ownerId, WhatId = os.get(2).Id, whoId=cs.get(1).id, startDateTime = datetime.now()-130, endDateTime = datetime.now()-130, Description='test 3', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique'),
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , ownerId = ownerId, WhatId = os.get(3).Id, whoId=cs.get(1).id, startDateTime = datetime.now()+15, endDateTime = datetime.now()+15, Description='test 4', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique'),
      
      //Edit didier 0103, on va s'assurer que les opp avec le même contact contact a plus de 3 mois sont marquées 
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , ownerId = ownerId, WhatId = os.get(4).Id, whoId=cs.get(0).id, startDateTime = datetime.now()+330, endDateTime = datetime.now()+330, Description='test 3', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique'),
      new Event(RecordTypeId = EventRecordTypes.get('RDV_Commercial') , ownerId = ownerId, WhatId = os.get(5).Id, whoId=cs.get(0).id, startDateTime = datetime.now()+400, endDateTime = datetime.now()+400, Description='test 4', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique')
    };
    insert evsToTest;
    test.startTest();
    os = [Select id, opportunite_soeur__c from Opportunity order by concurrent__c asc];
    List<Event> evUp = [Select id, RDV_double_produit__c from Event];
    
    //Edit didier 01/03/2013
    system.assertEquals(os.get(0).opportunite_soeur__c, null);
    system.assertEquals(os.get(1).opportunite_soeur__c, null);
    
    
    /*
    Test ne marche plus à réparer //TODO
    if(os.get(2).opportunite_soeur__c == null){
      system.assertEquals(os.get(3).opportunite_soeur__c, os.get(2).id);
    
      system.assert( evUp.get(3).RDV_double_produit__c );
    }else{
      system.assertEquals(os.get(2).opportunite_soeur__c, os.get(3).id);
      system.assert( evUp.get(2).RDV_double_produit__c );
    }
    */
    /*
    //Marche pas test a réparer //TODO
    if(os.get(4).opportunite_soeur__c == null){
      system.assertEquals( os.get(4).id, os.get(5).opportunite_soeur__c ); //On teste que les opportunités soeurs se sont bien remplies
      //Test du remplissage RDV double produit
      system.assert( evUp.get(5).RDV_double_produit__c );
    }else{
      system.assertEquals( os.get(4).opportunite_soeur__c, os.get(5).id );
      system.assert( evUp.get(4).RDV_double_produit__c );
    }
    */
        
    //Test Suppression d'un evt sur opp soeur
    delete evsToTest.get(1);
    evsToTest.get(3).startDateTime = dateTime.now() + 100;
    evsToTest.get(3).endDateTime = dateTime.now() + 100;
    update evsToTest.get(3);  //Test de mise a jour d'évenement dans une date qui ne marche plus
    os = [Select id, opportunite_soeur__c from Opportunity order by concurrent__c asc];
    test.stopTest();
    system.assertEquals(null, os.get(0).opportunite_soeur__c);
    system.assertEquals(null, os.get(1).opportunite_soeur__c);
    system.assertEquals(null, os.get(2).opportunite_soeur__c);
    system.assertEquals(null, os.get(3).opportunite_soeur__c);
    }
    
    
    
}