global class FactuApexScheduler implements Schedulable{
   global void execute(SchedulableContext SC) {
      FactuDecalePrevision ba = new FactuDecalePrevision();	//Mise a jour des vieilles prévision encaissemenent
      database.executeBatch(ba );
      new FactuMailPlanif();		//Envoi des mails de retard de planif
   }
   
   public static testMethod void testFactuSchedule() {

		Test.StartTest();
		FactuApexScheduler sh = new FactuApexScheduler();
        String sch = '0 0 23 * * ?';
        system.schedule('Test Territory Check', sch, sh);
		Test.stopTest();
		
		}
   
}