@isTest
public class FactuSelectPlanificationsCtrl_Test {

	public static testmethod void testFactuSelectPlanificationsCtrl(){
				
		FactuTestBase.Init();
		Mission__c m = FactuTestBase.Missions.get(0);
		
		Test.startTest();
		
		System.currentPageReference().getParameters().put('id', m.Id);
		FactuSelectPlanificationsCtrl ctrl = new FactuSelectPlanificationsCtrl();
		ctrl.selectedPlanifications = new List<Id>{ctrl.lsSelectOptionPlanifications.get(0).getValue()};
		ctrl.CreateFactu();
		
		Test.stopTest();

    }	

}