public without sharing class INNOtimeSheetPlanningCtrl2 extends INNOtauxOccupationBase{

	private static final Integer DISPLAYED_DAYS = 74;
	
	public List<SelectOption> availablePhasesFilter {get; set;}
	public String selectedPhaseFilter {get; set;}
	
	public transient String consultantsJSON {get; set;}
	public String monthsJSON {get; set;}
	
	
	public String otherTimesForMissionFilterJSON {get; set;}
	
	public static Id myUserId = UserInfo.getUserId();
	
	public static Map<Id, List<INNOequipeConsulting__c>> timeByMission = new Map<Id, List<INNOequipeConsulting__c>> ();
	
	public static Id recordTypeCir = Schema.getGlobalDescribe().get('INNOmission__c').getDescribe().getRecordTypeInfosByName().get('CIR').getRecordTypeId();
	
	
	
	
	
	public INNOtimeSheetPlanningCtrl2(){
		
		this.initMonths(System.today().toStartOfWeek().addDays(-7));
		
		this.availablePhasesFilter = new List<SelectOption>{new SelectOption('', '')};
		for(Schema.PicklistEntry phase : INNOmission__c.Phase__c.getDescribe().getPicklistValues()){
			if(!phase.getValue().startsWith('Inactif'))
				this.availablePhasesFilter.add(new SelectOption(phase.getValue(), phase.getLabel()));
		}
		timeByMission = new Map<Id,List<INNOequipeConsulting__c>>();
	}
    
	
	protected override void initUsersOccupancyRates(Set<Id> usersRestriction){
		
		system.debug(usersRestriction);
		
		Date planningStartDate = System.today().toStartOfWeek().addDays(-7);
		Date planningEndDate = planningStartDate.addDays(DISPLAYED_DAYS + 4);		//+4 pour être sûr de prendre tous les jours de la dernière semaine (car le planning affiche toute la dernière semaine même si on a dépassé DISPLAYED_DAYS)
		
		this.otherTimesForMissionFilterJSON = '{}';
		
		List<Consultant> consultants = new List<Consultant>();

		Consultant tempConsultant;
		Mission tempMission;
		String prevUserId;
		String prevMissionId;
		
		
		Boolean showAllPhases = true; //toujours afficher depuis le 20161025     this.dummyEquipeConsultant.Mission_CIR__c != null;
		
		String req = 'SELECT Id, Mission_CIR__c, Mission_CIR__r.recordType.DeveloperName, Mission_CIR__r.Name, Mission_CIR__r.Date_fin_audit__c, Mission_CIR__r.Date_fin_valorisation__c, Mission_CIR__r.Date_fin_justification_recap__c, Date__c, Utilisateur__c, Utilisateur__r.Name, Duree__c, Theorique__c, Phase__c, Phase_technique__c ' + 
					'FROM INNOtimeSheet__c ' + 
					'WHERE Utilisateur__c IN :usersRestriction ' + 
					'AND Date__c >= :planningStartDate ' + 
					'AND Date__c <= :planningEndDate ';
		
		
		if(this.dummyEquipeConsultant.MissionCIR__c != null)
			req += 'AND (Mission_CIR__c = \'' + this.dummyEquipeConsultant.MissionCIR__c + '\' OR Mission_CIR__c = null)';
			
		if(String.isNotBlank(this.selectedPhaseFilter))
			req += 'AND Mission_CIR__r.Phase__c = \'' + this.selectedPhaseFilter + '\' ';
		
		
		req += 'ORDER BY Utilisateur__r.Name, Mission_CIR__r.Name';
		
		
		List<INNOtimeSheet__c> tss = Database.query(req);
		
		//On récupère tous les Ids de mission utilisé
		Set<Id> missionsIds = new Set<Id>();
		for(INNOtimeSheet__c ts : tss){
			if(ts.Mission_CIR__c != null)
				missionsIds.add(ts.Mission_CIR__c);
		}
		
		if(this.dummyEquipeConsultant.MissionCIR__c != null)
			missionsIds.add(this.dummyEquipeConsultant.MissionCIR__c);
		
		Set<Id> editableMissionsIds = new Set<Id>();
		
		for(INNOequipeConsulting__c eq : [SELECT Id, 
		                                        MissionCIR__c,
                                        		Nombre_jours_engages_Audit__c,
                                                Nombre_jours_engages_Controle__c,
                                                Nombre_jours_engages_Justif__c,
                                                Nombre_jours_engages_Total__c,
                                                Nombre_jours_engages_Valorisation__c,
                                                Nombre_jours_theoriques_Audit__c,
                                                Nombre_jours_theoriques_Controle__c,
                                                Nombre_jours_theoriques_Justification__c,
                                                Nombre_jours_theoriques_Total__c,
                                                Nombre_jours_theoriques_Valorisation__c,
                                                Utilisateur__c
                                                FROM INNOequipeConsulting__c  
                                                WHERE MissionCIR__c IN :missionsIds]){
            if(eq.Utilisateur__c == myUserId)
			    editableMissionsIds.add(eq.MissionCIR__c);
			if(eq.MissionCIR__c != null){
			    if(!timeByMission.containsKey(eq.MissionCIR__c))
                    timeByMission.put(eq.MissionCIR__c, new List<INNOequipeConsulting__c>());
                timeByMission.get(eq.MissionCIR__c).add(eq);
			}
		}
		
		for(INNOtimeSheet__c ts : tss){
			
			//timeSheets.add(new TimeSheet(ts));
			
			if(prevUserId == null || prevUserId != ts.Utilisateur__c){
				tempConsultant = new Consultant(ts.Utilisateur__c, ts.Utilisateur__r.Name);
				consultants.add(tempConsultant);
				prevMissionId = null;
			}
			
			if(prevMissionId == null || prevMissionId != ts.Mission_CIR__c){
				if(ts.Mission_CIR__c != null){
					tempMission = tempConsultant.addMission(ts.Mission_CIR__r, editableMissionsIds.contains(ts.Mission_CIR__c), showAllPhases);
				}
				else if(tempMission == null || tempMission.mission != null)
					tempMission = tempConsultant.addMission(null, true, showAllPhases);
			}
			
			tempConsultant.addDuration(ts);
			//tempMission.addPhase(ts.Phase_technique__c);
			
			prevUserId = ts.Utilisateur__c;
			prevMissionId = ts.Mission_CIR__c;
			
		}
		
		
		//Si on a appliqué le filtre Mission, tous les user de userRestriction doivent être dans consultants (même si ils n'ont aucun temps de renseigné)
		if(this.dummyEquipeConsultant.MissionCIR__c != null){
			this.selectedPhaseFilter = ''; //On supprime le filtre Phase qui ne sert à rien si on a mis un filtre sur la mission
			
			INNOmission__c mission = [SELECT Id, Name, RecordType.DeveloperName, Date_fin_audit__c, Date_fin_valorisation__c, Date_fin_justification_recap__c FROM INNOmission__c WHERE Id = :this.dummyEquipeConsultant.MissionCIR__c][0];
			Boolean userFound;
			for(User u : [SELECT Id, Name FROM User WHERE Id IN :usersRestriction ORDER BY Name]){
				userFound = false;
				for(Consultant c : consultants){
					if(c.userId == u.Id){
						
						//Si le user a des TimeSheet sur des phases Générales mais pas de TimeSheet sur la mission => On ajoute la mission
						if(!c.hasMission)
							c.addMission(mission, editableMissionsIds.contains(mission.Id), true);
							
						//Si le user a des TimeSheet sur la mission mais pas de TimeSheet sur les phases Générales => On ajoute les phases Générales
						if(!c.hasGeneral)
							c.addMission(null, true, true);
							
						userFound = true;
						break;
					}
				}
				
				//Si le user n'a aucune TimeSheet => On ajoute la mission et les phases Générales
				if(!userFound){
					tempConsultant = new Consultant(u.Id, u.Name);
					consultants.add(tempConsultant);
					tempConsultant.addMission(mission, editableMissionsIds.contains(mission.Id), true);
					tempConsultant.addMission(null, true, true);
				}
			}
			
			
			//Met dans otherTimesForMissionFilterJSON les temps saisis pour le consultant sur d'autres missions
			Map<String, Map<String, Decimal>> otherTimesForMissionFilter = new Map<String, Map<String, Decimal>>();
			String tempUserId;
			Date tempDate;
			Map<String, Decimal> tempOtherTimesOfConsultant;
			for(AggregateResult aggr : [SELECT Date__c, SUM(Duree__c) dureeTotale, Utilisateur__c FROM INNOtimeSheet__c WHERE Mission_CIR__c != null AND Mission_CIR__c != :this.dummyEquipeConsultant.MissionCIR__c AND Utilisateur__c IN :usersRestriction AND Date__c >= :planningStartDate AND Date__c <= :planningEndDate GROUP BY Utilisateur__c, Date__c]){
				tempDate = (Date) aggr.get('Date__c');
				tempUserId = (String) aggr.get('Utilisateur__c');
				
				tempOtherTimesOfConsultant = otherTimesForMissionFilter.get(tempUserId);
				if(tempOtherTimesOfConsultant == null){
					tempOtherTimesOfConsultant = new Map<String, Decimal>();
					otherTimesForMissionFilter.put(tempUserId, tempOtherTimesOfConsultant);
				}
				
				tempOtherTimesOfConsultant.put(tempDate.year() + '-' + tempDate.month() + '-' + tempDate.day(), (Decimal) aggr.get('dureeTotale'));
			}
			this.otherTimesForMissionFilterJSON = JSON.serialize(otherTimesForMissionFilter);
		}
		
		
		//Si on a appliqué le filtre Utilisateur, on affiche les phases dont les dates sont comprises sur le planning même s'il n'y a pas de temps saisi dessus
		else if(this.dummyEquipeConsultant.Utilisateur__c != null){
			
			if(consultants.isEmpty()){
				User consult = [SELECT Id, Name FROM User WHERE Id = :this.dummyEquipeConsultant.Utilisateur__c][0];
				tempConsultant = new Consultant(consult.Id, consult.Name);
				consultants.add(tempConsultant);
			}
			
			tempMission = null;
			
			for(INNOequipeConsulting__c eq : [SELECT Id,
													MissionCIR__r.Id,
													MissionCIR__r.Name,
													MissionCIR__r.RecordType.DeveloperName,
													MissionCIR__r.Date_fin_audit__c,
													MissionCIR__r.Date_lancement_mission__c,
													MissionCIR__r.Date_fin_valorisation__c,
													MissionCIR__r.Date_debut_valorisation__c,
													MissionCIR__r.Date_fin_justification_recap__c,
													MissionCIR__r.Date_debut_justification__c,
													Utilisateur__c
											FROM INNOequipeConsulting__c 
											WHERE MissionCIR__r.Statut__c = 'Active' 
												AND Actif__c = true
												AND Utilisateur__c = :this.dummyEquipeConsultant.Utilisateur__c
												AND (
													(MissionCIR__r.Date_fin_audit__c >= :planningStartDate 
														AND MissionCIR__r.Date_lancement_mission__c <= :planningEndDate)
													OR (MissionCIR__r.Date_fin_valorisation__c >= :planningStartDate 
														AND MissionCIR__r.Date_debut_valorisation__c <= :planningEndDate)
													OR (MissionCIR__r.Date_fin_justification_recap__c >= :planningStartDate 
														AND MissionCIR__r.Date_debut_justification__c <= :planningEndDate)
													)
											ORDER BY MissionCIR__r.Name]){

				tempMission = null;
				for(Mission m : tempConsultant.missions){

				    if(m.mission != null){
    				    if(m.mission.Id == eq.MissionCIR__r.Id){
    						tempMission = m;
    						break;
    					}    
				    }
				}

				if(tempMission == null){
					tempMission = tempConsultant.addMission(eq.MissionCIR__r, true, false);
				}
				
				if(eq.MissionCIR__r.Date_fin_audit__c >= planningStartDate && eq.MissionCIR__r.Date_lancement_mission__c <= planningEndDate)
					tempMission.addPhase('Audit');
				if(eq.MissionCIR__r.Date_fin_valorisation__c >= planningStartDate && eq.MissionCIR__r.Date_debut_valorisation__c <= planningEndDate)
					tempMission.addPhase('Valorisation');
				if(eq.MissionCIR__r.Date_fin_justification_recap__c >= planningStartDate && eq.MissionCIR__r.Date_debut_justification__c <= planningEndDate)
					tempMission.addPhase('Justification');
			}
		}
		
		
		
		//Si on a pas appliqué le filtre Mission, on rajoute obligatoirement les phases générales pour le user courant même s'il n'y a pas de TS dessus
		else{
			for(Consultant c : consultants){
				if(c.userId == myUserId){
					if(!c.hasGeneral)
						c.addMission(null, true, true);
					break;
				}
			}
		}
		
		//On met la "mission 'Général'" à la fin
		for(Consultant cons : consultants){
			if(!cons.missions.isEmpty() && cons.missions[0].mission == null){
				cons.missions.add(cons.missions[0]);
				cons.missions.remove(0);
			}
		}
		
		consultantsJSON = JSON.serialize(consultants);
	}
	
	
	
	@RemoteAction
	public static Boolean saveTimeSheet(String missionId, String tsDate, String phase, String dureeStr, String userId){
		
		return INNOtimeSheet.saveTimeSheet(missionId, tsDate, phase, dureeStr, userId);
        
	}	
	
	
	private void initMonths(Date planningStartDate){
		
		List<Month> months = new List<Month>();
		Date d = planningStartDate;
		Date prevDay;
		Integer dayInWeek;
		Month m;
		Integer i = 0;
		while(i < DISPLAYED_DAYS || (i >= DISPLAYED_DAYS && dayInWeek != 4)){
			dayInWeek = Math.mod(i, 7);
			
			if(prevDay == null || prevDay.month() != d.month()){
				m = new Month(monthsNames.get(d.month() - 1), dayInWeek);
				months.add(m);
			}
			
			//On exclut samedi et dimanche
			if(dayInWeek < 5){
				m.days.add(new Day(d, dayInWeek, i > 4));
			}
			
			prevDay = d;
			d = d.addDays(1);
			i ++;
		}
		
		this.monthsJSON = JSON.serialize(months);
	}
	
	
	
	public class Month{
		
		public String name {get; set;}
		public List<Day> days {get; set;}
		public Integer firstDayIndexInWeek {get; set;}
		
		public Month(String monthName, Integer firstDayIndexInWeek){
			this.name = monthName;
			this.firstDayIndexInWeek = firstDayIndexInWeek;
			this.days = new List<Day>();
		}
		
		
	}
	
	public class Day{
		
		public Date d {get; set;}
		public String dateFormatted {get; set;}
		public Boolean isFriday {get; set;}
		public Boolean isFutureWeek {get; set;}
		
		
		public Day(Date d, Integer dayInWeek, Boolean isFutureWeek){
			this.d = d;
			this.dateFormatted = d.year() + '-' + d.month() + '-' + d.day();
			this.isFriday = (dayInWeek == 4);
			this.isFutureWeek = isFutureWeek;
		}
		
	}
	
	
	
	public class Consultant{
		public Id userId {get; set;}
		public String userName {get; set;}
		
		public List<Mission> missions {get; set;}
		public List<TimeSheet> timeSheets {get; set;}
		
		public Map<Date, Decimal> durationsByDate {get; set;}
		
		
		protected Boolean hasMission = false;
		protected Boolean hasGeneral = false;
		
		
		public Consultant(Id userId, String userName){
			this.userId = userId;
			this.userName = userName;
			this.missions = new List<Mission>();
			this.durationsByDate = new Map<Date, Decimal>();
			this.timeSheets = new List<TimeSheet>();
		}
		
		
		
		public Mission addMission(INNOmission__c mission, Boolean editable, Boolean showAllPhases){
			Mission m = new Mission(mission, this.userId == myUserId && editable, showAllPhases, this.userId);
			this.missions.add(m);
			
			if(mission == null)
				this.hasGeneral = true;
			else
				this.hasMission = true;
				
			return m;
		}
		
		public void addDuration(INNOtimeSheet__c ts){
			this.timeSheets.add(new TimeSheet(ts));
			Decimal duration = this.durationsByDate.get(ts.Date__c);
			if(duration == null)
				this.durationsByDate.put(ts.Date__c, ts.Duree__c);
			else
				this.durationsByDate.put(ts.Date__c, duration + ts.Duree__c);
		}
		
		
	}
	
	public class Mission{
		public List<UsedPhase> usedPhases {get; set;}
		public INNOmission__c mission {get; set;}
		public Boolean editable {get; set;}
		public Id userId {get; set;}
		
		public Mission(INNOmission__c mission, Boolean editable, Boolean showAllPhases, Id userId){
			this.mission = mission;
			this.editable = editable;
			this.userId = userId;
			this.usedPhases = new List<UsedPhase>();
			if(showAllPhases){
			    List<String> phases = new List<String> ();
			    if(this.mission == null){
			        phases = new List<String>(INNOtimeSheetCtrl.PHASES_GENERAL);
			    }
			    else{
			        if(this.mission.recordTypeId == recordTypeCir)
			            phases = new List<String>(INNOtimeSheetCtrl.PHASES_MISSION);
			        
			        else
			            phases = new List<String>(INNOtimeSheetCtrl.PHASES_MISSION_NOT_CIR);
		     	}
    			for(String ph : phases)
    			    addPhase(ph);       
    		}
		}
		
		public void addPhase(String phase){
		    Boolean notAddedYet = true;
		    for(UsedPhase u : this.usedPhases){
		        if(u.phase == phase){
		            notAddedYet = false;
		            break;
		        }
		    }
		    if (notAddedYet)
		        this.usedPhases.add(new usedPhase(phase,this.mission == null ? null : this.mission.Id, this.userId));
		}
	}
	
	public class UsedPhase{
	    public Id missionId {get; set;}
	    public Id userId {get; set;}
	    public String phase {get; set;}
	    public String phaseTechnique {get; set;}
	    public Boolean isPhaseMission {get; set;}
	    public String colorClass {get; set;} // plus facile à gérer dans le ctrl
	    public String indicateurDelta {get; set;} // plus facile à gérer dans le ctrl
	    
	    public UsedPhase(String phaseTechnique, Id missionId, Id userId){
	        this.missionId = missionId;
	        this.userId = userId;
			this.phase = INNOtimeSheetCtrl.PHASES_LABELS.get(phaseTechnique);
			this.phaseTechnique = phaseTechnique;
			this.colorClass = '';
			this.indicateurDelta = '';
			
			if(this.missionId != null && timeByMission.containsKey(this.missionId)){
			    List<INNOequipeConsulting__c> temps = timeByMission.get(this.missionId);
			    Decimal totalTempsTheorique = 0.0;    
		        Decimal totalTempsEngage = 0.0;
			    for(INNOequipeConsulting__c temp : temps){
			        if(temp.Utilisateur__c == this.userId){
			            Decimal tempsTheorique = 0;    
    			        Decimal tempsEngage = 0;
    			        if (this.phaseTechnique == 'Audit'){
    			            tempsTheorique = temp.Nombre_jours_theoriques_Audit__c;
    			            tempsEngage = temp.Nombre_jours_engages_Audit__c;
    			        }
    			        else if(this.phaseTechnique == 'Valorisation'){
    			            tempsTheorique = temp.Nombre_jours_theoriques_Valorisation__c;
    			            tempsEngage = temp.Nombre_jours_engages_Valorisation__c;
    			        }
    			        else if(this.phaseTechnique == 'Justification'){
    			            tempsTheorique = temp.Nombre_jours_theoriques_Justification__c;
    			            tempsEngage = temp.Nombre_jours_engages_Justif__c;
    			        }
    			        else if(this.phaseTechnique == 'Controle'){
    			            tempsTheorique = temp.Nombre_jours_theoriques_Controle__c;
    			            tempsEngage = temp.Nombre_jours_engages_Controle__c;
    			        }
    			        totalTempsTheorique += tempsTheorique != null ? tempsTheorique : 0;
    			        totalTempsEngage += tempsEngage != null ? tempsEngage : 0;
			        }
			    }
			    if(totalTempsTheorique != 0 || totalTempsEngage != 0){
			        if(totalTempsTheorique > 0 && totalTempsEngage == 0)
			            this.colorClass = 'colorNoTime';
			        else if(totalTempsTheorique < totalTempsEngage)
			            this.colorClass = 'colorMoreTime';
			        else if(totalTempsTheorique > 0 &&  totalTempsTheorique >= totalTempsEngage)
			            this.colorClass = 'colorLessTime';
			    }
			    if(totalTempsTheorique > 0 || totalTempsEngage > 0)
			        this.indicateurDelta = String.valueOf((totalTempsTheorique - totalTempsEngage).setScale(1));
			}
		}
	}
	
	public class TimeSheet{
		public Id xId {get; set;}
		public String phase {get; set;}
		public Id xUser {get; set;}
		public String mission {get; set;}
		public Boolean theorique {get; set;}
		public Decimal duree {get; set;}
		public String dateStr {get; set;}
		
		public TimeSheet(INNOtimeSheet__c ts){
			this.xId = ts.Id;
			this.phase = ts.Phase_technique__c;
			this.xUser = ts.Utilisateur__c;
			this.mission = (ts.Mission_CIR__c == null ? 'general' : ts.Mission_CIR__c);
			this.theorique = ts.Theorique__c;
			this.duree = ts.Duree__c;
			this.dateStr = ts.Date__c.year() + '-' + ts.Date__c.month() + '-' + ts.Date__c.day();
		}
		
		public override String toString(){
			return JSON.serialize(this);
		}
	}
}