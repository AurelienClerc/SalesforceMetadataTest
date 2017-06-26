@isTest
public class TaskHandler_Test {

	public static testmethod void testTaskHandler(){
				
		FactuTestBase.Init();
		Test.startTest();		
		// Creation des factures
		FactuTestBase.InitFactures();
		
		// factures FI et avoir FI
		Facture__c f = FactuTestBase.Factures.get(4);
		
		Task t = new Task(Subject = 'Test',Description = 'test commentaire recouvrement',WhatId = f.Id);
		insert t;
		
		FactuTestBase.refreshFacture();
		f = FactuTestBase.Factures.get(4);
		system.assertEquals('test commentaire recouvrement',f.Commentaires_recouvrement__c);
		
		t.Description = 'test commentaire recouvrement 2';
		update t;
		
		delete t;
		
		Test.stopTest();
		
	}
}