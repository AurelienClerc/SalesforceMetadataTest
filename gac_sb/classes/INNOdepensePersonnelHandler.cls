/**
 * Class INNOdepensePersonnelHandler
 *
 * Trigger Handler for the INNOdepensePersonnel__c	 SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public with sharing class INNOdepensePersonnelHandler implements ITrigger {
	
	private static final Set<String> populateOptionFiscaleFields = new Set<String>{'Salaire_charge', 'Total_heures_travaillees', 'Salaire_brut_annuel'};

	//Contiendra tous les Id des valos dans lesquelles il faudra mettre à jour les dotations aux amortissements
	private Set<Id> valosIdsToUpdateAmortissement = new Set<Id>();
	
	//copie de l'unité de temps vers le CJO
	private Map<Id,List<INNOpersonnelToProjet__c>> ppsById = new Map<Id,List<INNOpersonnelToProjet__c>>();
	private List<INNOpersonnelToProjet__c> ppsToUpdate = new List<INNOpersonnelToProjet__c>();
	
	// Constructor
	public INNOdepensePersonnelHandler(){
	}

	
	public void bulkBefore(){
	}
	
	public void bulkAfter(){
	    
	    if(Trigger.isUpdate){
	        List<INNOpersonnelToProjet__c> pps = [SELECT Id, Depense_de_personnel__c FROM INNOpersonnelToProjet__c WHERE Depense_de_personnel__c IN :Trigger.new];
            for(INNOpersonnelToProjet__c pp : pps){
                if(!ppsById.containsKey(pp.Depense_de_personnel__c))
                    ppsById.put(pp.Depense_de_personnel__c, new List<INNOpersonnelToProjet__c>());
                ppsById.get(pp.Depense_de_personnel__c).add(pp);
            }
	    }
	}
		
	/**
	*/
	public void beforeInsert(SObject so){
		INNOdepensePersonnel__c personnel = (INNOdepensePersonnel__c) so;
		
		INNOmissionBaseCtrl.populateOptionsFiscales((sObject) personnel, populateOptionFiscaleFields);
		
		initDefaultValues(personnel);
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
		INNOdepensePersonnel__c oldPersonnel = (INNOdepensePersonnel__c) oldSo;
		INNOdepensePersonnel__c personnel = (INNOdepensePersonnel__c) so;
		
		initDefaultValues(personnel);
	}
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
		INNOdepensePersonnel__c personnel = (INNOdepensePersonnel__c) so;
		
		if(personnel.Actif__c){												//SI on ajoute un personnel actif 
			valosIdsToUpdateAmortissement.add(personnel.Valorisation__c);	//ALORS il faudra faire un update des dotations aux amortissements de la valo
		}
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
		INNOdepensePersonnel__c oldPersonnel = (INNOdepensePersonnel__c) oldSo;
		INNOdepensePersonnel__c personnel = (INNOdepensePersonnel__c) so;
		
		
		//Si un des champs suivant a changé: Actif, Département, les Heures R&D, le total des heures travaillées		
		if(oldPersonnel.Actif__c != personnel.Actif__c || oldPersonnel.Departement__c != personnel.Departement__c || oldPersonnel.Heures_RD_option1__c != personnel.Heures_RD_option1__c || oldPersonnel.Heures_RD_option2__c != personnel.Heures_RD_option2__c || oldPersonnel.Heures_RD_option3__c != personnel.Heures_RD_option3__c || oldPersonnel.Total_heures_travaillees_option1__c != personnel.Total_heures_travaillees_option1__c || oldPersonnel.Total_heures_travaillees_option2__c != personnel.Total_heures_travaillees_option2__c || oldPersonnel.Total_heures_travaillees_option3__c != personnel.Total_heures_travaillees_option3__c){
			valosIdsToUpdateAmortissement.add(personnel.Valorisation__c);	//ALORS il faudra faire un update des dotations aux amortissements de la valo
		}
				
		if(oldPersonnel.UniteTempsDepensesPersonnel__c != personnel.UniteTempsDepensesPersonnel__c){
		    setPPUnite(personnel);
		}
		
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
		
		/**
		*	On effectue l'update des dotations aux amortissements si c'est nécéssaire
		*/
		if(valosIdsToUpdateAmortissement.size() > 0){
			//La liste des dotations aux amortissements qu'il faudra mettre à jour
			List<INNOamortissement__c> amortissementsToUpdate = [SELECT Id, Valorisation__c FROM INNOamortissement__c WHERE Valorisation__c IN :valosIdsToUpdateAmortissement AND Methode_de_calcul__c != 'Manuelle'];
			for(INNOamortissement__c amo : amortissementsToUpdate)
				amo.Forcer_recalcul_taux_RD__c = true;
			
			//Update les dotations aux amortissements nécéssaires	
			update amortissementsToUpdate;
		}
		
		if(this.ppsToUpdate.size() > 0){
			update this.ppsToUpdate;
		}
		
	}
	
	
	
	private void initDefaultValues(INNOdepensePersonnel__c personnel){
		personnel.Name = personnel.Prenom__c + ' ' + personnel.Nom__c;
		
		//Si les champs Heures_XXXX_optionY__c sont null, on y met 0
		for(String f : new Set<String>{'RD','veille','normalisation','brevetPM'}){
			for(Integer i = 1; i < 4; i++){
				if(personnel.get('Heures_' + f + '_option' + String.valueOf(i) + '__c') == null)
					personnel.put('Heures_' + f + '_option' + String.valueOf(i) + '__c', 0);
			}
		}
	}
	
	private void setPPUnite(INNOdepensePersonnel__c personnel){
		
		if(this.ppsById.containsKey(personnel.Id)){
		    for(INNOpersonnelToProjet__c pp : this.ppsById.get(personnel.Id)){
		        pp.UniteTempsDepensesPersonnel2__c = personnel.UniteTempsDepensesPersonnel__c;
		        this.ppsToUpdate.add(pp);
		    }
		}          
	}
}