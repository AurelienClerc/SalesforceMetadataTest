public with sharing class INNOsubventionListCtrl extends INNOmissionBaseCtrl {


	public String tab {get; set;}
	
	
	public List<INNOsubvention__c> subventions {get; set;}
	

	public INNOsubventionListCtrl(ApexPages.standardController stdCtrl){
		
		this.tab = ApexPages.currentPage().getParameters().get('tab');
		
		if(this.tab == null)
			this.tab = 'subvention';
		
		this.subventions = [SELECT Id, 
									Name, 
									Organisme__c, 
									Matricule__c, 
									Date_versement__c, 
									Salarie__c, 
									Departement__c, 
									Departement__r.Name, 
									Projet__c, 
									Montant_option1__c, 
									Montant_option2__c, 
									Montant_option3__c 
								FROM INNOsubvention__c 
								WHERE RecordType.DeveloperName = :this.tab 
									AND Valorisation__c = :this.valo.Id];
		
	}
	
	
}