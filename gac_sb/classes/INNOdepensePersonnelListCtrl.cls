public with sharing class INNOdepensePersonnelListCtrl extends INNOmissionBaseCtrl{

	public transient List<INNOdepensePersonnel__c> personnels {get; set;}
	
	
	public String tab {get; set;}
	
	

	//La liste de salariés avec leur temps passé sur chaque projet
	public transient personnelProjets[] personnelsProjets {get; set;}
	
	//La clé est IdDuSalarié_IdDuProjet
	private transient Map<String, INNOpersonnelToProjet__c> personnelsToProjet;
	
	//Tous les projets de la mission
	public Map<Id, INNOprojet__c> allProjects {get; set;}
	
	//Utile pour pouvoir boucler correctement dans la page par ca ne fonctionne pas correctement quand on boucle sur "projets" (car static)
	public transient List<Id> projetsIds {get; set;}
	
	
	public static Map<String, Map<Integer, Decimal>> projetsTotaux {get; set;}


	public INNOdepensePersonnelListCtrl(){

		this.tab = ApexPages.currentPage().getParameters().get('tab');
		
		if(this.tab == null)
			this.tab = 'salarie';

		
		this.personnelsProjets = new List<personnelProjets>();
		this.personnelsToProjet = new Map<String, INNOpersonnelToProjet__c>();
		projetsTotaux = new Map<String, Map<Integer, Decimal>>();
		
		this.initPersonnels();
		
		if(this.tab == 'salarie' || this.tab == 'jeuneDocteur' || this.tab == 'miseDisposition'){
			
			this.initAllProjets();
			
			//On initialise pesonnelsToProjet
			for(INNOpersonnelToProjet__c pp : [SELECT Id, Name, UniteTempsDepensesPersonnel2__c, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c, Projet__c, Depense_de_personnel__c FROM INNOpersonnelToProjet__c WHERE Projet__r.Valorisation__c = :this.valo.Id AND Depense_de_personnel__r.RecordType.DeveloperName = :this.tab]){
				this.personnelsToProjet.put(pp.Depense_de_personnel__c + '_' + pp.Projet__c, pp);
			}
				
			for(INNOdepensePersonnel__c pers : this.personnels){
			    if(pers.Actif__c == true)
			        this.personnelsProjets.add(new personnelProjets(true, pers, this.allProjects, this.personnelsToProjet));
			}
		}
	}
	
	
	
	
	private void initPersonnels(){
		
		String req = 'SELECT Id, UniteTempsDepensesPersonnel__c, Name, Nom__c, Prenom__c, Departement__c, Departement__r.Name, Actif__c, Montant_RD_retenu_option1__c, Montant_RD_retenu_option2__c, Montant_RD_retenu_option3__c, Montant_normalisation_retenu_option1__c, Montant_normalisation_retenu_option2__c, Montant_normalisation_retenu_option3__c, Montant_brevetPM_retenu_option1__c, Montant_brevetPM_retenu_option2__c, Montant_brevetPM_retenu_option3__c, Montant_veille_retenu_option1__c, Montant_veille_retenu_option2__c, Montant_veille_retenu_option3__c FROM INNOdepensePersonnel__c WHERE Valorisation__c = \'' + this.valo.Id + '\' ';
		
		if(this.tab == 'salarie' || this.tab == 'jeuneDocteur' || this.tab == 'miseDisposition')
		    req += 'AND RecordType.DeveloperName = \'' + this.tab + '\' ';
		else
			req += 'AND (Montant_' + this.tab + '_retenu_option1__c > 0 OR Montant_' + this.tab + '_retenu_option2__c > 0 OR Montant_' + this.tab + '_retenu_option3__c > 0) '; 

	    this.personnels = Database.query(req);
	}
	
	
	
	
	
	
	/**
	*	Initialise la liste des projets de la mission, des "faux projets" de type PM brevet, Normalisation et Veille sont aussi à la fin de cette liste
	*/
	private void initAllProjets(){
		
		//Contiendra les "projets" de type veille, PM brevet et normalisation pour pouvoir les ajouter en fin de liste
		List<Id> projetsSpeciaux = new List<Id>();
		
		//On initialise les projets
		this.allProjects = new Map<Id, INNOprojet__c>();
		this.projetsIds = new List<Id>();
		for(INNOprojet__c p : [SELECT Id, Name, Type__c, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c, Jours_RD_option1__c, Jours_RD_option2__c, Jours_RD_option3__c FROM INNOprojet__c WHERE Valorisation__c = :this.valo.Id ORDER BY Name]){
			this.allProjects.put(p.Id, p);
			
			if(p.Type__c == 'projet')
				this.projetsIds.add(p.Id);
			else
				projetsSpeciaux.add(p.Id);
				
				
			projetsTotaux.put(p.Id, new Map<Integer, Decimal>{1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0});
		}
		//Rajoute les projets spéciaux (veille, PM brevet et normalisation) en fin de liste, sauf si on est sur les jeunes docteurs
		this.projetsIds.addAll(projetsSpeciaux);
		
		
		projetsTotaux.put('totalHeuresProjets', new Map<Integer, Decimal>{1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0});
		projetsTotaux.put('totalHeures', new Map<Integer, Decimal>{1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0});
	}
	
	
	
	
	
	/**
	*	Inner class correspondant à un salarié avec ses heures travaillées sur les projets
	*/
	public class personnelProjets{
		
		public Id salarieId {get; set;}
		
		public String salarieNom {get; set;}
		public String salariePrenom {get; set;}
		
		public String uniteDeTemps {get; set;}
		
		//Les heures travaillées avec l'id du projet en clé
		public Map<Id, INNOpersonnelToProjet__c> projetsHeures {get; set;}
		
		public Decimal totalHeuresProjetsOptions1 {get; set;}
		public Decimal totalHeuresProjetsOptions2 {get; set;}
		public Decimal totalHeuresProjetsOptions3 {get; set;}
		
		public Decimal totalHeuresOptions1 {get; set;}
		public Decimal totalHeuresOptions2 {get; set;}
		public Decimal totalHeuresOptions3 {get; set;}

        public Decimal totalJoursProjetsOptions1 {get; set;}
		public Decimal totalJoursProjetsOptions2 {get; set;}
		public Decimal totalJoursProjetsOptions3 {get; set;}
		
		public Decimal totalJoursOptions1 {get; set;}
		public Decimal totalJoursOptions2 {get; set;}
		public Decimal totalJoursOptions3 {get; set;}


		//Constructeur		
		public personnelProjets(Boolean initProjectsTotaux, INNOdepensePersonnel__c pers, Map<Id, INNOprojet__c> allProjects, Map<String, INNOpersonnelToProjet__c> personnelsToProjet){
			this.salarieId = pers.Id;
			this.salarieNom = pers.Nom__c;
			this.salariePrenom = pers.Prenom__c;
			this.uniteDeTemps = pers.UniteTempsDepensesPersonnel__c;

			this.init(initProjectsTotaux, allProjects, personnelsToProjet);
		}
		
		public void init(Boolean initProjectsTotaux, Map<Id, INNOprojet__c> allProjects, Map<String, INNOpersonnelToProjet__c> personnelsToProjet){
			
			INNOpersonnelToProjet__c persToProjetTemp;
			
			this.projetsHeures = new Map<Id, INNOpersonnelToProjet__c>();
			
			Map<Integer, Decimal> totauxParOption;
			
			for(Id projetId : allProjects.keySet()){
				persToProjetTemp = personnelsToProjet.get(this.salarieId + '_' + projetId);
				
				
				if(persToProjetTemp != null){
					this.projetsHeures.put(projetId, persToProjetTemp);
					
					if(initProjectsTotaux){
						totauxParOption = projetsTotaux.get(projetId);
						totauxParOption.put(1, totauxParOption.get(1) + (persToProjetTemp.Heures_RD_option1__c == null || persToProjetTemp.UniteTempsDepensesPersonnel2__c == 'Jours' ? 0 : persToProjetTemp.Heures_RD_option1__c));
						totauxParOption.put(2, totauxParOption.get(2) + (persToProjetTemp.Heures_RD_option2__c == null || persToProjetTemp.UniteTempsDepensesPersonnel2__c == 'Jours'  ? 0 : persToProjetTemp.Heures_RD_option2__c));
						totauxParOption.put(3, totauxParOption.get(3) + (persToProjetTemp.Heures_RD_option3__c == null || persToProjetTemp.UniteTempsDepensesPersonnel2__c == 'Jours'  ? 0 : persToProjetTemp.Heures_RD_option3__c));
						totauxParOption.put(4, totauxParOption.get(4) + (persToProjetTemp.Heures_RD_option1__c == null || persToProjetTemp.UniteTempsDepensesPersonnel2__c == 'Heures'  ? 0 : persToProjetTemp.Heures_RD_option1__c));
						totauxParOption.put(5, totauxParOption.get(5) + (persToProjetTemp.Heures_RD_option2__c == null || persToProjetTemp.UniteTempsDepensesPersonnel2__c == 'Heures'  ? 0 : persToProjetTemp.Heures_RD_option2__c));
						totauxParOption.put(6, totauxParOption.get(6) + (persToProjetTemp.Heures_RD_option3__c == null || persToProjetTemp.UniteTempsDepensesPersonnel2__c == 'Heures'  ? 0 : persToProjetTemp.Heures_RD_option3__c));
						projetsTotaux.put(projetId, totauxParOption);
					}
				}
				else{
					this.projetsHeures.put(projetId, new INNOpersonnelToProjet__c(Projet__c = projetId, Depense_de_personnel__c = this.salarieId, Heures_RD_option1__c=null, Heures_RD_option2__c=null, Heures_RD_option3__c=null, UniteTempsDepensesPersonnel2__c = this.uniteDeTemps));
				}
				
			}
			
			if(initProjectsTotaux)
				this.refreshTotauxHeures(allProjects);
			
			
		}
		
		
		/**
		*	Recalcul les colonnes de totaux des heures travaillées
		*/
		private void refreshTotauxHeures(Map<Id, INNOprojet__c> allProjects){
			this.totalHeuresOptions1 = this.totalHeuresOptions2 = this.totalHeuresOptions3 = this.totalHeuresProjetsOptions1 = this.totalHeuresProjetsOptions2 = this.totalHeuresProjetsOptions3 = 0;
            this.totalJoursOptions1 = this.totalJoursOptions2 = this.totalJoursOptions3 = this.totalJoursProjetsOptions1 = this.totalJoursProjetsOptions2 = this.totalJoursProjetsOptions3 = 0;

			for(INNOpersonnelToProjet__c ptp : this.projetsHeures.values()){
				this.totalHeuresOptions1 += ptp.Heures_RD_option1__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Heures' ? ptp.Heures_RD_option1__c : 0;
				this.totalHeuresOptions2 += ptp.Heures_RD_option2__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Heures' ? ptp.Heures_RD_option2__c : 0;
				this.totalHeuresOptions3 += ptp.Heures_RD_option3__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Heures' ? ptp.Heures_RD_option3__c : 0;
				
				if(allProjects.get(ptp.Projet__c).get('Type__c') == 'projet'){
					this.totalHeuresProjetsOptions1 += ptp.Heures_RD_option1__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Heures' ? ptp.Heures_RD_option1__c : 0;
					this.totalHeuresProjetsOptions2 += ptp.Heures_RD_option2__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Heures' ? ptp.Heures_RD_option2__c : 0;
					this.totalHeuresProjetsOptions3 += ptp.Heures_RD_option3__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Heures' ? ptp.Heures_RD_option3__c : 0;
				}
				
				this.totalJoursOptions1 += ptp.Heures_RD_option1__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Jours' ? ptp.Heures_RD_option1__c : 0;
				this.totalJoursOptions2 += ptp.Heures_RD_option2__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Jours' ? ptp.Heures_RD_option2__c : 0;
				this.totalJoursOptions3 += ptp.Heures_RD_option3__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Jours' ? ptp.Heures_RD_option3__c : 0;
				
				if(allProjects.get(ptp.Projet__c).get('Type__c') == 'projet'){
					this.totalJoursProjetsOptions1 += ptp.Heures_RD_option1__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Jours' ? ptp.Heures_RD_option1__c : 0;
					this.totalJoursProjetsOptions2 += ptp.Heures_RD_option2__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Jours' ? ptp.Heures_RD_option2__c : 0;
					this.totalJoursProjetsOptions3 += ptp.Heures_RD_option3__c != null && ptp.UniteTempsDepensesPersonnel2__c == 'Jours' ? ptp.Heures_RD_option3__c : 0;
				}
			}
			
			
			Map<Integer, Decimal> totauxParOption = projetsTotaux.get('totalHeuresProjets');
			totauxParOption.put(1, totauxParOption.get(1) + this.totalHeuresProjetsOptions1);
			totauxParOption.put(2, totauxParOption.get(2) + this.totalHeuresProjetsOptions2);
			totauxParOption.put(3, totauxParOption.get(3) + this.totalHeuresProjetsOptions3);
			totauxParOption.put(4, totauxParOption.get(4) + this.totalJoursProjetsOptions1);
			totauxParOption.put(5, totauxParOption.get(5) + this.totalJoursProjetsOptions2);
			totauxParOption.put(6, totauxParOption.get(6) + this.totalJoursProjetsOptions3);
			projetsTotaux.put('totalHeuresProjets', totauxParOption);
			
			totauxParOption = projetsTotaux.get('totalHeures');
			totauxParOption.put(1, totauxParOption.get(1) + this.totalHeuresOptions1);
			totauxParOption.put(2, totauxParOption.get(2) + this.totalHeuresOptions2);
			totauxParOption.put(3, totauxParOption.get(3) + this.totalHeuresOptions3);
			totauxParOption.put(4, totauxParOption.get(4) + this.totalJoursOptions1);
			totauxParOption.put(5, totauxParOption.get(5) + this.totalJoursOptions2);
			totauxParOption.put(6, totauxParOption.get(6) + this.totalJoursOptions3);
			projetsTotaux.put('totalHeures', totauxParOption);
			
		}
	}
}