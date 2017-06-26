@isTest
public class FactuFacturePDFCtrl_Test {

	public static testmethod void testFactuFacturePDFCtrl(){
				
		FactuTestBase.Init();
		Test.startTest();
		FactuTestBase.InitFactures();
		Facture__c f = FactuTestBase.Factures.get(0);
		
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(f);
		FactuFacturePDFCtrl ctrl = new FactuFacturePDFCtrl(stdCtrl);
		
		Test.stopTest();

    }

}