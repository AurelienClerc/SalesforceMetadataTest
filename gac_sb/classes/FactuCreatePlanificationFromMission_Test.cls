@isTest
public class FactuCreatePlanificationFromMission_Test {

	public static testmethod void testFactuCreatePlanificationFromMissionCtrl(){
				
		FactuTestBase.Init();
		Mission__c m = FactuTestBase.Missions.get(0);
		
		Test.startTest();
		
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(m);
		FactuCreatePlanificationFromMissionCtrl ctrl = new FactuCreatePlanificationFromMissionCtrl(stdCtrl);
		ctrl.createPlanification();
		
		Test.stopTest();

    }

}