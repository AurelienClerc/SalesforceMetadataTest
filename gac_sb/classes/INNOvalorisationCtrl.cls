public with sharing class INNOvalorisationCtrl extends INNOmissionBaseCtrl{

    //La mission INNO advance
    private INNOvalo__c valo {get; set;}
    
    //Le controller standard de la mission
    private ApexPages.standardController stdCtrl;
    
    //True si mission CIR, false sinon (AS,CIN)
    public Boolean isCir {get; set;}
    
    
  //  //Ce controller sert à la fois pour la page AppCIRmissionView et AppCIRmissionEdit, donc c'est pour savoir dans quelle cas on est
  //  private Boolean isEditMode;
    
  //  //True si l'utilisateur a le droit de créer une nouvelle entité (il faut qu'il soit superviseur/manager dans au moins 1 mission du client)
  //  public Boolean userCanCreateEntite {get; set;}
    
    
  //  //Le contrat dans un objet custom pour que les consultant avec des licences Force.com puissent y accéder
  //  public AppCIRcontrat contrat {get; set;}

  //  //La liste des interlocuteurs de l'entité
  //  public AppCIRinterlocuteur__c[] interlocuteurs {get; set;}
    
  //  //La liste des départements de l'entité
  //  public AppCIRdepartement__c[] departements {get; set;}

  //  //La liste des autres missions de l'entité
  //  public AppCIRmission__c[] missionsSoeurs {get; set;}
    
  //  //L'id de l'entité de la mission
  //  private Id entiteId;

    
    
      
    public PageReference checkParams(){
  
        if( this.stdCtrl.getId() != null && ApexPages.currentPage().getParameters().get('valoId') == null){
        	PageReference retPage = new PageReference('/apex/INNOvalorisationView');
	        retPage.getParameters().put('id', this.stdCtrl.getId());
	        retPage.getParameters().put('valoId', this.stdCtrl.getId());
	        retPage.setRedirect(true);
        	return retPage;
        }
        
        return null;
    }
    

    /**
    *   Constructeur
    */
    public INNOvalorisationCtrl(ApexPages.standardController stdCtrl){
        
        if(!Test.isRunningTest())
        	stdCtrl.addFields(new List<String> {'MissionCIR__r.OwnerId','MissionCIR__r.RecordType.DeveloperName','MissionCIR__r.Annee_CIR__c'});
        	
        this.valo = (INNOvalo__c) stdCtrl.getRecord();
        
        this.isCir = this.valo.MissionCIR__r.RecordType.DeveloperName == 'CIR';
        
        this.stdCtrl = stdCtrl;
        
    
    	if(ApexPages.currentPage().getParameters().get('sharingRecalc') == '1')
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Le partage de la mission aux équipes consulting peut prendre quelques minutes...'));
    }
    
    public PageReference deleteValo(){

        Id missionId = this.valo.MissionCIR__c;
    	if(INNOmissionUtils.userHasFullAccess() || this.valo.MissionCIR__r.OwnerId == Userinfo.getUserId() || [SELECT RecordId, HasDeleteAccess FROM UserRecordAccess WHERE RecordId = :this.valo.MissionCIR__c AND UserId = :Userinfo.getUserId()][0].HasDeleteAccess){
	 		Database.delete(this.valo.Id);
	    	
	     	PageReference retPage = new PageReference ('/'+missionId);
	     	retPage.setRedirect(true);
	 		return retPage;
    	}
    	else{
    		 Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Seul le propriétaire ou les utilisateurs du groupe \'INNO ADVANCE FULL ACCESS\' peuvent supprimer une valorisation'));
    		 return null;
    	}
	 }
	 
        
     
    
    
}