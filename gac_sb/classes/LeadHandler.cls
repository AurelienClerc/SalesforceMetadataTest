/**
 * Class LeadHandler
 *
 * Trigger Handler for the Event SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public with sharing class LeadHandler implements ITrigger {
	
	protected Map<Id,Id> LeadToAccount = new map<Id,Id>();
	
	// Constructor
	public LeadHandler(){
	}

	
	public void bulkBefore(){
	}
	
	public void bulkAfter(){
	}
		
	/**
	*/
	public void beforeInsert(SObject so){
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
	}
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
		Lead oldLead = (Lead) oldSo;
		Lead newLead = (Lead) so;
		if(oldLead.ConvertedAccountId != newLead.ConvertedAccountId){
			LeadToAccount.put(newLead.Id,newLead.ConvertedAccountId);
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
		if(LeadToAccount.size() > 0){
			List<Etablissement_secondaire__c> esToUpdate = new List<Etablissement_secondaire__c>();
			for(Etablissement_secondaire__c es: [Select Id,piste__c,Account__c from Etablissement_secondaire__c where piste__c in :LeadToAccount.keyset()]){
				if(es.Account__c == null){
					es.Account__c = LeadToAccount.get(es.piste__c);
					es.piste__c = null;
					esToUpdate.add(es);
				}
			}
			update esToUpdate;
		}
	}

}