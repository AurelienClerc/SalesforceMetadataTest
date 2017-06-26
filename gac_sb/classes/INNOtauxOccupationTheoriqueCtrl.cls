public without sharing class INNOtauxOccupationTheoriqueCtrl extends INNOtauxOccupationBase {

    public transient List<UserOccupancyRates> usersOccupancyRates {get; set;}

    //CONFIGURATION
	private static final Integer nbMonthsToDisplay = 12;         //Nombre de mois à afficher dans le planning
	
	//Nombre de jours moyen dans un mois pour chaque Role
	@TestVisible private static final Map<String, List<Decimal>> nbBusinessDaysInMonth = new Map<String, List<Decimal>>{
	                'SCIENTIFIQUE_MANAGER'      => new List<Decimal>{10.4, 10.4, 10.4, 10.4, 9.9, 9.9, 9.3, 5.5, 10.4, 10.4, 10.4, 10.4},
	                'SCIENTIFIQUE_SUPERVISEUR'  => new List<Decimal>{15.6, 15.6, 15.6, 15.6, 14.8, 14.8, 14.0, 8.3, 15.6, 15.6, 15.6, 15.6},
	                'SCIENTIFIQUE_CONSULTANT'   => new List<Decimal>{16.5, 16.5, 16.5, 16.5, 15.6, 15.6, 14.7, 8.8, 16.5, 16.5, 16.5, 16.5},
	                'FISCALITE_CONSULTANT'     => new List<Decimal>{16.5, 16.5, 16.5, 16.5, 15.6, 15.6, 14.7, 8.8, 16.5, 16.5, 16.5, 16.5}};	
    
	
	/**
	 * Créer une liste avec les noms des mois utilisés dans le planning dans l'ordre
	 * Utilisé directement et uniquement par la page VF: <apex:repeat value="{!usedMonthsNames}" var="monthName">
	 * 
	 * @return List<String> la liste des noms de mois
	 */
	public override List<String> getHeaderValues(){
	    List<String> usedMonthsNames = new List<String>();
		Integer planningStartMonth = System.today().month(); 
		for(Integer mois = planningStartMonth; mois < planningStartMonth + nbMonthsToDisplay; mois ++){
			usedMonthsNames.add(monthsNames.get(Math.mod(mois - 1, 12)));
		}

		return usedMonthsNames;
	}
	
	
	
	/**
	 * Initialise les taux d'occupation
	 * 
	 * @param Set<Id> usersRestriction: la liste des Ids d'utilisateur dont il faut calculer le taux d'occupation
	 */
	protected override void initUsersOccupancyRates(Set<Id> usersRestriction){

		Date planningStartDate = System.today().toStartOfMonth();               //Le 1er jour du planning, ex 01/01/2015
		Date planningEndDate = planningStartDate.addMonths(nbMonthsToDisplay);   //Le lendemin du dernier jour du planning, ex 01/01/2016
		
		
		//Initialise this.usersOccupancyRates
		this.usersOccupancyRates = new List<UserOccupancyRates>();
		UserOccupancyRates tempUserOccupancyRate;
		
		for(User u : [SELECT Id, 
							Name,	
							UserRole.DeveloperName,
							(SELECT 
								Id, 
								Name,
								MissionCIR__r.Date_debut_Audit__c, 					//Début Audit
								MissionCIR__r.Date_fin_audit__c, 	                //Fin Audit
								MissionCIR__r.Date_debut_valorisation__c, 			//Début Valorisation
								MissionCIR__r.Date_fin_valorisation__c, 			//Fin Valorisation
								MissionCIR__r.Date_debut_justification__c, 			//Début Justification
								MissionCIR__r.Date_fin_justification_recap__c, 		//Fin Justification
								Nombre_jours_theoriques_Audit__c, 
								Nombre_jours_theoriques_Valorisation__c, 
								Nombre_jours_theoriques_Justification__c,
								Nombre_jours_travailles_Justification__c
							FROM EquipesConsulting2__r
							WHERE Actif__c = true
								AND Utilisateur__r.UserRole.DeveloperName IN :nbBusinessDaysInMonth.keySet() 
								AND MissionCIR__r.Phase__c != 'Terminée - Dossier à 0' 
								AND MissionCIR__r.Phase__c != 'Terminée'
								AND MissionCIR__r.Phase__c != 'Contrôle' 
								AND MissionCIR__r.TousDTrendus__c = false
								AND (Nombre_jours_theoriques_Audit__c > 0 
									OR Nombre_jours_theoriques_Valorisation__c > 0
									OR Nombre_jours_theoriques_Justification__c > 0)
								AND (MissionCIR__r.Date_debut_Audit__c >= :planningStartDate
									OR MissionCIR__r.Date_debut_valorisation__c >= :planningStartDate
									OR MissionCIR__r.Date_debut_justification__c >= :planningStartDate
									OR MissionCIR__r.Date_fin_audit__c < :planningEndDate
									OR MissionCIR__r.Date_fin_valorisation__c < :planningEndDate
									OR MissionCIR__r.Date_fin_justification_recap__c < :planningEndDate)
								)
						FROM User
						WHERE Id IN :usersRestriction 
						ORDER BY Name]){
			
			if(!u.EquipesConsulting2__r.isEmpty())
				this.usersOccupancyRates.add(new UserOccupancyRates(u));
			
		}
		
		
	
		
	}
	
	

	/**
	 * Calcul le pourcentage qu'occupe une phase (startOfPhase-endOfPhase) dans un mois donnée (startOfMonth-endOfMonth)
	 * 
	 */
	private static Decimal getPercentageOfPhaseInMonth(Date startOfPhase, Date endOfPhase, Date startOfMonth, Date endOfMonth){
		if(startOfPhase == null || endOfPhase == null || startOfMonth == null || endOfMonth == null)
			return 0;
		else{
		    //Nombre de jours de la phase qui sont contenus dans le mois, c-a-d entre le MAX(début phase, début mois) et le MIN(fin phase, fin mois)
			Decimal nbDaysOfPhaseInMonth = (startOfPhase < startOfMonth ? startOfMonth : startOfPhase).daysBetween(endOfPhase > endOfMonth ? endOfMonth : endOfPhase);
			
			//On divise ce nombre de jours de la phase dans le mois par le nombre de jours de la phase
			return nbDaysOfPhaseInMonth > 0 ? nbDaysOfPhaseInMonth / startOfPhase.daysBetween(endOfPhase) : 0;
		}
	}
	
	
	
	
	
	
	
	
	/**
	 * Wrapper class représentant un utilisateur dont il faut calculer le taux d'occupation
	 * 
	 */
	public class UserOccupancyRates{
		public User collaborateur {get; set;}                   //L'utilisateur
		public List<Decimal> occupancyRates {get; set;}         //La liste des taux d'occupation par mois
		
		
		
		public UserOccupancyRates(User collaborateur){
			this.collaborateur = collaborateur;
			this.computeOccupancyRate();
		}
		
		
		
		/**
		 * Calcul le taux d'occupation de l'utilisateur pour chaque mois du planning
		 */
		public void computeOccupancyRate(){
			this.occupancyRates = new List<Decimal>();
			Date planningStart = System.today().toStartOfMonth();
			Date startOfMonth;
			Date endOfMonth;
			Decimal nbDaysInMonth;
			Decimal nbCongesInMonth;
			
			for(Integer mois = 0; mois < nbMonthsToDisplay; mois ++){
				startOfMonth = planningStart.addMonths(mois);
				endOfMonth = startOfMonth.addMonths(1).addDays(-1);
				nbDaysInMonth = 0;
				nbCongesInMonth = 0;
				
				
				//Calcule le nombre de jours travaillés théoriques dans le mois
				for(INNOequipeConsulting__c missionMember : this.collaborateur.EquipesConsulting2__r){
				    
					//Audit
					if(missionMember.Nombre_jours_theoriques_Audit__c != null)
						nbDaysInMonth += getPercentageOfPhaseInMonth(missionMember.MissionCIR__r.Date_debut_Audit__c, missionMember.MissionCIR__r.Date_fin_audit__c, startOfMonth, endOfMonth) * missionMember.Nombre_jours_theoriques_Audit__c;
        			
					//Valorisation
					if(missionMember.Nombre_jours_theoriques_Valorisation__c != null)
						nbDaysInMonth += getPercentageOfPhaseInMonth(missionMember.MissionCIR__r.Date_debut_valorisation__c, missionMember.MissionCIR__r.Date_fin_valorisation__c, startOfMonth, endOfMonth) * missionMember.Nombre_jours_theoriques_Valorisation__c;
					
					//Justification
					if(missionMember.Nombre_jours_theoriques_Justification__c != null)
						nbDaysInMonth += getPercentageOfPhaseInMonth((System.today() > missionMember.MissionCIR__r.Date_debut_justification__c ? System.today() : missionMember.MissionCIR__r.Date_debut_justification__c), missionMember.MissionCIR__r.Date_fin_justification_recap__c, startOfMonth, endOfMonth) * Math.max(missionMember.Nombre_jours_theoriques_Justification__c - missionMember.Nombre_jours_travailles_Justification__c, 0);
                    
				}
				
		

                //On en déduit un taux d'occupation théorique
				this.occupancyRates.add(Math.round(nbDaysInMonth / (nbBusinessDaysInMonth.get(this.collaborateur.UserRole.DeveloperName).get(startOfMonth.month() - 1) - nbCongesInMonth) * 100));
			}
			
		}
		
		
		
	}
	
	
}