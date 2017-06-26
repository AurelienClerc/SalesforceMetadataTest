@isTest
public class FactuCreateMissionCtrl_Test {
	
	public static testmethod void testFactuCreateMissionCtrl(){
				
		FactuTestBase.Init();
		Contract c = FactuTestBase.Contracts.get(0);
		
		Test.startTest();
		
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(c);
		FactuCreateMissionCtrl ctrl = new FactuCreateMissionCtrl(stdCtrl);
		ctrl.createMission();
		
		Test.stopTest();

    }
	
}