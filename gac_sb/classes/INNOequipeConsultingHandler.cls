/**
 * Class INNOequipeConsultingHandler
 *
 * Trigger Handler for the INNOequipeConsulting__c	 SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public without sharing class INNOequipeConsultingHandler implements ITrigger {
	
	private Map<Id, INNOmission__c> involvedMissions;
	
	
	// Constructor
	public INNOequipeConsultingHandler(){
	}

	
	public void bulkBefore(){
	}
	
	public void bulkAfter(){
		
		Set<Id> involvedMissionsIds = new Set<Id>();
		
		for(INNOequipeConsulting__c eq : (List<INNOequipeConsulting__c>) (trigger.isDelete ? trigger.old : trigger.new)){
			involvedMissionsIds.add(eq.MissionCIR__c);
		}
		
		this.involvedMissions = new Map<Id, INNOmission__c>([SELECT Id, (SELECT Id, Role__c, Utilisateur__r.Name FROM EquipesConsulting__r WHERE Actif__c = true) FROM INNOmission__c WHERE Id IN :involvedMissionsIds]);
	}
		
	/**
	*/
	public void beforeInsert(SObject so){
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
	}
	
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
	}
	
	public void afterDelete(SObject so){
	}
	
	/**
	 * andFinally
	 *
	 * This method is called once all records have been processed by the trigger. Use this 
	 * method to accomplish any final operations such as creation or updates of other records.
	 */
	public void andFinally(){
		
		if(!this.involvedMissions.isEmpty()){
			
			//MAJ des champs qui concatène les consultants, superviseurs & managers
			this.computeMissionEquipeRollups();
			update this.involvedMissions.values();
			
			//Recalcul du partage Apex pour les missions et missionsINNO concernées
			if(!Test.isRunningTest()){
				System.enqueueJob(new ApexSharingRecalc_INNOmission(this.involvedMissions.keySet()));
				System.enqueueJob(new ApexSharingRecalc_mission(this.involvedMissions.keySet()));
			}
			
		}
		
	}
	
	
	private void computeMissionEquipeRollups(){
		
		for(INNOmission__c m : this.involvedMissions.values()){
				
				
			Set<String> consultants_scientifiques = new Set<String>();
			Set<String> consultants_exterieurs = new Set<String>();
			Set<String> consultants_fiscalistes = new Set<String>();
			Set<String> auditeurs_financiers = new Set<String>();
			Set<String> managers = new Set<String>();
			Set<String> redacteurs_scientifiques = new Set<String>();

				
			for(INNOequipeConsulting__c eq : m.EquipesConsulting__r){
				
				
				//Concatenation du membre sur le champ 'Consultants scientifiques' de la mission
				if(eq.Role__c == 'Consultant scientifique' || eq.Role__c == 'Superviseur/Consultant' || eq.Role__c == 'Superviseur' || eq.Role__c == 'Superviseur/Consultant')
					consultants_scientifiques.add(eq.Utilisateur__r.Name);
					
				//Concatenation du membre sur le champ 'Consultants exterieurs' de la mission
				else if(eq.Role__c == 'Consultant extérieur')
					consultants_exterieurs.add(eq.Utilisateur__r.Name);
					
				//Concatenation du membre sur le champ 'Rédacteurs scientifiques' de la mission	
				else if(eq.Role__c == 'Redacteur scientifique RO' || eq.Role__c == 'Rédacteur scientifique')
					 redacteurs_scientifiques.add(eq.Utilisateur__r.Name);
				
				//Concatenation du membre sur le champ 'Consultants fiscalistes' de la mission
				else if(eq.Role__c == 'Consultant fiscaliste')
					consultants_fiscalistes.add(eq.Utilisateur__r.Name);
					
				//Concatenation du membre sur le champ 'Auditeur Financier' de la mission
				else if(eq.Role__c == 'Auditeur Financier')
					auditeurs_financiers.add(eq.Utilisateur__r.Name);
					
				//Concatenation du membre sur le champ 'Managers' de la mission
				if(eq.Role__c == 'Manager')
					managers.add(eq.Utilisateur__r.Name);
					
				
			}
			
			
			m.Consultants_scientifiques__c 	= String.join(new List<String>(consultants_scientifiques), ' - ').left(255);
			m.Consultants_exterieurs__c 	= String.join(new List<String>(consultants_exterieurs), ' - ').left(255);
			m.Consultants_fiscalistes__c 	= String.join(new List<String>(consultants_fiscalistes), ' - ').left(255);
			m.Auditeurs_financiers__c 		= String.join(new List<String>(auditeurs_financiers), ' - ').left(255);
			m.Managers__c 					= String.join(new List<String>(managers), ' - ').left(255);
			m.Redacteurs_scientifiques__c   = String.join(new List<String>(redacteurs_scientifiques), ' - ').left(255);

		}
	}
	
	
	/*
	private void computeMissionSharings(){
		
		if(!Test.isRunningTest()){
			
			ApexSharingRecalc_INNOmission INNOmissionApexSharingRecalculation;
			
			
			
			//Si on atteind les limites du nombre de batch simultanés, on lance un recalcul complet dans 3 minutes
			if([SELECT count() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND status in ('Queued', 'Processing', 'Preparing')] >= 4){
				
				//Besoin d'un try catch car ce trigger peut être appelé plusieurs fois, or un job peut être schedulé qu'une fois avec le même nom
				try{
					
					System.debug('Schedule Batch in 3 minute: ApexSharingRecalc_INNOmission');
					INNOmissionApexSharingRecalculation = new ApexSharingRecalc_INNOmission();
					System.scheduleBatch(INNOmissionApexSharingRecalculation, 'INNOmissionApexSharingRecalculation', 3);
					
					
					// system.debug('Schedule Batch in 3 minute: ApexSharingRecalc_Mission');
					// MissionApexSharingRecalculation = new ApexSharingRecalc_Mission();
					// System.scheduleBatch(MissionApexSharingRecalculation, 'MissionApexSharingRecalculation', 3);
				}
				catch(System.Asyncexception e){
					System.debug(e.getMessage());
				}
			}
			
			//Sinon on lance immédiatement un recalcul uniquement sur les missions impliquées
			else{
				System.debug('Launch Batch: ApexSharingRecalc_INNOmission with ' + this.involvedMissions.size() + ' records');
				INNOmissionApexSharingRecalculation = new ApexSharingRecalc_INNOmission(this.involvedMissions.keySet());
				Database.executeBatch(INNOmissionApexSharingRecalculation);
				
				// system.debug('Launch Batch: ApexSharingRecalc_Mission with ' + missionsToUpdateRollupEquipe.size() + ' records');
				// MissionApexSharingRecalculation = new ApexSharingRecalc_Mission(missionsToUpdateRollupEquipe);
				// Database.executeBatch(MissionApexSharingRecalculation);
			}
		}	
	}*/
	
}