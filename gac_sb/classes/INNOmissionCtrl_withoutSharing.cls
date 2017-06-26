public without sharing class INNOmissionCtrl_withoutSharing {
	
	//Le controller standard de la mission
    private ApexPages.standardController stdCtrl;
    
    public Map<String, String> missionAccessByUser {get; set;}
    public Boolean missionReadWrite {get; set;}
    
    // //La liste des autres entités du client
    // public AppCIRentite__c[] entitesSoeurs {get; set;}
        
        
	public INNOmissionCtrl_withoutSharing(ApexPages.standardController stdCtrl){
    
    	this.stdCtrl = stdCtrl;
    	this.missionReadWrite = true;
    	
		//Permet notamment de vérifier automatiquement que l'utilisateur à bien les droits sur la mission
		INNOmission__c mission = (INNOmission__c) stdCtrl.getRecord();
		
		this.missionAccessByUser = new Map<String, String>();
        
       	Integer userReadAccess, userEditAccess;
       	List<UserRecordAccess> ura;
        for(INNOequipeConsulting__c eq : mission.EquipesConsulting__r){
        	system.debug(eq);
        	userReadAccess = userEditAccess = 0;
        	ura = [SELECT RecordId, HasReadAccess, HasEditAccess FROM UserRecordAccess WHERE UserId = :eq.Utilisateur__c AND RecordId = :mission.Id LIMIT 1];
        	
        	this.missionAccessByUser.put(eq.Utilisateur__c, ura.isEmpty() ? 'Aucun accès' : (ura[0].HasEditAccess ? 'Modification' : (ura[0].HasReadAccess ? 'Lecture' : 'Aucun accès')));
        	 
        }
		
		
  //      this.initEntitesSoeurs(mission.Entite__c, mission.Entite__r.Contrat__c);
	}

	 public PageReference deleteMission(){
    	INNOmission__c mission = (INNOmission__c) this.stdCtrl.getRecord();


    	if(INNOmissionUtils.userHasFullAccess() || mission.OwnerId == Userinfo.getUserId() || [SELECT RecordId, HasDeleteAccess FROM UserRecordAccess WHERE RecordId = :mission.Id AND UserId = :Userinfo.getUserId()][0].HasDeleteAccess){
	 		Database.delete(mission.Id);
	    	
	     	PageReference retPage = new PageReference ('/'+mission.Contrat__c);
	     	retPage.setRedirect(true);
	 		return retPage;
    	}
    	else{
    		 Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Seul le propriétaire de la mission ou les utilisateurs du groupe \'INNO ADVANCE FULL ACCESS\' peuvent supprimer une mission'));
    		 return null;
    	}
	 }
	
	
	// /**
 //   *   Initialise les autres entités du client
 //   */
 //   public void initEntitesSoeurs(Id entiteId, Id contratId){
 //       this.entitesSoeurs = [SELECT Id, Name, SIREN__c, Effectif__c, CA__c, Resultat_NET__c FROM AppCIRentite__c WHERE Id != :entiteId AND Contrat__c = :contratId];
 //   }
	
	
	
}