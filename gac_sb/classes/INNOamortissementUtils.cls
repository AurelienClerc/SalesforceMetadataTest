public with sharing class INNOamortissementUtils {

	private Id valoId;
	
	
	/**
	*	Les taux RD pour les dotations aux amortissement pour chaque méthode de calcul et pour chaque département de l'entité
	*	Clé: String: 'All' pour tous les départements, '' pour avoir des taux nuls partout, sinon 'IdDuDepartement'
	*	Valeur: tauxRDdepartement: une inner class (voir plus bas)
	*/
	public Map<String, tauxRDdepartement> tauxRD {get;set;}
	
	
	/**
	*	Constructeur quand on passe que l'id de la mission
	*/
	public INNOamortissementUtils(Id valoId){
		this.initTauxRD(valoId, [SELECT Id, Entite__c FROM INNOvalo__c WHERE Id = :valoId LIMIT 1][0].Entite__c);
	}
	
	
	/**
	*	Constructeur quand on passe l'id de la mission et l'id de filiale
	*/
	public INNOamortissementUtils(Id valoId, Id filialeId){
		this.initTauxRD(valoId, filialeId);
	}
	
	
	
	public void refreshTauxRD(INNOamortissement__c amo){
		
		if(amo.Methode_de_calcul__c == 'Manuelle')
			return;
		else if(amo.Methode_de_calcul__c == 'Moyenne des sommes'){
			amo.Taux_RD_option1__c = this.tauxRD.get('all').getMoyenneSommesOpt1();
			amo.Taux_RD_option2__c = this.tauxRD.get('all').getMoyenneSommesOpt2();
			amo.Taux_RD_option3__c = this.tauxRD.get('all').getMoyenneSommesOpt3();
		}
		else if(amo.Methode_de_calcul__c == 'Somme des moyennes'){
			amo.Taux_RD_option1__c = this.tauxRD.get('all').getSommeMoyennesOpt1();
			amo.Taux_RD_option2__c = this.tauxRD.get('all').getSommeMoyennesOpt2();
			amo.Taux_RD_option3__c = this.tauxRD.get('all').getSommeMoyennesOpt3();
		}
		else if(amo.Methode_de_calcul__c == 'Moyenne des sommes du département'){
			amo.Taux_RD_option1__c = this.tauxRD.get(amo.Departement__c).getMoyenneSommesOpt1();
			amo.Taux_RD_option2__c = this.tauxRD.get(amo.Departement__c).getMoyenneSommesOpt2();
			amo.Taux_RD_option3__c = this.tauxRD.get(amo.Departement__c).getMoyenneSommesOpt3();
		}
		else if(amo.Methode_de_calcul__c == 'Somme des moyennes du département'){
			amo.Taux_RD_option1__c = this.tauxRD.get(amo.Departement__c).getSommeMoyennesOpt1();
			amo.Taux_RD_option2__c = this.tauxRD.get(amo.Departement__c).getSommeMoyennesOpt2();
			amo.Taux_RD_option3__c = this.tauxRD.get(amo.Departement__c).getSommeMoyennesOpt3();
		}
	}
	
	
	
	/**
	*	Initialise la Map this.tauxRD
	*/
	private void initTauxRD(Id valoId, Id filialeId){

		this.valoId = valoId;
		this.tauxRD = new Map<String, tauxRDdepartement>();
		
		//on initialise les différents départements (y compris un departement 'all' qui comprendra tous les salariés et un departement vide qui sera à 0)
		this.tauxRD.put('all', new tauxRDdepartement());
		this.tauxRD.put(null, new tauxRDdepartement());
		this.tauxRD.put('', new tauxRDdepartement());
		for(INNOdepartement__c dept : [SELECT Id FROM INNOdepartement__c WHERE Entite__c = :filialeId])
			this.tauxRD.put(dept.Id, new tauxRDdepartement());	
			
		for(INNOdepensePersonnel__c salarie : [SELECT ID, Departement__c, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c, Taux_RD_option1__c, Taux_RD_option2__c, Taux_RD_option3__c, Total_heures_travaillees_option1__c, Total_heures_travaillees_option2__c, Total_heures_travaillees_option3__c, Montant_RD_option1__c, Montant_RD_option2__c, Montant_RD_option3__c FROM INNOdepensePersonnel__c WHERE Actif__c = true AND Valorisation__c = :this.valoId AND RecordType.DeveloperName != 'miseDisposition']){
			this.addSalarie(salarie);
		}
		
	}
	
	
	/**
	*	Ajoute un salarié dans le calcul des différents taux R&D
	*/
	private void addSalarie(INNOdepensePersonnel__c salarie){
		
		//Création du département dans la map si il existe pas deja
		if( salarie.Departement__c != null && ! this.tauxRD.containsKey(salarie.Departement__c))
			this.tauxRD.put(salarie.Departement__c, new tauxRDdepartement());

		//ajoute le salarié dans le calcul du taux R&D de tous les départements		
		this.tauxRD.get('all').addSalarie(salarie);
		
		//ajoute le salarié dans le calcul du taux R&D de son département
		if(salarie.Departement__c != null)
			this.tauxRD.get(salarie.Departement__c).addSalarie(salarie);
	}
	
	
	
	
	/**
	*	Permet de calculer le taux R&D d'un département selon différentes méthodes de calcul
	*/
	public class tauxRDdepartement{
		private Decimal nombreSalariesOpt1 = 0;
		private Decimal nombreSalariesOpt2 = 0;
		private Decimal nombreSalariesOpt3 = 0;
		private Decimal heuresRDopt1 = 0;
		private Decimal heuresRDopt2 = 0;
		private Decimal heuresRDopt3 = 0;
		private Decimal tauxRDopt1 = 0;
		private Decimal tauxRDopt2 = 0;
		private Decimal tauxRDopt3 = 0;
		private Decimal totalHeuresOpt1 = 0;
		private Decimal totalHeuresOpt2 = 0;
		private Decimal totalHeuresOpt3 = 0;

		private Decimal moyenneSommesOpt1 = null;		
		private Decimal moyenneSommesOpt2 = null;		
		private Decimal moyenneSommesOpt3 = null;		
		private Decimal sommeMoyennesOpt1 = null;		
		private Decimal sommeMoyennesOpt2 = null;		
		private Decimal sommeMoyennesOpt3 = null;		

		public void addSalarie(INNOdepensePersonnel__c salarie){
			
			
			//Les conditions IF suivantes sont rajoutées depuis le 15/02/2013 pour le pas prendre en compte les salariés à zero
			if(salarie.Montant_RD_option1__c != 0){
				this.heuresRDopt1 += salarie.Heures_RD_option1__c;
				this.tauxRDopt1 += salarie.Taux_RD_option1__c;
				this.totalHeuresOpt1 += (salarie.Total_heures_travaillees_option1__c == null ? 0 : salarie.Total_heures_travaillees_option1__c);
				this.nombreSalariesOpt1 ++;
			}
			
			if(salarie.Montant_RD_option2__c != 0){
				this.heuresRDopt2 += salarie.Heures_RD_option2__c;
				this.tauxRDopt2 += salarie.Taux_RD_option2__c;
				this.totalHeuresOpt2 += (salarie.Total_heures_travaillees_option2__c == null ? 0 : salarie.Total_heures_travaillees_option2__c);
				this.nombreSalariesOpt2 ++;
			}
			
			if(salarie.Montant_RD_option3__c != 0){
				this.heuresRDopt3 += salarie.Heures_RD_option3__c;
				this.tauxRDopt3 += salarie.Taux_RD_option3__c;
				this.totalHeuresOpt3 += (salarie.Total_heures_travaillees_option3__c == null ? 0 : salarie.Total_heures_travaillees_option3__c);
				this.nombreSalariesOpt3 ++;
			}
		}
		
		
		public Decimal getMoyenneSommesOpt1(){
			if(this.moyenneSommesOpt1 == null)
				this.moyenneSommesOpt1 = this.totalHeuresOpt1 == 0 ? 0 : this.heuresRDopt1.divide(this.totalHeuresOpt1, 5) * 100;
			return this.moyenneSommesOpt1;
		}
		
		public Decimal getMoyenneSommesOpt2(){
			if(this.moyenneSommesOpt2 == null)
				this.moyenneSommesOpt2 = this.totalHeuresOpt2 == 0 ? 0 : this.heuresRDopt2.divide(this.totalHeuresOpt2, 5) * 100;
			return this.moyenneSommesOpt2;
		}
		
		public Decimal getMoyenneSommesOpt3(){
			if(this.moyenneSommesOpt3 == null)
				this.moyenneSommesOpt3 = this.totalHeuresOpt3 == 0 ? 0 : this.heuresRDopt3.divide(this.totalHeuresOpt3, 5) * 100;
			return this.moyenneSommesOpt3;
		}
		
		
		
		public Decimal getSommeMoyennesOpt1(){
			if(this.sommeMoyennesOpt1 == null)
				this.sommeMoyennesOpt1 = this.nombreSalariesOpt1 == 0 ? 0 : this.tauxRDopt1.divide(this.nombreSalariesOpt1, 3);
			return this.sommeMoyennesOpt1;
		}
		
		public Decimal getSommeMoyennesOpt2(){
			if(this.sommeMoyennesOpt2 == null){
				this.sommeMoyennesOpt2 = this.nombreSalariesOpt2 == 0 ? 0 : this.tauxRDopt2.divide(this.nombreSalariesOpt2, 3);
			}
			return this.sommeMoyennesOpt2;
		}
		
		public Decimal getSommeMoyennesOpt3(){
			if(this.sommeMoyennesOpt3 == null)
				this.sommeMoyennesOpt3 = this.nombreSalariesOpt3 == 0 ? 0 : this.tauxRDopt3.divide(this.nombreSalariesOpt3, 3);
			return this.sommeMoyennesOpt3;
		}
	}
	
	
	
}