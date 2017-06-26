global with sharing class INNOtimeSheetCtrl {

    private ApexPages.standardController stdCtrl;
    
    private String selectedMission = ApexPages.currentPage().getParameters().get('missionId');
    
    public INNOmission__c[] missions {get; set;}
    
    public transient Map<String, INNOtimeSheet__c> timeSheets {get;set;}
    public transient Map<String, Decimal> otherMissionsTimes {get; set;}
    
    public Date[] dates {get; set;}
    
    public Integer numeroSemaine {get; set;}
     
    public static final String[] PHASES_MISSION = new List<String>{'Audit', 'Valorisation', 'Justification', 'Controle'};
    public static final String[] PHASES_MISSION_NOT_CIR = new List<String>{'Audit'};
    public static final String[] PHASES_GENERAL = new List<String>{'AvantVenteAO', 'Formation', 'Administration', 'Disponibilite', 'CP', 'DUP'}; 
    
    public static final Map<String, String> PHASES_LABELS = new Map<String, String>{'Audit' 			=> 'Audit',
																					'Valorisation' 		=> 'Valorisation', 
																					'Justification'		=> 'Justification', 
																					'Controle'	 		=> 'Contrôle', 
																					'AvantVenteAO' 		=> 'Avant-Vente / AO', 
																					'Formation' 		=> 'Formation', 
																					'Administration'	=> 'Administration', 
																					'Disponibilite' 	=> 'Disponibilité', 
																					'ASDI' 				=> 'AS/DI', 
																					'CP' 				=> 'CP / RTT', 
																					'DUP' 				=> 'DUP'};
    
    public Boolean userHasFullAccess {get; set;}
    
    public Date startOfTodaysWeek {get; set;}
    
    public transient Map<String, Decimal> otherWeeksRealTimes {get; set;}
    public transient Map<String, Decimal> otherWeeksScheduledTimes {get; set;}
    
    public INNOtimeSheetCtrl(){
        
        this.stdCtrl = stdCtrl;
        
        this.userHasFullAccess = true;
        
        this.startOfTodaysWeek = System.today().toStartOfWeek();
        
        Boolean lastWeek = ApexPages.currentPage().getParameters().get('lastWeek') == '1';
        
        this.initWeek(system.today().toStartOfWeek().addDays(lastWeek ? -7 : 0));
        
        this.initTimeSheets();
    }
    
    /**
    *   Change la semaine de remplissage de la TimeSheet
    *   @PageReferenceParam (String way, 'lower' ou 'upper' pour monter ou descendre d'une semaine) OU (String day, une date au format yyyy-MM-dd la semaine à afficher)
    */
    public void changeWeek(){
        
        String way = ApexPages.currentPage().getParameters().get('way');
        
        //Si on a passer le parametre 'way' (lower ou upper)
        if(way != null){
            this.initWeek( this.dates[0].addDays( way == 'lower' ? -7 : 7 ) );
        }
        //Si on a passer directement un jour de l'année
        else{
            this.initWeek( date.valueOf( ApexPages.currentPage().getParameters().get('day') + ' 00:00:00' ).toStartOfWeek() );
        }
        
        
        this.initTimeSheets();
    }
    
    
        
    public List<String> getPhasesMission(){
        return PHASES_MISSION;
    }
    
    public List<String> getPhasesGeneral(){
        return PHASES_GENERAL;
    }
    
    
    
    
    
    
    
    
    
    
    private void initWeek(Date lundi){
        
        /*
        *   Initialisation des jours de la semaine
        */
        
        this.dates = new List<Date>();
        for(Integer i = 0; i < 5; i++)
            this.dates.add(lundi.addDays(i));

        this.numeroSemaine = Integer.valueOf(DateTime.newInstance( lundi, Time.newInstance(12,0,0,0) ).format('w'));
        
        
    }
    
    

    
    
    private void initTimeSheets(){
        
        this.missions = new List<INNOmission__c>();
        Set<Id> missionsIds = new Set<Id>();
        Set<Id> missionsIdsMatchingFilters = new Set<Id>{null};
        this.otherWeeksRealTimes = new Map<String, Decimal>();
        this.otherWeeksScheduledTimes = new Map<String, Decimal>();

        for(INNOmission__c mission : [SELECT Id, Name, RecordType.DeveloperName, Annee_CIR__c, Contrat__r.AccountId, Date_debut_Audit__c, Date_debut_valorisation__c, Date_debut_justification__c, Date_fin_audit__c, Date_fin_valorisation__c, Date_fin_justification_recap__c, (SELECT Id, Actif__c, Nombre_jours_theoriques_Audit__c, Nombre_jours_theoriques_Valorisation__c, Nombre_jours_theoriques_Justification__c, Nombre_jours_theoriques_Controle__c FROM EquipesConsulting__r WHERE Utilisateur__c = :UserInfo.getUserId()) FROM INNOmission__c WHERE Statut__c = 'Active' ORDER BY Annee_CIR__c, Name]){
            if(!mission.EquipesConsulting__r.isEmpty() && mission.EquipesConsulting__r[0].Actif__c){
	            missionsIds.add(mission.Id);
	            
	            if(this.selectedMission == mission.Id || this.selectedMission == null){
	                
	                this.missions.add(mission); 
	                missionsIdsMatchingFilters.add(mission.Id);
	                
	                for(String phase : PHASES_MISSION){
	                    this.otherWeeksRealTimes.put(mission.Id + '_' + phase, 0);
	                    this.otherWeeksScheduledTimes.put(mission.Id + '_' + phase, 0);
	                }
	            } 
            }
                    
        }
        
        //Initialisation de this.otherMissionsTimes avec les jours de la semaine
        this.otherMissionsTimes = new Map<String, Decimal>();
        for(Date d : this.dates)
            this.otherMissionsTimes.put(String.valueOf(d), 0);
            
            
        //L'id le l'utilisateur
        Id userId = UserInfo.getUserId();
        
        this.timeSheets = new Map<String, INNOtimeSheet__c>();
        
        for(INNOtimeSheet__c TSs : [SELECT Id, Mission_CIR__c, Date__c, Phase__c, Phase_technique__c, Duree__c, Theorique__c FROM INNOtimeSheet__c WHERE Utilisateur__c = :userId AND Date__c >= :this.dates[0] AND Date__c <= :this.dates[4]]){
            
            //Si la TS rentre dans les critères des filtres
            if(missionsIdsMatchingFilters.contains(TSs.Mission_CIR__c))
                this.timeSheets.put( (TSs.Mission_CIR__c == null ? 'general' : TSs.Mission_CIR__c) + '_' + String.valueOf(TSs.Date__c) + '_' + TSs.Phase_technique__c, TSs);
            else
                this.otherMissionsTimes.put(String.valueOf(TSs.Date__c), this.otherMissionsTimes.get(String.valueOf(TSs.Date__c)) + TSs.Duree__c);
        }
        
    
        for(AggregateResult aggr : [SELECT SUM(Duree__c) duree, Mission_CIR__c, Phase__c, Passee__c FROM INNOtimeSheet__c WHERE Mission_CIR__c IN :missionsIdsMatchingFilters AND Utilisateur__c = :UserInfo.getUserId() AND Date__c NOT IN :this.dates GROUP BY Mission_CIR__c, Phase__c, Passee__c]){
        	
        	if((Boolean) aggr.get('Passee__c'))
            	this.otherWeeksRealTimes.put(aggr.get('Mission_CIR__c') + '_' + String.valueOf(aggr.get('Phase__c')).replace('Contrôle', 'Controle'), (Decimal) aggr.get('duree'));
            else
            	this.otherWeeksScheduledTimes.put(aggr.get('Mission_CIR__c') + '_' + String.valueOf(aggr.get('Phase__c')).replace('Contrôle', 'Controle'), (Decimal) aggr.get('duree'));
        }
        
       
      
        
    }
    
    
    public PageReference validateWeek(){
    	
    	Date firstDayOfWeekToValidate = Date.parse(ApexPages.CurrentPage().getParameters().get('firstDayOfWeekToValidate'));

	
        List<INNOtimeSheet__c> tsList = [SELECT Id, Theorique__c FROM INNOtimeSheet__c WHERE Utilisateur__c = :Userinfo.getUserId() AND Theorique__c = true AND Date__c >= :firstDayOfWeekToValidate AND Date__c <= :firstDayOfWeekToValidate.addDays(4) AND (Mission_CIR__c IN :this.missions OR Mission_CIR__c = null)];
        
        for(INNOtimeSheet__c ts : tsList){
            ts.Theorique__c = false;
        }
        
        update tsList;
        
        PageReference retPage = Page.INNOtimeSheetEdit;
        retPage.setRedirect(true);
        
        if(String.isNotBlank(this.selectedMission))
            retPage.getParameters().put('missionId', this.selectedMission);
            
        return retPage;
    }
    
    
    @RemoteAction
	public static Boolean saveTimeSheet(String missionId, String tsDate, String phase, String dureeStr){
		
        return INNOtimeSheet.saveTimeSheet(missionId, tsDate, phase, dureeStr, null);
	}
}