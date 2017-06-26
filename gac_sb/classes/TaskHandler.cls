/**
 * Class TaskHandler
 *
 * Trigger Handler for the Task SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public without sharing class TaskHandler implements ITrigger{

	private List<Id> IdsFacturesToUpdate = new List<Id>();
	protected Map<Id,Facture__c> FacturesToUpdate = new Map<Id,Facture__c>();
	protected Map<id,Recommandation_cross_selling__c> recoToUp;
	protected string Factureprefix;
  
  // Constructor
  public TaskHandler(){
		this.Factureprefix = Facture__c.sObjectType.getDescribe().getKeyPrefix();
		recoToUp = new Map<id,Recommandation_cross_selling__c>();
		system.debug('handler : '+this.Factureprefix);
  }

  
  public void bulkBefore(){
  }
  
  public void bulkAfter(){
  }
  
  public void beforeInsert(SObject so){
  }
  
  public void beforeUpdate(SObject oldSo, SObject so){
  }
  
  public void beforeDelete(SObject so){  
  }
  
  public void afterInsert(SObject so){
  	Task t = (Task) so;
  	if(t.get('WhatId') !=null && ((String) t.WhatId).startsWith(this.Factureprefix))
  		this.IdsFacturesToUpdate.add((Id) t.get('WhatId'));
  	if(t.Recommandation__c != null){
  	    recoToUp.put(t.Recommandation__c, new Recommandation_cross_selling__c(id = t.Recommandation__c, tache_cree__c = true));
  	}
  }
  
  public void afterUpdate(SObject oldSo, SObject so){
  	Task t = (Task) so;
  	Task oldT = (Task) oldSo;
	if(t.get('WhatId') !=null && ((String) t.WhatId).startsWith(this.Factureprefix)){
  		this.IdsFacturesToUpdate.add((Id) t.get('WhatId'));
  		if(t.get('WhatId') != oldT.get('WhatId'))	
  			this.IdsFacturesToUpdate.add((Id) oldT.get('WhatId'));
	}
	if(oldSo.get('WhatId') !=null && ((String) oldT.WhatId).startsWith(this.Factureprefix) && t.get('WhatId') ==null){
		this.IdsFacturesToUpdate.add((Id) oldT.get('WhatId'));
	}
	if(t.Recommandation__c != null){
  	    recoToUp.put(t.Recommandation__c, new Recommandation_cross_selling__c(id = t.Recommandation__c, tache_cree__c = true));
  	}
  		
  }
  
  public void afterDelete(SObject so){
  	Task t = (Task) so;
	if(t.get('WhatId') !=null && ((String) t.WhatId).startsWith(this.Factureprefix))
  		this.IdsFacturesToUpdate.add((Id) t.get('WhatId'));
  }
  
  /**
   * andFinally
   *
   * This method is called once all records have been processed by the trigger. Use this 
   * method to accomplish any final operations such as creation or updates of other records.
   */
  public void andFinally(){
    if(Trigger.isAfter){
      List<Facture__c> Fact = this.processFacturesToUpdate();
      system.debug('TEST liste : ' + Fact);
      try{
        update Fact;
        
      }catch(Exception e){
        String Message = e.getMessage();
        if(Message.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION,')){
          Message = Message.replaceAll('.*FIELD_CUSTOM_VALIDATION_EXCEPTION,','');
        }
        if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
          trigger.new.get(0).addError(System.Label.Erreur_opp_soeur + Message );
        }else
          trigger.old.get(0).addError(System.Label.Erreur_opp_soeur + Message );
      }
      if(!recoToUp.isEmpty()){
          update recoToUp.values();
      }
  	}
  }
  
  private List<Facture__c> processFacturesToUpdate(){
  	if(!this.IdsFacturesToUpdate.isEmpty()){
	  	for (Facture__c f : [Select id, Commentaires_recouvrement__c, Date_de_derniere_relance__c,
			  					(Select Id,Description, LastModifiedDate
			  					from Tasks
			                    ORDER by ActivityDate DESC)
	                    	FROM Facture__c
	                  		WHERE Id IN:this.IdsFacturesToUpdate]){
	        if(f.Tasks.size() > 0){          			
		        if(f.Commentaires_recouvrement__c != f.Tasks.get(0).Description){
		          f.Commentaires_recouvrement__c = f.Tasks.get(0).Description;
		          f.Date_de_derniere_relance__c = date.valueOf(f.Tasks.get(0).LastModifiedDate);
		          this.FacturesToUpdate.put(f.id,f);
		        }
	        }else{
	        	 f.Commentaires_recouvrement__c = '';
	        	 f.Date_de_derniere_relance__c = null;
		         this.FacturesToUpdate.put(f.id,f);
	        }
	     }
  	}
  	 return this.FacturesToUpdate.values();
  }

}