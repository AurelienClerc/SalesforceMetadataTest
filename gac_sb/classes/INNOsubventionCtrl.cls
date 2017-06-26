public with sharing class INNOsubventionCtrl extends INNOmissionBaseCtrl{

	private ApexPages.standardController stdCtrl;
	
	public String tab {get; set;}
	
	//Pour la page d'edit
	public SelectOption[] salaries {get; set;}	//pour les subventions uniquement
	
	
	public INNOsubventionCtrl(ApexPages.standardController stdCtrl){
		
		this.stdCtrl = stdCtrl;
		
		this.tab = ApexPages.currentPage().getParameters().get('tab');

		if(this.tab == null)
			this.tab = 'subvention';
		
		
		INNOsubvention__c subvention = (INNOsubvention__c) this.stdCtrl.getRecord();
		
		//mode edition
		if(ApexPages.currentPage().getUrl().startsWith('/apex/INNOsubventionEdit')){
				
			///Si c'est une NOUVELLE depense de prestation
			if(subvention.Id == null){
				subvention.Valorisation__c = this.valoId;
				subvention.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'INNOsubvention__c' AND DeveloperName = :this.tab LIMIT 1][0].Id;
			}
			
			this.initDepartements();
			this.initProjets();
			
			
			if(this.tab == 'subvention'){
				this.salaries = new List<SelectOption>{new SelectOption('', '- Aucun -')};
				for(INNOdepensePersonnel__c salarie : [SELECT Id, Name FROM INNOdepensePersonnel__c WHERE Valorisation__c = :this.valoId ORDER BY Name]){
					this.salaries.add( new SelectOption(salarie.Id, salarie.Name) );
				}
			}
		}
		
	}
	
	
	
	public PageReference save(){
	
		this.stdCtrl.save();
		
		PageReference retPage;
		
		retPage = new PageReference('/apex/INNOsubventionView');
				
		retPage.getParameters().put('id', this.stdCtrl.getId());
		retPage.getParameters().put('valoId', this.valoId);
		retPage.getParameters().put('tab', this.tab);
			
		retPage.setRedirect(true);
		
		return retPage;
	}
	
	
	/**
	*	Supprime une subvention et redirige vers la page de liste 
	*/
	public PageReference deleteAndRedirect(){
		Database.delete(this.stdCtrl.getId());

		PageReference retPage = new PageReference( '/apex/INNOsubventionList' );
		
		retPage.getParameters().put('valoId', this.valoId);
		retPage.getParameters().put('tab', this.tab);
		retPage.setRedirect(true);
		return retPage; 
	}
	
}