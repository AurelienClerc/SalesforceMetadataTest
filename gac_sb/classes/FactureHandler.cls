public with sharing class FactureHandler implements ITrigger {

  /*
  *  La liste des Id de factures venant d'être supprimées
  *  Pour passer toutes les planifs des factures supprimées en statut "Prévue"
  */
  private List<Id> deletedFactureIds = new List<Id>();
  
  /*
  *  La liste des Id de factures venant d'être modifiées (la date)
  *  Pour mettre à jour toutes les planifs des factures concernées
  */
  private List<Id> updatedDateFactureIds = new List<Id>();
  
  /*
  *  La liste des factures venant de passer en statut Validée
  *  Pour créer une nouvelle prévision d'encaissement à 30 jours fin de mois de la date d'échéance
  */
  private List<Facture__c> facturesValidees = new List<Facture__c>();

  /*
  *  Didier 18/10
  */
  private List<Facture__c> factureStatutChanged = new List<Facture__c>();

  /*
  *  La liste des factures venant de passer en statut Soldée
  *  Pour supprimer les previsions d'encaissement des factures soldées
  */
  private List<Facture__c> facturesSoldees = new List<Facture__c>();


  /*
  *  La liste des Id de factures liées à un avoir
  *  Pour mettre à jour le montant annulé par avoir sur les factures et la date du dernier avoir
  */
  private Set<Id> facturesLieesIds = new Set<Id>();
  private Map<Id,Facture__c> facturesLiees = new Map<Id,Facture__c>();

	/*
	* DIDIER 12/05/14 permet de récupérer les planifs des factures mises a jour
	*/
  private Map<Id,List<Prevision_de_facturation__c>> planifsAssociees;
	
	
		
  //DIDIER 030714 case 00003463, Rémy souhaite pouvoir bypasser l'erreur "vous ne pouvez pas modifier la date d'une facture...etc."
  public static boolean canChangeDate;
  
  static{
  	user u = [select id, changeInvoiceDate__c from user where id = :userInfo.getUserId()][0];
  	canChangeDate = u.changeInvoiceDate__c;
  }
		

  public FactureHandler(){
  }
  
  
  public void bulkBefore(){
  	//EDIT DIDIER 12/05/2014
  	/*
  	* On va mettre des champs de la facture a jour en fonction des champs de la planif
  	* On récupère d'abord toutes les planifs sur lesquelles sommer
  	*/
  	if(planifsAssociees == null && trigger.isUpdate){
  		system.debug('####FactureHandler, IN bulkBefore');
  		planifsAssociees = new Map<Id,List<Prevision_de_facturation__c>>();
  		for(Prevision_de_facturation__c planif : [select id,Prevision_HT__c,facture__c,percent_Prestation__c,Apporteur_d_affaire_comptabilise_paye__c,Prestataire__c,Prevision_HT_Prestataire__c,Prestataire_comptabilise_paye__c,typologie_CA__c from Prevision_de_facturation__c where facture__c in:trigger.newMap.keySet() ]){
  			if(!planifsAssociees.containsKey(planif.facture__c))
  				planifsAssociees.put(planif.facture__c,new List<Prevision_de_facturation__c>());
  			planifsAssociees.get(planif.facture__c).add(planif);
  		}
  		system.debug('####FactureHandler, OUT bulkBefore: found '+planifsAssociees.size()+' planifs to recompute facture value');
  	}else if (trigger.isUpdate){
  		system.debug('####FactureHandler , IN/OUT bulkBefore : No need to recompute facture value based on planifs');
  	}
  	//FIN EDIT DIDIER 12/05/2014
  }
  
  public void bulkAfter(){
  }
    
    
  public void beforeInsert(SObject so){
  }
  
  public void beforeUpdate(SObject oldSo, SObject so){
    
    Facture__c oldFacture = (Facture__c) oldSo;
    Facture__c facture = (Facture__c) so;
    
    // Pour assigner le nom définitif à la facture en fonction du pays
    if(facture.Account_Record_Type__c == 'FRANCE_ACCOUNT'){
      
      if(oldFacture.Statut__c != 'Validée' && facture.Statut__c == 'Validée')
        this.facturesValidees.add(facture);
        
    }else if(facture.Account_Record_Type__c == 'BRASIL_ACCOUNT'){
      
      // rien à faire
      
    }else{
      
      if(oldFacture.Statut__c != 'Validée' && facture.Statut__c == 'Validée')
        this.facturesValidees.add(facture);
        
    }

    if(!facture.Name.startsWith('TEMP-') && oldFacture.Date__c.year() != facture.Date__c.year() && !canChangeDate){
      facture.Date__c.addError('Vous ne pouvez pas modifier l\'année d\'une facture ayant déjà été validée');
    }
    
    
    //EDIT DIDIER 12/05/14
    if(planifsAssociees!=null && planifsAssociees.containsKey(facture.id)){
    	system.debug('###FactureHandler BeforeUpdate : recomputing facture values based on planifications for facture '+facture.id+' '+ planifsAssociees.get(facture.id).size()+' planifications a prendre en compte');
    	set<string> prestataireError = new set<String>();
    	set<string> percentPrestataireError = new set<string>();
    	//On va recalculer tous ces champs, on les réinitialise d'abord
    	facture.Prevision_HT_Prestataire__c = 0;
    	facture.prestataire__c = null;
    	facture.percent_Prestation__c = null;
    	facture.Prestataire_comptabilise_paye__c = false;
    	facture.Apporteur_d_affaire_comptabilise_paye__c = false;
    	for(Prevision_de_facturation__c p : planifsAssociees.get(facture.id)){
			/*
			Concernant le champ « Prévision prestataire HT (facture) », il doit contenir :
			
			o Si qu'une seule planif liée à la facture : le contenu du champ « Prévision prestataire HT » de la planif liée à la facture
			
			o Si plusieurs planif liées à la facture : la somme de tous les montants « Prévision prestataire HT » de chaque planifications liées à la facture
			*/
			if(p.Prevision_HT_Prestataire__c != null && p.Prevision_HT_Prestataire__c != 0)
				facture.Prevision_HT_Prestataire__c += p.Prevision_HT_Prestataire__c;
    		
    		// Concernant le champ « Prestataire comptabilisé/payé », si la case est cochée sur la, ou l'une des planif liées à la facture, il faut donc que la case soit cochée sur ce même champ sur la facture.
    		if(p.Prestataire_comptabilise_paye__c)
    			facture.Prestataire_comptabilise_paye__c = true;
    		
    		//Il faudrait mettre en place la formule suivante : si l'une des planifications à la case "Apporteur d'affaire comptabilisé / payé" est cochée alors le champ reporté sur la facture doit être aussi coché sinon laissé vide.
    		if(p.Apporteur_d_affaire_comptabilise_paye__c)
    			facture.Apporteur_d_affaire_comptabilise_paye__c = true;
    			
    		if(p.Prestataire__c != null){
    			facture.prestataire__c = p.prestataire__c;
    			//Ces champs doivent être vide ou identiques sur toutes les planifications
    			if(!prestataireError.contains(p.prestataire__c))
    				prestataireError.add(p.prestataire__c);
    		}
    		if(p.percent_Prestation__c != null){
    			facture.percent_Prestation__c = p.percent_prestation__c;
    			//Ces champs doivent être vides ou identiques sur toutes les planifications
    			if(!percentPrestataireError.contains(String.valueOf(p.percent_prestation__c)))
    				percentPrestataireError.add(String.valueOf(p.percent_prestation__c));
    		}
    	}
    	string errorMessage='';
    	if(prestataireError.size()>1){
    		List<String> errorPrest = new list<string>();
    		errorPrest.addAll(prestataireError);
    		system.debug('###beforeupdate Erreur : il n\'est pas possible de saisir 2 prestataires différents sur 2 planifications liées à la même facture. Vous avez renseigné '+ String.join(errorPrest,',')+'\n');
    		errorMessage += 'Erreur : il n\'est pas possible de saisir 2 prestataires différents sur 2 planifications liées à la même facture. Vous avez renseigné '+ String.join(errorPrest,',')+'\n';
    	}
    	if(percentPrestataireError.size()>1){
    		List<String> errorPrest = new list<string>();
    		errorPrest.addAll(percentPrestataireError);
    	    system.debug('###beforeupdate Erreur : il n\'est pas possible de saisir 2 pourcentages de rémunération prestataires différents sur 2 planifications liées à la même facture. Vous avez renseigné "'+ String.join(errorPrest,'","')+'"');
    		errorMessage += 'Erreur : il n\'est pas possible de saisir 2 pourcentages de rémunération prestataires différents sur 2 planifications liées à la même facture. Vous avez renseigné "'+ String.join(errorPrest,'","')+'"';
    	}
    	if(string.isNotEmpty(errorMessage))
    		so.addError(errorMessage);
    }
    //FIN EDIT DIDIER 12/05/14
  }
  
  public void beforeDelete(SObject so){
    //Pour passer toutes les planifs des factures supprimées en statut "Prévue"
    this.deletedFactureIds.add( (Id) so.get('Id') );
  }
  
  public void afterInsert(SObject so){
  }
  
  public void afterUpdate(SObject oldSo, SObject so){
    
    Facture__c oldFacture = (Facture__c) oldSo;
    Facture__c facture = (Facture__c) so;
    
    // Pour mettre à jour les dates des planifications liées si la date de la facture a changé
    if(oldFacture.Date__c != facture.Date__c){
      this.updatedDateFactureIds.add(facture.Id);
    }
    
    // Pour créer une nouvelle prévision d'encaissement à 30 jours fin de mois de la date d'échéance lors de la validation
    if(oldFacture.Statut__c != 'Validée' && facture.Statut__c == 'Validée'){
      this.facturesValidees.add(facture);
    }
    /*
    * EDIT DIDIER 18/10
    */
    if(oldFacture.Statut__c != facture.Statut__c)
      this.factureStatutChanged.add(facture);
    /*
    *  Fin EDIT DIDIER 18/10
    */
    // Si il s'agit d'un avoir validé ou dévalidé, il faut mettre à jour le montant annulé par avoir de sa facture liée
    if((oldFacture.Statut__c != 'Validée' && facture.Statut__c == 'Validée') || (oldFacture.Statut__c != 'En attente' && facture.Statut__c == 'En attente')){
      if(facture.Facture_liee__c != null){
        this.facturesLieesIds.add( (Id) facture.Facture_liee__c);
        //system.debug('###FactureHandler MAJ Facture '+  facture.Facture_liee__c);
        this.facturesLiees.put((Id) facture.Facture_liee__c,new Facture__c(Id = (Id) facture.Facture_liee__c, Montant_annule_par_avoir_HT__c = 0,  Montant_annule_par_avoir2_TTC__c = 0, Date_dernier_avoir__c = null));
      }
    }
    
    // Si il s'agit d'un avoir validé sur lequel on met à jour la facture liée
    if(facture.Statut__c != 'En attente' && oldFacture.Statut__c != 'En attente' && oldFacture.Facture_liee__c != facture.Facture_liee__c){
      if(facture.Facture_liee__c != null){
        this.facturesLieesIds.add( (Id) facture.Facture_liee__c);
        this.facturesLiees.put((Id) facture.Facture_liee__c,new Facture__c(Id = (Id) facture.Facture_liee__c, Montant_annule_par_avoir_HT__c = 0, Montant_annule_par_avoir2_TTC__c = 0, Date_dernier_avoir__c = null));
      }
      if(oldFacture.Facture_liee__c != null){
        this.facturesLieesIds.add( (Id) oldFacture.Facture_liee__c);
        this.facturesLiees.put((Id) oldFacture.Facture_liee__c,new Facture__c(Id = (Id) oldFacture.Facture_liee__c, Montant_annule_par_avoir_HT__c = 0, Montant_annule_par_avoir2_TTC__c = 0, Date_dernier_avoir__c = null));
      }
    }
    
    // Pour supprimer les previsions d'encaissement des factures soldées
    if(oldFacture.Statut__c != 'Soldée' && facture.Statut__c == 'Soldée'){
      this.facturesSoldees.add(facture);
    }
    
    // Pour mettre à jour l'ancienne et la nouvelle facture liée sur un avoir qui aurait été déplacé
    if(oldFacture.Facture_liee__c != facture.Facture_liee__c && facture.Statut__c == 'Validée'){
      if(facture.Facture_liee__c != null){
        this.facturesLieesIds.add( (Id) facture.Facture_liee__c);
        this.facturesLiees.put((Id) facture.Facture_liee__c,new Facture__c(Id = (Id) facture.Facture_liee__c, Montant_annule_par_avoir_HT__c = 0, Montant_annule_par_avoir2_TTC__c = 0, Date_dernier_avoir__c = null));
      }
      if(oldFacture.Facture_liee__c != null){
        this.facturesLieesIds.add( (Id) oldFacture.Facture_liee__c);
        this.facturesLiees.put((Id) oldFacture.Facture_liee__c,new Facture__c(Id = (Id) oldFacture.Facture_liee__c, Montant_annule_par_avoir_HT__c = 0, Montant_annule_par_avoir2_TTC__c = 0, Date_dernier_avoir__c = null));
      }
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
      system.debug('###IN Facture handler andFinally');
      /*
      *  Récupère toutes les planifs des factures dont la date est modifiée et met leur date à jour
      */
      //EDIT DIDIER 12/05/14 On gagne une requete SOQL
	   //On met une variable a true pour éviter la récursivité (récursivité qui ferait déconner les règle de validations paramétrées avec isChanged)
	   Prevision_de_facturationHandler.isActive = false;
      //EDIT DIDIER 20/02/2015 On profite de cette boucle pour remplir la typologie_CA des factures afin de créer les prévisions d'encaissement
      map<Id,string> factureToTypoCA = new Map<Id,String>();
      //FIN EDIT didier 20/02/2015
      if(!updatedDateFactureIds.isEmpty() || !factureStatutChanged.isEmpty()){
      //FIN EDIT DIDIER 12/05/14 
	      List<Prevision_de_facturation__c> planifsToMaj = [SELECT Id, Typologie_facturation__c, Date_prevue__c,facture__c,Facture__r.Date__c FROM Prevision_de_facturation__c WHERE Facture__c IN :this.updatedDateFactureIds OR Facture__c IN : this.factureStatutChanged];
	      for(Prevision_de_facturation__c planif : planifsToMaj){
	        factureToTypoCA.put(planif.facture__c, planif.Typologie_facturation__c);
	        planif.Date_prevue__c = planif.Facture__r.Date__c;
	      }
	      if(planifsToMaj.size() > 0){
	        update planifsToMaj;
	      }
      }
      
      
      /*
      *  Récupère toutes les planifs des factures supprimées et passe leurs statut en "Prévue"
      */
      //EDIT DIDIER 12/05/14 On gagne une requete SOQL
      if(!this.deletedFactureIds.isEmpty()){
      //FIN EDIT DIDIER 12/05/14 
          List<Prevision_de_facturation__c> planifsApasserEnStatutPrevue = [SELECT Id, Statut__c FROM Prevision_de_facturation__c WHERE Facture__c IN :this.deletedFactureIds];
          for(Prevision_de_facturation__c planif : planifsApasserEnStatutPrevue){
            planif.Facture__c = null;
            planif.Statut__c = 'Prévue';
          }
          if(planifsApasserEnStatutPrevue.size() > 0)
            update planifsApasserEnStatutPrevue;
      }
      
      Prevision_de_facturationHandler.isActive = true;
      
      /*
      *   EDIT DIDIER 18/10/13 => si le statut de la facture a changé, on lance un update sur les prévision de facture
      * /
      set<Id> FactureToMaj;
      //NB : Rien n'est fait sur l'insert, on ne travaille que sur des update
      if(Trigger.isUpdate )
        FactureToMaj = Trigger.newMap.keyset();
      else if(trigger.isDelete)
        FactureToMaj = Trigger.oldMap.keyset();
      if(!FactureToMaj.isEmpty()){
      List<Prevision_de_facturation__c> planifRawUpdate = [SELECT Id FROM Prevision_de_facturation__c WHERE 
                          //  Facture__c NOT IN :this.deletedFactureIds     //On update pas celle la, on a déja fait ca plus haut
                          //AND Facture__c NOT IN :this.updatedDateFactureIds AND  //On update pas celle la, on a déja fait ca plus haut
                           Facture__c IN : FactureToMaj          //On update celles la
                          ];
      if(!planifRawUpdate.isEmpty())
        update planifRawUpdate;
      }*/
      
      /*
       *   FIN EDIT DIDIER
       */
      
      /*
      *  Assigne un numéro de facture définitif
      *  Créé une nouvelle prévision d'encaissement à 30 jours fin de mois de la date d'échéance des factures
      */
      
      //On récup les developerName des recordType des mission associées aux factures validées
      Map<String, String> missionDeveloperNames = new Map<String, String>();
      //EDIT DIDIER 12/05/14 On gagne une requete SOQL
      if(!this.facturesValidees.isEmpty()){
      //FIN EDIT Didier  12/05/14 
        for(Facture__c facture : [SELECT Id, Mission__c, Mission__r.RecordType.DeveloperName FROM Facture__c WHERE Id IN :this.facturesValidees])
          missionDeveloperNames.put(facture.Mission__c, facture.Mission__r.RecordType.DeveloperName);
      }
  
      List<Prevision_encaissement__c> previsionsEncaissementAcreer = new List<Prevision_encaissement__c>();
      Integer nbMoisEncaissement;
      for(Facture__c facture : this.facturesValidees){
        if(Trigger.isBefore){
          system.debug('###IN FactureHandler:andFinaly : AssignName To tmpFacture' + facture.Name);
          facture.Name = FactuUtils.getFactureNumber(facture, missionDeveloperNames.get(facture.Mission__c));
          system.debug('###IN FactureHandler:andFinaly :: '+facture.Name);
        }
        else{
          if(facture.Montant_previsions_encaissement_TTC__c  == 0 && facture.Montant_HT__c > 0){
              
          	if(missionDeveloperNames.get(facture.Mission__c) == 'ACS'){
          		nbMoisEncaissement = 4;
          	}
          	/*EDIT DIDIER 12/10/2015 : On remet tout a 60 pour le TAT 00012307
          	//EDIT DIDIER 20/02/2014 Changement automatique des dates de prévision d’encaissement par défaut (+60 ou +120 jours) à la création des factures TAT selon si la typologie de facturation est « facturation initiale » ou « refacturation »
          	else if(missionDeveloperNames.get(facture.Mission__c) == 'TAT' && factureToTypoCA.containsKey(facture.id) && factureToTypoCA.get(facture.id) =='Re-facturation'){
          	    nbMoisEncaissement = 4;
          	}
          	*/
          	//Fin Edit Didier 20/02/2014
          	//EDIT DIDIER 22/04/2015 Prévision a 1 mois pour singapour requete 00011107
          	else if(missionDeveloperNames.get(facture.Mission__c) == 'SGP_PIC'){
          	    nbMoisEncaissement = 1;
          	}
          	//FIN Edit didier 22/04/2015
          	else
          		nbMoisEncaissement = 2;
          	
            previsionsEncaissementAcreer.add( 
    									new Prevision_encaissement__c(	Facture__c = facture.Id,
    																	CurrencyIsoCode = facture.CurrencyIsoCode,
                                  										Montant_prevu_TTC__c = facture.Montant_TTC__c,
                                  										Date_prevue__c = facture.Date__c.addMonths(nbMoisEncaissement)  ) 
                                  			);
          }
        }
      }
      if(previsionsEncaissementAcreer.size() > 0)
        insert previsionsEncaissementAcreer;
      
      
      
      /*
      *  Supprime les prévisions d'encaissement des factures soldées
      */
      //EDIT DIDIER 12/05/14 On gagne une requete SOQL
      if(!facturesSoldees.isEmpty()){
       //FIN EDIT DIDIER 12/05/14 
      	delete [SELECT Id FROM Prevision_encaissement__c WHERE Facture__c IN :this.facturesSoldees];
      }
      /*
      * Recalcule les montants annulé par avoir sur les factures liées
      */
      //EDIT DIDIER 12/05/14 On gagne une requete SOQL
      if(!facturesLieesIds.isEmpty()){
      //FIN EDIT DIDIER 12/05/14 
	      for(Facture__c  avoir : [Select Montant_HT__c, Montant_TTC__c, Date__c, Facture_liee__c From Facture__c Where Statut__c != 'En attente' and Facture_liee__c in :this.facturesLieesIds order by Date__c desc]){
	        this.facturesLiees.get(avoir.Facture_liee__c).Montant_annule_par_avoir_HT__c += avoir.Montant_HT__c;
	        this.facturesLiees.get(avoir.Facture_liee__c).Montant_annule_par_avoir2_TTC__c += avoir.Montant_TTC__c;
	        if(this.facturesLiees.get(avoir.Facture_liee__c).Date_dernier_avoir__c == null || this.facturesLiees.get(avoir.Facture_liee__c).Date_dernier_avoir__c < avoir.Date__c)
	          this.facturesLiees.get(avoir.Facture_liee__c).Date_dernier_avoir__c = avoir.Date__c;
	      }
      }
      if(this.facturesLiees.size() > 0)
        update this.facturesLiees.values();
      
      system.debug('###OUT FactureHandler AndFinally');
    
  }
}