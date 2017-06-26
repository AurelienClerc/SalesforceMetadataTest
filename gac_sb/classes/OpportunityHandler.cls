//@coveredby OpportunityHandler_Test
public without sharing class OpportunityHandler implements iTrigger{
  
  public Map<Id,String> OpportunityId = new Map<Id,String>();

  public Set<Id> RecoToCheck = new Set<Id>();
  
  public Map<id,ProcessInstanceStep> lastsSteps = new Map<Id,ProcessInstanceStep>();
  
  public Map<Id,boolean> oppSoeurId = new Map<Id,boolean>();
  
  public List<Id> eventOnOppToUpdate = new List<Id>();
  
  public static V2Params__c v2Param;
  
  public static set<Id> doneIds = new Set<Id>();
  
  public static boolean preventRecursivity;
  
  public static Map<Id,User> users;
  
  public map<Id,Account> refAccount;
  
  public static map<String,id> refRecordTypes;
    
  static{
      preventRecursivity = false;
      v2Param = V2Params__c.getInstance();
      if(v2Param.BuInno__c == null){  //Cas des tests
        v2Param = new V2Params__c(formationDone__c = true,BuInno__c = 'CIR,FI,CIN',buOpti__c = 'ACS,TAT',BuFL__c ='IL',BuDescribeId__c='TEST BU',ForceSegmentation__c = true,OpportunitesFR__c = '012D0000000gdyJ,012D0000000gdyE,012D0000000hDjO,012D0000000gdqH,012D0000000gdup');
        insert v2Param;
      }
      system.debug(v2param);
      users = new Map<Id,User>([SELECT id,isActive from User]);
      refRecordTypes = new map<String, id>();
      for(recordtype rt: [SELECT Id, developerName FROM RecordType WHERE SobjectType='Opportunity' ]){
          refRecordTypes.put(rt.developerName, rt.id);
      }
  }
  
  // Constructor
  public OpportunityHandler(){
  }

  
  public void bulkBefore(){
    
    if(trigger.isUpdate && trigger.isBefore && !preventRecursivity){
      preventRecursivity = true;
      //Le test de cette fonction se trouve dans le EventHandler_test
      for(Opportunity o : [select Id,StageName,
                (Select ownerId from Events where Annulation_et_report__c = null and isChild = false order by StartDateTime DESC ) from opportunity where Id in: trigger.newMap.Keyset()]){
        //Mise a jour du propriétaire de l'enregistrement lors du passage de RDV effectué a RDV Validé
        if(trigger.newMap.get(o.Id).get('StageName') == 'RDV effectué' && trigger.oldMap.get(o.Id).get('StageName') != 'RDV effectué' && !o.events.isEmpty() ){
          if(users.containsKey(o.Events.get(0).ownerId) && users.get(o.Events.get(0).ownerId).isActive)
            trigger.newMap.get(o.Id).put('OwnerId',o.Events.get(0).ownerId );
        }
      }
      
      //On prend les processinstance les plus récents et pour les mettre dans l'opportunité
      for(ProcessInstance p : [SELECT Id,Status,TargetObjectId,(SELECT Id, StepStatus, Comments FROM Steps where StepStatus = 'Approved' or StepStatus='Rejected' order by createdDate DESC LIMIT 1) FROM ProcessInstance WHERE TargetObjectId in: trigger.newMap.Keyset() order by createdDate DESC]){
        if(!p.Steps.isEmpty() && !lastsSteps.containsKey(p.TargetObjectId)){
          lastsSteps.put(p.TargetObjectId,p.Steps.get(0));
        }
      }
    }
    //A l'insertion, on mappe avec le type de compte
    if(trigger.isInsert && trigger.isBefore){
        set<Id> accountsId = new set<Id>();
        for(sObject o : trigger.new){
            if(!accountsId.contains((id)o.get('accountId')))
                accountsId.add((id)o.get('accountId'));
        }
        refAccount = new map<Id,Account>([SELECT id,type_de_compte__c,recordType.developerName from Account where id in : accountsId]);
    }
  }
  
  public void bulkAfter(){
  }
    
  /**
  * A chaque insertion d'une opportunité, on rempli les infos de segmentation du compte
  */
  public void beforeInsert(SObject so){
     system.debug('###OpportunityHandler Inserting New Opportunity, registering opp for Segmentation');
     Opportunity o = (Opportunity) so;
      if(o.Product_Piste__c != null && refRecordTypes.containsKey(o.Product_Piste__c))
         o.RecordTypeId = refRecordTypes.get(o.Product_Piste__c);
     if(o.Product_Piste__c == 'AS')
         o.RecordTypeId = refRecordTypes.get('FI');
     system.debug('### OpportuintyRecordType '+o.recordTypeId+' '+v2Param.formationDone__c+' '+refAccount.get(o.accountId).recordType.developerName);
     if(o.Annee_segmentation__c == null){
        o.Annee_segmentation__c = String.valueOf(date.today().year());
     }
     o.segmentation_id_externe__c = V2AP01_SegmentationManager.getHistoIdExterne(o.AccountId, Integer.valueOf(o.Annee_segmentation__c));
     if(    v2Param.formationDone__c &&
            v2Param.OpportunitesFR__c.contains((String)o.recordTypeId) &&
            refAccount.containsKey(o.accountId) && 
            refAccount.get(o.accountId).recordType.developerName == 'FRANCE_ACCOUNT') 
    {
        if(o.type_de_compte__c == null)
            o.type_de_compte__c = refAccount.get(o.AccountId).type_de_compte__c;
            V2AP01_SegmentationManager.addItem(o);
     }
  }
  
  public void beforeUpdate(sObject oldSo, sObject so){
    Opportunity o = (Opportunity) so;
    if(o.Annee_segmentation__c == null){
        o.Annee_segmentation__c = String.valueOf(o.createdDate.year());
    }
    //Dis donc ! un nouveau processStep a été enregistré pour cette opportunité
    if(lastsSteps.containsKey(o.id) ){
      if(o.Numero_etape__c >= 6){
         o.commentaire_approbation_proposition__c = lastsSteps.get(o.id).comments;
      }else{
         o.commentaire_approbation_RDV__c = lastsSteps.get(o.id).comments;
      }
    }
    if(o.segmentation_id_externe__c == null || oldSo.get('Annee_segmentation__c') != so.get('Annee_segmentation__c')){
        o.segmentation_id_externe__c = V2AP01_SegmentationManager.getHistoIdExterne(o.AccountId, Integer.valueOf(o.Annee_segmentation__c));
    }
    
  }
  
  public void beforeDelete(SObject so){  
    //Mise a jour du champ Annee concernée des contrats
  }
  
  public void afterInsert(SObject so){
    OpportunityId.Put((Id) so.get('Id'), (String) so.get('Type_de_mission_multi__c'));
    if(so.get('Recommandation__c') != null)
      this.RecoToCheck.add((Id) so.get('Recommandation__c'));
  }
  
  public void afterUpdate(SObject oldSo, SObject so){
    OpportunityId.Put((Id) so.get('Id'), (String) so.get('Type_de_mission_multi__c'));
    if(so.get('Recommandation__c') != null)
      this.RecoToCheck.add((Id) so.get('Recommandation__c'));
    if(oldSo.get('Recommandation__c') != null && so.get('Recommandation__c') != oldSo.get('Recommandation__c'))
      this.RecoToCheck.add((Id) oldSo.get('Recommandation__c'));
    
    if(oldSo.get('opportunite_soeur__c') != so.get('opportunite_soeur__c'))  
    	this.oppSoeurId.put((Id)so.get('Id'), so.get('opportunite_soeur__c') != null);
    
    //EDIT DIDER 180314 => case 2832  Rajout de la case opportunite soeur manuelle : si on la décoche, il faut la remettre dans le systeme
    if( (boolean) oldSo.get('Opportunite_soeur_manuelle__c') && oldSo.get('Opportunite_soeur_manuelle__c') != so.get('Opportunite_soeur_manuelle__c')){
    	//Si on décoche oppsoeur manuelle, il faut updater les évents associés
    	this.eventOnOppToUpdate.add((Id) so.get('Id'));
    }
    //FIN EDIT Didier 180314 case 2832 
    
    if(oldSo.get('Role_Apporteur_daffaires__c') != so.get('Role_Apporteur_daffaires__c')){
	     //Si on modifie Role aporteur d'affaire, il faut remettre les origines du RDV
	 	 this.eventOnOppToUpdate.add((Id) so.get('Id'));
	}
    
  }
  
  public void afterDelete(SObject so){
    OpportunityId.Put((Id) so.get('Id'), (String) so.get('Type_de_mission_multi__c'));
    if(so.get('Recommandation__c') != null)
      this.RecoToCheck.add((Id) so.get('Recommandation__c'));
  }
  
  
  public List<sObject> processRecosUpdate(){
    
    List<sObject> Recos = new List<sObject>();
    if(!this.RecoToCheck.isEmpty()){
        for(Recommandation_cross_selling__c Reco : [
          SELECT Id, Opportunities_creees__c, 
          (Select Id from Opportunit_s__r)
          FROM Recommandation_cross_selling__c where Id in :this.RecoToCheck
        ]){
          if(!Reco.Opportunit_s__r.isEmpty() && Reco.Opportunities_creees__c == false){
            Reco.Opportunities_creees__c = true;
            Recos.add((sObject) Reco);
          }else if(Reco.Opportunit_s__r.isEmpty() && Reco.Opportunities_creees__c == true){
            Reco.Opportunities_creees__c = false;
            Recos.add((sObject) Reco);
          }
        }
    }
    return Recos;
  }
  
  /**
   * andFinally
   *
   * This method is called once all records have been processed by the trigger. Use this 
   * method to accomplish any final operations such as creation or updates of other records.
   */
  public void andFinally(){
    //Le test de cette fonction se treouve dans le contractGateway
    //TODO test
    /* Suppression par Fred le 17/12 car finalement le champs est obligatoire à la saisie du contrat et n'a plus lieu d'etre mis à jour par l'opportunité
    if(!OpportunityId.KeySet().isEmpty()){
      List<Contract> cToUpdate = new List<Contract>();
      for(Contract c:[Select Id,Type_de_mission_multi__c,Opportunite__c from contract where Opportunite__c in :OpportunityId.KeySet()]){
        //Mise a jours des chamsp type de mission des contrats
        if(c.Type_de_mission_multi__c != OpportunityId.get(c.Opportunite__c)){
          c.Type_de_mission_multi__c = OpportunityId.get(c.Opportunite__c);
          cToUpdate.add(c);
        }
      }
      if(!cToUpdate.isEmpty())
        update cToUpdate;
    }*/
    
    if(Trigger.isInsert && Trigger.isBefore){
        system.debug('###OpportunityHandler Inserting New Opportunity, Copying Segmentation');
        V2AP01_SegmentationManager.processCopySegmentation();
    }
    
    List<Sobject> ToUpdate = this.processRecosUpdate();
    
    //Mise a jour des champs RDV freres des évenements rattachés
    if(!oppSoeurId.isEmpty()){
    	List<Event> EvToUpdate = new List<Event>();
    	for(Opportunity o : [select Id,(Select RDV_double_produit__c,whatId from Events) from opportunity where id in: oppSoeurId.keySet()]){
    		if(o.Events.size() > 0){
    			for(Event ev : o.Events){
    				//On ne met pas a jour les événements sur les opporutunités qu'on est en train d'updater
    				if( ev.RDV_double_produit__c != oppSoeurId.get(o.id) ){
    					ev.RDV_double_produit__c = oppSoeurId.get(o.id);
    					ToUpdate.add((sObject) ev);
    				}
    			}
    		}
    	}
    }
    for(event e : [select id from Event where whatId in : this.eventOnOppToUpdate]){
    	//bizarre, on ne peut pas rajouter cette liste ToUpdate? System.TypeException: Collection store exception adding all LIST to LIST
   		ToUpdate.add((sObject) e);
    }
     if(!ToUpdate.isEmpty()){
      update ToUpdate;
    }
  }
}