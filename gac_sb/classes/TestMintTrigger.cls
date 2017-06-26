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
private class TestMintTrigger {
/*
    static testMethod void myUnitTest() {
		List<Account> accounts = new List<Account>{};
		String etablissementPrincipalTest = 'FR431866482';
		List<Account> parents = [select Id from Account where ID_BVD__c = 'FR431866482'];
		String etablissementPrincipalIDTest = parents[0].Id;
		//etablissementPrincipalIDTest = '001D000000jQgmV';
	           
		for(Integer i = 0; i < 2; i++){
	    	Account a = new Account(
			  	Name = 'Test Account ' + i, 
			  	Siret__c = '12345678901234', 
			 	RecordTypeId = '012D0000000i8ar',
				
				
				BillingCountry = 'FRANCE',
				BillingPostalCode = '12345',
				
			  	Type_d_etablissement__c = 'Principal',
			  	Type_d_etablissement_MINT__c = 'etablissement vide',
			  	AnnualRevenue = 1000,
			  	AnnualRevenue_MINT__c = 1,
			  	Date_de_cloture_fiscale__c = '31 Décembre',
			  	Date_de_cloture_fiscale_MINT__c = Date.newInstance(2012, 04, 23),
			  	Effectif_France__c = 100,
			  	Effectif_site__c = '50',
			  	Effectif_MINT__c = 1,
			  	Activity__c = 'test',Industry = 'test'
			);
			accounts.add(a);
	    }
	      
	    insert accounts;

		Test.startTest();
		/*
		 * Tests type d'établissement
		 */
		
		/* test 1
		 * champ visible : non modifié
		 * champ mint modifié : 'Branch location'
		 * résultat : champ visible = 'Secondaire'
		 */ 
		//testStringField(accounts, 'Type_d_etablissement_MINT__c', 'Branch location', etablissementPrincipalIDTest, etablissementPrincipalTest, 'Type_d_etablissement__c', 'Secondaire');
		
		/* test 2
		 * champ visible modifié : 'Principal'
		 * champ mint : non modifié
		 * résultat : champ mint = 'Principal'
		 */ 
		//testStringField(accounts, 'Type_d_etablissement__c', 'Principal', null, null, 'Type_d_etablissement_MINT__c', 'Principal');
		
		/* test 3
		 * champ mint modifié : valeur quelconque
		 * champ visible : non modifié
		 * résultat : champ visible = 'Principal'
		 */
		//testStringField(accounts, 'Type_d_etablissement_MINT__c', 'test string', null, null, 'Type_d_etablissement__c', 'Principal');
		
		/*
		 * Tests chiffre d'affaire
		 */
		
		/* test 1
		 * champ mint : non modifié
		 * champ visible modifié : null
		 * résultat : champ mint = null
		 */
		//testIntegerField(accounts, 'AnnualRevenue', null, null, 'AnnualRevenue_MINT__c', null);
		
		/* test 2
		 * champ mint : 10
		 * champ visible : non modifié
		 * résultat : champ visible = 10000
		 */
		//testIntegerField(accounts, 'AnnualRevenue_MINT__c', 10, null, 'AnnualRevenue', 10000);

		/* test 3
		 * champ mint : non modifié
		 * champ visible modifié : 1000
		 * résultat : champ mint = 1
		 */
		//testIntegerField(accounts, 'AnnualRevenue', 1000, null, 'AnnualRevenue_MINT__c', 1);
		
		/*
		 * Tests date de clôture
		 */
		
		/* test 1
		 * champ mint : non modifié
		 * champ visible modifié : null
		 * résultat : champ mint = null
		 */
		//testStringField(accounts, 'Date_de_cloture_fiscale__c', null, null, null, 'Date_de_cloture_fiscale_MINT__c', null);
		
		/* test 2
		 * champ mint : non modifié
		 * champ visible modifié : valeur quelconque
		 * résultat : champ mint = valeur du champ visible
		 */
		//testStringField(accounts, 'Date_de_cloture_fiscale__c', '01 Février', null, null, 'Date_de_cloture_fiscale_MINT__c', '01/02/2012');
		
