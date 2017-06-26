public with sharing class INNOprojetListCtrl extends INNOmissionBaseCtrl{

	
	public List<INNOprojet__c> projets {get; set;}
	
	
	public INNOprojetListCtrl(ApexPages.StandardController stdCtrl){
		
		
		this.projets = [SELECT Id, 
								Name, 
								Departement__c, 
								Departement__r.Name, 
								Num_projet__c, 
								Nom_regroupement_projet__c 
							FROM INNOprojet__c 
							WHERE Valorisation__c = :this.valo.Id 
								AND Type__c = 'projet'];
		
	}
	
	
	
	
}