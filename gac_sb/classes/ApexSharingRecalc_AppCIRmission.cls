global without sharing class ApexSharingRecalc_AppCIRmission implements Database.Batchable<sObject>{
	
	static final String equipeConsultingMissionRowCause = Schema.AppCIRmission__Share.RowCause.Equipe_Consulting__c;
	static final String equipeConsultingEntiteRowCause = Schema.AppCIRentite__Share.RowCause.Equipe_Consulting__c;
	static final String emailAddress = 'contact@synefo.fr';
	
	private Set<Id> updatedMissionsINNOids;
	
	private Set<Id> relatedEntitesIds = new Set<Id>();
	
	
	global ApexSharingRecalc_AppCIRmission(){}
	
	
	global ApexSharingRecalc_AppCIRmission(Set<Id> updatedMissionsINNOids){
		this.updatedMissionsINNOids = updatedMissionsINNOids;
	}
	
	
	global Database.QueryLocator start(Database.BatchableContext BC){
		/*
		if(this.updatedMissionsINNOids != null){
			
			for(AppCIRmission__c m : [SELECT Id, Entite__c FROM AppCIRmission__c WHERE Id IN :updatedMissionsINNOids]){
				this.relatedEntitesIds.add(m.Entite__c);
			}
			
			return Database.getQueryLocator([SELECT Id FROM AppCIRmission__c WHERE Entite__c IN :relatedEntitesIds ORDER BY Entite__c]);
		}
		else
			return Database.getQueryLocator([SELECT Id FROM AppCIRmission__c ORDER BY Entite__c]);
		*/

		if(this.updatedMissionsINNOids != null){
			
			for(AppCIRmission__c m : [SELECT Id, Entite__c FROM AppCIRmission__c WHERE Id IN :updatedMissionsINNOids]){
				this.relatedEntitesIds.add(m.Entite__c);
			}
			
			return Database.getQueryLocator([SELECT Id FROM AppCIRentite__c WHERE Id IN :relatedEntitesIds ]);
		}
		else
			return Database.getQueryLocator([SELECT Id FROM AppCIRentite__c ]);

	}

	
	
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		
		system.debug('Start: BATCH ApexSharingRecalc_AppCIRmission');
		

		List<AppCIRentite__c> entites = (List<AppCIRentite__c>) scope;
		List<AppCIRmission__c> missionsINNO = [SELECT Id FROM AppCIRmission__c WHERE Entite__c IN :entites];
		//List<AppCIRmission__c> missionsINNO = (List<AppCIRmission__c>) scope;
		
		
		// Create a list of Mission__Share objects to be inserted.
		List<AppCIRmission__Share> newMissionINNOShrs = new List<AppCIRmission__Share>();
		
		//On sépare les entités share en 2: read et edit, pour ensuite insérer les Edit APRES les Read afin de surcharger le Read si necessaire
		List<AppCIRentite__Share> newEntiteINNOReadShrs = new List<AppCIRentite__Share>();
		List<AppCIRentite__Share> newEntiteINNOEditShrs = new List<AppCIRentite__Share>();
		
		system.debug(missionsINNO.size() + ' missions INNO');
		//this.relatedEntitesIds = new Set<Id>();
		
		for(AppCIRequipeConsulting__c eq : [SELECT Id, Mission_CIR__c, Mission_CIR__r.Entite__c, Utilisateur__c, Role__c FROM AppCIRequipeConsulting__c WHERE Mission_CIR__r.Entite__c IN :entites AND Utilisateur__r.IsActive = true AND Actif__c = true]){
			
			newMissionINNOShrs.add(new AppCIRmission__Share(ParentId = eq.Mission_CIR__c, UserOrGroupId = eq.Utilisateur__c, AccessLevel = (eq.Role__c == 'Consultant extérieur' ? 'Read' : 'Edit'), RowCause = equipeConsultingMissionRowCause));
			
			if(eq.Role__c == 'Consultant extérieur')
				newEntiteINNOReadShrs.add(new AppCIRentite__Share(ParentId = eq.Mission_CIR__r.Entite__c, UserOrGroupId = eq.Utilisateur__c, AccessLevel = 'Read', RowCause = equipeConsultingEntiteRowCause));
			else
				newEntiteINNOEditShrs.add(new AppCIRentite__Share(ParentId = eq.Mission_CIR__r.Entite__c, UserOrGroupId = eq.Utilisateur__c, AccessLevel = 'Edit', RowCause = equipeConsultingEntiteRowCause));
			
			//this.relatedEntitesIds.add(eq.Mission_CIR__r.Entite__c);
		}
		
		
		newEntiteINNOReadShrs.addAll(newEntiteINNOEditShrs);
		
		
		system.debug(newMissionINNOShrs.size() + ' newMissionINNOShrs');
		system.debug(newEntiteINNOReadShrs.size() + ' newEntiteINNOShrs');
		
		
		try {
			// Locate and delete all existing sharing records for the Mission records in the batch.
			// This allows new sharing records to be written from scratch.
			Database.delete([SELECT Id FROM AppCIRmission__Share WHERE ParentId IN :missionsINNO AND RowCause = :equipeConsultingMissionRowCause], false);
			Database.delete([SELECT Id FROM AppCIRentite__Share WHERE ParentId IN :entites AND RowCause = :equipeConsultingEntiteRowCause], false);
			
			
			// Insert the new sharing records and capture the save result. 
			// The false parameter allows for partial processing if multiple records are 
			// passed into operation. 
			Database.SaveResult[] lsr = Database.insert(newMissionINNOShrs, false);
			lsr.addAll(Database.insert(newEntiteINNOReadShrs, false));
			
			// Process the save results for insert.
			for(Database.SaveResult sr : lsr){
				if(!sr.isSuccess()){
					// Get the first save result error.
					Database.Error err = sr.getErrors()[0];
					
					// Check if the error is related to trivial access level.
					// Access levels equal or more permissive than the object's default 
					// access level are not allowed. 
					// These sharing records are not required and thus an insert exception 
					// is acceptable. 
					if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
								&&  err.getMessage().contains('AccessLevel'))){
						// Error is not related to trivial access level.
						// Send an email to the Apex job's submitter.
						Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
						String[] toAddresses = new String[] {emailAddress}; 
						mail.setToAddresses(toAddresses); 
						mail.setSubject('GAC: INNO Advance - AppCIRmission Apex Sharing Recalculation sur UN record');
						mail.setPlainTextBody('Apex sharing recalculation exception: \n' + err.getMessage() + '\n' + err.getFields());
						system.debug('Exception sur un record: ' + err.getMessage() + '-' + err.getFields());
						Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
					}
				}
			}  
		} catch(DmlException e) {
			//Send an email to the Apex job's submitter on failure.
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[] {emailAddress}; 
			mail.setToAddresses(toAddresses); 
			mail.setSubject('GAC: INNO Advance - AppCIRmission Apex Sharing Recalculation');
			mail.setPlainTextBody('Apex sharing recalculation exception: \n' + e.getMessage());
			system.debug('Exception globale: ' + e.getMessage());
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
		
		system.debug('End: BATCH ApexSharingRecalc_AppCIRmission');
	}
	
	

	global void finish(Database.BatchableContext BC){}
	
	
}