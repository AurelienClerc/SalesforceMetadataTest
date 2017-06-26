public class INNOvalorisationExportCtrl {
    
    public INNOvalo__c valo {get; set;}
    
    public String xmlHeader {get; set;}
	public String dateNowFormated {get; set;}
	public String endfile {get; set;}
	public String endWorksheet {get; set;}
	
	public transient Map<String, String> opts {get; set;}
	public transient List<INNOdepartement__c> departements {get; set;}
	public transient List<INNOprojet__c> projets {get; set;}
	public transient List<INNOdepensePersonnel__c> personnels {get; set;}
	
	//Listes personnels(heures)/personnels(jours) pour l'Export Excel
	public transient List<INNOdepensePersonnel__c> personnelsHeures {get; set;}
	public transient List<INNOdepensePersonnel__c> personnelsJours {get; set;}
	
	//On précalcul une ligne des heures travaillées par une salarié sur un projet car c'est bien plus rapide de le faire en APEX qu'en VF  
	public transient Map<String, String> personnelsProjets {get; set;}
	public transient Map<String, Decimal> personnelsToProjetNoRD {get; set;}
	public transient Map<String, Decimal> personnelsToProjetVeille {get; set;}
	public transient List<INNOamortissement__c> amortissements {get; set;}
	public transient List<INNOdepensePrestation__c> prestations {get; set;}
	public transient Map<String, List<INNOdepensePrestation__c>> prestataires {get; set;}
	public transient List<Integer> prestaPublicCounts {get; set;}
	public transient List<String> prestatairesAgrees {get; set;}
	public transient List<String> prestatairesPublics {get; set;}
	public transient List<INNOsubvention__c> subventions {get; set;}

    public Map<String, Map<String, Decimal>> depensesParTypeEtDepartement {get; set;}
	public Map<String, Map<String, Decimal>> depensesParTypeEtProjet {get; set;}
	public List<String> typesDepenses {get; set;}
    
    public INNOvalorisationExportCtrl(ApexPages.standardController stdCtrl){
       
        if(!Test.isRunningTest())
            stdCtrl.addFields(new List<String>{'Name','RecordType.DeveloperName','Entite__r.Name','MissionCIR__r.Annee_CIR__c','MissionCIR__r.TauxCII__c','MissionCIR__r.Taux_CIR__c','Option_retenue_salarie__c', 'Option_retenue_jeuneDocteur__c', 'Option_retenue_miseDisposition__c', 'Option_retenue_amortissement__c', 'Option_retenue_amortissementBrevet__c', 'Option_retenue_brevetPM__c', 'Option_retenue_brevetDef__c', 'Option_retenue_normalisation__c', 'Option_retenue_brevetAssu__c', 'Option_retenue_veille__c', 'Option_retenue_prestataire_public__c', 'Option_retenue_prestataire_agree__c', 'Option_retenue_subvention__c', 'Option_retenue_avanceRemboursable__c', 'Option_retenue_remboursementAvance__c', 'Option_retenue_honoraires_N1__c', 'Total_salarie_option1__c', 'Total_salarie_option2__c', 'Total_salarie_option3__c', 'Total_jeuneDocteur_option1__c', 'Total_jeuneDocteur_option2__c', 'Total_jeuneDocteur_option3__c', 'Total_miseDisposition_option1__c', 'Total_miseDisposition_option2__c', 'Total_miseDisposition_option3__c', 'Total_amortissement_option1__c', 'Total_amortissement_option2__c', 'Total_amortissement_option3__c', 'Total_brevetPM_option1__c', 'Total_brevetPM_option2__c', 'Total_brevetPM_option3__c', 'Total_brevetDef_option1__c', 'Total_brevetDef_option2__c', 'Total_brevetDef_option3__c', 'Total_brevetDef_option1__c', 'Total_brevetDef_option2__c', 'Total_brevetDef_option3__c', 'Total_amortissementBrevet_option1__c', 'Total_amortissementBrevet_option2__c', 'Total_amortissementBrevet_option3__c', 'Total_normalisation_option1__c', 'Total_normalisation_option2__c', 'Total_normalisation_option3__c', 'Total_brevetAssu_option1__c', 'Total_brevetAssu_option2__c', 'Total_brevetAssu_option3__c', 'Total_veille_option1__c', 'Total_veille_option2__c', 'Total_veille_option3__c', 'Total_prestataire_public_option1__c', 'Total_prestataire_public_option2__c', 'Total_prestataire_public_option3__c', 'Total_prestataire_agree_option1__c', 'Total_prestataire_agree_option2__c', 'Total_prestataire_agree_option3__c', 'Total_subvention_option1__c', 'Total_subvention_option2__c', 'Total_subvention_option3__c', 'Total_avanceRemboursable_option1__c', 'Total_avanceRemboursable_option2__c', 'Total_avanceRemboursable_option3__c', 'Total_remboursementAvance_option1__c', 'Total_remboursementAvance_option2__c', 'Total_remboursementAvance_option3__c', 'Honoraires_N1_a_deduire_option1__c', 'Honoraires_N1_a_deduire_option2__c', 'Honoraires_N1_a_deduire_option3__c', 'Honoraires_N_a_deduire_option1__c', 'Honoraires_N_a_deduire_option2__c', 'Honoraires_N_a_deduire_option3__c', 'Honoraires_N_a_deduire_optionFinaleManue__c','UniteTempsDepensesPersonnel__c'});
       	this.valo = (INNOvalo__c) stdCtrl.getRecord();
	}
	
	public String getFileName(){
		return 'Fichier de valorisation - ' + (this.valo.Entite__r.Name == null ? '' : this.valo.Entite__r.Name.replace(',', ' -')) + ' - ' + (this.valo.RecordType.DeveloperName == 'CII' ? 'CII' : 'CIR') + ' ' + this.valo.MissionCIR__r.Annee_CIR__c + ' - Option ' + (ApexPages.currentPage().getParameters().get('opt') == null ? 'hybride' : ApexPages.currentPage().getParameters().get('opt'));
	}
	
	private Boolean initOptionFiscale(String opt){
		if(opt != '1' && opt != '2' && opt != '3')
			opt = null;
		
		this.opts = new Map<String, String>{
											'salarie' 				=> '',
											'jeuneDocteur'			=> '',
											'miseDisposition' 		=> '',
											'amortissement' 		=> '',
											'brevetPM' 				=> '',
											'brevetDef' 			=> '',
											'amortissementBrevet'	=> '',
											'normalisation' 		=> '',
											'brevetAssu' 			=> '',
											'veille' 				=> '',
											'prestataire_public' 	=> '',
											'prestataire_agree' 	=> '',
											'subvention' 			=> '',
											'avanceRemboursable' 	=> '',
											'remboursementAvance' 	=> '',
											'honoraires_N1'			=> ''
		};
		
		String optTemp;
		for(String k : this.opts.keySet()){
			
			optTemp = (opt == null ? String.valueOf(this.valo.get('Option_retenue_' + k + '__c')) : opt);
			if(optTemp == null){
				return false;
			}
			
			this.opts.put(k, optTemp);
		}
		return true;
	}
	
	public PageReference initDatas(){
	    //Aurélien
	    this.typesDepenses = new List<String>{'Heures', 'Jours','Salariés', 'Jeunes docteurs', 'Mises à disposition', 'Dotations aux amortissements', 'Frais de fonctionnement', 'Prises et maintenances de brevets', 'Défenses de brevets', 'Dotations aux amortissements de brevets', 'Assurances de brevets', 'Normalisations', 'Veilles', 'Organismes publics', 'Organismes agréés', 'Remboursements d\'avances', 'Honoraires ' + this.valo.MissionCIR__r.Annee_CIR__c + ' à déduire', 'Subventions', 'Avances remboursables'};
		
		//Initialise les options fiscales choisies
		if (!this.initOptionFiscale(ApexPages.currentPage().getParameters().get('opt'))){
			PageReference retPage = new Pagereference('/apex/INNOvalorisationRecap');
			retPage.getParameters().put('id', this.valo.Id);
			retPage.getParameters().put('valoId', this.valo.Id);
			retPage.getParameters().put('missingFiscalOption', '1');
			retPage.setRedirect(true);
			return retPage;
		}  
		
		//La page VF n'accepte pas de mettre cette ligne, donc on la met dans une variable
		this.xmlHeader = '<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?>';
		
		this.dateNowFormated = system.now().format('yyyy-MM-dd') + 'T' + system.now().format('HH:mm:ss') + 'Z';
		
		//La page VF ne génére pas cette balise en fin de fichier, donc on la met dans une variable
		this.endfile = '</Workbook>';
		this.endWorksheet = '</Worksheet>';
		
		this.projets = [SELECT Id, Name, Departement__c FROM INNOprojet__c WHERE Valorisation__c = :this.valo.Id AND Type__c = 'projet' ORDER BY Name];
		Map<String, Decimal> depensesParProjet = new Map<String, Decimal>();
		for(INNOprojet__c projet : this.projets){
			depensesParProjet.put(projet.Name, 0);
		}
		depensesParProjet.put('Non Affecté', 0);

		this.depensesParTypeEtProjet = new Map<String, Map<String, Decimal>>{'temps' => depensesParProjet.clone()};
		for(String type : this.typesDepenses){
			this.depensesParTypeEtProjet.put(type, depensesParProjet.clone());
		}
		
		this.departements = [SELECT Id, Name FROM INNOdepartement__c WHERE Entite__c = :this.valo.Entite__c ORDER BY Name];
		Map<String, Decimal> depensesParDepartement = new Map<String, Decimal>();
		for(INNOdepartement__c departement : this.departements){
			depensesParDepartement.put(departement.Name, 0);
		}
		depensesParDepartement.put('Non Affecté', 0);
		
        this.depensesParTypeEtDepartement = new Map<String, Map<String, Decimal>>{'temps' => depensesParDepartement.clone()};
        for(String type : this.typesDepenses){
			this.depensesParTypeEtDepartement.put(type, depensesParDepartement.clone());
		}
		
		//Recupération de toutes les dépenses de personnel
		this.personnels = [SELECT Id, 
									Name, 
									RecordType.DeveloperName, 
									Nom__c, 
									Prenom__c,
									Matricule__c,
									Diplome__c, 
									Fonction__c, 
									Date_entree__c, 
									Date_sortie__c, 
									Departement__r.Name,
									Organisme_normalisation__c,
									Societe_appartenance__c,
									Salaire_brut_annuel_option1__c, 
									Salaire_brut_annuel_option2__c, 
									Salaire_brut_annuel_option3__c, 
									Interessement_option1__c,
									Interessement_option2__c,
									Interessement_option3__c,
									Participation_option1__c,
									Participation_option2__c,
									Participation_option3__c,
									Salaire_charge_option1__c, 
									Salaire_charge_option2__c, 
									Salaire_charge_option3__c, 
									Heures_RD_option1__c, 
									Heures_RD_option2__c, 
									Heures_RD_option3__c, 
									Total_heures_travaillees_option1__c, 
									Total_heures_travaillees_option2__c, 
									Total_heures_travaillees_option3__c, 
									Heures_normalisation_option1__c, 
									Heures_normalisation_option2__c, 
									Heures_normalisation_option3__c,
									Heures_veille_option1__c,
									Heures_veille_option2__c,
									Heures_veille_option3__c,
									Heures_brevetPM_option1__c,
									Heures_brevetPM_option2__c,
									Heures_brevetPM_option3__c
							FROM INNOdepensePersonnel__c 
							WHERE Valorisation__c = :this.valo.Id 
									AND Actif__c = true 
							ORDER BY Nom__c];
		
		//On alimente les listes personnelsHeures et personnelsJours
		List<Id> personnelsHeuresTemp = new List<Id>();
		for(INNOpersonnelToProjet__c ptp : [SELECT Id, Depense_de_personnel__c, UniteTempsDepensesPersonnel2__c FROM INNOpersonnelToProjet__c WHERE UniteTempsDepensesPersonnel2__c = 'Heures' AND Depense_de_personnel__c IN :personnels]){
		    personnelsHeuresTemp.add(ptp.Depense_de_personnel__c);
		}
		List<Id> personnelsJoursTemp = new List<Id>();
		for(INNOpersonnelToProjet__c ptp : [SELECT Id, Depense_de_personnel__c, UniteTempsDepensesPersonnel2__c FROM INNOpersonnelToProjet__c WHERE UniteTempsDepensesPersonnel2__c = 'Jours' AND Depense_de_personnel__c IN :personnels]){
		    personnelsJoursTemp.add(ptp.Depense_de_personnel__c);
		}
		
		personnelsHeures = [SELECT Id, Name, RecordType.DeveloperName, Nom__c, Prenom__c,Matricule__c,Diplome__c, Fonction__c, Date_entree__c, Date_sortie__c, Departement__r.Name,Organisme_normalisation__c,Societe_appartenance__c,Salaire_brut_annuel_option1__c, Salaire_brut_annuel_option2__c, Salaire_brut_annuel_option3__c, Interessement_option1__c,Interessement_option2__c,Interessement_option3__c,Participation_option1__c,Participation_option2__c,Participation_option3__c,Salaire_charge_option1__c, Salaire_charge_option2__c, Salaire_charge_option3__c, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c, Total_heures_travaillees_option1__c, Total_heures_travaillees_option2__c, Total_heures_travaillees_option3__c, Heures_normalisation_option1__c, Heures_normalisation_option2__c, Heures_normalisation_option3__c,Heures_veille_option1__c,Heures_veille_option2__c,Heures_veille_option3__c,Heures_brevetPM_option1__c,Heures_brevetPM_option2__c,Heures_brevetPM_option3__c FROM INNOdepensePersonnel__c WHERE Id IN :personnelsHeuresTemp ORDER BY Nom__c];
		personnelsJours = [SELECT Id, Name, RecordType.DeveloperName, Nom__c, Prenom__c,Matricule__c,Diplome__c, Fonction__c, Date_entree__c, Date_sortie__c, Departement__r.Name,Organisme_normalisation__c,Societe_appartenance__c,Salaire_brut_annuel_option1__c, Salaire_brut_annuel_option2__c, Salaire_brut_annuel_option3__c, Interessement_option1__c,Interessement_option2__c,Interessement_option3__c,Participation_option1__c,Participation_option2__c,Participation_option3__c,Salaire_charge_option1__c, Salaire_charge_option2__c, Salaire_charge_option3__c, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c, Total_heures_travaillees_option1__c, Total_heures_travaillees_option2__c, Total_heures_travaillees_option3__c, Heures_normalisation_option1__c, Heures_normalisation_option2__c, Heures_normalisation_option3__c,Heures_veille_option1__c,Heures_veille_option2__c,Heures_veille_option3__c,Heures_brevetPM_option1__c,Heures_brevetPM_option2__c,Heures_brevetPM_option3__c FROM INNOdepensePersonnel__c WHERE Id IN :personnelsJoursTemp ORDER BY Nom__c];
		
		//Pour compte le nombre d'heures travaillées sur un projet ( pour virer ceux à 0)
		Map<Id, Decimal> projetHeures = new Map<Id, Decimal>();
		Map<Id, Decimal> departementHeures = new Map<Id, Decimal>();
		for (INNOprojet__c p : this.projets){
			projetHeures.put(p.Id , 0);
			departementHeures.put(p.Departement__c , 0);
		}
		
		Map<String, Decimal> personnelsToProjet = new Map<String, Decimal>();
		Decimal h;
		//Récupération des dépenses de personnel to projet //Aurélien
		for(INNOpersonnelToProjet__c pp : [SELECT Id, Name, UniteTempsDepensesPersonnel2__c, Projet__r.Departement__c, Projet__r.Departement__r.Name, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c, Projet__c, Projet__r.Name, Projet__r.Type__c, Montant_RD_retenu_option1__c, Montant_RD_retenu_option2__c, Montant_RD_retenu_option3__c, Depense_de_personnel__c,Depense_de_personnel__r.RecordType.DeveloperName, Depense_de_personnel__r.Departement__r.Name, Depense_de_personnel__r.RecordType.Name FROM INNOpersonnelToProjet__c WHERE Projet__r.Valorisation__c = :this.valo.Id AND Depense_de_personnel__r.Actif__c = true]){
			if(pp.Projet__r.Type__c == 'projet'){
				h = (Decimal) pp.get('Heures_RD_option' + opts.get(pp.Depense_de_personnel__r.RecordType.DeveloperName) + '__c');
				if(h != null && h != 0){
					personnelsToProjet.put(pp.Depense_de_personnel__c + '_' + pp.Projet__c, h);
					projetHeures.put(pp.Projet__c, projetHeures.get(pp.Projet__c) + h);	
					departementHeures.put(pp.Projet__r.Departement__c, departementHeures.get(pp.Projet__r.Departement__c) + h);	
				}
			}
			//Aurélien
			if(pp.UniteTempsDepensesPersonnel2__c != null){
				    this.addDepense(pp.UniteTempsDepensesPersonnel2__c, getProjectName(pp.Projet__r), (Decimal) pp.get('Heures_RD_option' + opts.get(pp.Depense_de_personnel__r.RecordType.DeveloperName) + '__c'));
			}
			this.addDepense(getDepenseProjectType(pp), getProjectName(pp.Projet__r), (Decimal) pp.get('Montant_RD_retenu_option' + opts.get(pp.Depense_de_personnel__r.RecordType.DeveloperName) + '__c'));
			String departement = pp.Projet__r.Name == 'Veille' || pp.Projet__r.Name == 'Normalisation' ? pp.Depense_de_personnel__r.Departement__r.Name : pp.Projet__r.Departement__r.Name;
			//Aurélien
			if(pp.UniteTempsDepensesPersonnel2__c != null){
				    this.addDepenseDepartement(pp.UniteTempsDepensesPersonnel2__c, getDepartementName(departement), (Decimal) pp.get('Heures_RD_option' + opts.get(pp.Depense_de_personnel__r.RecordType.DeveloperName) + '__c'));
			}
			this.addDepenseDepartement(getDepenseProjectType(pp), getDepartementName(departement), (Decimal) pp.get('Montant_RD_retenu_option' + opts.get(pp.Depense_de_personnel__r.RecordType.DeveloperName) + '__c'));
		}
		
		//On supprime les projets qui ont 0 heures
		List<INNOprojet__c> projetsTemp = new List<INNOprojet__c>();
		for (INNOprojet__c p : this.projets){
			if(projetHeures.get(p.Id) != 0){
				projetsTemp.add(p);
			}
		}
		this.projets = projetsTemp;
		
		//On supprime les departements qui ont 0 heures
		List<INNOdepartement__c> departementsTemp = new List<INNOdepartement__c>();
		for (INNOdepartement__c d : this.departements){
			if(departementHeures.get(d.Id) != 0){
				departementsTemp.add(d);
			}
		}
		this.departements = departementsTemp;
		
		this.personnelsProjets = new Map<String, String>();
		String line;
		
		Decimal hours;
        this.personnelsToProjetNoRD = new Map<String, Decimal>();
        this.personnelsToProjetVeille = new Map<String, Decimal>();
		for(INNOdepensePersonnel__c personnel : this.personnels){
			line = '';
			for(INNOprojet__c projet : this.projets){
				line += '<Cell ss:StyleID="integerCenter">' + (personnelsToProjet.containsKey(personnel.Id + '_' + projet.Id) ? '<Data ss:Type="Number">' + personnelsToProjet.get(personnel.Id + '_' + projet.Id) + '</Data>' : '') + '</Cell>';
			}
			this.personnelsProjets.put(personnel.Id, line);
			
            hours = (Decimal) personnel.get('Total_heures_travaillees_option' + opts.get(personnel.RecordType.DeveloperName) + '__c') - (Decimal) personnel.get('Heures_RD_option' + opts.get(personnel.RecordType.DeveloperName) + '__c') - (Decimal) personnel.get('Heures_normalisation_option' + opts.get(personnel.RecordType.DeveloperName) + '__c') - (Decimal) personnel.get('Heures_veille_option' + opts.get(personnel.RecordType.DeveloperName) + '__c');
            this.personnelsToProjetNoRD.put(personnel.Id, hours);
            this.personnelsToProjetVeille.put(personnel.Id, (Decimal) personnel.get('Heures_normalisation_option' + opts.get(personnel.RecordType.DeveloperName) + '__c')+(Decimal) personnel.get('Heures_veille_option' + opts.get(personnel.RecordType.DeveloperName) + '__c'));
		}
		
		//Recupération de toutes les amortissements
		this.amortissements = [SELECT Id, 
										Name, 
										RecordType.DeveloperName, 
										RecordType.Name, 
										Num_immobilisation__c, 
										Projet__r.Name,
										Projet__r.Type__c,
										Departement__r.Name,
										Date_acquisition__c, 
										Montant_acquisition__c, 
										Annuite_amortissement__c, 
										Taux_RD_option1__c, 
										Taux_RD_option2__c, 
										Taux_RD_option3__c, 
										Montant_RD_retenu_option1__c, 
										Montant_RD_retenu_option2__c, 
										Montant_RD_retenu_option3__c 
								FROM INNOamortissement__c 
								WHERE Valorisation__c = :this.valo.Id 
								ORDER BY Name];
		
		for(INNOamortissement__c amo : this.amortissements){
			this.addDepense(amo.RecordType.Name, getProjectName(amo.Projet__r), (Decimal) amo.get('Montant_RD_retenu_option' + opts.get(amo.RecordType.DeveloperName) + '__c'));
			this.addDepenseDepartement(amo.RecordType.Name, getDepartementName(amo.Departement__r.Name), (Decimal) amo.get('Montant_RD_retenu_option' + opts.get(amo.RecordType.DeveloperName) + '__c'));
		}
		
		//Recupération de toutes les dépenses de prestations
		this.prestations = [SELECT Id, 
									Name, 
									RecordType.DeveloperName, 
									RecordType.Name, 
									Prestataire__c, 
									SIREN__c,
									Projet__r.Name,
									Projet__r.Type__c,
									Nature_prestation__c, 
									Departement__r.Name,
									Num_brevet__c, 
									Date_de_depot__c, 
									Date_delivrance__c,
									Date_debut_agrement__c,
									Date_fin_agrement__c,
									Num_piece__c, 
									Date_piece__c,
									Type_organisme__c,
									Lien_de_dependance__c,
									Localisation__c,
									Montant_retenu_option1__c, 
									Montant_retenu_option2__c, 
									Montant_retenu_option3__c 
							FROM INNOdepensePrestation__c 
							WHERE Valorisation__c = :this.valo.Id 
							ORDER BY Prestataire__c];
		

		this.prestatairesPublics = new List<String>{'TOTAL (avec un lien de dépendance) (Double du montant) en France', 
													'TOTAL (avec un lien de dépendance) (Double du montant) à l\'étranger',
													'TOTAL (sans un lien de dépendance) (Double du montant) en France',
													'TOTAL (sans un lien de dépendance) (Double du montant) à l\'étranger'
												};
												
		this.prestatairesAgrees = new List<String>{'TOTAL (avec un lien de dépendance) en France', 
													'TOTAL (avec un lien de dépendance) à l\'étranger',
													'TOTAL (sans un lien de dépendance) en France',
													'TOTAL (sans un lien de dépendance) à l\'étranger'
												};
	
		this.prestataires = new Map<String, List<INNOdepensePrestation__c>>{
																				'TOTAL (avec un lien de dépendance) (Double du montant) en France'=>new List<INNOdepensePrestation__c>(),
																				'TOTAL (avec un lien de dépendance) (Double du montant) à l\'étranger'=>new List<INNOdepensePrestation__c>(),
																				'TOTAL (sans un lien de dépendance) (Double du montant) en France'=>new List<INNOdepensePrestation__c>(),
																				'TOTAL (sans un lien de dépendance) (Double du montant) à l\'étranger'=>new List<INNOdepensePrestation__c>(),
																				'TOTAL (avec un lien de dépendance) en France'=>new List<INNOdepensePrestation__c>(),
																				'TOTAL (avec un lien de dépendance) à l\'étranger'=>new List<INNOdepensePrestation__c>(),
																				'TOTAL (sans un lien de dépendance) en France'=>new List<INNOdepensePrestation__c>(),
																				'TOTAL (sans un lien de dépendance) à l\'étranger'=>new List<INNOdepensePrestation__c>()
				};
		
		String cat;
		List<INNOdepensePrestation__c> tempPrestations;
		
		Decimal amount;
		for(INNOdepensePrestation__c p : this.prestations){
			
			amount = (Decimal) p.get('Montant_retenu_option' + opts.get('prestataire_public') + '__c');
			
			if(p.RecordType.DeveloperName == 'prestataire'){
				cat = '';
				
				if(p.Type_organisme__c == 'Public'){
					
					this.addDepense('Organismes publics', getProjectName(p.Projet__r), amount);
                    this.addDepenseDepartement('Organismes publics', getDepartementName(p.Departement__r.Name), amount);
                    
					if(amount != 0){
					
						if(p.Lien_de_dependance__c == 'Avec'){
							if(p.Localisation__c == 'En France')
								cat = 'TOTAL (avec un lien de dépendance) (Double du montant) en France';
							else
								cat = 'TOTAL (avec un lien de dépendance) (Double du montant) à l\'étranger';
						}
						else{
							if(p.Localisation__c == 'En France')
								cat = 'TOTAL (sans un lien de dépendance) (Double du montant) en France';
							else
								cat = 'TOTAL (sans un lien de dépendance) (Double du montant) à l\'étranger';
						}
					}
				}
				else{
					
					this.addDepense('Organismes agréés', getProjectName(p.Projet__r), amount);
                    this.addDepenseDepartement('Organismes agréés', getDepartementName(p.Departement__r.Name), amount);
                    
					if(amount != 0){
					
						if(p.Lien_de_dependance__c == 'Avec'){
							if(p.Localisation__c == 'En France')
								cat = 'TOTAL (avec un lien de dépendance) en France';
							else
								cat = 'TOTAL (avec un lien de dépendance) à l\'étranger';
						}
						else{
							if(p.Localisation__c == 'En France')
								cat = 'TOTAL (sans un lien de dépendance) en France';
							else
								cat = 'TOTAL (sans un lien de dépendance) à l\'étranger';
						}
					}
				}
				
				if(cat != ''){
					tempPrestations = this.prestataires.get(cat);
					tempPrestations.add(p);
					this.prestataires.put(cat, tempPrestations);
				}
			}

			else{
				this.addDepense(p.RecordType.Name, getProjectName(p.Projet__r), amount);
				this.addDepenseDepartement(p.RecordType.Name, getDepartementName(p.Departement__r.Name), amount);
			}
		}
		
		this.prestaPublicCounts = new List<Integer>();
		
		
		for(String s : this.prestatairesPublics){
			this.prestaPublicCounts.add(this.prestataires.get(s).size());
		}
		
		//Recupération de toutes les subventions
		this.subventions = [SELECT Id, 
									Name, 
									RecordType.DeveloperName, 
									RecordType.Name, 
									Organisme__c, 
									Projet__r.Name,
									Projet__r.Type__c,
									Nature__c, 
									Departement__r.Name,
									Date_versement__c, 
									Montant_option1__c, 
									Montant_option2__c, 
									Montant_option3__c
							FROM INNOsubvention__c
							WHERE Valorisation__c = :this.valo.Id 
							ORDER BY Organisme__c];
							
		for(INNOsubvention__c subv : this.subventions){
			this.addDepense(subv.RecordType.Name, getProjectName(subv.Projet__r), (Decimal) subv.get('Montant_option' + opts.get(subv.RecordType.DeveloperName) + '__c'));
			this.addDepenseDepartement(subv.RecordType.Name, getDepartementName(subv.Departement__r.Name), (Decimal) subv.get('Montant_option' + opts.get(subv.RecordType.DeveloperName) + '__c'));
		}

		String opt = (String.isBlank(ApexPages.currentPage().getParameters().get('opt')) ? 'FinaleManue' : ApexPages.currentPage().getParameters().get('opt'));
		this.addDepense('Honoraires ' + this.valo.MissionCIR__r.Annee_CIR__c + ' à déduire', 'Non Affecté' , (Decimal) this.valo.get('Honoraires_N_a_deduire_option' + opt + '__c'));
		this.addDepenseDepartement('Honoraires ' + this.valo.MissionCIR__r.Annee_CIR__c + ' à déduire', 'Non Affecté' , (Decimal) this.valo.get('Honoraires_N_a_deduire_option' + opt + '__c'));
		return null;
	}
	
	private static String getProjectName(INNOprojet__c project){
		return (project == null || String.isBlank(project.Name) || project.Type__c != 'projet' ? 'Non Affecté' : project.Name);
	}
	private static String getDepartementName(String dep){
		return (dep == null ? 'Non Affecté' : dep);
	}

	private void addDepense(String type, String project, Decimal amount){
		if(amount != null)
			this.depensesParTypeEtProjet.get(type).put(project, this.depensesParTypeEtProjet.get(type).get(project) + amount);
	}
    private void addDepenseDepartement(String type, String departement, Decimal amount){
       	if(amount != null)
			this.depensesParTypeEtDepartement.get(type).put(departement, this.depensesParTypeEtDepartement.get(type).get(departement) + amount);
	}

	private static String getDepenseProjectType(INNOpersonnelToProjet__c pp){
		if(pp.Projet__r.Type__c == 'normalisation')
			return 'Normalisations';
		else if(pp.Projet__r.Type__c == 'brevetPM')
			return 'Prises et maintenances de brevets';
		else if(pp.Projet__r.Type__c == 'veille')
			return 'Veilles';
		else
			return pp.Depense_de_personnel__r.RecordType.Name;
	}
}