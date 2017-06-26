public class INNOmissionCreateCtrl {
    
    public Id inputId  {get; set;}
    public INNOmission__c mission {get; set;}
    public Contract contrat {get; set;}
    private Set<String> contractYears;
    public List<INNOequipeConsulting__c> consultants {get;set;}
    
    public List<SelectOption> allEntites {get; set;}
	public List<String> selectedEntites {get; set;} 
	public List<SelectOption> allTypesMission {get; set;}
	public String selectedTypeMission {get; set;} 
	public String selectedTypeValos {get; set;} 
		
	public Boolean fromMission {get; set;} 
    public Boolean isCir {get; set;} 
    public Boolean createMissionsFactu {get; set;}
    
    public INNOmissionCreateCtrl(){
        
        this.mission = new INNOmission__c();
        this.contrat = new Contract();
        this.fromMission = false;
        this.createMissionsFactu = true;
        this.selectedTypeValos = 'CIR';
        
        this.inputId = ApexPages.currentPage().getParameters().get('id');
        
        if(this.inputId.getSObjectType() == INNOmission__c.sObjectType){
            this.fromMission = true;
            List<INNOmission__c> missions = [SELECT Id, 
                                                    Annee_CIR__c, 
                                                    Contrat__c,
                                                    Date_debut_Audit__c,
                                                    Date_fin_audit__c,
                                                    Date_debut_valorisation__c,
                                                    Date_fin_valorisation__c,
                                                    Date_debut_justification__c,
                                                    Date_fin_justification_recap__c,
                                                    Date_Initiale_echeance_DT__c,
                                                    Temps_theorique_mission__c
                                                    FROM INNOmission__c WHERE Id = :this.inputId];
            if(missions.size() == 1)
    			this.mission = missions[0];
    	}
    	
        Id contratId = this.inputId.getSObjectType() == Contract.sObjectType ? this.inputId : this.mission.Contrat__c;
        this.contrat = [SELECT  Id,
                                AccountId, 
                                Account.Name,
                                Annees_concernees__c,
                                Conditions_de_renouvellement__c,
                                Conditions_de_facturation__c,
                                Conditions_de_remuneration__c,
                                Conditions_particuli_res__c,
                                Conditions_de_paiement__c,
                                Consultant_Commercial__c,
                                ContractNumber, 
                                ContractTerm,
                                Date_de_cloture_exercice__c,
                                Opportunite__r.Total_jours_retenus__c,
                                Preavis_de_resiliation__c,
                                Precision_paiement__c,
                                Precision_facturation__c,
                                Precision_remuneration__c,
                                RecordType.Name,
                                Remuneratuin_future__c,
                                Taux_de_remuneration__c,
                                Type_de_mission_multi__c
                                FROM Contract WHERE Id = :contratId][0];

		this.contrat.Type_de_mission_multi__c = null;	//Bidouille pour récupérer les types de mission dispos pour ce recordType en JS dans la page VF
		this.contractYears = String.isBlank(this.contrat.Annees_concernees__c) ? new Set<String>() : new Set<String>(this.contrat.Annees_concernees__c.split(';'));
			
        this.isCir = this.contrat.RecordType.Name == 'CIR' ? true : false;
        if(this.mission.Temps_theorique_mission__c == null)
            this.mission.Temps_theorique_mission__c = this.contrat.Opportunite__r.Total_jours_retenus__c;
        
        List<String> roles = new String[]{'Consultant scientifique','Consultant scientifique','Consultant scientifique','Consultant scientifique','Rédacteur scientifique','Rédacteur scientifique','Redacteur scientifique RO', 'Redacteur scientifique RO'}; 
        this.consultants = new List<INNOequipeConsulting__c>{new INNOequipeConsulting__c(Role__c = 'Manager', Utilisateur__c = System.Userinfo.getUserId())};
        for(String role : roles){
                this.consultants.add(new INNOequipeConsulting__c(Role__c = role));
        }
        
        this.allEntites = new List<SelectOption>{new SelectOption(this.contrat.AccountId, this.contrat.Account.Name)};
        this.selectedEntites = new List<String>();
        
        for(Societe_a_auditer__c f : [SELECT Societe_a_auditer__c, Societe_a_auditer__r.Name FROM Societe_a_auditer__c WHERE Contract__c = :contratId AND Societe_a_auditer__c != :this.contrat.AccountId])
            this.allEntites.add(new SelectOption(f.Societe_a_auditer__c, f.Societe_a_auditer__r.Name));
        
        //On init allTypesMission avec toutes les valeurs possible mais on restreindra cette liste dans la page en JS :/
        this.allTypesMission = new List<SelectOption>();
        for(Schema.PicklistEntry typeMission : Contract.Type_de_mission_multi__c.getDescribe().getPicklistValues()){
        	this.allTypesMission.add(new SelectOption(typeMission.getLabel(), typeMission.getLabel()));
        }
    }
    
    public PageReference saveMission(){
        
        PageReference retPage;
        
        if(this.isCir){
            Decimal totalTheorique = 0;
            for(INNOequipeConsulting__c consultant : this.consultants){
                if(consultant.Utilisateur__c != null){
                    totalTheorique += consultant.Nombre_jours_theoriques_Audit__c == null ? 0 : consultant.Nombre_jours_theoriques_Audit__c;
                    totalTheorique += consultant.Nombre_jours_theoriques_Valorisation__c == null ? 0 : consultant.Nombre_jours_theoriques_Valorisation__c;
                    totalTheorique += consultant.Nombre_jours_theoriques_Justification__c == null ? 0 : consultant.Nombre_jours_theoriques_Justification__c;
                    totalTheorique += consultant.Nombre_jours_theoriques_Controle__c == null ? 0 : consultant.Nombre_jours_theoriques_Controle__c;
                }
            } 
            if(totalTheorique > this.mission.Temps_theorique_mission__c){
        	    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Le nombre de jours théoriques est supérieur à celui estimé sur l\'opportunité'));
        	    return null;
            }
        }
        
        if(this.selectedEntites.isEmpty()){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Il faut sélectionner au moins une entite'));
        	return null;    
        }
        
        Id missionRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'INNOmission__c' AND DeveloperName = :this.contrat.RecordType.Name].Id;
        Id missionFactuRecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Mission__c' AND Name = :this.contrat.RecordType.Name].Id;
        
        //create INNOmission__c
        List<INNOmission__c> missionsToInsert = new List<INNOmission__c>();
        List<Mission__c> missionsFactuToInsert = new List<Mission__c>();
        if(!this.fromMission){
            
            List<String> yearsToCreate = this.isCir ? (this.contrat.Annees_concernees__c != null ? this.contrat.Annees_concernees__c.split(';') : new List<String>() ) : new List<String> {String.valueof(System.today().year())};
            if(yearsToCreate.isEmpty()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Il faut sélectionner au moins une année'));
        	    return null;    
            }
            yearsToCreate.sort();
            Integer yearIncrement = 0;
            for(String year : yearsToCreate){
                missionsToInsert.add(new INNOmission__c(    Contrat__c                              = this.contrat.Id,
                                                            ownerId                                 = this.consultants.get(0).utilisateur__c,
                                                            Name                                    = this.contrat.Account.Name + ' - ' + this.contrat.RecordType.Name + (this.isCir ? ' ' + year : ''),   
                                                            taux_cir__c                             = 30,   
                                                            TauxCII__c								= 20,
                                                            RecordTypeId                            = missionRecordTypeId,
                                                            TypeMission__c							= this.selectedTypeMission,
                                	                        Annee_CIR__c                            = this.isCir ? year : String.valueOf(System.today().year()),
                                	                        Phase__c                                = (this.contrat.Conditions_de_renouvellement__c == 'Par nouvel accord' && !this.contractYears.contains(year) ? 
                                	                        												'Inactif / en attente de renouvellement' : 
                                	                        												'Inactif / en attente de lancement'),
                                	                        Date_lancement_mission__c               = this.mission.Date_debut_Audit__c != null ? this.mission.Date_debut_Audit__c.addYears(yearIncrement) : null,
                                	                        Date_debut_Audit__c                     = this.mission.Date_debut_Audit__c != null ? this.mission.Date_debut_Audit__c.addYears(yearIncrement) : null,
                                							Date_fin_audit__c                       = this.mission.Date_fin_audit__c != null ? this.mission.Date_fin_audit__c.addYears(yearIncrement) : null,
                                							Date_debut_valorisation__c              = this.mission.Date_debut_valorisation__c != null ? this.mission.Date_debut_valorisation__c.addYears(yearIncrement) : null,
                                							Date_fin_valorisation__c                = this.mission.Date_fin_valorisation__c != null ? this.mission.Date_fin_valorisation__c.addYears(yearIncrement) : null,
                                							Date_debut_justification__c             = this.mission.Date_debut_justification__c != null ? this.mission.Date_debut_justification__c.addYears(yearIncrement) : null,
                                							Date_Initiale_echeance_DT__c            = this.isCir ? (this.mission.Date_Initiale_echeance_DT__c != null ? this.mission.Date_Initiale_echeance_DT__c.addYears(yearIncrement) : null ) : (this.mission.Date_fin_audit__c != null ? this.mission.Date_fin_audit__c.addYears(yearIncrement) : null),
                                							Temps_theorique_mission__c              = this.mission.Temps_theorique_mission__c,
                                							Temps_theorique_opportunite__c			= this.contrat.Opportunite__r.Total_jours_retenus__c
                                                            )); 
                yearIncrement++;
                
                //create Mission__c facturation
                if(this.createMissionsFactu){
               		missionsFactuToInsert.add( new Mission__c(  Name                            = year + ' - ' + this.contrat.Account.Name,
               		                                            ownerId                         = this.consultants.get(0).utilisateur__c,
                                                                Annee_concernee__c              = year,
                                                                Contrat__c                      = this.contrat.Id,
                                                                Compte__c                       = this.contrat.AccountId,
                                                                Type_de_mission__c              = this.selectedTypeMission,
                                                                Cond_renouvellement__c          = this.contrat.Conditions_de_renouvellement__c,
                                        						Conds_facturation__c            = this.contrat.Conditions_de_facturation__c,
                                        						Conds_paiement__c               = this.contrat.Conditions_de_paiement__c,
                                        						Conds_remuneration__c           = this.contrat.Conditions_de_remuneration__c,
                                        						Precision_facturation__c        = this.contrat.Precision_facturation__c,
                                        						Precision_paiement__c           = this.contrat.Precision_paiement__c,
                                        						Precision_remuneration__c       = this.contrat.Precision_remuneration__c,
                                        						Contrat_signe_par__c            = this.contrat.Consultant_Commercial__c,
                                        						Conditions_particuli_res__c     = this.contrat.Conditions_particuli_res__c,
                                        						Dur_e_initiale_mois__c          = this.contrat.ContractTerm,
                                        						Pr_avis_r_siliation_mois__c     = this.contrat.Preavis_de_resiliation__c,
                                        						R_mun_ration_future__c          = this.contrat.Remuneratuin_future__c,
                                        						Taux_de_r_mun_ration__c         = this.contrat.Taux_de_remuneration__c,
                                        						RecordTypeId                    = missionFactuRecordTypeId
                    ));
                }
            }
            insert missionsToInsert;
            insert missionsFactuToInsert;
        }
        else{
            missionsToInsert = new List<INNOmission__c>{this.mission};
            
            Boolean hasDupeValo = false;
            for(INNOvalo__c dupeValo : [SELECT Id, Name, Entite__r.Name FROM INNOvalo__c WHERE MissionCIR__c = :this.mission.Id AND RecordType.DeveloperName = :this.selectedTypeValos AND Entite__c IN :this.selectedEntites]){
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Une valorisation ' + this.selectedTypeValos + ' existe déjà pour l\'entité ' + dupeValo.Entite__r.Name));
        	    hasDupeValo = true;
            }
            if(hasDupeValo)
            	return null;
        }
        
        Id valosRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'INNOvalo__c' AND DeveloperName = :this.selectedTypeValos][0].Id;
        List<INNOvalo__c> valosToInsert = new List<INNOvalo__c>();
        List<INNOequipeConsulting__c> consultantsToInsert = new List<INNOequipeConsulting__c>();
        String valoName;
        for(INNOmission__c mission : missionsToInsert){
            
            for(String entiteId : this.selectedEntites){
            	valoName = '';
            	
            	for(SelectOption so : this.allEntites){
            		if(so.getValue() == entiteId){
            			valoName = 'V' + mission.Annee_CIR__c + ' - ' + so.getLabel() + ' - ' + (this.contrat.RecordType.Name == 'CIR' ? this.selectedTypeValos : this.contrat.RecordType.Name);
            			break;
            		}
            	}
            	
                //create INNOvalo__c
                valosToInsert.add(new INNOvalo__c(  Entite__c                      = (Id) entiteId,
                                                    MissionCIR__c                   = mission.Id,
                                                    RecordTypeId					= valosRecordTypeId,
                                                    Name                            = valoName,
                                        	        Date_de_cloture__c              = System.today(),
                                        	        Jour_mois_de_cloture_fiscale__c = this.contrat.Date_de_cloture_exercice__c
                                                    ));    
            }
            if(!this.fromMission){
                //create INNOequipeConsulting__c
                for(INNOequipeConsulting__c consultant : this.consultants){
                    if(consultant.Utilisateur__c != null){
                        INNOequipeConsulting__c c = new INNOequipeConsulting__c(Utilisateur__c                              = consultant.Utilisateur__c,
                                                                                Role__c                                     = consultant.Role__c,
                                                                                Nombre_jours_theoriques_Audit__c            = consultant.Nombre_jours_theoriques_Audit__c,
                                                                                Nombre_jours_theoriques_Valorisation__c     = consultant.Nombre_jours_theoriques_Valorisation__c,
                                                                                Nombre_jours_theoriques_Justification__c    = consultant.Nombre_jours_theoriques_Justification__c,
                                                                                Nombre_jours_theoriques_Controle__c         = consultant.Nombre_jours_theoriques_Controle__c,
                                                                                MissionCIR__c                               = mission.Id);
                        consultantsToInsert.add(c);
                    }
                }   
            }
        }
        insert valosToInsert;
        insert consultantsToInsert;
            
        //create INNOprojet__c
        List<INNOprojet__c> projetsToInsert = new List<INNOprojet__c>();
        for(INNOvalo__c valo : valosToInsert){
            projetsToInsert.add(new INNOprojet__c(Name = 'PM brevet',       Type__c = 'brevetPM',       Valorisation__c = valo.Id));
    		projetsToInsert.add(new INNOprojet__c(Name = 'Veille',          Type__c = 'veille',         Valorisation__c = valo.Id));
    		projetsToInsert.add(new INNOprojet__c(Name = 'Normalisation',   Type__c = 'normalisation',  Valorisation__c = valo.Id));    
        }
        insert projetsToInsert;
        
        retPage = new PageReference('/apex/INNOmissionView');
		retPage.getParameters().put('id', missionsToInsert[0].Id);
		retPage.getParameters().put('missionId', missionsToInsert[0].Id);
		retPage.getParameters().put('sharingRecalc', '1');
        
        retPage.setRedirect(true);
		return retPage;
    }
    
    public List<EquipeWrapper> getEquipesWithIndex(){
        List<INNOequipeConsulting__c> equipes = this.consultants;
        List<EquipeWrapper> equipeWrapped = new List<EquipeWrapper>();
        integer idx = 0;
        for(INNOequipeConsulting__c equipe : equipes){
            equipeWrapped.add(new EquipeWrapper(equipe,idx));
            idx ++;
        }
        return equipeWrapped;
    }
    public class EquipeWrapper {
        public INNOequipeConsulting__c equipe {get;set;}
        public Integer index {get;set;}
        public EquipeWrapper(INNOequipeConsulting__c equipe,Integer index){
            this.index = index;
            this.equipe = equipe;
		}
    }
}