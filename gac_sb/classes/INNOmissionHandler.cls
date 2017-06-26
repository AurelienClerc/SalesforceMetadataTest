/**
 * Class INNOmissionHandler
 *
 * Trigger Handler for the INNOmission__c	 SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public with sharing class INNOmissionHandler implements ITrigger {
	
	
	private Set<INNOmission__c> missiondToRetrieveCoutsStandards = new Set<INNOmission__c>();
	
	
	// Constructor
	public INNOmissionHandler(){
	}

	
	public void bulkBefore(){
	}
	
	public void bulkAfter(){
	}
		
	/**
	*/
	public void beforeInsert(SObject so){
		INNOmission__c m = (INNOmission__c) so;
		
		if(m.Cout_standard_INNO_advance__c == null)
			this.missiondToRetrieveCoutsStandards.add(m);
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
		INNOmission__c oldM = (INNOmission__c) oldSo;
		INNOmission__c m = (INNOmission__c) so;
		
		if(oldM.Statut__c != 'Active' && m.Statut__c == 'Active')
			this.missiondToRetrieveCoutsStandards.add(m);
			
		if(m.Date_Initiale_echeance_DT__c == null && m.Date_fin_justification_recap__c != null)
			m.Date_Initiale_echeance_DT__c = m.Date_fin_justification_recap__c;
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

		//Récupère les couts standards		
		this.retrieveCoutsStandards();
	}
	
	
	
	private void retrieveCoutsStandards(){
		
		if(!this.missiondToRetrieveCoutsStandards.isEmpty()){
		
			List<INNOcoutStandard__c> coutsStandards = [SELECT Id FROM INNOcoutStandard__c ORDER BY CreatedDate DESC LIMIT 1];

			if( ! coutsStandards.isEmpty() ){
				for(INNOmission__c m : this.missiondToRetrieveCoutsStandards)
					m.Cout_standard_INNO_advance__c = coutsStandards[0].Id;
			}
			
		}
			
	}
	

}