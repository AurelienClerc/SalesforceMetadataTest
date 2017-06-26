public with sharing class Prevision_de_facturationHandler implements ITrigger{

	/*
	*  La liste des Id de contrat impactés
	*  Pour mettre à jour la date de 1ère planif
	*/
	private List<Id> contractToUpdateIds = new List<Id>();
	
	/*
	*  La liste des Id de planif delete à ne pas utiliser
	*  Pour mettre à jour la date de 1ère planif
	*/
	private List<Id> planifDeletedIds = new List<Id>();
	
	private static map<id,Map<string,decimal>> insertedPrevisionsTotals;
	
	private id[] factureToUp = new List<Id>();

    /*
    *	@deprecated
    *   La liste des Id Mission CIR (INNO Advance) impactés
    *   Pour mettre à jour le Montant rémunération brut et la Date de facturation GAC
    private Set<Id> missionsCirIds = new Set<Id>(); 
    */
    
    /*
    *   La liste des Id de Valo CIR (INNO Advance) impactés
    *   Pour mettre à jour le Chiffre d'affaire et la Date de facturation GAC
    */
    private Set<Id> valosCirIds = new Set<Id>();
    
    

    //Si isActive est a false, on ne fera pas de mise a jour à vide des facture associés à ces planifs
    //Sert pour éviter la récursivité aevc Facture HANDLER
	public static boolean isActive;

	static{
		isActive = true;
		if(insertedPrevisionsTotals == null)
			insertedPrevisionsTotals = new map<id,Map<string,decimal>>();
	}

    public Prevision_de_facturationHandler(){
    }
    
    public void bulkBefore(){
    }
    
    public void bulkAfter(){
    }
        
    /**
    */
    public void beforeInsert(SObject so){
		Prevision_de_facturation__c planif = (Prevision_de_facturation__c) so;
		// 012D0000000kP3i = IL
		planif.Statut__c = getPlanifStatus(planif);
		//EDIT DIDIER 18/10/13
		if(!insertedPrevisionsTotals.containsKey( planif.contrat__c)){
			insertedPrevisionsTotals.put( planif.contrat__c,new Map<string,decimal>{'Prévue'=>0,'Facturée'=>0});
		}
        
        
        //On fait le ca facturé
		if(planif.Statut__c == 'Prévue' || ( planif.Statut__c == 'Facturée' && planif.statut_facture__c != 'En attente' )  ) //On fait le CA facturé réel
			insertedPrevisionsTotals.get( planif.contrat__c ).put(planif.Statut__c, insertedPrevisionsTotals.get(planif.contrat__c).get(planif.Statut__c) * 1 + 1 * planif.Prevision_HT__c);
        //Fin edit
    }
    
    public void beforeUpdate(SObject oldSo, SObject so){
		Prevision_de_facturation__c planif = (Prevision_de_facturation__c) so;
		// 012D0000000kP3i = IL
		planif.Statut__c = getPlanifStatus(planif);
		if(planif.Date_prevue__c != planif.Facture__r.Date__c && planif.Facture__r.Date__c != null)
			planif.Date_prevue__c = planif.Facture__r.Date__c;
    }
    
    public void beforeDelete(SObject so){
    }
    
    
    
    public void afterInsert(SObject so){
		Prevision_de_facturation__c planif = (Prevision_de_facturation__c) so;
		
		this.contractToUpdateIds.add(planif.Contrat__c);
		
		if(so.get('facture__c') != null)
			factureToUp.add(planif.facture__c);
		
		// @deprecated
		// if(planif.Mission_Inno_Advance__c != null)
		// 	missionsCirIds.add(planif.Mission_Inno_Advance__c);
			
		if(planif.ValoINNOadvance__c != null)
			valosCirIds.add(planif.ValoINNOadvance__c);
    }
    
    
    
    public void afterUpdate(SObject oldSo, SObject so){
      
		Prevision_de_facturation__c oldPlanif = (Prevision_de_facturation__c) oldSo;
		Prevision_de_facturation__c planif = (Prevision_de_facturation__c) so;
		
		this.contractToUpdateIds.add(planif.Contrat__c);
		
		if(oldPlanif.facture__c != null)
			factureToUp.add(oldPlanif.facture__c);
		if(planif.facture__c != null)
			factureToUp.add(planif.facture__c);
		
		if(oldPlanif.Contrat__c != planif.Contrat__c)
			this.contractToUpdateIds.add(oldPlanif.Contrat__c);
		
		// @deprecated
		// if(planif.Mission_Inno_Advance__c != null)
		// 	missionsCirIds.add(planif.Mission_Inno_Advance__c);
		// if(oldPlanif.Mission_Inno_Advance__c != null)
		// 	missionsCirIds.add(oldPlanif.Mission_Inno_Advance__c);
			
		if(planif.ValoINNOadvance__c != null)
			valosCirIds.add(planif.ValoINNOadvance__c);
			
		if(oldPlanif.ValoINNOadvance__c != null)
			valosCirIds.add(oldPlanif.ValoINNOadvance__c);
            
    }
    
    
    
    
    public void afterDelete(SObject so){
      
		Prevision_de_facturation__c planif = (Prevision_de_facturation__c) so;
		
		if(planif.Date_prevue__c != null){
			this.contractToUpdateIds.add(planif.Contrat__c);
			this.planifDeletedIds.add(planif.Id);
		}

		
		if(planif.Facture__c != null)
			factureToUp.add(planif.facture__c);

    	// @deprecated
		// if(planif.Mission_Inno_Advance__c != null)
		// 	missionsCirIds.add(planif.Mission_Inno_Advance__c);
			
		if(planif.ValoINNOadvance__c != null)
			valosCirIds.add(planif.ValoINNOadvance__c);
    }
    
    
    
    
    /**
     * andFinally
     *
     * This method is called once all records have been processed by the trigger. Use this 
     * method to accomplish any final operations such as creation or updates of other records.
     */
    public void andFinally(){
		System.debug('###IN Prev de facturation handler');
		system.debug(insertedPrevisionsTotals);
		/*
		*  Récupère tous les contrats dont il faut recalculer la date de 1ere planif
		*/
		List<Contract> contratsToMaj = [SELECT Id,
												Date_1ere_planification__c,
												CA_Facture__c,
												CA_Reste_a_facturer__c,
												(SELECT Id,
													Date_prevue__c,
													statut__c,
													Prevision_HT__c,
													statut_facture__c
												FROM Planificiations_de_facturation__r 
												WHERE Id NOT IN :this.planifDeletedIds)
											FROM Contract 
											WHERE Id IN :this.contractToUpdateIds];
											
		for(Contract contrat : contratsToMaj){
			contrat.Date_1ere_planification__c = null;
			/*
			EDIT DIDIER 18/10/13 MAJ des totaux de facturation sur le contrat
			*/
			Decimal CA_Facture = 0 ;
			Decimal CA_resteafacturer = 0;
			if(insertedPrevisionsTotals.containsKey(contrat.id)){
				CA_Facture = insertedPrevisionsTotals.get(contrat.id).get('Facturée');
				CA_resteafacturer = insertedPrevisionsTotals.get(contrat.id).get('Prévue');
			}
			/*
			FIN EDIT DIDIER 18/10/13 MAJ des totaux de facturation sur le contrat
			*/
			for(Prevision_de_facturation__c pr : contrat.Planificiations_de_facturation__r){
				
				/*
				EDIT DIDIER 18/10/13 MAJ des totaux de facturation sur le contrat
				*/
				if(pr.Statut__c == 'Prévue')
					CA_resteafacturer += pr.Prevision_HT__c;
				else if(pr.Statut_facture__c != 'En attente') //On prend le facturé réel
					CA_Facture += pr.Prevision_HT__c;
				/*
				Fin EDIT DIDIER
				*/
				if(contrat.Date_1ere_planification__c == null)
					contrat.Date_1ere_planification__c = pr.Date_prevue__c;
				if(contrat.Date_1ere_planification__c != null){
					if(pr.Date_prevue__c < contrat.Date_1ere_planification__c)
						contrat.Date_1ere_planification__c = pr.Date_prevue__c;
				}
			}
			/*
			EDIT DIDIER 18/10/13 MAJ des totaux de facturation sur le contrat
			*/
			contrat.CA_Facture__c = CA_Facture;
			contrat.CA_Reste_a_facturer__c = CA_resteafacturer;
			/*
			Fin EDIT DIDIER
			*/
		}
		//Mise a jour des contrats liés
		if(contratsToMaj.size() > 0)
			update contratsToMaj;
		
		//Mise a jour des factures de la planif (champs prestataire)
		if(!factureToUp.isEmpty() && isActive){
			try{
				update [select id from facture__c where id in : factureToUp];
			}
			catch(Exception e){
				String Message = e.getMessage();
				if(Message.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION,')){
					Message = Message.replaceAll('.*FIELD_CUSTOM_VALIDATION_EXCEPTION,','');
				}
				trigger.new.get(0).addError('Une erreur est survenue sur la facture liée. '+Message);
			}
		}
		
		
		/*
		*	@deprecated
		*   Mises à jour des missions CIR d'INNO Advance, champs:
		*   - Montant rémunération brut
		*   - Date de facturation GAC
		*
		
		//Création des copies des missions CIR à updater
		Map<Id, AppCIRmission__c> missionsCirRecords = new Map<Id, AppCIRmission__c>();
		
		for(Id missionId : this.missionsCirIds){
			missionsCirRecords.put(missionId, new AppCIRmission__c( Id = missionId, 
			Montant_remuneration_final__c = 0,
			Date_facturation_GAC__c = null
			));
		}
		
		//Recupère toutes les planifs rattachés aux missionsIds
		AppCIRmission__c missionCIR;
		for(Prevision_de_facturation__c planif : [SELECT Id, Mission_Inno_Advance__c, Prevision_HT__c, Date_prevue__c FROM Prevision_de_facturation__c WHERE Mission_Inno_Advance__c IN :missionsCirIds AND RecordType.DeveloperName = 'CIR' order by Date_prevue__c]){
		
			missionCIR = missionsCirRecords.get(planif.Mission_Inno_Advance__c);
			
			//MAJ du champ Montant rémunération brut
			missionCIR.Montant_remuneration_final__c += planif.Prevision_HT__c;
			
			//MAJ du champ Date de facturation GAC (à la date de la 1ere planif)
			if(missionCIR.Date_facturation_GAC__c == null)
				missionCIR.Date_facturation_GAC__c = planif.Date_prevue__c;
			
		}
		
		//Update des missions CIR
		update missionsCirRecords.values();
		*/
		
		
		/*
		*   Mises à jour des valorisation CIR d'INNO Advance, champs:
		*   - Chiffre d'affaire
		*   - Date de facturation GAC
		*/
		
		//Création des copies des missions CIR à updater
		Map<Id, INNOvalo__c> valosCirRecords = new Map<Id, INNOvalo__c>();
		
		for(Id valoId : this.valosCirIds){
			valosCirRecords.put(valoId, new INNOvalo__c( Id = valoId, 
														ChiffreAffaire__c = 0,
														Date_facturation_GAC__c = null
			));
		}
		
		//Recupère toutes les planifs rattachés aux missionsIds
		INNOvalo__c valoCIR;
		for(Prevision_de_facturation__c planif : [SELECT Id, ValoINNOadvance__c, Prevision_HT__c, Date_prevue__c FROM Prevision_de_facturation__c WHERE ValoINNOadvance__c IN :valosCirIds AND RecordType.DeveloperName = 'CIR' order by Date_prevue__c]){
		
			valoCIR = valosCirRecords.get(planif.ValoINNOadvance__c);
			
			//MAJ du champ Montant rémunération brut
			valoCIR.ChiffreAffaire__c += planif.Prevision_HT__c;
			
			//MAJ du champ Date de facturation GAC (à la date de la 1ere planif)
			if(valoCIR.Date_facturation_GAC__c == null)
				valoCIR.Date_facturation_GAC__c = planif.Date_prevue__c;
			
		}
		
		//Update des valos CIR
		update valosCirRecords.values();
		
		
		system.debug('###OUT Prevision de facturationhandler');
    }
    
    
    
	private static String getPlanifStatus(Prevision_de_facturation__c planif){
		
		if(planif.Facture__c != null)
			return 'Facturée';
		else if(planif.Dossier_rejete__c && planif.RecordTypeId == '012D0000000kZ4L')       //Recordtype CIR CANADA
			return 'Rejetée';
		else if(planif.HGNF_comptabilise__c)
			return 'HGNF';
		else if (planif.Etape__c == 'Dossier à 0' && planif.RecordTypeId == '012D0000000kP3i')      //Recordtype IL, Ne pas fusionner avec le "else if(planif.Dossier_rejete__c)" car l'ordre a son importance, on doit d'abord vérifier si HGNF
			return 'Rejetée';
		else
			return 'Prévue';
	
	}
}