public with sharing class AccountHandler implements ITrigger {

	public static Integer nbAccountsGeocoded = 0;	//Le nombre d'appel de geocodage déjà éffectués dans le batch
	
	public AccountHierarchyGateway AccHierarchy = new AccountHierarchyGateway();
	
	
	public Map<Id,Id> ParentsId = new Map<Id,Id>(); 
	
	public void bulkBefore(){
		List<Id> ParentsToLookFor = new List<Id>();
		List<sObject> records = Trigger.isDelete ? Trigger.old : Trigger.new;
		for(sObject so : records){
			Account AccNew = (Account) so;
			if(AccNew.parentId != null)
			    ParentsToLookFor.add(AccNew.parentId);
		}
		if(!ParentsToLookFor.isEmpty()){
			//Remplissage du parentId qui contient les références tete de groupe
			for(Account Acc:[Select id,parentId,reference_Tete_de_groupe__c from Account where id in : ParentsToLookFor]){
				if(Acc.reference_Tete_de_groupe__c == null)
					ParentsId.put(Acc.Id,Acc.Id);
				else
					ParentsId.put(Acc.Id,Acc.reference_Tete_de_groupe__c);	
			}
		}
	}
	
	public void bulkAfter(){
	}
		
	public void beforeInsert(SObject so){
		Account newAcc = (Account) so;
		if(newAcc.ParentId == null)
			newAcc.reference_Tete_de_groupe__c = null;
		else
			newAcc.reference_Tete_de_groupe__c = ParentsId.get(newAcc.parentId);
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
		Account oldAcc = (Account) oldSo;
		Account newAcc = (Account) so;
		
		if(oldAcc.ParentId != newAcc.ParentId){
			if(newAcc.ParentId == null){
				newAcc.reference_Tete_de_groupe__c = null;
				AccHierarchy.AddChildToCompute(newAcc.Id, newAcc.Id, ParentsId.get(newAcc.parentId));
			}else{
				newAcc.reference_Tete_de_groupe__c = ParentsId.get(newAcc.parentId);
				AccHierarchy.AddChildToCompute(newAcc.Id, newAcc.ParentId, ParentsId.get(newAcc.parentId));
			}
		}
		if(newAcc.BillingStreet != oldAcc.BillingStreet || newAcc.BillingPostalCode != oldAcc.BillingPostalCode) //On change l'adresse
		    newAcc.GoogleGeocoded__c = false;
			
	}
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
		geocodeAccount((Account) so);
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
		geocodeAccount((Account) so);
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
		if(trigger.isUpdate && trigger.isBefore){
			List<Account> UpdateAcc = AccHierarchy.processChildrenUpdate();
			update updateAcc;
		}else if(trigger.isAfter){
			List<Id> AccountsToReconstruct = new List<Id>();
			List<sObject> records = Trigger.isDelete ? Trigger.old : Trigger.new;
			for(sObject so : records){
				if(trigger.isDelete || (trigger.isUpdate && so.get('parentId') != trigger.oldMap.get(so.Id).get('parentId')) )
					AccountsToReconstruct.add(so.Id);
			}
			if(!AccountsToReconstruct.isEmpty())
				AccHierarchy.reconstruct(AccountsToReconstruct);
			
			
			
		}
	}
	
	
	private static void geocodeAccount(Account acc){
		
		/**
		 * Effectue la géolocalisation si:
		 * 	- On n'est pas déjà dans un contexte future
		 * 	- La rue et le code postal sont renseignés
		 * 	- On n'a pas dépassé le nombre maximal de requêtes de géolocations (cf. custom setting "Google Map Settings")
		 */
		if(!System.isFuture() && !System.isBatch() && !acc.GoogleGeocoded__c && String.isNotBlank(acc.BillingStreet) && String.isNotBlank(acc.BillingPostalCode) && nbAccountsGeocoded < GoogleMapSettings__c.getInstance().GeocodeMaxBatch__c){
			SF2AP01_GoogleGeocode.geocodeAccount(acc.Id);
			nbAccountsGeocoded ++;
		}
		
	}
}