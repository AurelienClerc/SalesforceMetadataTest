//Gestion des dates de rdv sur les opportunités et des RDV soeur et opportunité soeurs
//@Coveredby EventOnOpportunityGateway_Test
//LAST EDIT DIDIER HUGUET 01/02/2016 : Modification de la classe pour ne plus mettre les Poles en dur
global without sharing class EventOnOpportunityGateway {

  protected string prefix; //006

  protected Id RecordTypeCommercial;

  protected Set<Id> OpportunitiesId = new Set<Id>();
  protected Set<Id> AccountsId = new Set<Id>();
  protected Map<Id,Opportunity> OppsToUpdate = new Map<Id,Opportunity>();
  protected Map<Id,Event> EventsDeleted = new Map<Id,Event>();
  
  protected map<id,Contact> contacts = new map<Id,Contact>();
      
  public EventOnOpportunityGateway(){
    this.prefix = Opportunity.sObjectType.getDescribe().getKeyPrefix();
    //this.rtId = [SELECT Id,DeveloperName FROM RecordType WHERE SobjectType='Event' AND developerName = 'RDV_Commercial' LIMIT 1][0].Id;
    //Déplacé dans init class val, ca ne sert a rien de faire une requête si rien a update
  }
  
  public void addItem(Event ev){
    this.addItem(ev,ev.AccountId);
  }
  public void addItem(Event ev,Id AccountId){
    String whatId = (String) Ev.WhatId;
    String whoId = (String) ev.whoId;
    if(whoId != null && whoId.startsWith('003'))
        this.contacts.put((Id) whoId, null);
    
   if(whatId!=null && whatId != '' && whatId.startsWith(this.prefix)){
      if(!this.OpportunitiesId.contains(whatId)){
        this.OpportunitiesId.add(whatId);
      }
      if(!this.AccountsId.contains(AccountId))
        this.AccountsId.add(AccountId);
    }
    if(Trigger.isDelete){
      this.EventsDeleted.put(ev.Id,ev);
    }
  }
  
  private void initClassVal(){
    if(this.RecordTypeCommercial == null)
    	this.RecordTypeCommercial = [SELECT Id FROM RecordType WHERE SobjectType='Event' AND DeveloperName = 'RDV_commercial' LIMIT 1][0].Id;
    set<Id> contactsId = this.contacts.keySet();
    this.contacts = new map<id, Contact>([Select id, ContactCreeViaLinkedIn__c from contact where id in : contactsId]);
  }
  
  public List<Opportunity> processOppUpdate(){
    if(this.OpportunitiesId.size() == 0)
     return oppsToUpdate.values();
    this.initClassVal();
    
    
    List<String> TypeEvent = new String[]{'RDV commercial','Suivi Proposition Commerciale','Suivi commercial'};
    List<String> NatureEvent = new String[]{'RDV Physique','RDV Téléphonique'}; 
    String RecordTypeCommercial = [SELECT Id FROM RecordType WHERE SobjectType='Event' AND DeveloperName = 'RDV_commercial' LIMIT 1][0].Id;

    //On traite séparément les RDV annulés et les non annulés pour être sur de n'avoir que cela et de pas trop user de script statement
    for (Opportunity o : [Select id,Origine_du_RDV__c,createdDate,Name,date_1er_RDV__c,date_dernier_RDV__c,RDV_effectues__c,
                  Contexte__c,Enjeux__c,Timing_Prochaine_etape__c,Processus_de_decision__c,Objections__c,Pole__c,
                  Role_Apporteur_daffaires__c,Apporteur_d_affaire__c,recommandePar__c,
                  Account.RecordType.developerName,Email_du_suiveur_notification_workflow__c,E_mail_du_DR__c,E_mail_du_DCR__c,
                  ACS_date_de_RDV_report__c,Date_de_prise_de_RDV__c,RDV_annul__c,Date_initiale_RDV__c,attente_besoin__c,RDV_a_effectuer_par__c , ContacteViaLinkedIn__c ,
                  (Select Id,Description,StartDatetime,Report_au__c,annulation_et_report__c,attente_besoin__c,contexte__c,createdDate,
                    Objections__c,Processus_de_decision__c,Enjeux__c,Timing_Prochaine_tape__c,OwnerId,createdById, recommandePar__c, who.id
                    from Events WHERE
                    objet_evenement__c IN:TypeEvent AND
                    nature_evenement__c IN: NatureEvent AND
                    recordTypeId = :this.RecordTypeCommercial 
                    AND annulation_et_report__c = null
                    AND isChild = false
                    ORDER by StartDateTime ASC
                  )  FROM Opportunity
                  WHERE Id IN:this.OpportunitiesId]
      ){
       
        
      if(o.events.size()>0){
        Boolean ToUpdate = false;
        //Remplissage du champ date premier rendez vous et date prise RDV
        if(o.date_1er_RDV__c == null || o.date_1er_RDV__c != o.events.get(0).StartDateTime.date() ){
          o.date_1er_RDV__c = o.events.get(0).StartDateTime.date();
          if(o.Date_de_prise_de_RDV__c == null)
          	o.Date_de_prise_de_RDV__c = date.valueOf(o.events.get(0).createdDate);
          ToUpdate = true;
        }
        
        //Edit didier, remplissage conditionnel du champ apporteur d'affaire
      if(o.Role_Apporteur_daffaires__c == null || (!o.Role_Apporteur_daffaires__c.contains('RDV effectué par') && o.RDV_a_effectuer_par__c == null)){
          o.RDV_a_effectuer_par__c = o.events.get(0).OwnerId;
        ToUpdate = true;
      }
      if(o.Role_Apporteur_daffaires__c != null && o.Role_Apporteur_daffaires__c.contains('RDV effectué par') && o.RDV_a_effectuer_par__c != null){
          o.RDV_a_effectuer_par__c = null;
          ToUpdate = true;
      }
      
      // remplissage conditionnel du champ origine du RDV (attention l'ordre des IF est important) :
      
      // Si le champ est vide on le rempli sauf si il y a un apporteur d'affaire qui a pris le RDV
      if(o.Origine_du_RDV__c == null && (o.Role_Apporteur_daffaires__c == null || !o.Role_Apporteur_daffaires__c.contains('RDV pris par'))){
          o.Origine_du_RDV__c = o.Events.get(0).createdById;
        ToUpdate = true;
      }
      
      // Si le champ est rempli on le met à jour uniquement si l'opportunité est en RDV annulé, car si on passe par là, c'est qu'elle va bientôt plus l'être et que donc l'origine du RDV peut être mis à jour
      if(o.Origine_du_RDV__c != null && o.RDV_annul__c == true){
          o.Origine_du_RDV__c = o.Events.get(0).createdById;
        ToUpdate = true;
      }
      
      // Si le champ est rempli et qu'il y a un apporteur d'affaire qui a pris le RDV on le vide
      if(o.Role_Apporteur_daffaires__c != null && o.Role_Apporteur_daffaires__c.contains('RDV pris par') && o.Origine_du_RDV__c != null){
          o.Origine_du_RDV__c = null;
          ToUpdate = true;
      }
        
        
        //Remplissage du champ date dernier rendez vous
        if(o.date_dernier_RDV__c ==null || o.date_dernier_RDV__c != o.events.get(o.events.size() - 1).StartDateTime.date()){
          o.date_dernier_RDV__c = o.events.get(o.events.size() - 1).StartDateTime.date();
          ToUpdate = true;
        }
        
        
        
        
        
        /* //Remplissage du champ commentaire dernier rendez vous
        if(o.Commentaire_dernier_RDV__c ==null || o.Commentaire_dernier_RDV__c != o.events.get(o.events.size() - 1).Description){
          o.Commentaire_dernier_RDV__c = o.events.get(o.events.size() - 1).Description;
          ToUpdate = true;
        }*/
        //Remplissage du champs rdv effectués
        if(o.RDV_effectues__c ==null || o.RDV_effectues__c != o.events.size()){
          o.RDV_effectues__c = o.events.size();
          ToUpdate = true;
        }

          
          //Si on a 1 recommandation d'un contact sur un évenment mais qu'on a rien sur les opport. 
          //on met a jours le champ recommande par de l'opportunité avec le premier champ recommandé par de l'évenment qu'on arrive a trouver.

          for(Event e : o.events){
              if(o.recommandePar__c == null && e.recommandePar__c != null){
                  o.RecommandePar__c = e.RecommandePar__c;
                  ToUpdate = true;
              }
              if(! o.contacteViaLinkedIn__c && e.WhoId != null && this.contacts.containsKey(e.WhoId) && this.contacts.get(e.WhoId).contactCreeViaLinkedIn__c ){
                  o.contacteViaLinkedIn__c = true;
                  ToUpdate = true;
              }
                  
          }

          
       //On ne rempli qu'avec les données du dernier RDv non vide
       for(Integer i=o.Events.size();i>0;i--){
            Event e = o.Events.get(i - 1);
            if(e.Description != null || e.attente_besoin__c !=null || e.Objections__c != null || e.Processus_de_decision__c != null || e.Enjeux__c != null || e.Timing_Prochaine_tape__c != null ){
              o.Contexte__c = e.Description;
              o.attente_besoin__c = e.attente_besoin__c;
              o.Objections__c =e.Objections__c;
              o.Processus_de_decision__c =e.Processus_de_decision__c;
              o.Enjeux__c  = e.Enjeux__c; 
              o.Timing_Prochaine_etape__c = e.Timing_Prochaine_tape__c;
              ToUpdate = true;
              break;
            }
        }
        
        
        
        
        
        /*if(o.Origine_du_RDV__c == null){
          ToUpdate = true;
          o.Origine_du_RDV__c = o.Events.get(0).createdById;
        }*/
        if(toUpdate){
          //On décoche les éventuels rdv annulés sur l'opportunité (On les recochera après)
          o.RDV_annul__c = false;
          oppsToUpdate.put(o.id,o);
        }
          
      }else if(o.date_1er_RDV__c != null || o.date_dernier_RDV__c !=null || o.RDV_effectues__c !=null || o.Contexte__c !=null){
        //On réinitialise dans le cas d'une annulation
        o.date_1er_RDV__c = null;
        o.date_dernier_RDV__c = null;
        o.RDV_effectues__c = null;
        o.Contexte__c = null;
        o.Objections__c = null;
        o.Processus_de_decision__c = null;
        o.Enjeux__c  = null; 
        o.Timing_Prochaine_etape__c = null;
        // On ne vide pas l'origine du RDV si il y a une annulation afin de garder une trace pr le tx d'annulation
        //o.Origine_du_RDV__c = null;
        //DIDIER 18/07/16 On ne vide plus le champ a l'annulation car des petits malin s'amusent a le re-remplir en créant un autre rdv plus tard
        //o.Date_de_prise_de_RDV__c = null;
        oppsToUpdate.put(o.Id,o);
      }
    }
    
      
      
    Boolean FlagRdvReporteOnOpportunite;
    //Traitement des RDV Annulés
    for (Opportunity o : [Select id,Origine_du_RDV__c,createdDate,Name,date_1er_RDV__c,date_dernier_RDV__c,RDV_effectues__c,
                  //Edit didier, on met origine du RDV a vide lorsque apporteur d'affaire est renseigné
                  Role_Apporteur_daffaires__c,Apporteur_d_affaire__c,recommandePar__c,
                  Contexte__c,Enjeux__c,Timing_Prochaine_etape__c,Processus_de_decision__c,Objections__c,Pole__c,
                  ACS_date_de_RDV_report__c,RDV_annul__c,Date_initiale_RDV__c,
                  Account.RecordType.developerName,Email_du_suiveur_notification_workflow__c,E_mail_du_DR__c,E_mail_du_DCR__c,
                  (Select Id,StartDatetime,Description,Report_au__c,annulation_et_report__c,Commentaires__c,
                    Objections__c,Processus_de_decision__c,Enjeux__c,Timing_Prochaine_tape__c,createdDate,recommandePar__c from Events WHERE
                    objet_evenement__c IN:TypeEvent AND
                    nature_evenement__c IN: NatureEvent AND
                    recordTypeId = :this.RecordTypeCommercial
                    AND annulation_et_report__c != null
                    ORDER by StartDateTime ASC
                  )  FROM Opportunity
                  WHERE Id IN:this.OpportunitiesId]
      ){
      if(o.events.size()>0){
        Opportunity o2 = oppsToUpdate.containsKey(o.id) ? oppsToUpdate.get(o.Id) : o;
        
        //FlagRdvReporteOnOpportunite = false;
        for(Event Ev:o.events){
          if(Ev.annulation_et_report__c == 'Annulé'){
            //On vérifie qd meme qu'on a pas mis un évenement plus récent dans le dernier RDV
            //Edit didier : Débile : on est sur qu'on est dans RDV annulé
            //if(o2.date_dernier_RDV__c == null || o2.date_dernier_RDV__c <= Ev.StartDateTime.date() || Ev.annulation_et_report__c == 'Annulé')
              o2.RDV_annul__c = true;
            //if(Ev.annulation_et_report__c == 'Annulé'){
              o2.StageName = 'Fermée: refus du RDV';
              o2.Precision_etape__c = 'RDV Annulé';
            //}
          }
          if(Ev.annulation_et_report__c == 'Annulé à reprendre'){
            //Si c'est le 1er RDV, il se peut qu'on soit passé par au dessus et qu'on ai remis les truc a null
            //Dans le cas d'un RDV antérieur reporté il ne faut pas cocher la case RDV annulé ni remettre l'opp à 0
            // Edit : 02/07/2013, en fait même si il y a un RDV antérieur reporté il faut mettre à jour l'opp à 0, sauf pb de reporting mais pas identifié aujourd'hui
            if((o2.date_dernier_RDV__c == null /*&& !FlagRdvReporteOnOpportunite*/)|| (o2.date_dernier_RDV__c == Ev.StartDateTime.date() && o2.RDV_effectues__c == 1)){
              o2.RDV_annul__c = true;
              o2.StageName = 'RDV à repositionner';
            }
          }
          if(Ev.annulation_et_report__c == 'Reporté'){
            //FlagRdvReporteOnOpportunite = true;
            o2.RDV_annul__c = false;
            o2.ACS_date_de_RDV_report__c = Ev.Report_au__c;
            
            //Edit didier 18/01/13 pb de date de prise de rdv dans le cas des RDV reportés
            if(o2.Date_de_prise_de_RDV__c == null || Ev.createdDate < o2.Date_de_prise_de_RDV__c){
              o2.Date_de_prise_de_RDV__c = Ev.createdDate.date();
            }
          }
          o2.Date_initiale_RDV__c = Ev.StartDateTime.date();
          o2.Commentaire_annulation_RDV__c = Ev.Commentaires__c;
        }
        if(!oppsToUpdate.containsKey(o2.Id))
          oppsToUpdate.put(o2.Id,o2);
      }  
      }
      this.RdvDoubleProduit();
    return oppsToUpdate.values();  
  }
  
  
  
  /**
   * 
   * Un Rendez vous est considéré comme RDV double produit si : 
   *       2 date de RDV dans 1 intervalle de 3 mois   |  //Edit didier 6 mois 11/12/12
   *      avec le même OwnerId,             |
   *       sur le même compte,              } Cas n˚1
   *      sur 2 opportunités différentes (meme pole)  |  
   *      Avec le même interlocuteur          |
   *
   *       2 date de RDV dans le même mois       | // Edit didier 3 mois 12/11/12
   *      avec le même OwnerId,             |
   *       sur le même compte,               } Cas n˚2
   *      sur 2 opportunités différentes (meme pole)  | 
   *      Avec un interlocuteur différent        |
   * 
   */
  private void RdvDoubleProduit(){
    
    Map<Id,OpportunityChecker> AccountToOpportunity = new Map<Id,OpportunityChecker>();
    //Récupération des opportunités ainsi que de leur premier RDV sur les comptes concernés
    for(Opportunity o : [Select Id,
                  AccountId,
                  Pole__c,
                  createdDate,
                  Opportunite_soeur__c,
                  (select Id from Opportunites_soeurs__r),
                  (select Id,ownerId,whoId,startDateTime from Events where 
                          recordTypeId =: this.recordTypeCommercial
                          AND isChild = false
                          AND Annulation_et_report__c = ''
                          order by startDateTime ASC ) 
                  from Opportunity 
                  where ( AccountId in :this.AccountsId  or id in : this.OpportunitiesId )
                  		//EDIT DIDIER 180314 case 2832 On peut mettre manuellement des opp soeurs => on crée une case a cocher qui permet de sortir des opportunités de ce système
                  		AND Opportunite_soeur_manuelle__c != true
                  		//FIn edit didier case 2832 
                  order by CreatedDate ASC]){
      
      if(!AccountToOpportunity.containsKey( o.AccountId ))
        AccountToOpportunity.put( o.AccountId ,new OpportunityChecker());
      
      OpportunityChecker opc = AccountToOpportunity.get(o.AccountId);
      if(!o.events.isEmpty()){
        opc.registerOpportunity(o,o.events.get(0));
      }else{
        opc.registerOpportunity(o,null);
      }
    }
    
    //Maintenant qu'on a toutes les opportunites, on va pouvoir les checker véritablement
    List<Opportunity> oppToUpdate2 = new List<Opportunity>();
    for(OpportunityChecker opc : AccountToOpportunity.values()){
        oppToUpdate2.addAll(opc.processAssignSister());
    }
    
    //Maintenant qu'on a les opportunités soeurs, on va les merger avec les vraies opportunités qu'on voulait update a la base
    for(Opportunity o : oppToUpdate2){
      if(this.OppsToUpdate.containsKey(o.Id)){
        this.OppsToUpdate.get(o.Id).Opportunite_soeur__c = o.Opportunite_soeur__c;
      }else
        this.OppsToUpdate.put(o.Id,o);
    }
  }
  
  private class OpportunityChecker{
    private Date minStartDate;
    private Date maxStartDate;
    
    /*
    private Map<Opportunity,Event> OpportunitesPoleSocial;
    private Map<Opportunity,Event> OpportunitesPoleInno;
    */
    private Map<String,Map<Opportunity,Event>> OpportunitesParPole;
      
    public OpportunityChecker(){
      this.OpportunitesParPole = new Map<String,Map<Opportunity,Event>>();
      //this.OpportunitesPoleSocial = new Map<Opportunity,Event>();
      //this.OpportunitesPoleInno   = new Map<Opportunity,Event>();
    }
    
    
    public void registerOpportunity(Opportunity o,Event premierRDV){
      if(!this.OpportunitesParPole.containsKey(o.pole__c))
          this.OpportunitesParPole.put(o.pole__c,new Map<Opportunity,Event>());
      this.OpportunitesParPole.get(o.pole__c).put(o,premierRDV);
      /* EDIT Didier 01/02/2017 : On ne met plus le pole en dur
       * if(o.pole__c == 'Innovation')
        this.OpportunitesPoleInno.put(o,premierRDV);
      else
        this.OpportunitesPoleSocial.put(o,premierRDV); */     
    }
    
    public Opportunity[] processAssignSister(){
      Opportunity[] ret = new List<Opportunity>();
      for(String pole : this.OpportunitesParPole.keySet())
          ret.addAll(this.compareOpps(this.OpportunitesParPole.get(pole)));
     /* ret.addAll(this.compareOpps(this.OpportunitesPoleSocial));
      ret.addAll(this.compareOpps(this.OpportunitesPoleInno));*/
      return ret;
    }
    
    private Opportunity[] compareOpps(Map<Opportunity,Event> oes){
      //ici, on a que des opportunités sur le même compte et le même pole associées a leur premier évenement,
      //Reste A checker : le ownerId des évènements, le whoId, la date des évènements
      Opportunity[] ret = new List<Opportunity>();

      map<Id,Opportunity[]> eventOwnerIdToOpps = new map<Id,Opportunity[]>();
      map<Id,Id>   OppIdToWhoId     = new map<Id,Id>();
      map<Id,Date> OppIdToDate    = new map<Id,Date>();
      for(Opportunity o: oes.keySet()){
        Event ev = oes.get(o);
        if( ev == null ){
          if(o.opportunite_soeur__c != null){
            o.opportunite_soeur__c = null;
            ret.add(o);
          }
          continue;
        }
        //Gestion des ownerId des événements
        if(!eventOwnerIdToOpps.containsKey(ev.ownerId))
          eventOwnerIdToOpps.put(ev.ownerId,new List<Opportunity>());
        eventOwnerIdToOpps.get(ev.ownerId).add(o);
        //Gestion des contacts des événements
        OppIdToWhoId.put(o.Id,ev.whoId);
        OppIdToDate.put(o.Id,ev.StartDateTime.Date());
      }
      
      //Maintenant, on peut matcher les trucs par eventOwnerId
      for(Opportunity[] oppsByOwner : eventOwnerIdToOpps.values()){
        if(oppsByOwner.size() > 1){
          ret.addAll(this.findSisters(oppsByOwner,OppIdToWhoId,OppIdToDate));
        }else{ 
          //On est sur qu'il n'y a qu'un RDV avec ce ownerId,
          if(oppsByOwner.get(0).opportunite_soeur__c != null){
            oppsByOwner.get(0).opportunite_soeur__c = null;
            ret.add(oppsByOwner.get(0));
          }
        }
          
      }      
      return ret;
    }
    
    private List<Opportunity> findSisters(List<Opportunity> inOpps, Map<Id,Id> OppIdToWhoId, Map<Id,Date> OppIdToDate ){
      //Ici, on a une liste d'opportunité, les whoId qui correspondent, ainsi que les dates de premier évenement
      //La technique : 
      /*
        On compare chaque opportunité avec toutes les autres
        On rempli SisterOpp, pour chaque opportunité, on aura toutes ses soeurs,
        Ensuite, on update toutes les opportunités en prenant garde a ne pas daire de référence cyclique
      */
      Map<Id,Opportunity> inOppsMap = new Map<Id,Opportunity>();
      Map<Id,Id[]> SistersOpp = new Map<Id,Id[]>();
      Map<Id,Id> prevOppSoeur = new Map<Id,Id>();
      Opportunity[] ret = new List<Opportunity>();
      
      
      //didier 01/03/13 a faire pour les opti, on compare uniquement avec 91 jours
      //En théorie, les opportunités sont déjà classée par pole
      Boolean isInno = false;
      if(!inOpps.isEmpty())
        isInno = inOpps.get(0).pole__c == 'Innovation';
      
      
      //Didier 1902
      //On va trier inOpps sur le champ createdDate
      system.debug('inOpps');
      system.debug(inOpps);
      List<OpportunityCreatedDateWrapper> sortedOpps = new List<OpportunityCreatedDateWrapper>();
      for(Opportunity o : inOpps){
        sortedOpps.add(new OpportunityCreatedDateWrapper(o));
      }      
      sortedOpps.sort();
      
      
      
      for(OpportunityCreatedDateWrapper wrapper:sortedOpps){
        Opportunity o = wrapper.oppy;
        prevOppSoeur.put(o.Id,o.opportunite_soeur__c);
        o.opportunite_soeur__c = null;  //On reset le opportunité soeur
        inOppsMap.put(o.Id,o);
        Date DateO = OppIdToDate.get(o.id);
        Id WhoIdO = OppIdToWhoId.get(o.Id);
        SistersOpp.put(o.Id,new List<Id>());
        //Comparaison de toutes les opportunités avec celle la
        for(Opportunity compTo : inOpps){
          Date CompDate = OppIdToDate.get(compTo.id);
          Id CompWho = OppIdToWhoId.get(compTo.Id);
          //Edit didier 01/03/13, pour les opti, on compare avec 3 mois quoiqu'il arrive
          if(CompWho != WhoIdO && isInno){
            if(Math.abs(DateO.daysBetween(compDate)) <= 91){
              SistersOpp.get(o.Id).add(compTo.Id);
            }
          }else if (CompWho == WhoIdO){
            if(Math.abs(DateO.daysBetween(compDate)) <= 182){
              SistersOpp.get(o.Id).add(compTo.Id);
            }
          }
        }
      }
      
      
      //Maintenant, on va désigner une vraie soeur unique pour chaque opportunité
      //Ici, la premiere de la liste sera considérée comme "maman"
      set<Id> OpportunitesTraitees = new Set<Id>();
      Id oppId;
      for(OpportunityCreatedDateWrapper wrapper:sortedOpps){
        //Id oppId : SistersOpp.keySet()){
        if(SistersOpp.containsKey(wrapper.oppy.id))
          oppId = wrapper.oppy.id;
        else 
          continue;
        
        
        OpportunitesTraitees.add(oppId);
        for(id sisterOpp : SistersOpp.get(oppId)){
          if(!OpportunitesTraitees.contains(sisterOpp)){  //On vérifie qu'on ne fait pas de références circulaires et qu'on a pas déjà rempli l'opp soeur
            OpportunitesTraitees.add(sisterOpp);
            inOppsMap.get(sisterOpp).opportunite_soeur__c = oppId;
            if(prevOppSoeur.get(inOppsMap.get(sisterOpp).id) != oppId){  //On ne met a jour que les opportunités qui ont changées.
              ret.add(inOppsMap.get(sisterOpp));
            }
          }
        }
      }
      //On reboucle pour ajouter les opportunités qui sont passées a null
      for(Opportunity o:inOppsMap.values()){
        if(prevOppSoeur.get(o.id) != o.opportunite_soeur__c){
          ret.add(o);
        }
      }
      return ret;
      
    }
  }
  
   public void sendDeleteEmail(){
      
      //Récupération de Sylvain Habert , Stéphane Sawicky et les assistantes
    //TODO refaire ca quand les roles seront fait
    List<string> Adresses = new List<string>();
      List<Messaging.Email> mails = new List<Messaging.Email>();
      
      //Récupération des adresses.
      List<String> AdressesInno = new List<String>();
      List<String> AdressesOpti = new List<String>();
      for(User u : [SELECT id,email,Mail_suppression_de_RDV_Inno__c,Mail_suppression_de_RDV_Opti__c from user where (Mail_suppression_de_RDV_Inno__c = true or Mail_suppression_de_RDV_Opti__c = true) AND isActive = true]){
        if(u.Mail_suppression_de_RDV_Inno__c){
          AdressesInno.add(u.email);
        }
        if(u.Mail_suppression_de_RDV_Opti__c){
          AdressesOpti.add(u.email);
        }
      }
      
      for(Event ev : this.EventsDeleted.values()){
        if(this.oppsToUpdate.containsKey(ev.whatId)){
          Adresses.clear();
          Opportunity o = this.oppsToUpdate.get(ev.whatId);
          if(o.Pole__c == 'Optimisation' && o.Account.RecordType.DeveloperName == 'FRANCE_ACCOUNT' && !AdressesOpti.isEmpty())
            Adresses.addAll(AdressesOpti);
          else if(o.Pole__c == 'Innovation' && o.Account.RecordType.DeveloperName == 'FRANCE_ACCOUNT' && !AdressesInno.isEmpty())
            Adresses.addAll(AdressesInno);
          
          if(o.E_mail_du_DCR__c != null)
            Adresses.add(o.E_mail_du_DCR__c);
          if(o.E_mail_du_DR__c != null)  
            Adresses.add(o.E_mail_du_DR__c);
          if(o.Email_du_suiveur_notification_workflow__c != null)  
            Adresses.add(o.Email_du_suiveur_notification_workflow__c);

          if(!Adresses.isEmpty()){
            //Génération des mails
            try{
              Messaging.reserveSingleEmailCapacity(Adresses.size());
              Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
              Map<String,String> dataToSend = getMailContent(ev,o);
              mail.setHtmlBody(dataToSend.get('HtmlValue'));
              mail.setPlainTextBody(dataToSend.get('Body'));
              mail.setSubject(dataToSend.get('Subject'));
              mail.setSaveAsActivity(false);
              mail.setToAddresses(Adresses);
              mails.add(mail);
            }catch(System.LimitException e){
              system.debug('#Maximum Mail size reached');
            }
          }else{
            system.debug('Mail non envoyé sur la suppression d\'un événement');
            system.debug(o.Pole__c);
            system.debug(o);
          }
        }
      }
    Messaging.Sendemailresult[] ret = Messaging.sendEmail(mails);
    //return null;
    }
    
    private Map<String,String> getMailContent (Event ev, Opportunity o){
      Map<String,String> ret = new Map<String,String>();
    ret.put('Subject', 'Un rendez vous de type commercial a été supprimé');


      String htmlValue = '';
    htmlvalue += '<p>Bonjour</p><br />';
    htmlvalue += '<p>Un rendez vous commercial a été supprimé sur l\'opportunité <a href=\'https://eu1.salesforce.com/'+o.Id+'\'>'+ o.Name +  '</a> par '+Userinfo.getName()+ '</p>';
    htmlvalue += '<strong>Informations sur l\'événement</strong>';
    htmlvalue += '<ul>';
    htmlvalue += '<li>Sujet : '+ev.subject +'</li>';
    htmlvalue += '<li>Identifiant : '+ev.Id + '</li>';
    htmlvalue += '<li>Date du rendez vous: '+ev.StartDateTime.format()+ '</li>';
    htmlvalue += '<li>Rendez vous annulé : '+(ev.Annulation_et_report__c != null ? ev.Annulation_et_report__c : '<i>Non renseigné</i>') + '</li>';
    htmlvalue += '<li>Commentaires : '+ (ev.Commentaires__c != null ? ev.Commentaires__c : '<i>Non renseigné</i>') + '</li>';
    htmlvalue += '</ul>';
    htmlvalue += '<p>Ce rendez vous restera dans la corbeille de l\'utilisateur '+Userinfo.getName()+ ' pendant 15 jours</p>';
    htmlvalue += 'Bonne journée';
      ret.put('HtmlValue',htmlValue);

    
    String bodyValue = '';
    bodyValue += 'Bonjour\n\n';
    bodyValue += 'Un rendez vous commercial a été supprimé sur l\'opportunité '+o.Name+' ( '+ o.Id +' ) par '+Userinfo.getName()+ '\n\n';
    bodyValue += 'Informations sur l\'événement\n';
    bodyValue += '\n';
    bodyValue += '\t * Sujet : '+ev.subject+'\n';
    bodyValue += '\t * Identifiant : '+ev.Id+'\n';
    bodyValue += '\t * Date du rendez vous: '+ev.StartDateTime.format()+'\n';
    bodyValue += '\t * Rendez vous annulé : '+(ev.Annulation_et_report__c != null ? ev.Annulation_et_report__c : '')+'\n';
    bodyValue += '\t * Commentaires : '+(ev.Commentaires__c != null ? ev.Commentaires__c : '')+'\n';
    bodyValue += '\n';
    bodyValue += 'Ce rendez vous restera dans la corbeille de l\'utilisateur '+Userinfo.getName()+ ' pendant 15 jours\n\n';
    bodyValue += 'Bonne journée';
    ret.put('Body',bodyValue);

      
      
      return ret;
    }
  
  global class OpportunityCreatedDateWrapper implements Comparable {

      public Opportunity oppy;
      
      // Constructor
      public OpportunityCreatedDateWrapper(Opportunity op) {
          oppy = op;
      }
      
      // Compare opportunities based on the opportunity CreatedDate.
      global Integer compareTo(Object compareTo) {
          // Cast argument to OpportunityWrapper
          OpportunityCreatedDateWrapper compareToOppy = (OpportunityCreatedDateWrapper)compareTo;
          
          // The return value of 0 indicates that both elements are equal.
          Integer returnValue = 0;
          if (oppy.CreatedDate > compareToOppy.oppy.CreatedDate) {
              // Set return value to a positive value.
              returnValue = 1;
          } else if (oppy.CreatedDate < compareToOppy.oppy.CreatedDate) {
              // Set return value to a negative value.
              returnValue = -1;
          }
          
          return returnValue;       
      }
  }
}