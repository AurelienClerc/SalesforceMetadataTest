public with sharing class INNOamortissementCtrl extends INNOmissionBaseCtrl{

	private ApexPages.standardController stdCtrl;
	
	
	public String tab {get; set;}
	
	public INNOamortissementUtils tauxRDcls {get; set;}
	public String selectedDepartement {get; set;}
	
	
	public INNOamortissementCtrl(ApexPages.standardController stdCtrl){
		this.stdCtrl = stdCtrl;
		
		this.tab = ApexPages.currentPage().getParameters().get('tab');

		if(this.tab == null)
			this.tab = 'amortissement';
		
		
		INNOamortissement__c dotation = (INNOamortissement__c) this.stdCtrl.getRecord();
		
		Id entiteId;
		
		if( ApexPages.currentPage().getUrl().startsWith('/apex/INNOamortissementEdit') ){
				
			//Si c'est une NOUVELLE depense de personnel
			if( dotation.Id == null){
				dotation.Valorisation__c = this.valoId;
				dotation.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'INNOamortissement__c' AND DeveloperName = :this.tab LIMIT 1][0].Id;
				dotation.Methode_de_calcul__c = 'Manuelle';
				
				if(this.tab == 'amortissementBrevet')
					dotation.Taux_RD_option1__c = dotation.Taux_RD_option2__c = dotation.Taux_RD_option3__c = 100;  
			}
			
			this.initDepartements();
			this.initProjets();

			this.tauxRDcls = new INNOamortissementUtils(this.valoId);
			this.selectedDepartement = dotation.Departement__c;
			
		}

	}
	
	
	
	public PageReference save(){
	
	
		this.stdCtrl.save();
		
		PageReference retPage;
		
		retPage = new PageReference('/apex/INNOamortissementView');
		retPage.getParameters().put('id', this.stdCtrl.getId());
		retPage.getParameters().put('valoId', this.valoId);
		retPage.getParameters().put('tab', this.tab);
			
		retPage.setRedirect(true);
		
		return retPage;
	}
	
	
	/**
	*	Supprime une dotation aux amortissements et redirige vers la page de liste dotations
	*/
	public PageReference deleteAndRedirect(){
		Database.delete(this.stdCtrl.getId());

		PageReference retPage = new pageReference( '/apex/INNOamortissementList' );
		retPage.getParameters().put('valoId', this.valoId);
		retPage.getParameters().put('tab', this.tab);
		retPage.setRedirect(true);
		return retPage; 
	}
	
	
	
}