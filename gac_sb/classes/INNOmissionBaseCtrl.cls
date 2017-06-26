public virtual with sharing class INNOmissionBaseCtrl {

	public Id valoId {get; set;}
	
	public INNOvalo__c valo {get; set;}
	
	public INNOmission__c mission {get; set;}
	
	public SelectOption[] departements {get; set;}
	public SelectOption[] projets {get; set;}
	
	//Pour savoir si l'utilisateur a les droits de lecture ET d'écriture sur la mission
	public Boolean missionReadWrite {get; set;}
	

	//True si l'utilisateur est superviseur/manager sur la mission
    public Boolean userIsManager {get; set;}
    
    //True si l'utilisateur est dans le groupe public INNO_ADVANCE_FULL_ACCESS
    public Boolean userHasFullAccess {get; set;}

     
    //Pour ajouter une sécurité aux méthodes deleteAllRecords et deleteRecord
	private Set<String> allowedObjectDeletion = new Set<String>{'INNOprojet__c', 'INNOdepensePersonnel__c', 'INNOdepensePrestation__c', 'INNOamortissement__c', 'INNOsubvention__c'};
	
	public INNOmissionBaseCtrl(ApexPages.standardController stdCtrl){
		this.initRights();
	}
	
	public INNOmissionBaseCtrl(){
        this.initRights();
	}
	
	private void initRights(){
		
		if(this.valoId == null)
			this.valoId = ApexPages.currentPage().getParameters().get('valoId');
		
			
		if(this.valoId != null){
			this.retrieveValo();
			this.mission = this.valo.MissionCIR__r;
		}
		else{
			Id missionId = ApexPages.currentPage().getParameters().get('missionId');
			if(missionId == null)
				return;
				
			this.mission = [SELECT Id, Name, Statut__c FROM INNOmission__c WHERE Id = :missionId][0];
		
		}
		
		this.missionReadWrite = false;
		this.userIsManager = false;
		
		this.userHasFullAccess = INNOmissionUtils.userHasFullAccess();

		//Vérification des droits de lecteure/ecriture sur la mission
		if(this.mission.Id != null){

			this.missionReadWrite = [SELECT RecordId FROM UserRecordAccess WHERE UserId = :UserInfo.getUserId() AND RecordId = :this.mission.Id AND HasEditAccess = true LIMIT 1].size() > 0;
			
			//On verifie aussi que la mission n'est pas validé
			if(this.missionReadWrite){
				
				if(ApexPages.currentPage().getUrl().startsWith('/apex/INNOequipeConsultingEdit'))
					this.missionReadWrite = (this.mission.Statut__c != 'Terminée' || this.userHasFullAccess);
					
				else if(ApexPages.currentPage().getUrl().startsWith('/apex/INNOmission'))
					this.missionReadWrite = true;
				
				else if(ApexPages.currentPage().getUrl().startsWith('/apex/INNOvalorisation'))
					this.missionReadWrite = (this.mission.Statut__c == 'Active');
					
				else
					this.missionReadWrite = (this.mission.Statut__c == 'Active');
			
				
				this.userIsManager = this.userHasFullAccess || [SELECT Id 
																FROM INNOequipeConsulting__c 
																WHERE Utilisateur__c = :Userinfo.getUserId() 
	                                                            	AND MissionCIR__c = :this.mission.Id
	                                                            	AND (Role__c = 'Superviseur' OR Role__c = 'Superviseur/Consultant' OR Role__c = 'Manager')].size() > 0;
			}
			
		}
	}
	
	protected void initProjets(){
		this.projets = new List<SelectOption>{new SelectOption('', '- Aucun -')};
		for(INNOprojet__c projet : [SELECT Id, Name FROM INNOprojet__c WHERE Valorisation__c = :this.valoId AND Type__c = 'projet' ORDER BY Name]){
			this.projets.add( new SelectOption(projet.Id, projet.Name) );
		}
	}
	
	protected void initDepartements(){
		this.departements = new List<SelectOption>{new SelectOption('', '- Aucun -')};
		for(INNOdepartement__c dept : [SELECT Id, Name FROM INNOdepartement__c WHERE Entite__c IN (SELECT Entite__c FROM INNOvalo__c WHERE Id = :this.valoId) ORDER BY Name]){
			this.departements.add( new SelectOption(dept.Id, dept.Name) );
		}
	}
	
	
	public PageReference deleteAllRecords(){
		String objectName = ApexPages.currentPage().getParameters().get('objectName');
		String recordType = ApexPages.currentPage().getParameters().get('recordType');
		String valoId = ApexPages.currentPage().getParameters().get('valoId');

		if(objectName != null && valoId != null && (recordType != null || objectName == 'INNOprojet__c') && this.allowedObjectDeletion.contains(objectName)){
			String req = 'SELECT Id FROM ' + String.escapeSingleQuotes(objectName) + ' WHERE Valorisation__c = \'' + String.escapeSingleQuotes(valoId) + '\'';
			if(recordType != null)
				req += ' AND RecordType.DeveloperName = \'' + String.escapeSingleQuotes(recordType) + '\'';
			if(objectName == 'INNOprojet__c')
				req += ' AND Type__c = \'projet\'';
				
			Database.delete(Database.query(req));
		} 
		
		PageReference pageRef = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));
		
		return pageRef;
	}
	
	
	
	public PageReference deleteRecord(){
		String recordId = ApexPages.currentPage().getParameters().get('recordId');
		
		
		
		if(recordId != null){
			if( this.allowedObjectDeletion.contains(((Id) recordId).getSObjectType().getDescribe().getName()))
				Database.delete(recordId);
		}
		
		PageReference pageRef = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));
		
		return pageRef;
	}
	
	
	
	
	
	public static void populateOptionsFiscales(sObject record, Set<String> fieldsToCheck){
		
		Decimal opt1, opt2, opt3;
		
		for(String fieldName : fieldsToCheck){
			opt1 = (Decimal) record.get(fieldName + '_option1__c');
			opt2 = (Decimal) record.get(fieldName + '_option2__c');
			opt3 = (Decimal) record.get(fieldName + '_option3__c');
			
			if(opt1 == null && opt2 == null && opt3 == null)
				opt1 = opt2 = opt3 = 0;
			else{
				opt1 = opt1 != null ? opt1 : 0;
				opt2 = opt2 != null ? opt2 : (opt1 != null ? opt1 : 0);
				opt3 = opt3 != null ? opt3 : (opt2 != null ? opt2 : 0);
			}
			
			record.put(fieldName + '_option1__c', opt1);
			record.put(fieldName + '_option2__c', opt2);
			record.put(fieldName + '_option3__c', opt3);
		}
	}
	
	
	
	
	private void retrieveValo(){
		this.valo = [SELECT Id,
							RecordType.DeveloperName,
							MissionCIR__c, 
							MissionCIR__r.Id, 
							MissionCIR__r.Name, 
							MissionCIR__r.Statut__c, 
							Total_amortissementBrevet_optionFinale__c, 
							Total_amortissementBrevet_option1__c, 
							Total_amortissementBrevet_option2__c, 
							Total_amortissementBrevet_option3__c, 
							Total_amortissement_option1__c, 
							Total_amortissement_option2__c, 
							Total_amortissement_option3__c, 
							Total_amortissement_optionFinale__c, 
							Total_brevetAssu_optionFinale__c, 
							Total_brevetAssu_option1__c, 
							Total_brevetAssu_option2__c, 
							Total_brevetAssu_option3__c, 
							Total_avanceRemboursable_optionFinale__c, 
							Total_avanceRemboursable_option1__c, 
							Total_avanceRemboursable_option2__c, 
							Total_avanceRemboursable_option3__c, 
							Total_brevetDef_option1__c, 
							Total_brevetDef_option2__c, 
							Total_brevetDef_option3__c, 
							Total_brevetDef_optionFinale__c, 
							Total_frais_fonctionnement_optionFinale__c, 
							Total_frais_fonctionnement_option1__c, 
							Total_frais_fonctionnement_option2__c, 
							Total_frais_fonctionnement_option3__c, 
							Total_heures_RD_option1__c, 
							Total_heures_RD_option2__c, 
							Total_heures_RD_option3__c, 
							Total_jours_RD_option1__c,
							Total_jours_RD_option2__c,
							Total_jours_RD_option3__c,
							Total_jeuneDocteur_option1__c, 
							Total_jeuneDocteur_option2__c, 
							Total_jeuneDocteur_option3__c, 
							Total_jeuneDocteur_optionFinale__c, 
							Total_miseDisposition_option1__c, 
							Total_miseDisposition_option2__c, 
							Total_miseDisposition_option3__c, 
							Total_miseDisposition_optionFinale__c, 
							Total_normalisation_option1__c, 
							Total_normalisation_option2__c, 
							Total_normalisation_option3__c, 
							Total_normalisation_optionFinale__c, 
							Total_brevetPM_facture_option1__c, 
							Total_brevetPM_facture_option2__c, 
							Total_brevetPM_facture_option3__c, 
							Total_brevetPM_option1__c, 
							Total_brevetPM_option2__c, 
							Total_brevetPM_option3__c, 
							Total_brevetPM_optionFinale__c, 
							Total_brevetPM_personnel_option1__c, 
							Total_brevetPM_personnel_option2__c, 
							Total_brevetPM_personnel_option3__c, 
							Total_prestataire_agree_optionFinale__c, 
							Total_prestataire_public_optionFinale__c, 
							Total_prestataire_agree_option1__c, 
							Total_prestataire_agree_option2__c, 
							Total_prestataire_agree_option3__c, 
							Total_prestataire_option1__c, 
							Total_prestataire_option2__c, 
							Total_prestataire_option3__c, 
							Total_prestataire_optionFinale__c, 
							Total_prestataire_public_option1__c, 
							Total_prestataire_public_option2__c, 
							Total_prestataire_public_option3__c, 
							Total_remboursementAvance_optionFinale__c, 
							Total_remboursementAvance_option1__c, 
							Total_remboursementAvance_option2__c, 
							Total_remboursementAvance_option3__c, 
							Total_salarie_option1__c, 
							Total_salarie_option2__c, 
							Total_salarie_option3__c, 
							Total_salarie_optionFinale__c, 
							Total_subvention_option1__c, 
							Total_subvention_option2__c, 
							Total_subvention_option3__c, 
							Total_subvention_optionFinale__c, 
							Total_veille_facture_option1__c, 
							Total_veille_facture_option2__c, 
							Total_veille_facture_option3__c, 
							Total_veille_option1__c, 
							Total_veille_option2__c, 
							Total_veille_option3__c, 
							Total_veille_optionFinale__c, 
							Total_veille_personnel_option1__c, 
							Total_veille_personnel_option2__c, 
							Total_veille_personnel_option3__c 
					FROM INNOvalo__c 
					WHERE Id = :this.valoId][0];

	}
	
	
}