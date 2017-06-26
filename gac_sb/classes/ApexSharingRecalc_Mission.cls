/**
 * Utilisé en Queueable dans le trigger
 * mais on prévoit également le Batchable pour faire d'éventuels "Apex Sharing Recalculation"
 */
global class ApexSharingRecalc_Mission implements Database.Batchable<sObject>, Queueable{
	
	static final String INNOadvanceRowCause = Schema.Mission__Share.RowCause.INNO_Advance__c;
	
	
	private Set<Id> relatedContractIds;
	
	global ApexSharingRecalc_Mission(){}
	
	
	global ApexSharingRecalc_Mission(Set<Id> updatedMissionsINNOids){
		this.relatedContractIds = new Set<Id>();
		
		for(INNOmission__c m : [SELECT Id, Contrat__c FROM INNOmission__c WHERE Id IN :updatedMissionsINNOids])
			this.relatedContractIds.add(m.Contrat__c);
	}
	
	/**
	 * Pour le Batchable
	 */
		global Database.QueryLocator start(Database.BatchableContext BC){
			
			List<RecordType> rts = [SELECT Id FROM RecordType WHERE sObjectType = 'Mission__c' 
			                                                            AND (DeveloperName = 'CIR'
			                                                            OR DeveloperName = 'CIN'
			                                                            OR DeveloperName = 'FI')];
			Set<Id> rtIds = new Set<Id>();
			for(RecordType rt : rts){
			    rtIds.add(rt.Id);
			}                      
			
			if(this.relatedContractIds != null)
				return Database.getQueryLocator([SELECT Id, Contrat__c, Annee_concernee__c FROM Mission__c WHERE Contrat__c IN :this.relatedContractIds AND RecordTypeId IN :rtIds AND Annee_concernee__c != null]);
			else
				return Database.getQueryLocator([SELECT Id, Contrat__c, Annee_concernee__c FROM Mission__c WHERE RecordTypeId IN :rtIds AND Annee_concernee__c != null]);
		}
		
		global void execute(Database.BatchableContext BC, List<Mission__c> missions){
			this.recomputeSharing(missions);
		}
	
		global void finish(Database.BatchableContext BC){}
	
	
	
	/**
	 * Pour le Queueable
	 */
	 	global void execute(QueueableContext SC) {
			if(this.relatedContractIds != null)
				this.recomputeSharing([SELECT Id, Contrat__c, Annee_concernee__c FROM Mission__c WHERE Contrat__c IN :this.relatedContractIds]);
			else
				this.recomputeSharing([SELECT Id, Contrat__c, Annee_concernee__c FROM Mission__c]);
		}
	
	
	
	private void recomputeSharing(List<Mission__c> missions){
		
		system.debug('Start: BATCH ApexSharingRecalc_Mission');
		
		system.debug(missions.size() + ' missions Factu');
		
		/*
		*	Map avec:
		* 	Clé: ContractId-AnnéeConcernée
		*	Valeur: L'id de la mission Factu
		*/
		Map<String, Id> missionIdByContractIdAndYear = new Map<String, Id>();
		
		//L'ensemble des Ids de contrats concernés par le chunk de missions
		Set<Id> contratsIds = new Set<Id>();
		
		//Remplissage de missionIdByContractIdAndYear et de contratsIds
		for(Mission__c mission : missions){
			missionIdByContractIdAndYear.put(mission.Contrat__c + '-' + mission.Annee_concernee__c, mission.Id);
			contratsIds.add(mission.Contrat__c);
		}
		
		List<Mission__Share> newMissionShrs = new List<Mission__Share>();
		Id missionId;
		
		//Ajoute un Mission__Share pour chaque membre des équipes consultings
		for(INNOequipeConsulting__c eq : [SELECT Id, Utilisateur__c, Role__c, MissionCIR__r.Contrat__c, MissionCIR__r.Annee_CIR__c FROM INNOequipeConsulting__c WHERE MissionCIR__r.Contrat__c IN :contratsIds AND Utilisateur__r.IsActive = true AND Actif__c = true]){
			missionId = missionIdByContractIdAndYear.get(eq.MissionCIR__r.Contrat__c + '-' + eq.MissionCIR__r.Annee_CIR__c);
			
			if(missionId != null)
				newMissionShrs.add(new Mission__Share(ParentId = missionId, UserOrGroupId = eq.Utilisateur__c, AccessLevel = (eq.Role__c == 'Manager' ? 'Edit' : 'Read'), RowCause = INNOadvanceRowCause));
		}
		
		system.debug(newMissionShrs.size() + ' newMissionShrs');
		
		Database.delete([SELECT Id FROM Mission__Share WHERE ParentId IN :missions AND RowCause = :INNOadvanceRowCause], false);
		Database.insert(newMissionShrs, false);
		system.debug(newMissionShrs.size());
		system.debug('End: BATCH ApexSharingRecalc_Mission');
	}
		
}