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
 *
 * Classe réécrite par synefo
 */
@isTest
private class TestValidationTechniqueTrigger{

	static list<Account> Accs;
	static list<Opportunity> Opps;

	static void refreshAccount(){
		Accs = [select Id,Name from Account where name= 'Test 1' order by name  ASC];
	}
	static void refreshOpps(){
		Opps = [select Id,Name from Opportunity where Id = :Opps.get(0).Id  order by name ASC];
	}

	static void Init(){
		insert new Account(Name = 'Test 1',Siret__c='12345678100001',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',	Activity__c = 'test',Industry = 'test');
		refreshAccount();
		Opps = new List<Opportunity> ();
		opps.add( new Opportunity(Name = 'Test 1',StageName='test',closeDate=date.today(),AccountId = Accs.get(0).Id));
		insert opps;
		refreshOpps();
	}

    static testMethod void TestEmpty() {
        // TO DO: implement unit test
        init();
        Validation_technique__c valid = new Validation_technique__c();
        /* edit synefo, fait en sorte que la classe integre son mail
        //valid.Opportunit__c = '006L00000024BAw';
        //valid.Opportunit__c = '006D000000J7sRH';
        */
        
        valid.Opportunit__c = Opps.get(0).Id;
        
        insert valid;
        System.assertNotEquals(valid.test_trigger__c, '');
    }
}