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
private class TestDepartement {

    /*
    EDIT Synefo
    Un compte ne peut plus ne pas avoir de code postal (regle de validation)
    static testMethod void testVide() {
      test('', null, 'france');
    }*/

    /*static testMethod void testHauteCorse() {
      test('20276', '2B', 'france');
    }
    
    static testMethod void testCorseSud() {
      test('20167', '2A', 'france');
    }
    
    static testMethod void testCorseSudExcep1() {
      test('20223', '2A', 'france');
    }
    
    static testMethod void testCorseSudExcep2() {
      test('20900', '2A', 'france');
    }
    
    static testMethod void testDomTom() {
      test('97340', '973', 'france');
    }
    
    static testMethod void testStd() {
      test('92100', '92', 'france');
    }
    
    /*
    * Synefo (dhuguet, une regle de validation fait que les champs code postaux doivent avoir 5 chiffres et obligatoirement)
    static testMethod void testStd2() {
      test('2000', '02', 'france');
    }
    
    * Synefo (dhuguet, une regle de validation fait que les comptes france doivent avoir une addresse de facturation avec le pays france)
    static testMethod void noFrance() {
      test('2000', null, 'belgique');
    * Suppression dud département région
    }*/
    /*
    static void test(String postalCode, String result, String country){
      if(result != null){
        Departements_regions__c dept = [
          Select
            Id
          from Departements_regions__c
          Where 
            Code_d_partement__c =: result
        ];
        result = dept.Id;
      }
      
      List<Account> accounts = new List<Account>{};
           
      for(Integer i = 0; i < 200; i++){
          Account a = new Account(
          	Name = 'Test Account ' + i, 
          	Siret__c = '12345678901234', 
          	RecordTypeId = '012D0000000i8ar', 
          	//RecordTypeId = '012L000000008h2',
          	BillingPostalCode = postalCode, 
          	BillingCountry = country);
          accounts.add(a);
      }
      
      Test.startTest();
      
      insert accounts;
      
      Test.stopTest();
      
      List<Account> insertedAccounts = [SELECT D_partement_r_gion__c
                                        FROM Account
                                        WHERE Id IN :accounts];
        
        for(Account a : insertedAccounts){
          System.assertEquals(a.D_partement_r_gion__c, result);
        }
    }
    */
}