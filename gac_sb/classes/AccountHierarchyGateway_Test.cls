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
 *@author Didier HUGUET
 *@created 13/06/2012
 */
@isTest
private class AccountHierarchyGateway_Test {

	static list<Account> Accs;

	static void refreshAccount(){
		Accs = [select Id,parentId,reference_Tete_de_groupe__c,reference_Tete_de_groupe__r.id_selligent__c from Account order by name ASC];
	}

	static public void init(){
		List<Account> toInsert = new Account[]{			
			new Account(Name = 'Test 01',Siret__c='01000000000000',id_selligent__c = '01',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 02',Siret__c='02000000000000',id_selligent__c = '02',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 03',Siret__c='03000000000000',id_selligent__c = '03',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 04',Siret__c='04000000000000',id_selligent__c = '04',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 05',Siret__c='05000000000000',id_selligent__c = '05',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 06',Siret__c='06000000000000',id_selligent__c = '06',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 07',Siret__c='07000000000000',id_selligent__c = '07',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 08',Siret__c='08000000000000',id_selligent__c = '08',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 09',Siret__c='09000000000000',id_selligent__c = '09',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 10',Siret__c='10000000000000',id_selligent__c = '10',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 11',Siret__c='11000000000000',id_selligent__c = '11',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 12',Siret__c='12000000000000',id_selligent__c = '12',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 13',Siret__c='13000000000000',id_selligent__c = '13',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 14',Siret__c='14000000000000',id_selligent__c = '14',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie')
		};
		insert toInsert;
		refreshAccount();
		
		for(Integer i=1;i<Accs.size();i++){
			Accs.get(i).ParentId = Accs.get(i-1).Id;
		}
		update Accs;
		
		AccountHierarchyGateway Ah = new AccountHierarchyGateway();
		Ah.reconstruct(0);
		
		refreshAccount();
		
	} 
	
	static testMethod void testInsert(){
		init();
		for(Integer i=1;i<Accs.size();i++){	
			system.assertEquals( String.valueOf(i) + ' 01',String.valueOf(i) + ' ' + Accs.get(i).reference_Tete_de_groupe__r.id_selligent__c);
		}
	}
	
	static testMethod void testEmpty(){
		init();
		Accs.get(6).parentId = null;
		
		test.startTest();
		update Accs.get(6);
		refreshAccount();
		test.stopTest();
		
		system.assertEquals(null, Accs.get(6).reference_Tete_de_groupe__r);
		for(Integer i=7; i<Accs.size();i++){
			system.assertEquals( String.valueOf(i) + ' 07',String.valueOf(i) + ' ' + Accs.get(i).reference_Tete_de_groupe__r.id_selligent__c);
		}
		
		
	}
	
	static testMethod void testReaffect(){
		init();
		insert new Account(Name = 'zTest bis',Siret__c='12345678900001',id_selligent__c = '15',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE', Industry = 'Santé',Activity__c='Biotech, biologie');
		refreshAccount();
		
		Accs.get(6).parentId = Accs.get(14).Id;
		test.startTest();
		update Accs.get(6);
		refreshAccount();
		test.stopTest();
		
		for(Integer i=1; i< 6;i++){
			system.assertEquals( String.valueOf(i) + ' 01',String.valueOf(i) + ' ' + Accs.get(i).reference_Tete_de_groupe__r.id_selligent__c);
		}
		
		for(Integer i=6; i<Accs.size() -1;i++){
			system.assertEquals( String.valueOf(i) + ' 15',String.valueOf(i) + ' ' + Accs.get(i).reference_Tete_de_groupe__r.id_selligent__c);
		}
	}
	
	static testMethod void testLead(){
		Lead l = new Lead(LastName = 'test',Company = 'test');
		insert l;
		update l;
	}
	
	//TODO How to handle Delete?

}