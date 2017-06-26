/**
 * Class INNOtimeSheetHandler
 *
 * Trigger Handler for the INNOtimeSheet__c	 SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public with sharing class INNOtimeSheetHandler implements ITrigger {
	
	private Set<Id> involvedMissionIds = new Set<Id>();
	private Set<Id> involvedUserIds = new Set<Id>();
	
	
	// Constructor
	public INNOtimeSheetHandler(){
	}

	
	public void bulkBefore(){
	}
	
	public void bulkAfter(){
	}
		
	public void beforeInsert(SObject so){
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
	}
	
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
		INNOtimeSheet__c ts = (INNOtimeSheet__c) so;
		
		this.involvedMissionIds.add(ts.Mission_CIR__c);
		this.involvedUserIds.add(ts.Utilisateur__c);
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
		INNOtimeSheet__c ts = (INNOtimeSheet__c) so;
		
		this.involvedMissionIds.add(ts.Mission_CIR__c);
		this.involvedUserIds.add(ts.Utilisateur__c);
	}
	
	public void afterDelete(SObject so){
		INNOtimeSheet__c ts = (INNOtimeSheet__c) so;
		
		this.involvedMissionIds.add(ts.Mission_CIR__c);
		this.involvedUserIds.add(ts.Utilisateur__c);
	}
	
	/**
	 * andFinally
	 *
	 * This method is called once all records have been processed by the trigger. Use this 
	 * method to accomplish any final operations such as creation or updates of other records.
	 */
	public void andFinally(){
		
		this.computeEquipeConsultingRollups();
		
	}
	
	
	private void computeEquipeConsultingRollups(){
		
		this.involvedMissionIds.remove(null);
		this.involvedUserIds.remove(null);
		
		
		if(!this.involvedMissionIds.isEmpty()){
			
			/**
			 * Création des copies des equipes consulting à updater
			 *  - clé: userId-missionId
			 *  - valeur: l'equipe consulting correspondante
			 */
			Map<String, INNOequipeConsulting__c> equipesRecords = new Map<String, INNOequipeConsulting__c>();
		
			for(INNOequipeConsulting__c eq : [SELECT Id, Utilisateur__c, MissionCIR__c FROM INNOequipeConsulting__c WHERE MissionCIR__c IN :this.involvedMissionIds AND Utilisateur__c IN :this.involvedUserIds]){
				equipesRecords.put(eq.Utilisateur__c + '-' + eq.MissionCIR__c, new INNOequipeConsulting__c(Id 											= eq.Id,
																											Nombre_jours_travailles_Audit__c 			= 0,
																											Nombre_jours_travailles_Valorisation__c 	= 0,
																											Nombre_jours_travailles_Justification__c 	= 0,
																											Nombre_jours_travailles_Controle__c 		= 0,
																											Nombre_jours_programmes_Audit__c 			= 0,
																											Nombre_jours_programmes_Valorisation__c 	= 0,
																											Nombre_jours_programmes_Justification__c 	= 0,
																											Nombre_jours_programmes_Controle__c 		= 0
																										));
			}
			
			system.debug(equipesRecords);
			
			INNOequipeConsulting__c tempEq;
			String tempFieldName;
			for(INNOtimeSheet__c ts : [SELECT Id, Duree__c, Mission_CIR__c, Utilisateur__c, Phase_technique__c, Passee__c FROM INNOtimeSheet__c WHERE Mission_CIR__c IN :this.involvedMissionIds AND Utilisateur__c IN :this.involvedUserIds AND Duree__c > 0 AND Phase__c IN ('Audit', 'Valorisation', 'Justification', 'Contrôle', 'Controle')]){
				
				tempEq = equipesRecords.get(ts.Utilisateur__c + '-' + ts.Mission_CIR__c);
				
				if(tempEq != null){
					tempFieldName = 'Nombre_jours_' + (ts.Passee__c ? 'travailles' : 'programmes') + '_' + ts.Phase_technique__c + '__c';
					tempEq.put(tempFieldName, (decimal) tempEq.get(tempFieldName) + ts.Duree__c);
				}
	
				
			}
			
			update equipesRecords.values();
		}
		
		
	}
	
}