public with sharing class INNOmissionCtrl extends INNOmissionBaseCtrl{

    
    //Le controller standard de la mission
    private ApexPages.standardController stdCtrl;
    
    
      
    public PageReference checkParams(){
  
        if( this.stdCtrl.getId() != null && ApexPages.currentPage().getParameters().get('missionId') == null){
        	PageReference retPage = new PageReference('/apex/INNOmissionView');
	        retPage.getParameters().put('id', this.stdCtrl.getId());
	        retPage.getParameters().put('missionId', this.stdCtrl.getId());
	        retPage.setRedirect(true);
        	return retPage;
        }
        
        return null;
    }
    

    /**
    *   Constructeur
    */
    public INNOmissionCtrl(ApexPages.standardController stdCtrl){
        
        this.mission = (INNOmission__c) stdCtrl.getRecord();

        
        this.stdCtrl = stdCtrl;

    	if(ApexPages.currentPage().getParameters().get('sharingRecalc') == '1')
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Le partage de la mission aux équipes consulting peut prendre quelques minutes...'));
    }
    
    
    	
    public INNOcontrat getContrat(){
		return new INNOcontrat(this.mission.Contrat__c);
	}
    
    
    public List<INNOmission__c> getMissionsSoeurs(){
    	return [SELECT Id, Name, Taux_CIR__c, Phase__c FROM INNOmission__c WHERE Contrat__c = :this.mission.Contrat__c AND Id != :this.stdCtrl.getId()];
    }
    
    
    
    
    
    
}