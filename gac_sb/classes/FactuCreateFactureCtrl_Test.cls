@isTest
public class FactuCreateFactureCtrl_Test {

	public static testmethod void testFactuEditFactureCtrl(){
				
		FactuTestBase.Init();
		Test.startTest();
		FactuTestBase.InitFactures();
		
		// CIR et devalidate
		Facture__c f = FactuTestBase.Factures.get(0);
		Test.setCurrentPageReference(new Pagereference('/apex/FactuCreateFacture'));
		System.currentPageReference().getParameters().put('id', f.Id);
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(f);
		FactuCreateFactureCtrl ctrl = new FactuCreateFactureCtrl(stdCtrl);
		ctrl.saveFacture();
		ctrl.unvalidateFacture();
		Test.stopTest();

    }
    
    public static testmethod void testFactuCreateFactureCIRCtrl(){
    	
    	FactuTestBase.Init();
    	Test.startTest();
		FactuTestBase.InitFactures();
		
		// CIR
		Mission__c m = FactuTestBase.Missions.get(0);
		Test.setCurrentPageReference(new Pagereference('/apex/FactuCreateFacture'));
		System.currentPageReference().getParameters().put('MissionId', m.Id);
		System.currentPageReference().getParameters().put('PlanifsId', m.Planifications_de_facturation__r[0].Id);
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(new Facture__c());
		FactuCreateFactureCtrl ctrl = new FactuCreateFactureCtrl(stdCtrl);
		ctrl.saveFacture();
		
		Test.stopTest();
    	
    }
    
    public static testmethod void testFactuCreateFactureACSCtrl(){
    	
    	FactuTestBase.Init();
    	Test.startTest();
		FactuTestBase.InitFactures();
		
		// ACS
		Mission__c m = FactuTestBase.Missions.get(1);
		Test.setCurrentPageReference(new Pagereference('/apex/FactuCreateFacture'));
		System.currentPageReference().getParameters().put('MissionId', m.Id);
		System.currentPageReference().getParameters().put('PlanifsId', m.Planifications_de_facturation__r[0].Id);
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(new Facture__c());
		FactuCreateFactureCtrl ctrl = new FactuCreateFactureCtrl(stdCtrl);
		ctrl.saveFacture();
		
		Test.stopTest();
    	
    }
    
     public static testmethod void testFactuCreateFactureTATCtrl(){
				
		FactuTestBase.Init();
		Test.startTest();
		FactuTestBase.InitFactures();
		
		
		// TAT et detail facture
		Mission__c m = FactuTestBase.Missions.get(2);
		Test.setCurrentPageReference(new Pagereference('/apex/FactuCreateFacture'));
		System.currentPageReference().getParameters().put('MissionId', m.Id);
		System.currentPageReference().getParameters().put('PlanifsId', m.Planifications_de_facturation__r[0].Id);
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(new Facture__c());
		FactuCreateFactureCtrl ctrl = new FactuCreateFactureCtrl(stdCtrl);
		ctrl.addDetailFacture();
		ctrl.addDetailFacture();
		System.currentPageReference().getParameters().put('detailFactureIndex', '1');
		ctrl.removeDetailFacture();
		ctrl.saveFacture();
		
		Test.stopTest();

    }
    
    public static testmethod void testFactuCreateFactureILCtrl(){
    	
    	FactuTestBase.Init();
    	Test.startTest();
		FactuTestBase.InitFactures();
		
		
		// IL
		Mission__c m = FactuTestBase.Missions.get(3);
		Test.setCurrentPageReference(new Pagereference('/apex/FactuCreateFacture'));
		System.currentPageReference().getParameters().put('MissionId', m.Id);
		System.currentPageReference().getParameters().put('PlanifsId', m.Planifications_de_facturation__r[0].Id);
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(new Facture__c());
		FactuCreateFactureCtrl ctrl = new FactuCreateFactureCtrl(stdCtrl);
		ctrl.saveFacture();
		
		Test.stopTest();
    	
    }
    
    public static testmethod void testFactuCreateFactureFICtrl(){
    	
    	FactuTestBase.Init();
		Test.startTest();
		FactuTestBase.InitFactures();
		
		// FI et avoir
		Mission__c m = FactuTestBase.Missions.get(4);
		Test.setCurrentPageReference(new Pagereference('/apex/FactuCreateFacture'));
		System.currentPageReference().getParameters().put('MissionId', m.Id);
		System.currentPageReference().getParameters().put('PlanifsId', m.Planifications_de_facturation__r[0].Id);
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(new Facture__c());
		FactuCreateFactureCtrl ctrl = new FactuCreateFactureCtrl(stdCtrl);
		ctrl.saveFacture();
		// System.currentPageReference().getParameters().put('MissionId', m.Id);
		// System.currentPageReference().getParameters().put('PlanifsId', m.Planifications_de_facturation__r[1].Id);
		// stdCtrl = new ApexPages.StandardController(new Facture__c());
		// ctrl = new FactuCreateFactureCtrl(stdCtrl);
		// ctrl.saveFacture();
		
		
		Test.stopTest();
    	
    }
    
   

}