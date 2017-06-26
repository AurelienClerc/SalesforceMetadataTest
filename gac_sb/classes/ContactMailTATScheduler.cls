/*
* Classe d'envoi des mail de rappel aux clients pour qu'ils envoient leur compte employeur au client tout les mois
* Mis en prod le 14/02/2014 
* Scheduler d'envoi de la classe
*/
global class ContactMailTATScheduler implements Schedulable{
	global void execute(SchedulableContext SC) {
       ContactMailTATBatchContext BA01 = new ContactMailTATBatchContext();
       database.executeBatch(BA01,50);  //Batch size de 10 pour ce WebService
      
      /*
      //Récupération du jour
      Boolean isRelance = Date.today().day() > 10;
      
      //5 Jour avant
      Date lastMail = date.today() - 6;
      DateTime lastMailDt = Datetime.newInstance(lastMail.year(), lastMail.month(), lastMail.day());
      
      ContactMailTAT.IgnoreTaskTrigger = true;
      //On evite les list has no row
      Contact[] cs = [select id,Date_dernier_email_TAT__c,AccountId,Account.Consultant_mission_T_A_T__r.Name,Account.Comptes_employeurs_recus_ce_mois__c,Account.Consultant_mission_T_A_T__r.Email 
      										from Contact where 
      											( Date_dernier_email_TAT__c = null OR Date_dernier_email_TAT__c < : lastMailDt) 
                      							AND 
      											Envoyer_mail_TAT__c = true //Envoyer mail TAT est un champ formule
      											LIMIT 300];
      if(!cs.isEmpty())
     	new ContactMailTAT(cs,isRelance);	
    	*/
   }
}