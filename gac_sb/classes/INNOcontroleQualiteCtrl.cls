public with sharing class INNOcontroleQualiteCtrl extends INNOmissionBaseCtrl{
    
    private ApexPages.standardController stdCtrl;
    
    public INNOmission__c mission {get; set;}
    public INNOcontroleQualite__c cq {get; set;}
    
    public PageReference checkParams(){
    
        if(this.stdCtrl.getId() == null){
            
            List<INNOcontroleQualite__c> ids = [SELECT Id FROM INNOcontroleQualite__c WHERE Mission_CIR__c = :this.mission.Id LIMIT 1];
 
        	PageReference retPage = Page.INNOcontroleQualite;
            if(!ids.isEmpty()){
            	retPage.getParameters().put('id', ids[0].Id);    
	            	        
		        retPage.getParameters().put('missionId', ApexPages.currentPage().getParameters().get('missionId'));
		        retPage.setRedirect(true);
	        	return retPage;
            }
        }        
        return null;
    }
    
    public INNOcontroleQualiteCtrl(ApexPages.standardController stdCtrl){

    	this.stdCtrl = stdCtrl;
        this.cq = (INNOcontroleQualite__c) this.stdCtrl.getRecord();

        this.mission = [SELECT Id, INNOcontroleQualite__c, Name FROM INNOmission__c WHERE Id = :ApexPages.currentPage().getParameters().get('missionId')];
	
		if(this.stdCtrl.getId() == null){
            this.cq.Mission_CIR__c = this.mission.Id;
		}       
    }   
    
    public PageReference saveCQ(){
               
		this.stdCtrl.save();

		this.mission.INNOcontroleQualite__c = this.stdCtrl.getId();	
 		update this.mission;
 		
 		PageReference retPage = new PageReference('/apex/INNOcontroleQualite');
 		retPage.getParameters().put('id',ApexPages.currentPage().getParameters().get('id'));
 		retPage.getParameters().put('missionId', ApexPages.currentPage().getParameters().get('missionId'));
 		retPage.setRedirect(true);
 		
 		return retPage;
		
	}
    
}