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
 *@author Frédéric PLISSIER
 *@created 15/10/2012
 */
@isTest
private class OpportunityHandler_Test {

	static Account acc;
	static Recommandation_cross_selling__c reco;
	static Opportunity opp;
	static Map<String,Id> EventRecordTypes;
	
	static void InitEventRecordType(){
		EventRecordTypes = new Map<String,Id>();
		for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Event']){
			EventRecordTypes.put(rtype.DeveloperName,rtype.Id);
		}
	}
	
 	static void Init() {
    	
    	acc = new Account(Name='testAccount',BillingCountry='FRANCE',BillingStreet='Adresse du compte',BillingPostalCode='12345',Activity__c='test',Industry='test');
    	insert acc;
    	
		reco = new Recommandation_cross_selling__c(Compte__c = acc.Id);
		insert reco;
		
		opp = new Opportunity(AccountId = acc.Id,name = '--test unitaire ',StageName='RDV à prendre',CloseDate=Date.today(),recordTypeId = '012D0000000gdup',type_de_compte__c = 'test',Concurrent__c = 'Inconnu ',Enjeux_opportunite__c='STAR',Date_de_validation_RDV__c=date.today(),
			ACS_effectif_concerne__c = 220, ACS_bas_salaires__c = 220,ACS_MS_concernee__c = 220,ACS_Nb_itinerants__c = 220,ACS_absenteisme__c = 220,
			ACS_Service_paie_ext__c = true
			);
		insert opp;
    	
    }
    
    static void refreshReco(){
		reco = [select id, Opportunities_creees__c from Recommandation_cross_selling__c WHERE id =: reco.Id];
	}
    
    static testMethod void testprocessRecosUpdate(){
    	init();
    	test.startTest();
    	opp.Recommandation__c = reco.Id;
    	update opp;
    	refreshReco();
    	system.assert(reco.Opportunities_creees__c);
    	opp.Recommandation__c = null;
    	update opp;
    	refreshReco();
    	system.assert(!reco.Opportunities_creees__c);
    	test.stopTest();

    }
    
    
    
}