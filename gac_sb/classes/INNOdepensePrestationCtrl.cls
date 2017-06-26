public with sharing class INNOdepensePrestationCtrl extends INNOmissionBaseCtrl{

	private ApexPages.standardController stdCtrl;

	public String tab {get; set;}
	
	public String listPageURL {get; set;}
	
	
	public INNOdepensePrestationCtrl(ApexPages.standardController stdCtrl){
		
		this.stdCtrl = stdCtrl;
		
		
		this.tab = ApexPages.currentPage().getParameters().get('tab');
		if(this.tab == null)
			this.tab = 'brevetPM';
		
		
		INNOdepensePrestation__c depensePrestation = (INNOdepensePrestation__c) this.stdCtrl.getRecord();
		
		//Mode édition
		if( ApexPages.currentPage().getUrl().startsWith('/apex/INNOdepensePrestationEdit') ){
				
			///Si c'est une NOUVELLE depense de prestation
			if(depensePrestation.Id == null){
				depensePrestation.Valorisation__c = this.valoId;		
				depensePrestation.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'INNOdepensePrestation__c' AND DeveloperName = :this.tab LIMIT 1][0].Id;
			}
			
			this.initProjets();
			this.initDepartements();
		}
		
		
		if(this.tab == 'brevetPM' || this.tab == 'veille')
			this.listPageURL = '/apex/INNOdepensePrestationPersonnelList';
		else
			this.listPageURL = '/apex/INNOdepensePrestationList';
		
	}
	
	
	
	public PageReference save(){
	
		this.stdCtrl.save();
		
		PageReference retPage;
		
		retPage = new PageReference('/apex/INNOdepensePrestationView');
				
		retPage.getParameters().put('id', this.stdCtrl.getId());
		retPage.getParameters().put('valoId', this.valoId);
		retPage.getParameters().put('tab', this.tab);
			
		retPage.setRedirect(true);
		
		return retPage;
	}
	
	
	/**
	*	Supprime une depense de prestation et redirige vers la page de liste 
	*/
	public PageReference deleteAndRedirect(){
		Database.delete(this.stdCtrl.getId());

		PageReference retPage = new PageReference( this.listPageURL );
		
		retPage.getParameters().put('id', this.valoId);
		retPage.getParameters().put('valoId', this.valoId);
		retPage.getParameters().put('tab', this.tab);
		retPage.setRedirect(true);
		return retPage; 
	}
	
}