public with sharing class INNOdepensePersonnelCtrl extends INNOmissionBaseCtrl {

	private ApexPages.standardController stdCtrl;

	
	public String tab {get; set;}
	
	
	//Les temps passé sur chaque projet par le salarié
	public INNOdepensePersonnelListCtrl.personnelProjets personnelProjets {get; set;}
	
	//La clé est IdDuSalarié_IdDuProjet
	private transient Map<String, INNOpersonnelToProjet__c> personnelsToProjet;
	
	//Tous les projets de la mission
	public Map<Id, INNOprojet__c> allProjects {get; set;}
	
	//Utile pour pouvoir boucler correctement dans la page par ca ne fonctionne pas correctement quand on boucle sur "projets" (car static)
	public List<Id> projetsIds {get; set;}
	
	public String listPageURL {get; set;}
	
	

	public INNOdepensePersonnelCtrl(ApexPages.standardController stdCtrl){
		this.stdCtrl = stdCtrl;
		
		this.tab = ApexPages.currentPage().getParameters().get('tab');

		if(this.tab == null)
			this.tab = 'salarie';
			
		
		this.personnelsToProjet = new Map<String, INNOpersonnelToProjet__c>();
		
		INNOdepensePersonnel__c depensePersonnel = (INNOdepensePersonnel__c) this.stdCtrl.getRecord();
		
		this.initAllProjets();
		
		if( ApexPages.currentPage().getUrl().startsWith('/apex/INNOdepensePersonnelEdit') ){
				
			///Si c'est une NOUVELLE depense de personnel
			if(depensePersonnel.Id == null){
				depensePersonnel.Valorisation__c = this.valoId;		
				depensePersonnel.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'INNOdepensePersonnel__c' AND DeveloperName = :this.tab LIMIT 1][0].Id;
			}
			
			//On initialise le menu deroulant des departements
			this.initDepartements();

		}
		
		//En cas d'update (pas à l'insert)
		if(depensePersonnel.Id != null){
			
			//On initialise pesonnelsToProjet
			for(INNOpersonnelToProjet__c pp : [SELECT Id, Name, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c, Projet__c, Depense_de_personnel__c FROM INNOpersonnelToProjet__c WHERE Projet__r.Valorisation__c = :this.valoId AND Depense_de_personnel__c = :this.stdCtrl.getId()]){
				this.personnelsToProjet.put(pp.Depense_de_personnel__c + '_' + pp.Projet__c, pp);
			}
		}
		
		
		this.personnelProjets = new INNOdepensePersonnelListCtrl.personnelProjets(false, depensePersonnel, this.allProjects, this.personnelsToProjet);
		
		
		if(this.tab == 'brevetPM' || this.tab == 'veille')
			this.listPageURL = '/apex/INNOdepensePrestationPersonnelList';
		else
			this.listPageURL = '/apex/INNOdepensePersonnelList';
			
	}
	
	
	
	
	
	
	/**
	*	Effectue un save de la dépense de personnel mais aussi des heures travaillées sur les projets
	*	Pout la page Edit uniquement
	*/
	public PageReference savePersonnelEtHeuresTravaillees(){
		this.stdCtrl.save();

		List<INNOpersonnelToProjet__c> ptpToUpsert = new List<INNOpersonnelToProjet__c>();
		List<INNOpersonnelToProjet__c> ptpToDelete = new List<INNOpersonnelToProjet__c>();
		
		for(INNOpersonnelToProjet__c ptp : personnelProjets.projetsHeures.values()){

			//Si le depense de personnel to projet n'existait pas
			if(ptp.Id == null){
				if( (ptp.Heures_RD_option1__c == null ? 0 : ptp.Heures_RD_option1__c) + (ptp.Heures_RD_option2__c == null ? 0 : ptp.Heures_RD_option2__c) + (ptp.Heures_RD_option3__c == null ? 0 : ptp.Heures_RD_option3__c) > 0){
					ptp.Depense_de_personnel__c = this.stdCtrl.getId();
					ptpToUpsert.add(ptp);
				}
			}
			else{
				if((ptp.Heures_RD_option1__c == null ? 0 : ptp.Heures_RD_option1__c) + (ptp.Heures_RD_option2__c == null ? 0 : ptp.Heures_RD_option2__c) + (ptp.Heures_RD_option3__c == null ? 0 : ptp.Heures_RD_option3__c) > 0)
					ptpToUpsert.add(ptp);
				else
					ptpToDelete.add(ptp);
				
			}
		}
				
		
		upsert ptpToUpsert;
		delete ptpToDelete;
		
		
		PageReference retPage = new pageReference( '/apex/INNOdepensePersonnelView' );
		retPage.getParameters().put('id', this.stdCtrl.getId());
		retPage.getParameters().put('valoId', this.valoId);
		retPage.getParameters().put('tab', this.tab);
		retPage.setRedirect(true);
		return retPage; 
	}
	
	
	/**
	*	Supprime une depense de personnel et redirige vers la page de liste des projets
	*/
	public PageReference deleteAndRedirect(){
		Database.delete(this.stdCtrl.getId());
		
		PageReference retPage = new pageReference( this.listPageURL );
		retPage.getParameters().put('id', this.valoId);
		retPage.getParameters().put('valoId', this.valoId);
		retPage.getParameters().put('tab', this.tab);
		retPage.setRedirect(true);
		return retPage; 
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
		for(INNOprojet__c p : [SELECT Id, Name, Type__c FROM INNOprojet__c WHERE Valorisation__c = :this.valoId ORDER BY Name]){
			this.allProjects.put(p.Id, p);
			
			if(p.Type__c == 'projet')
				this.projetsIds.add(p.Id);
			else
				projetsSpeciaux.add(p.Id);
		}
		//Rajoute les projets spéciaux (veille, PM brevet et normalisation) en fin de liste, sauf si on est sur les jeunes docteurs
		this.projetsIds.addAll(projetsSpeciaux);
		
	}
	
	
	
	
	
	/**
	*	Inner class correspondant à un salarié avec ses heures travaillées sur les projets
	*/
	// public class personnelProjets{
		
	// 	public Id salarieId {get; set;}
		
	// 	public String salarieName {get; set;}
		
	// 	//Les heures travaillées avec l'id du projet en clé
	// 	public Map<Id, AppCIRpersonnelToProjet__c> projetsHeures {get; set;}
		
	// 	public Decimal totalHeuresProjetsOptions1 {get; set;}
	// 	public Decimal totalHeuresProjetsOptions2 {get; set;}
	// 	public Decimal totalHeuresProjetsOptions3 {get; set;}
		
	// 	public Decimal totalHeuresOptions1 {get; set;}
	// 	public Decimal totalHeuresOptions2 {get; set;}
	// 	public Decimal totalHeuresOptions3 {get; set;}




	// 	//Constructeur		
	// 	public personnelProjets(AppCIRdepensePersonnel__c pers){
	// 		this.salarieId = pers.Id;
	// 		this.salarieName = pers.Name;
	// 		this.init();
	// 	}
		
	// 	//Constructeur
	// 	public personnelProjets(Id salarieId, String salarieName){
	// 		this.salarieId = salarieId;
	// 		this.salarieName = salarieName;
	// 		this.init();
	// 	}
		
		
		
	// 	public void init(){
			
	// 		AppCIRpersonnelToProjet__c persToProjetTemp;
			
	// 		this.projetsHeures = new Map<Id, AppCIRpersonnelToProjet__c>();
			
	// 		for(Id projetId : projets.keySet()){
	// 			persToProjetTemp = personnelsToProjet.get(this.salarieId + '_' + projetId);
				
	// 			if(persToProjetTemp != null){
	// 				this.projetsHeures.put(projetId, persToProjetTemp);
	// 			}
	// 			else{
	// 				this.projetsHeures.put(projetId, new AppCIRpersonnelToProjet__c(Projet__c = projetId, Depense_de_personnel__c = this.salarieId));
	// 			}
	// 		}
			
	// 		this.refreshTotauxHeures();
	// 	}
		
		
	// 	/**
	// 	*	Recalcul les colonnes de totaux des heures travaillées
	// 	*/
	// 	private void refreshTotauxHeures(){
	// 		this.totalHeuresOptions1 = this.totalHeuresOptions2 = this.totalHeuresOptions3 = this.totalHeuresProjetsOptions1 = this.totalHeuresProjetsOptions2 = this.totalHeuresProjetsOptions3 = 0;

	// 		for(AppCIRpersonnelToProjet__c ptp : this.projetsHeures.values()){
	// 			this.totalHeuresOptions1 += ptp.Heures_RD_option1__c != null ? ptp.Heures_RD_option1__c : 0;
	// 			this.totalHeuresOptions2 += ptp.Heures_RD_option2__c != null ? ptp.Heures_RD_option2__c : 0;
	// 			this.totalHeuresOptions3 += ptp.Heures_RD_option3__c != null ? ptp.Heures_RD_option3__c : 0;
				
	// 			if(projets.get(ptp.Projet__c).get('Type__c') == 'projet'){
	// 				this.totalHeuresProjetsOptions1 += ptp.Heures_RD_option1__c != null ? ptp.Heures_RD_option1__c : 0;
	// 				this.totalHeuresProjetsOptions2 += ptp.Heures_RD_option2__c != null ? ptp.Heures_RD_option2__c : 0;
	// 				this.totalHeuresProjetsOptions3 += ptp.Heures_RD_option3__c != null ? ptp.Heures_RD_option3__c : 0;
	// 			}
	// 		}
	// 	}
	// }
	

}