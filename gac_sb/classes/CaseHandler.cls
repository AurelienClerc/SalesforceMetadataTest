/**
 * Class CaseHandler
 *
 * Trigger Handler for the Event SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */
public with sharing class CaseHandler implements ITrigger{
		
	
	// Constructor
	public CaseHandler(){
	}

	
	public void bulkBefore(){
	}
	
	public void bulkAfter(){
	}
		
	/**
	* A chaque insertion d'une requete de type interne, on assigne l'utilisateur a la requete en fonction de son mail.
	* On se sert uniquement de l'alias mail étant donné qu'il y a deux domaines : grande-armee-conseil et global-approach-consulting
	*/
	public void beforeInsert(SObject so){
		Case c = (Case) so;
		if(c.SuppliedEmail != null){
			String MailAlias = c.SuppliedEmail.replaceAll('@.+','@%');
			
			
			List<User> u = [Select Id,Name from User Where Email LIKE :MailAlias AND isActive = true];
			if(u.size() > 0){
				c.Interlocuteur__c = u.get(0).Id;
				if( c.suppliedEmail.contains('@grande-armee-conseil.com')){ 
						c.entite__c = 'Grande armée conseil';
				} else
					c.entite__c = 'Global approach consulting';
			}
			
		}
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
	}
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
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
		
	}

}