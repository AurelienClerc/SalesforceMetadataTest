/**
 * Class INNOdepensePrestationHandler
 *
 * Trigger Handler for the INNOdepensePrestation__c	 SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public with sharing class INNOdepensePrestationHandler implements ITrigger {
	
	private static final Set<String> populateOptionFiscaleFields = new Set<String>{'Taux'};

	//Contiendra tous les Id des valos dans lesquelles il faudra mettre à jour les faux rollups
	private Set<Id> valosIdsToUpdateRollups = new Set<Id>();
	
	
	
	
	// Constructor
	public INNOdepensePrestationHandler(){
	}

	
	public void bulkBefore(){
	}
	
	public void bulkAfter(){
	}
		
	/**
	*/
	public void beforeInsert(SObject so){
		INNOdepensePrestation__c presta = (INNOdepensePrestation__c) so;
		
		INNOmissionBaseCtrl.populateOptionsFiscales((sObject) presta, populateOptionFiscaleFields);
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
	}
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
		INNOdepensePrestation__c presta = (INNOdepensePrestation__c) so;
		
		this.valosIdsToUpdateRollups.add(presta.Valorisation__c);
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
		INNOdepensePrestation__c presta = (INNOdepensePrestation__c) so;
		
		this.valosIdsToUpdateRollups.add(presta.Valorisation__c);
	}
	
	public void afterDelete(SObject so){
		INNOdepensePrestation__c presta = (INNOdepensePrestation__c) so;
		
		this.valosIdsToUpdateRollups.add(presta.Valorisation__c);
	}
	
	
	/**
	 * andFinally
	 *
	 * This method is called once all records have been processed by the trigger. Use this 
	 * method to accomplish any final operations such as creation or updates of other records.
	 */
	public void andFinally(){
		
		/**
		*	Calcul des faux rollups sur la valo
		*/
		this.recomputeValosRollups();
	}
	
	
	
	/**
	*	MAJ des faux récapitulatifs de cumul sur les missions des subventions
	*	- Si c'est une défense de brevet, on calcul sur la mission:
	*		- Total défenses de brevets option 1
	*		- Total défenses de brevets option 2
	*		- Total défenses de brevets option 3
	*	- Si c'est une assurance de brevet, on calcul sur la mission:
	*		- Total assurances de brevets option 1
	*		- Total assurances de brevets option 2
	*		- Total assurances de brevets option 3
	*	- Si c'est une prise et maintenance de brevet de type facture, on calcul sur la mission:
	*		- Total PM brevets facture option 1
	*		- Total PM brevets facture option 2
	*		- Total PM brevets facture option 3
	*	- Si c'est une veille de type facture, on calcul sur la mission:
	*		- Total veilles facture option 1
	*		- Total veilles facture option 2
	*		- Total veilles facture option 3
	*	- Si c'est un prestataire public, on calcul sur la mission:
	*		- Total prestataires publics option 1
	*		- Total prestataires publics option 2
	*		- Total prestataires publics option 3
	*	- Si c'est un prestataire agréé, on calcul sur la mission:
	*		- Total prestataires agréés option 1
	*		- Total prestataires agréés option 2
	*		- Total prestataires agréés option 3
	*/
	private void recomputeValosRollups(){
		
		if(!this.valosIdsToUpdateRollups.isEmpty()){
		
			Map<Id, INNOvalo__c> valoRecords = new Map<Id, INNOvalo__c>();
			
			for(Id valoId : this.valosIdsToUpdateRollups){
				
				valoRecords.put(valoId, new INNOvalo__c(Id = valoId,
														Total_brevetPM_facture_option1__c 	= 0,
														Total_brevetPM_facture_option2__c 	= 0,
														Total_brevetPM_facture_option3__c 	= 0,
														Total_brevetDef_option1__c 			= 0,
														Total_brevetDef_option2__c 			= 0,
														Total_brevetDef_option3__c 			= 0,
														Total_brevetAssu_option1__c 		= 0,
														Total_brevetAssu_option2__c 		= 0,
														Total_brevetAssu_option3__c 		= 0,
														Total_veille_facture_option1__c 	= 0,
														Total_veille_facture_option2__c 	= 0,
														Total_veille_facture_option3__c 	= 0,
														Total_prestataire_agree_option1__c 	= 0,
														Total_prestataire_agree_option2__c 	= 0,
														Total_prestataire_agree_option3__c 	= 0,
														Total_prestataire_public_option1__c = 0,
														Total_prestataire_public_option2__c = 0,
														Total_prestataire_public_option3__c = 0
														));
			}
			
			//Recupère toutes les prestations (de tous les recordType) rattachés aux missionsIds
			Integer i;
			String fieldName;
			for(INNOdepensePrestation__c prestation : [SELECT Id, Valorisation__c, RecordType.DeveloperName, Type_organisme__c, Montant_retenu_option1__c, Montant_retenu_option2__c, Montant_retenu_option3__c FROM INNOdepensePrestation__c WHERE Valorisation__c IN :this.valosIdsToUpdateRollups AND RecordTypeId != null]){
				
				if(prestation.RecordType.DeveloperName == 'prestataire')
					fieldName = (prestation.Type_organisme__c == 'Public' ? 'Total_prestataire_public_option' : 'Total_prestataire_agree_option');
				else if (prestation.RecordType.DeveloperName == 'brevetPM' || prestation.RecordType.DeveloperName == 'veille')
					fieldName = 'Total_' + prestation.RecordType.DeveloperName + '_facture_option';
				else
					fieldName = 'Total_' + prestation.RecordType.DeveloperName + '_option';

				
				//Pour chaque option fiscale
				for(i = 1; i <= 3; i++){
					//On incrémente les bon champs en fonction du record type (si c'est une subvention, on incrémente Total_subvention_option1__c, Total_subvention_option2__c et Total_subvention_option3__c)
					valoRecords.get(prestation.Valorisation__c).put(fieldName + i + '__c',  (decimal) valoRecords.get(prestation.Valorisation__c).get(fieldName + i + '__c') + (decimal) prestation.get('Montant_retenu_option' + i + '__c'));
				}
				
			}
	   			
	   		//Update des valos
	   		update valoRecords.values();
			
		}
			
	}
	

}