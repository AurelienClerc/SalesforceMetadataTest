public with sharing class AccountHierarchyGateway {

	public Map<Id,list<Id>> newParentMap = new Map<Id,list<Id>>();

	public AccountHierarchyGateway(){
		
	}
	
	public void AddChildToCompute(Id AccountId, Id newParentId, Id newParentMaisonMere){
		newParentMap.put(AccountId,new List<Id>{newParentId,newParentMaisonMere});
	}
	
	 public List<Account> getChildren(set<id> AccountId){
		if(!AccountId.IsEmpty())
			return [Select id,parentId,reference_Tete_de_groupe__c from Account where parentId IN :AccountId];
		else 
			return new List<Account>();
	}
	
	 public list<Account> processChildrenUpdate(){
		List<Account> accToUpdate = new List<Account>();
		List<Account> CurrentSet = getChildren(newParentMap.KeySet());
		while(!CurrentSet.isEmpty()){
			set<Id> nextStep = new set<Id>();
			for(Account Acc:CurrentSet){
				if(newParentMap.get(Acc.parentId).get(1) != null)
					Acc.reference_Tete_de_groupe__c = newParentMap.get(Acc.parentId).get(1);
				else
					Acc.reference_Tete_de_groupe__c = newParentMap.get(Acc.parentId).get(0);
					
				if(!newParentMap.containsKey(Acc.Id)){
					AccToUpdate.add(Acc);
					newParentMap.put(Acc.Id,newParentMap.get(Acc.parentId));
					nextStep.add(Acc.Id);	
				}
			}
			CurrentSet = getChildren(nextStep);
		}
		system.debug(AccToUpdate);
		return AccToUpdate;
	}
	
	public void reconstruct(Integer Start){
		//Construcion de la parentmap principale;
		for(Account Ac : [Select Id from Account where parentId = null LIMIT 200 OFFSET :Start]){
			AddChildToCompute(Ac.Id,Ac.Id,(Id) null);
		}
		update processChildrenUpdate();
	}
	
	public void reconstruct(Id AccountId){
		List<Id> AccountsId = new Id[]{AccountId};
		reconstruct(AccountsId);
	}
	
	public void reconstruct(List<id> AccountsId){
		for(Account Ac : [Select Id from Account where parentId = null AND id in:AccountsId]){
			AddChildToCompute(Ac.Id,Ac.Id,(Id) null);
		}
		update processChildrenUpdate();
	}
	
}