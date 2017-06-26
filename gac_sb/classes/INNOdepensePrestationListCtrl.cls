/**
*  Controller du composent Visualforce INNOdepensePrestationList
*/
public with sharing class INNOdepensePrestationListCtrl extends INNOmissionBaseCtrl{
	
	
	public String tab {get; set;}
	
	
	public transient List<INNOdepensePrestation__c> prestations {get; set;}
	
	
	public INNOdepensePrestationListCtrl(){
	
		this.tab = ApexPages.currentPage().getParameters().get('tab');
		
		if(this.tab == null)
			this.tab = 'brevetPM';
		  
		this.prestations = [SELECT Id, 
									Name, 
									Num_piece__c, 
									Prestataire__c, 
									Type_organisme__c, 
									Montant_retenu_option1__c, 
									Montant_retenu_option2__c, 
									Montant_retenu_option3__c 
								FROM INNOdepensePrestation__c 
								WHERE RecordType.DeveloperName = :this.tab 
									AND Valorisation__c = :this.valo.Id];
	
	}
	
	
	
	
    
}