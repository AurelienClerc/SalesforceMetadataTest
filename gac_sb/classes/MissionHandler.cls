public with sharing class MissionHandler implements ITrigger {


	/*
	*	La liste des Id de contrat impactés
	*	Pour mettre à jour l'année de 1ere mission
	*/
	private List<Id> contractToUpdateIds = new List<Id>();
	
	// EDIT DIDIER 30/10/2013
	/*
	* Lorsqu'une mission change de contrat, on doit réinitialiser les champs de la mission
	* avec les valeurs du nouveau contrat
	*/
	private map<Id,Contract> NewContract = new map<Id,Contract>();
	
	//EDIT DIDIER 19/02/2015 Réaffectation des factures
	private static map<id,id> OldContractToNewContractId;
	
	private static boolean reafectMissionDone = false;
	
	/*
	* Liste des champs de la mission a mettre a jour avec ceux du contrat
	* Utilisé lorsqu'une mission change de contrat
	* ContractField -> missionField
	*/
	private static final map<string,string> ContractFieldToMissionField = new Map<String,String>{
		'AccountId' 						=> 'Compte__c',
		'Conditions_de_renouvellement__c' 	=> 'Cond_renouvellement__c',
		'Conditions_de_facturation__c'		=> 'Conds_facturation__c',
		'Conditions_de_paiement__c'			=> 'Conds_paiement__c',
		'Conditions_de_remuneration__c'		=> 'Conds_remuneration__c',
		'Precision_facturation__c'			=> 'Precision_facturation__c',
		'Precision_paiement__c'				=> 'Precision_paiement__c',
		'Precision_remuneration__c'			=> 'Precision_remuneration__c',
		'Consultant_Commercial__c'			=> 'Contrat_signe_par__c',
		'Conditions_particuli_res__c'		=> 'Conditions_particuli_res__c',
		'ContractTerm'						=> 'Dur_e_initiale_mois__c',
		'Preavis_de_resiliation__c'			=> 'Pr_avis_r_siliation_mois__c',
		'Remuneratuin_future__c'			=> 'R_mun_ration_future__c',
		'Taux_de_remuneration__c'			=> 'Taux_de_r_mun_ration__c'
	};
	
	//FIN EDIT DIDIER 30/10/2013
	static{
	    OldContractToNewContractId = new Map<Id,Id>();
	}
	
	/*
	*	La liste des Id de mission delete à ne pas utiliser
	*	Pour mettre à jour l'année de 1ere mission
	*/
	private List<Id> missionDeletedIds = new List<Id>();



	/**
	*	EDIT THIBAULT 22/02/2014
	*	Contient tous les Id de contrats pour lesquels il faut recalculer le champ "Missions N-1" de toutes leurs missions
	*	
	*	Ajouté pour remplacer le code de fred ci dessous qui emplosait les limites car le select etait appelé pour chaque mission...
	*	
	*	// Edit Fred le 22/11/2013
	*	// On récupère la mission de l'année N-1 si le champ est vite
	*	Mission__c mission = (Mission__c) so;
	*	if(mission.Mission_N_1__c == null){
	*		if(mission.Annee_concernee__c != null && mission.Annee_concernee__c != 'Outros'){
	*			List<Mission__c> Missions = [SELECT Id FROM Mission__c WHERE Id <>: mission.Id AND Contrat__c =: mission.Contrat__c AND Annee_concernee__c =: string.ValueOf(integer.ValueOf(mission.Annee_concernee__c)-1) LIMIT 1];
	*			if(Missions.size() > 0){
	*				mission.Mission_N_1__c = Missions[0].Id;
	*			}
	*		}
	*	}
	*/
	private Set<Id> contractIdsToComputeMissionNmoins1 = new Set<Id>();


	public MissionHandler(){
	}
	
	
	public void bulkBefore(){
		
		
		//EDIT DIDIER 30/10 (toute la méthode)
		map<Id,Id> ContractMissionChangedId = new map<Id,Id>();
		 
		if(Trigger.isUpdate){
			for(Mission__c m : (Mission__c[])trigger.new){
				if(trigger.oldMap.get(m.id).get('Contrat__c') != m.Contrat__c){
					ContractMissionChangedId.put(m.Id,(Id) m.get('Contrat__c'));
				}
			}
			List<String> ContractField = new List<string>();
			contractField.addAll(ContractFieldToMissionField.keySet());
			Map<Id,Contract> ContractMap = new Map<Id,Contract>();
			List<Id> ContractIdList = ContractMissionChangedId.values();
			for(Contract c : database.Query('SELECT id, '+ String.join(ContractField,',') + ' FROM contract where id in : ContractIdList')){
				ContractMap.put(c.id,c);				
			}
			for(Id mId : ContractMissionChangedId.keySet()){
				NewContract.put(mId,ContractMap.get(ContractMissionChangedId.get(mId)) );
			}
		}
		//FIN EDIT DIDIER
		
		
	}
	
	public void bulkAfter(){
	    
	}
		
		
	public void beforeInsert(SObject so){
		
		
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
		//Edit DIDIER 30/10/2013
		//On remet a jour les champs de la mission
		if(NewContract.containsKey(so.id)){
			for(String f : ContractFieldToMissionField.keySet()){
				so.put(ContractFieldToMissionField.get(f),NewContract.get(so.id).get(f));
			}
		}
		//Fin EDIT Didier 30/10/2013
		

	}
	
	public void beforeDelete(SObject so){
		Mission__c mission = (Mission__c) so;
		
		//Impossible de supprimer une mission sur laquelle est rattaché des facture ou des planifs facturée
		if(mission.Nb_factures__c > 0 || mission.Nb_planifications_facturees__c > 0)
			mission.addError(Label.Factu_erreur_supprimer_mission);
			
		
	}
	
	
	public void afterInsert(SObject so){
		this.contractIdsToComputeMissionNmoins1.add((Id) so.get('Contrat__c'));
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
				
		Mission__c oldMission = (Mission__c) oldSo;
		Mission__c mission = (Mission__c) so;
		
		this.contractToUpdateIds.add(mission.Contrat__c);
				
		if(oldMission.Contrat__c != mission.Contrat__c)
			this.contractToUpdateIds.add(oldMission.Contrat__c);

		
			
		//Si le contrat de la mission change, on recalculera le champ "Missions N-1" de toutes les missions de l'ancien et du nouveau contrat
		//EDIT DIDIER 19/02/2015 Si le contrat change, on doit également réaffecter les planifs et factures associées à ce contrat
		if(oldMission.Contrat__c != mission.Contrat__c ){
			this.contractIdsToComputeMissionNmoins1.add(oldMission.Contrat__c);
			this.contractIdsToComputeMissionNmoins1.add(mission.Contrat__c);
			//Début EDIT DIDIER 19/02/15
			OldContractToNewContractId.put(oldMission.contrat__c,mission.contrat__c);
			//Fin EDIT DIDIER 19/02/15
		}
		
		
		//Si l'année concernée change, on recalcul le champ "Missions N-1" de toutes les missions du contrat
		if(oldMission.Annee_concernee__c != mission.Annee_concernee__c ){
			this.contractIdsToComputeMissionNmoins1.add(mission.Contrat__c);
		}
	}
	
	public void afterDelete(SObject so){
		
		Mission__c mission = (Mission__c) so;
    	
    	if(mission.Annee_concernee__c != null){
    		this.contractToUpdateIds.add(mission.Contrat__c);
			this.missionDeletedIds.add(mission.Id);
    	}
		
		
		this.contractIdsToComputeMissionNmoins1.add(mission.Contrat__c);
	}
	
	
	
	/**
	 * andFinally
	 *
	 * This method is called once all records have been processed by the trigger. Use this 
	 * method to accomplish any final operations such as creation or updates of other records.
	 */
	public void andFinally(){
		
		 /*
		*	Récupère tous les contrats dont il faut recalculer l'année de 1ere mission
		*/
        List<Contract> contratsToMaj = [SELECT Id,
        								X_1ere_ann_e_de_mission__c,
                                		(Select Id,
                                        Annee_concernee__c
                                        From Missions__r WHERE Type_d_annee__c <> 'Rectificative / rétroactive' AND Id NOT IN :this.missionDeletedIds)
        								FROM Contract WHERE Id IN :this.contractToUpdateIds];
		for(Contract contrat : contratsToMaj){
			contrat.X_1ere_ann_e_de_mission__c = null;
			for(Mission__c m : contrat.Missions__r){
				/*
				 Pour le Brésil, le champ année concernée peut contenir la valeur "Outros" à exclure pour le traitement de la 1ere année de mission
				*/
				if(contrat.X_1ere_ann_e_de_mission__c == null && m.Annee_concernee__c != 'Outros'){
					contrat.X_1ere_ann_e_de_mission__c = m.Annee_concernee__c;
				}
				if(contrat.X_1ere_ann_e_de_mission__c != null && m.Annee_concernee__c != null && m.Annee_concernee__c != 'Outros'){
						if(integer.valueOf(m.Annee_concernee__c) < integer.valueOf(contrat.X_1ere_ann_e_de_mission__c))
							contrat.X_1ere_ann_e_de_mission__c = m.Annee_concernee__c;
				}
			}
		}
		
		if(contratsToMaj.size() > 0)
			update contratsToMaj;
		//Edit DIDIER 19/02/2015 Lorsqu'on déplace des missions de contrat, il faut également modifier les planifs et les factures
		if(!OldContractToNewContractId.isEmpty() && !reafectMissionDone){
		    system.debug('###EDIT MISSION Reaffect planif et factures');
		    List<sObject> sos = new List<sobject>();
		    set<Id> newIds = Trigger.newMap.keySet();
		    for(sObject p : [select id, contrat__c from facture__c where contrat__c in : OldContractToNewContractId.keySet() and mission__c in : newIds]){
		        p.put('contrat__c', OldContractToNewContractId.get((id)p.get('contrat__c')) );
		        sos.add(p);
		    }
		    for(sObject p : [select id, contrat__c from Prevision_de_facturation__c where contrat__c in : OldContractToNewContractId.keySet()  and mission__c in : newIds ]){
		        p.put('contrat__c', OldContractToNewContractId.get((id)p.get('contrat__c')) );
		        sos.add(p);
		    }
		    if(!sos.isEmpty()){
		        try{
		            update sos;
		        }catch (System.DmlException ex) {
                      if(ex.getDmlType(0) == StatusCode.ENTITY_IS_LOCKED){
                        Trigger.new.get(0).addError('Cette mission contient une ou plusieurs factures en attente de validation. Vous ne pouvez pas changer le contrat de la mission tant que les factures en attente n\'ont pas été validées');
                      }else
                        Trigger.new.get(0).addError(ex.getDMLMessage(0));
                      
		        }
		        OldContractToNewContractId = new map<id,id>();  //On reset les valeurs
		        reafectMissionDone = true;
		    }
		}
		//Fin editMission
		
		/**
		*	Recalcul le champ "Mission N-1" de toutes les missions des contrats dans this.contractIdsToComputeMissionNmoins1
		*/
		
		if(!this.contractIdsToComputeMissionNmoins1.isEmpty()){
			
			List<Mission__c> missions = [SELECT Id, Contrat__c, Annee_concernee__c, Mission_N_1__c FROM Mission__c WHERE Contrat__c IN :this.contractIdsToComputeMissionNmoins1 ORDER BY Contrat__c, Annee_concernee__c ];
			
			Id missionNmoins1;
			List<Mission__c> missionsToUpdate = new List<Mission__c>();
			
			for(Mission__c m1 : missions){
				
				missionNmoins1 = null;
				
				if(m1.Annee_concernee__c != null && m1.Annee_concernee__c != 'Outros'){
					
					
					for(Mission__c m2 : missions){
						
						if(m1.Contrat__c == m2.Contrat__c && m2.Annee_concernee__c == string.ValueOf(integer.ValueOf(m1.Annee_concernee__c) - 1)){
							missionNmoins1 = m2.Id;
							break;
						}
					}
				}
				
				if(missionNmoins1 != m1.Mission_N_1__c){
					m1.Mission_N_1__c = missionNmoins1;
					missionsToUpdate.add(m1);
				}
			}
			
			if(!missionsToUpdate.isEmpty())
				update missions;
			
		}
		
		
	}
	
}