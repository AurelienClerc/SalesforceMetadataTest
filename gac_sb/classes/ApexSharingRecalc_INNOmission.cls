/**
 * Utilisé en Queueable dans le trigger
 * mais on prévoit également le Batchable pour faire d'éventuels "Apex Sharing Recalculation"
 */
global without sharing class ApexSharingRecalc_INNOmission implements Database.Batchable<sObject>, Queueable{
	
	private static final String equipeConsultingMissionRowCause = Schema.INNOmission__Share.RowCause.Equipe_Consulting__c;
	
	private Set<Id> updatedMissionsINNOids;
	

	global ApexSharingRecalc_INNOmission(){}
	
	
	global ApexSharingRecalc_INNOmission(Set<Id> updatedMissionsINNOids){
		this.updatedMissionsINNOids = updatedMissionsINNOids;
	}
	

	/**
	 * Pour le Batchable
	 */
		global Database.QueryLocator start(Database.BatchableContext BC){
			if(this.updatedMissionsINNOids != null)
				return Database.getQueryLocator([SELECT Id FROM INNOmission__c WHERE Id IN :this.updatedMissionsINNOids]);
			else
				return Database.getQueryLocator([SELECT Id FROM INNOmission__c]);
		}
		
		global void execute(Database.BatchableContext BC, List<INNOmission__c> scope){
			this.recomputeSharing(scope);
		}
		
		global void finish(Database.BatchableContext BC){}
	
	
	/**
	 * Pour le Queueable
	 */
		global void execute(QueueableContext SC) {
			if(this.updatedMissionsINNOids != null)
				this.recomputeSharing([SELECT Id FROM INNOmission__c WHERE Id IN :this.updatedMissionsINNOids]);
			else
				this.recomputeSharing([SELECT Id FROM INNOmission__c]);
		}
	
	
	
	
	private void recomputeSharing(List<INNOmission__c> missionsINNO){
			
		system.debug('Start: BATCH ApexSharingRecalc_INNOmission');
		
		List<INNOmission__Share> newMissionINNOShrs = new List<INNOmission__Share>();
		
		system.debug(missionsINNO.size() + ' missions INNO');
		
		for(INNOequipeConsulting__c eq : [SELECT Id, MissionCIR__c, Utilisateur__c, Role__c FROM INNOequipeConsulting__c WHERE MissionCIR__c IN :missionsINNO AND Utilisateur__r.IsActive = true AND Actif__c = true]){
			newMissionINNOShrs.add(new INNOmission__Share(ParentId = eq.MissionCIR__c, UserOrGroupId = eq.Utilisateur__c, AccessLevel = (eq.Role__c == 'Consultant extérieur' ? 'Read' : 'Edit'), RowCause = equipeConsultingMissionRowCause));
		}
		
		system.debug(newMissionINNOShrs.size() + ' newMissionINNOShrs');
		
		Database.delete([SELECT Id FROM INNOmission__Share WHERE ParentId IN :missionsINNO AND RowCause = :equipeConsultingMissionRowCause], false);
		
		Database.insert(newMissionINNOShrs, false);
			
		system.debug('End: BATCH ApexSharingRecalc_INNOmission');
	}
	
}