		/* test 3
		 * champ mint modifié : date au format "jj/mm/aaaa"
		 * champ visible : non modifié
		 * résultat : champ visible = date au format "jj mois" 
		 */
		//testStringField(accounts, 'Date_de_cloture_fiscale_MINT__c', '01/02/2012', null, null, 'Date_de_cloture_fiscale__c', '1 Février');
		
		/*
		 * Tests effectif
		 */		
		
		/*
		 * test 1
		 * champ visible modifié : null
		 * champ mint : non modifié
		 * résultat : champ mint = null
		 */
		//testIntegerField(accounts, 'Effectif_France__c', null, null, 'Effectif_MINT__c', null);
		
		/*
		 * test 2
		 * champ visible modifié : valeur quelconque
		 * champ mint : non modifié
		 * résultat : champ mint = valeur du champ visible
		 */
		//testIntegerField(accounts, 'Effectif_France__c', 10, null, 'Effectif_MINT__c', 10);
		
		/*
		 * test 3
		 * champ visible : non modifié
		 * champ mint modifié : valeur quelconque
		 * résultat : champ mint = valeur du champ mint
		 */
		//testIntegerField(accounts, 'Effectif_MINT__c', 100, null, 'Effectif_France__c', 100);
		
		/*
		 * Tests parent
		 */
		//testStringField(accounts, 'ParentId', '001L0000004NmHW', null, 'ParentId_MINT__c', 'FR408397628');
		
		
		//Test.stopTest();
  
    //}
    
    // TODO : trouver un moyen de passer des paramètres de type différents suivant l'appel à la méthode :
    // String, ou Integer
    /*static void testStringField(List<Account> accounts, String fieldToUpdate, String updatedValue, String parentId, String parentBvdId, String resultField, String resultValue){
    	List<Account> updatedAccounts = new List<Account>();
		List<Id> accountsIds = new List<Id>();
		List<String> tmp;
		
		for(Account a : accounts){
    		if(fieldToUpdate == 'Date_de_cloture_fiscale_MINT__c'){
				tmp = updatedValue.split('/', 0);
				a.put(fieldToUpdate, Date.newInstance(integer.valueof(tmp[2]), integer.valueof(tmp[1]), integer.valueof(tmp[0])));				
			}else{
	    		a.put(fieldToUpdate, updatedValue);
    		}
    		
    		// Obligatoire pour pouvoir metre à jour un ES
	    	a.Etablissement_Principal__c = parentId;	// sandbox
	    	a.ParentId_MINT__c = parentBvdId;	// sandbox
	    	accountsIds.add(a.Id);
    	}
    	update accounts;
    	
    	String soqlquery = 'Select ' + fieldToUpdate + ', ' + resultField + ' from Account WHERE Id IN :accountsIds';
    	updatedAccounts = Database.query(soqlquery);
    	
    	for(Account a : updatedAccounts){
    		if((resultField == 'Date_de_cloture_fiscale_MINT__c') && (resultValue != null) ){
				tmp = resultValue.split('/', 0);
				System.assertEquals(Date.newInstance(integer.valueof(tmp[2]), integer.valueof(tmp[1]), integer.valueof(tmp[0])), a.get(resultField));
			}else{
				System.assertEquals(resultValue, a.get(resultField));
			}
    	}
    }
    
    static void testIntegerField(List<Account> accounts, String fieldToUpdate, Decimal updatedValue, String parentId, String resultField, Decimal resultValue){
    	List<Account> updatedAccounts = new List<Account>();
		List<Id> accountsIds = new List<Id>();
		
    	for(Account a : accounts){
    		a.put(fieldToUpdate, updatedValue);
	    	// Obligatoire pour pouvoir metre à jour un ES
	    	a.Etablissement_Principal__c = parentId;	// sandbox
	    	accountsIds.add(a.Id);
    	}
    	update accounts;
    	
    	String soqlquery = 'Select ' + fieldToUpdate + ', ' + resultField + ' from Account WHERE Id IN :accountsIds';
    	updatedAccounts = Database.query(soqlquery);
    	
    	for(Account a : updatedAccounts){
			System.assertEquals(resultValue, a.get(resultField));
		}
    }*/
}