/**
 * Class CaseHandler
 *
 * Trigger Handler for the Event SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */
 
 //TODO, virer les paramètre statiques tatic Map<id, List<Id>> staticEventParams; , le bug sur les whoId et WhatId vide dans les triggers After a été corrigé dans l'API 26
public without sharing class EventHandler implements ITrigger{
  
  protected EventOnOpportunityGateway EvOnOpp = new EventOnOpportunityGateway();
  
  static boolean OppSoeurCalculees;
  
  protected Map<Id,List<Event>> OppsId = new Map<Id,List<Event>>();
  
  protected Map<Id,List<Event>> ConsId = new Map<Id,List<Event>>();
  
  
  static Map<id, List<Id>> staticEventParams;
  
  // Constructor
  public EventHandler(){
    if (OppSoeurCalculees == null)
        OppSoeurCalculees = false;
  }

  
  public void bulkBefore(){
    if(trigger.isBefore)
      staticEventParams = new Map<id, List<Id>>();
  }
  
  public void bulkAfter(){
  }
  
  //En before , on va modifier les evenement a la volée pour mettre a jour les champs body outlook etc.
  public void beforeInsert(SObject so){
    this.addEvent((Event) so);
  }
  
  public void beforeUpdate(SObject oldSo, SObject so){
    this.addEvent((Event) so);
  }
  
  public void beforeDelete(SObject so){  
    Event e = (Event) so;
    staticEventParams.put(e.Id,new List<Id>{e.AccountId , e.WhatId, e.WhoId});
  }
  
  //En after, on va regarder si on doit mettre a jour l'opportunité (date de RDV pris, opportunité soeur...etc) cf eventOnOpportunityGateway
  public void afterInsert(SObject so){
    this.EvOnOpp.addItem((Event) so);
  }
  
  public void afterUpdate(SObject oldSo, SObject so){
    this.EvOnOpp.addItem((Event) oldSo); //On ajoute le oldso pour modifier également la vielle opportunité
    this.EvOnOpp.addItem((Event) so);
  }
  
  public void afterDelete(SObject so){
    //system.debug(so);
    Event ev = (Event) so;
    ev = ev.clone(true);
    ev.WhatId = staticEventParams.get(ev.Id).get(1);
    ev.WhoId = staticEventParams.get(ev.Id).get(2);
    this.EvOnOpp.addItem(ev,staticEventParams.get(ev.Id).get(0));
  }
  
  /**
   * andFinally
   *
   * This method is called once all records have been processed by the trigger. Use this 
   * method to accomplish any final operations such as creation or updates of other records.
   */
  public void andFinally(){
    if(Trigger.isAfter && !OppSoeurCalculees){
      List<Opportunity> oppsToUpdate = this.EvOnOpp.processOppUpdate();
      system.debug('finaly');
      system.debug(oppsToUpdate);
      OppSoeurCalculees = true;
      try{
        update oppsToUpdate;
        OppSoeurCalculees = false;
      }catch(Exception e){
        String Message = e.getMessage();
        if(Message.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION,')){
          Message = Message.replaceAll('.*FIELD_CUSTOM_VALIDATION_EXCEPTION,','');
        }
        if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
          trigger.new.get(0).addError(System.Label.Erreur_opp_soeur + Message );
        }else
          trigger.old.get(0).addError(System.Label.Erreur_opp_soeur + Message );
          
        //return;
      }
      //Didier 22/01/2013
      if(Trigger.isDelete){
        //on est en after delete, on envoie un mail de suppression
        this.EvOnOpp.sendDeleteEmail();
      }
      
    }else if(!trigger.isDelete){
      //On est sur qu'on est en before insert ou update
      processOutlookEvent();
    }
  }
  
  
  
  /*########################################
  
  
  fonction pour la mise a jour OutlookEvent
  
  
  ##########################################*/
  private void addEvent(Event e){
    if(e.get('WhatId') !=null && ((String) e.WhatId).startsWith('006')){
      if(!OppsId.containsKey(e.whatId))
        OppsId.put(e.WhatId, new Event[]{e} );
      else
        oppsId.get(e.WhatId).add(e);
      if(e.Nature_evenement__c == 'RDV Physique' && e.categorie_outlook__c == null)
              e.categorie_outlook__c = 'Catégorie verte';
          if(e.Nature_evenement__c == 'RDV Téléphonique' && e.categorie_outlook__c == null)
              e.categorie_outlook__c = 'Catégorie bleue';
          if(e.Annulation_et_report__c == 'Annulé' && e.categorie_outlook__c == null)
              e.categorie_outlook__c = 'Catégorie rouge';
          if((e.Annulation_et_report__c == 'Reporté' || e.Annulation_et_report__c=='Annulé à reprendre') && e.categorie_outlook__c == null)
              e.categorie_outlook__c = 'Catégorie jaune';
    }else{
      /*e.emplacement_outlook__c = '';
      e.body_outlook__c = '';
      e.categorie_outlook__c = '';*/
    }
    if(e.get('WhoId') !=null && ((String) e.WhoId).startsWith('003') && ((String) e.WhatId).startsWith('006')){
      if(!ConsId.containsKey(e.WhoId))
        ConsId.put(e.WhoId,new Event[]{e} );
      else{
        ConsId.get(e.WhoId).add(e);
      }
    }
  }
  
  /******************************
  *******************************
  ***              ***
  ***              ***
  ***              ***
  ***    Fonction de       ***
  ***  remplissage des champs  ***
  ***   outlook_emplacement  ***
  ***              ***
  ***              ***
  *******************************
  *******************************
  */
  private void processOutlookEvent(){
      Map<Id,User> users = new map<Id,User>([Select Id,Name from User]);
      
      
      
      
      for(Opportunity o:[SELECT Id, Name ,enjeux_opportunite__c, RecordTypeId, 
                Origine_du_RDV__c, RDV_a_effectuer_par__c, description,
                Account.Name, Account.BillingStreet,Account.BillingPostalCode,Account.BillingCity,
                Origine_du_RDV__r.Name,OwnerId,RecordType.Name
                from Opportunity where id in :OppsId.keySet()]){
        for(Event e:OppsId.get(o.Id)){
          
          e.emplacement_outlook__c =   o.recordType.Name + 
                        addElement(' - ',o.enjeux_opportunite__c,'')+
                        addElement(' - ',o.Account.Name,'');
            
            if(e.WhoId == null || !((String)e.WhoId).startsWith('003')){
              e.emplacement_outlook__c = addElement(' - ', o.Account.BillingPostalCode, '' ) + 
                             addElement(', ', o.Account.BillingCity, '' );
                            
              e.body_outlook__c = addElement( System.Label.Adresse + ' : ', o.Account.BillingStreet, '\n')+
                        addElement('',o.description,'');

            }else{
              e.body_outlook__c = '__ADRESSTOFILL____EMAILTOFILL__'+addElement('',o.description,'');
              e.emplacement_outlook__c += '__CITYTOFILL__';
            }
            e.emplacement_outlook__c += ' ('+users.get(e.ownerId).Name + ' / ' + users.get(e.CreatedById != null ? e.CreatedById : UserInfo.getUserId()).Name+')';
          
          if(e.emplacement_outlook__c.length() > 255)
                e.emplacement_outlook__c = e.emplacement_outlook__c.substring(0, 251) + '...';
              if(e.body_outlook__c !=null && e.body_outlook__c.length() > 255){
                  e.body_outlook__c = e.body_outlook__c.substring(0, 251) + '...';
          }
        }
      }for(Contact c:[SELECT Id,Salutation,Name,Title,Email,Etablissement__r.Rue__c,Etablissement__r.Code_postal__c, Etablissement__r.ville__c,Phone,
                  Account.BillingStreet,Account.BillingPostalCode,Account.BillingCity from contact where id in:ConsId.keySet()]){
        String MailReplacement = (c.Email != null ? 'E-mail : ' + c.Email + '\n' : '');
        String AdressReplacement = c.Etablissement__r.Rue__c != null ? System.Label.Adresse + ' : '+c.Etablissement__r.Rue__c+'\n':
                      (c.Account.BillingStreet != null  ? System.Label.Adresse + ' : '+c.Account.BillingStreet + '\n':'');
        String CityReplacement = c.Etablissement__r.Code_postal__c != null ? c.Etablissement__r.Code_postal__c + addElement(', ',c.Etablissement__r.Ville__c,''):
                    (c.Account.BillingPostalCode != null  ? c.Account.BillingPostalCode + addElement(', ',c.Account.BillingCity,'') :'');
                      
        for(Event e:ConsId.get(c.Id)){
          if(e.emplacement_outlook__c.contains('__CITYTOFILL__') && e.body_outlook__c.contains('__ADRESSTOFILL____EMAILTOFILL__')){
            e.emplacement_outlook__c = e.emplacement_outlook__c.replaceFirst('__CITYTOFILL__',AddElement (' - ',CityReplacement,''));
            e.emplacement_outlook__c += ' - '+ addElement('',c.Salutation,' ') + c.Name + addElement(' (',c.Title,')');
            e.body_outlook__c = e.body_outlook__c.replaceFirst('__EMAILTOFILL__',MailReplacement  );
            e.body_outlook__c = e.body_outlook__c.replaceFirst('__ADRESSTOFILL__',AdressReplacement  );
            
            e.emplacement_outlook__c += addElement(' - Tél.: ', c.Phone, '');
            if(e.emplacement_outlook__c.length() > 255){
                  e.emplacement_outlook__c = e.emplacement_outlook__c.substring(0, 251) + '...';
            }
            if(e.body_outlook__c !=null && e.body_outlook__c.length() > 255){
                  e.body_outlook__c = e.body_outlook__c.substring(0, 251) + '...';
            }
          }
        }              
      }
  }
  
  
  private String addElement( String beforeString, String str, String afterString ){
        if(
            (str == null) ||
            (str == '')
        )
            return '';
        return beforeString + str + afterString;
    }
    
   
  
  
  
}