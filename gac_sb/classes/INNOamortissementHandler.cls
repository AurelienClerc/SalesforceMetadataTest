/**
 * Class INNOamortissementHandler
 *
 * Trigger Handler for the INNOamortissement__c	 SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public with sharing class INNOamortissementHandler implements ITrigger {
	
	private static final Set<String> populateOptionFiscaleFields = new Set<String>{'Taux_RD'};
	
	//Instances de la classe INNOamortissementUtils par Id de valo
	private Map<Id, INNOamortissementUtils> tauxRDclasses = new Map<Id, INNOamortissementUtils>();
	
	//clé: Id de recordType, valeur: DeveloperName du recordType
	private Map<Id, String> recordTypeDevNamesById = new Map<Id, String>();
	
	
	
	
	// Constructor
	public INNOamortissementHandler(){
	}

	
	public void bulkBefore(){
		//Initialise recordTypeDevNamesById
		for(RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = 'INNOamortissement__c'])	
			this.recordTypeDevNamesById.put(rt.Id, rt.DeveloperName);
			
		/**
		 * Initialise this.tauxRDclasses
		 */
		Set<Id> involvedValoIds = new Set<Id>();
		
		for(INNOamortissement__c amo : (List<INNOamortissement__c>) Trigger.new)
			involvedValoIds.add(amo.Valorisation__c);
			
		for(INNOvalo__c valo : [SELECT Id, Entite__c FROM INNOvalo__c WHERE Id IN :involvedValoIds])
			this.tauxRDclasses.put(valo.Id, new INNOamortissementUtils(valo.Id, valo.Entite__c));
			
	}
	
	public void bulkAfter(){
	}
		
	/**
	*/
	public void beforeInsert(SObject so){
		INNOamortissement__c amo = (INNOamortissement__c) so;
		
		INNOmissionBaseCtrl.populateOptionsFiscales((sObject) amo, populateOptionFiscaleFields);
		
		//Si c'est un DA 'classique' et que la méthode de calcul de taux R&D n'est pas manuelle => on recalcul des taux R&D
		if(recordTypeDevNamesById.get(amo.RecordTypeId) == 'amortissement' && amo.Methode_de_calcul__c != 'Manuelle'){
			this.tauxRDclasses.get(amo.Valorisation__c).refreshTauxRD(amo);
		}
		
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
		INNOamortissement__c oldAmo = (INNOamortissement__c) oldSo;
		INNOamortissement__c amo = (INNOamortissement__c) so;
		
		//Si c'est un DA 'classique' et que la méthode de calcul de taux R&D a changée et n'est pas manuelle, ou qu'on a demandé à forcer le recalcul (via trigger sur les dépenses de personnel) => on recalcul des taux R&D
		if(recordTypeDevNamesById.get(amo.RecordTypeId) == 'amortissement' && amo.Methode_de_calcul__c != 'Manuelle' && (amo.Forcer_recalcul_taux_RD__c || oldAmo.Methode_de_calcul__c != amo.Methode_de_calcul__c)){
			this.tauxRDclasses.get(amo.Valorisation__c).refreshTauxRD(amo);
		}
			
		amo.Forcer_recalcul_taux_RD__c = false;
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
	}
	
}