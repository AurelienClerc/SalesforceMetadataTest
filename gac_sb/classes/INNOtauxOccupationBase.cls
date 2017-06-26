public abstract without sharing class INNOtauxOccupationBase {

    public Boolean userIsManager {get; set;}                            //True si le user est manager (via les Roles)
    public Boolean userIsSuperviseur {get; set;}                        //True si le user est superviseur (via les Roles)

    public INNOequipeConsulting__c dummyEquipeManager {get; set;}     //Sert uniquement à afficher les champs lookup Consultant et Mission
	public INNOequipeConsulting__c dummyEquipeConsultant {get; set;}  //Sert uniquement à afficher le champ lookup Manager

	public List<UserOccupancyRates> usersOccupancyRates {get; set;}
	
	public List<SelectOption> availableActivityFilter {get; set;}
	public String selectedActivityFilter {get; set;}
	
	
	public static final List<String> monthsNames = new List<String>{'Jan.', 'Fév.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Aout', 'Sept', 'Oct.', 'Nov.', 'Dec.'};    //Les mois de l'année	
	
	
	/**
	 * Constructeur
	 */
	public INNOtauxOccupationBase(){
	   
	   	this.dummyEquipeManager = new INNOequipeConsulting__c();
		this.dummyEquipeConsultant = new INNOequipeConsulting__c();
		
		this.userIsManager = INNOmissionUtils.userIsManager();
		this.userIsSuperviseur = !this.userIsManager && INNOmissionUtils.userIsManagerOrSuperviseur();
		
		this.availableActivityFilter = new List<SelectOption>{new SelectOption('true', 'Actif'),new SelectOption('false', 'Inactif')};
		this.selectedActivityFilter = 'true';
		
		this.applyFilters();
		
		//Pour les admins, on peut ne pas séléctionner de filtre, ça prendra alors tout le monde
		// if(INNOmissionUtils.userHasFullAccess()){
		// 	this.applyFilters();
		// }
		// //Pour les superviseurs
		// else if(!this.userIsManager && this.userIsSuperviseur){
		//     //this.dummyEquipeManager.Utilisateur__c = UserInfo.getUserId();
		//     this.applyFilters();
		// }
		
		// //Pour les consultants
		// else if(!this.userIsManager && !this.userIsSuperviseur && this.dummyEquipeConsultant.MissionCIR__c == null){
		//     this.dummyEquipeConsultant.Utilisateur__c = UserInfo.getUserId();
		//     this.applyFilters();
		// }
		
	}
	
	
	/**
	 * Permet de passer le controller au component Visualforce
	 */
	public INNOtauxOccupationBase getThis(){
        return this;
    }
	
	
	/**
	 * Application des filtres => On recalcule tous les taux d'occupation
	 * 
	 */
	public void applyFilters(){
		
		if(!this.userIsManager && !this.userIsSuperviseur){
		    this.dummyEquipeConsultant.Utilisateur__c = (this.dummyEquipeConsultant.MissionCIR__c == null ? UserInfo.getUserId() : null);
		}
		
		//Pour les superviseurs, on a par defaut le filtre "Manager/Superviseur" avec eux dedans. Sauf si il choisi un des 2 autres filtres		
		//désactivé suite au case 590, le volume de missions fait planter la page, l'utilisateur filtre lui même
		else if(this.userIsSuperviseur){
			if(this.dummyEquipeConsultant.Utilisateur__c == null && this.dummyEquipeConsultant.MissionCIR__c == null)
				this.dummyEquipeManager.Utilisateur__c = UserInfo.getUserId();
			else
				this.dummyEquipeManager.Utilisateur__c = null;
		}
		
	//	this.dummyEquipeManager.Utilisateur__c = '005D0000001w3Ns';
		
		//Vérifie qu'on a bien un seul filtre utilisé en même temps
		Integer nbUsedFilters = (this.dummyEquipeConsultant.Utilisateur__c == null ? 0 : 1) + (this.dummyEquipeManager.Utilisateur__c == null ? 0 : 1) + (this.dummyEquipeConsultant.MissionCIR__c == null ? 0 : 1);
		if(nbUsedFilters > 1){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Vous ne pouvez utiliser qu\'un seul filtre à la fois'));
			return;
		}
		
		//On va remplir userRestriction avec une liste d'Id utilisateur dont il faut calculer les taux d'occupation
		Set<Id> usersRestriction = new Set<Id>();
		Boolean activity = Boolean.valueOf(this.selectedActivityFilter);

		//Si on est admin et qu'on a pas choisi de filtre, on laisse vide pour ne pas avoir un chargement trop long
		if(INNOmissionUtils.userHasFullAccess() && nbUsedFilters == 0){
			// -> désactivé suite au case 590, le volume de missions fait planter la page, l'utilisateur filtre lui même
			for(INNOequipeConsulting__c eq : [SELECT Id, Utilisateur__c FROM INNOequipeConsulting__c WHERE Actif__c = :activity AND Utilisateur__r.IsActive = true])
				usersRestriction.add(eq.Utilisateur__c);
			
		}
        //Si on a rempli le filtre "Consultant"	=> on prend que cet utilisateur
	    else if(this.dummyEquipeConsultant.Utilisateur__c != null){
			         
            //pour les admins, pas de restriction
            if(INNOmissionUtils.userHasFullAccess()){
            	usersRestriction.add(this.dummyEquipeConsultant.Utilisateur__c);    
            }

			//Pour les managers/superviseurs, on doit vérifier que le consultant choisi est bien consultant sur une des missions où l'utilisateur est Manager ou Superviseur
			else if(this.userIsManager && this.dummyEquipeConsultant.Utilisateur__c != UserInfo.getUserId()){

				List<INNOmission__c> missionsWhereUserIsManager = [SELECT Id FROM INNOmission__c WHERE Id IN (SELECT MissionCIR__c FROM INNOequipeConsulting__c WHERE Utilisateur__c = :UserInfo.getUserId() AND (Role__c = 'Manager' OR Role__c = 'Superviseur' OR Role__c = 'Superviseur/Consultant'))];

				
				if([SELECT COUNT() FROM INNOequipeConsulting__c WHERE Utilisateur__c = :this.dummyEquipeConsultant.Utilisateur__c AND Role__c != 'Manager' AND Role__c != 'Superviseur' AND Role__c != 'Superviseur/Consultant' AND MissionCIR__c IN :missionsWhereUserIsManager] > 0)
					usersRestriction.add(this.dummyEquipeConsultant.Utilisateur__c);   
			}
			else if(this.userIsSuperviseur && this.dummyEquipeConsultant.Utilisateur__c != UserInfo.getUserId()){
				
				List<INNOmission__c> missionsWhereUserIsSuperviseur = [SELECT Id FROM INNOmission__c WHERE Id IN (SELECT MissionCIR__c FROM INNOequipeConsulting__c WHERE Utilisateur__c = :UserInfo.getUserId() AND (Role__c = 'Superviseur' OR Role__c = 'Superviseur/Consultant'))];
				
				if([SELECT COUNT() FROM INNOequipeConsulting__c WHERE Utilisateur__c = :this.dummyEquipeConsultant.Utilisateur__c AND Role__c != 'Manager' AND Role__c != 'Superviseur' AND Role__c != 'Superviseur/Consultant' AND MissionCIR__c IN :missionsWhereUserIsSuperviseur] > 0)
					usersRestriction.add(this.dummyEquipeConsultant.Utilisateur__c);
			}
			else
				usersRestriction.add(this.dummyEquipeConsultant.Utilisateur__c);
				
		}
		//Si on a rempli le filtre "Manager/Superviseur" => on prend tous les utilisateurs membres des missions sur lequelles l'utilisateur du filtre est Manager ou superviseur
		else if(this.dummyEquipeManager.Utilisateur__c != null){
			
			usersRestriction.add(this.dummyEquipeManager.Utilisateur__c);
			
			Set<Id> missionsWhereUserIsManager = new Set<Id>();
			for(INNOequipeConsulting__c eq : [SELECT Id, MissionCIR__c FROM INNOequipeConsulting__c WHERE MissionCIR__r.Statut__c = 'Active' AND (Role__c = 'Manager' OR Role__c = 'Superviseur' OR Role__c = 'Superviseur/Consultant') AND Utilisateur__c = :this.dummyEquipeManager.Utilisateur__c AND Actif__c = true]){
				missionsWhereUserIsManager.add(eq.MissionCIR__c);
			}
			
			for(INNOequipeConsulting__c eq : [SELECT Id, Utilisateur__c, Role__c FROM INNOequipeConsulting__c WHERE MissionCIR__c IN :missionsWhereUserIsManager AND Actif__c = :activity AND Utilisateur__r.IsActive = true]){
                //Pour les superviseurs, on n'affiche pas les Manager et les autres Superviseurs
                if(!this.userIsSuperviseur || (eq.Role__c != 'Manager' && eq.Role__c != 'Superviseur' && eq.Role__c != 'Superviseur/Consultant'))
				    usersRestriction.add(eq.Utilisateur__c);
			}
		}
		//Si on a rempli le filtre "Mission" 
		else if(this.dummyEquipeConsultant.MissionCIR__c != null){
			
			//Mananger & Superviseurs => On prend tous les utilisateurs membres de la mission
			if(this.userIsManager || this.userIsSuperviseur){
				for(INNOequipeConsulting__c eq : [SELECT Id, Utilisateur__c, Role__c FROM INNOequipeConsulting__c WHERE MissionCIR__c = :this.dummyEquipeConsultant.MissionCIR__c AND Actif__c = :activity AND Utilisateur__r.IsActive = true]){
					//Pour les superviseurs, on n'affiche pas les Manager et les autres Superviseurs
	                if(!this.userIsSuperviseur || eq.Utilisateur__c == UserInfo.getUserId() || (eq.Role__c != 'Manager' && eq.Role__c != 'Superviseur' && eq.Role__c != 'Superviseur/Consultant'))
					    usersRestriction.add(eq.Utilisateur__c);
				}
			}
			else
				usersRestriction.add(UserInfo.getUserId());
		}
		
		system.debug(usersRestriction);
		//Calcul des taux d'occupation
		this.initUsersOccupancyRates(usersRestriction);
	}
	
	

	protected virtual void initUsersOccupancyRates(Set<Id> usersRestriction){}
	
	public virtual List<String> getHeaderValues(){return null;}
	
	
	public virtual class UserOccupancyRates{
	    public User collaborateur {get; set;}                   //L'utilisateur
		public List<Decimal> occupancyRates {get; set;}         //La liste des taux d'occupation par mois
	}
	
}