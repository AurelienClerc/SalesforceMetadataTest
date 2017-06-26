global without sharing class INNOtimeSheet {
	
    public INNOtimeSheet(INNOtimeSheetPlanningCtrl2 controller){}
    
	public static void fillingLastWeekTimeSheetReminder(){
		
		//Le role des consultants devant remplir leurs TimeSheet
		String TimeSheetUserRole = 'GAC_World_Wide';//'SCIENTIFIQUE_CONSULTANT'; 
		
		//Lundi dernier
		Date lastMonday = system.today().toStartOfWeek().addDays(-7);
	
	
		//Tous les utilisateurs devant remplir une TimeSheet
		Map<Id, User> timeSheetUsers = new Map<Id, User>([SELECT Id, Name, Email, ManagerId, Manager.Email FROM User WHERE IsActive = true AND UserRole.DeveloperName = :TimeSheetUserRole ]);
		
		//Boucle sur tous les consultants qui ont bien rempli 5 jours sur leur TimeSheet de la semaine précédente
		for(AggregateResult aggr : [SELECT SUM(Duree__c) total, Utilisateur__c  FROM INNOtimeSheet__c WHERE Date__c >= :lastMonday AND Date__c <= :lastMonday.addDays(4) AND Utilisateur__r.IsActive = true AND Utilisateur__r.UserRole.DeveloperName = :TimeSheetUserRole GROUP BY Utilisateur__c HAVING SUM(Duree__c) = 5]){
			
			//On supprime le consultant de timeSheetUsers car il a bien rempli sa TimeSheet, il ne nous intéresse donc plus
			timeSheetUsers.remove((Id) aggr.get('Utilisateur__c'));
		}

		
		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		Messaging.SingleEmailMessage mail;
		
		
		Id emailTemplateId = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'INNO_Rappel_remplissage_TimeSheet' LIMIT 1][0].Id;
		
		String addresses = '';
		
		for(User u : timeSheetUsers.values()){
			mail = new Messaging.SingleEmailMessage();
			
			mail.setTemplateID(emailTemplateId);
			mail.setUseSignature(false);
	    	mail.setSaveAsActivity(false);
	    	
			mail.setTargetObjectId(u.Id);
			if(u.Manager.Email != null)
				mail.setCcAddresses( new List<String>{u.Manager.Email} );
			
			mails.add(mail);
			
			addresses += u.Email + ', ';
		}
		
		system.debug('Tentative d\'envoi de ' + mails.size() + ' emails de rappel de remplissage de TimeSheet');
		system.debug('Destinataires: ' + addresses);
		
		Integer nbEmailSuccess = 0;
		
		for(Messaging.SendEmailResult result : Messaging.sendEmail(mails, false)){
			if(result.isSuccess())
				nbEmailSuccess ++;
			else{
				for(Messaging.SendEmailError error : result.getErrors()){
					system.debug('Erreur d\'envoi pour ' + error.getTargetObjectId() + ' : ' + error.getMessage());
				}
			}
		}
		
		system.debug('Emails correctement envoyés : ' + nbEmailSuccess);
	}
	
	
	
	public static Boolean saveTimeSheet(String missionId, String tsDate, String phase, String dureeStr, String userId){
		
        missionId = (missionId == 'general' ? null : missionId);
		Decimal duree = String.isBlank(dureeStr) ? 0 : decimal.valueOf(dureeStr);
        phase = INNOtimeSheetCtrl.PHASES_LABELS.get(phase);
		String[] dateSplit = tsDate.split('-');
        Date d = Date.newInstance(Integer.valueOf(dateSplit[0]), Integer.valueOf(dateSplit[1]), Integer.valueOf(dateSplit[2]));
        Boolean theorique = (d < System.today().toStartOfWeek() || d > System.today().toStartOfWeek().addDays(4));
		if(String.isBlank(userId))
			userId = UserInfo.getUserId();
		
		//Si on rempli la TS d'un autre utilisateur, on vérifi qu'on est Superviseur ou Manager sur la mission
		if(String.isNotBlank(missionId) && userId != UserInfo.getUserId()){
			List<INNOequipeConsulting__c> equipes = [SELECT Id FROM INNOequipeConsulting__c WHERE MissionCIR__c = :missionId AND Utilisateur__c = :UserInfo.getUserId() AND Actif__c = true AND (Role__c = 'Superviseur' OR Role__c = 'Manager')];
			if(equipes.isEmpty())
				return false;
		}
		
		INNOtimeSheet__c ts;
		try{

			List<INNOtimeSheet__c> tsList = [SELECT Id, Duree__c FROM INNOtimeSheet__c WHERE Utilisateur__c = :userId AND Mission_CIR__c = :missionId AND Date__c = :d AND Phase__c = :phase LIMIT 1];
			
			Savepoint sp = Database.setSavepoint();

			if(!tsList.isEmpty()){
				ts = tsList[0];
        
				if(duree == 0){
					Database.delete(ts);
				}
				else{
					ts.Duree__c = duree;
					ts.Theorique__c = theorique;
					update ts;
				}
			}
			else if(duree != 0){
				
				ts = new INNOtimeSheet__c(Mission_CIR__c = missionId, Utilisateur__c = userId, Date__c = d, Phase__c = phase, Duree__c = duree, Theorique__c = theorique, Passee__c = (d <= System.today()));
				insert ts;
			}
			
            Decimal totalTime = (Decimal) [SELECT SUM(Duree__c) sum FROM INNOtimeSheet__c WHERE Utilisateur__c = :userId AND Date__c = :d][0].get('sum');
            if(totalTime != null && totalTime > 1){
				Database.rollback(sp);
				throw new TriggerException();
            }

			return true;
		}
		catch(Exception e){
			return false;
		}
	}
	
}