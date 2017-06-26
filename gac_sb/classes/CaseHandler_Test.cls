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
 *@created 24/05/2012
 */
@isTest
private class CaseHandler_Test {

	/*
	* Vérifie que l'utilisateur est bien rattaché Grande armée
	*/
    // static testMethod void TestBeforeInsert() {
    // 	User u = [Select Id,Email from User WHERE isActive = true AND Email LIKE '%@grande-armee-conseil.com%'][0];
    // 	Case TestCase = new Case(SuppliedEmail = u.Email);
    // 	ITrigger CaseHandlerInst = new CaseHandler();
    // 	CaseHandlerInst.beforeInsert(TestCase);
    // 	System.AssertEquals(u.Id,TestCase.Interlocuteur__c);
    // 	System.AssertEquals('Grande armée conseil',TestCase.entite__c);
    // }
    
    /*
	* Vérifie que l'utilisateur est bien rattaché avec Global Approach
	*/
     static testMethod void TestBeforeInsertGlobalApproach() {
    	User u = [Select Id,Email from User WHERE isActive = true AND Email LIKE '%@group-gac.com%'][0];
    	Case TestCase = new Case(SuppliedEmail = u.Email);
    	ITrigger CaseHandlerInst = new CaseHandler();
    	CaseHandlerInst.beforeInsert(TestCase);
    	System.AssertEquals(u.Id,TestCase.Interlocuteur__c);
    	System.AssertEquals('Global approach consulting',TestCase.entite__c);
    }
    
    /*
	* Insertion
	*/
    static testMethod void TestCrudCreate(){
    	Case TestCase = new Case();
    	insert TestCase;
    }
    
    /*
	* Update
	*/
    static testMethod void TestCrudUpdate(){
    	Case TestCase = new Case();
    	insert TestCase;
    	test.startTest();
    	TestCase.Description = 'Dummy Description';
    	update TestCase;
    	test.stopTest();
    }
    
    /*
	* Delete
	*/
    static testMethod void TestCrudDelete(){
    	Case TestCase = new Case();
    	insert TestCase;
    	test.startTest();
    	delete TestCase;
    	test.stopTest();
    }
    
    
    
}