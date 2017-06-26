public with sharing class PortailATctrl {

	public Contact myContact {get; set;}
	
	public String inscriptionSelectedFormation {get; set;}
	public String inscriptionComment {get; set;}
	
	public List<Id> availableMissionIds;
	
	public PortailATctrl(){
		
		this.myContact = [SELECT Id, Contact.Id, Contact.FirstName, Contact.LastName, Contact.Title, Contact.Email, Contact.Account.ATVisibiliteGereeParMission__c FROM User WHERE Id = :UserInfo.getUserId()][0].Contact;


		//Initialise this.availableMissionIds avec la liste des Ids de mission visibles par l'utilisateur
		this.availableMissionIds = new List<Id>();
		
		//Si ATVisibiliteGereeParMission__c est cochée sur le compte : on regarde les missions visibles dans l'objet AppATPartageMissionPortail__c
		if(this.myContact.Account.ATVisibiliteGereeParMission__c)
			for(AppATPartageMissionPortail__c missionShare : [SELECT Id, Mission__c FROM AppATPartageMissionPortail__c WHERE Contact__c = :this.myContact.Id])
				this.availableMissionIds.add(missionShare.Mission__c);
				
		//Sinon on prend toutes les missions du compte (toutes celles visible grâce au "with sharing")
		else
			for(Mission__c m : [SELECT Id FROM Mission__c WHERE RecordType.DeveloperName = 'TAT'])
				this.availableMissionIds.add(m.Id);
		
	}
	

	
	/************************************************************************************/
	/************************************************************************************/
	/*																					*/
	/*								Dossiers salariés									*/
	/*																					*/
	/************************************************************************************/
	/************************************************************************************/
	
	public String getDossiersJSON(){
		return JSON.serialize([SELECT Id, Name, DateSinistre__c, Type__c, Statut__c,MontantEconomieGlobale__c, RecordType.Name, EtablissementConcerne__r.Ville__c, EtablissementConcerne__r.Entite__c FROM AppATdossiersSalaries__c WHERE Mission__c IN :this.availableMissionIds ORDER BY Name]);
	}
	
	
	/************************************************************************************/
	/************************************************************************************/
	/*																					*/
	/*									Etablissements									*/
	/*																					*/
	/************************************************************************************/
	/************************************************************************************/	
	
	public List<AppATetablissement__c> getEtablissements(){
		return [SELECT Id, Ville__c, Entite__c, SIRET__c FROM AppATetablissement__c WHERE Mission__c IN :this.availableMissionIds ORDER BY Ville__c];
	}
	
	
	@RemoteAction
	public static AppATetablissement__c getEtablissementDetails(String etabId){
	
		return [SELECT Id, 
						Ville__c,
						Entite__c, 
						SIRET__c,
						CodeRisque__c,
						AlsaceMoselle__c,
						Etablissement_principal__c,
						(SELECT Id, 
								Name, 
								DateSinistre__c, 
								Type__c, 
								Statut__c,
								MontantEconomieGlobale__c,
								EtablissementConcerne__c, 
								EtablissementConcerne__r.SIRET__c, 
								EtablissementConcerne__r.CodeRisque__c 
							FROM DossiersSalaries__r 
							ORDER BY Name),
						(SELECT Id,
								RecordType.Name,
								CTN__c,
								CTN__r.TypeCTN__c,
								CTN__r.CCMIP1__c,
								CTN__r.CCMIP2__c,
								CTN__r.CCMIP3__c,
								CTN__r.CCMIP4__c,
								CTN__r.CCMIT1__c,
								CTN__r.CCMIT2__c,
								CTN__r.CCMIT3__c,
								CTN__r.CCMIT4__c,
								CTN__r.CCMIT5__c,
								CTN__r.CCMIT6__c
							FROM FeuillesCalcul__r
							WHERE AnneeFeuilleCalcul__c = :String.valueOf(System.today().year()))
					FROM AppATetablissement__c 
					WHERE Id =: etabId];
	}


	@RemoteAction
	public static List<List<Decimal>> getEtablissementChartData(Id etabId){
		
		
		Map<String, List<Decimal>> dataMap = new Map<String, List<Decimal>>();
		List<Decimal> tempTaux;
		List<String> years = new List<String>();
		for(AppATfeuilleCalcul__c fc : [SELECT Id, AnneeFeuilleCalcul__c, Type_de_feuille_de_calcul__c, TauxApplicable__c, TauxCollectif__c FROM AppATfeuilleCalcul__c WHERE EtablissementConcerne__c = :etabId AND Type_de_feuille_de_calcul__c IN ('Initiale', 'Rectifiée', 'Refacturation') ORDER BY AnneeFeuilleCalcul__c, LastModifiedDate]){
			
			
			tempTaux = dataMap.get(fc.AnneeFeuilleCalcul__c);
			if(tempTaux == null){
				tempTaux = new List<Decimal>{0, 0, 0, 0};
				dataMap.put(fc.AnneeFeuilleCalcul__c, tempTaux);
				years.add(fc.AnneeFeuilleCalcul__c);
			}
			
			if(fc.Type_de_feuille_de_calcul__c == 'Initiale' && tempTaux[0] == 0){
				tempTaux[0] = fc.TauxApplicable__c;
				tempTaux[3] = fc.TauxCollectif__c;
			}
			else if(fc.Type_de_feuille_de_calcul__c == 'Rectifiée')
				tempTaux[1] = fc.TauxApplicable__c;
			else if(fc.Type_de_feuille_de_calcul__c == 'Refacturation')
				tempTaux[2] = fc.TauxApplicable__c;
		}
		
		
		// for(AggregateResult aggr : [SELECT AnneeFeuilleCalcul__c annee, Type_de_feuille_de_calcul__c type, SUM(TauxNetArrondi__c) taux FROM AppATfeuilleCalcul__c WHERE EtablissementConcerne__c = :etabId AND Type_de_feuille_de_calcul__c IN('Initiale', 'Rectifiée') GROUP BY AnneeFeuilleCalcul__c, Type_de_feuille_de_calcul__c]){
		// 	dataMap.get((String) aggr.get('annee'))[aggr.get('type') == 'Initiale' ? 0 : 1] = (Decimal) aggr.get('taux');
		// }
		
		List<List<Decimal>> data = new List<List<Decimal>>();
		
		for(String year : years){
			data.add(new List<Decimal>{Decimal.valueOf(year), dataMap.get(year)[0], dataMap.get(year)[0], dataMap.get(year)[1], dataMap.get(year)[1], dataMap.get(year)[2], dataMap.get(year)[2], dataMap.get(year)[3], dataMap.get(year)[3]});
		}
		
		system.debug(data);
		
		return data;
	}
	
	
	

	/************************************************************************************/
	/************************************************************************************/
	/*																					*/
	/*										Factures									*/
	/*																					*/
	/************************************************************************************/
	/************************************************************************************/	
		
	
	public List<Prevision_de_facturation__c> getPrevisionsFactures(){
		return [SELECT Id, 
						Name, 
						Dossier_salarie__c, 
						Etablissement__c,
						Etablissement__r.Ville__c,
						Etablissement__r.Entite__c,
						Motif_attente_facturation__c, 
						Prevision_HT__c, 
						Date_prevue__c, 
						Periode_debut__c, 
						Periode_fin__c 
					FROM Prevision_de_facturation__c 
					WHERE Statut__c = 'Prévue' 
						AND Prevision_HT__c > 0 
						AND Motif_attente_facturation__c IN ('Prêt à facturer', 'Attente rectification des taux') 
						AND Date_prevue__c <= NEXT_YEAR 
						AND Mission__c IN :this.availableMissionIds
					ORDER BY Date_prevue__c];
	}

	public List<Facture__c> getFactures(){
		return [SELECT Id, 
						Name, 
						Montant_HT__c, 
						Montant_TTC__c, 
						Date_envoi__c, 
						Echeance__c,
						(SELECT Id,
								Description__c
							FROM Details_facture__r
							ORDER BY Ordre__c),
						(SELECT Id,
								Etablissement__c,
								Etablissement__r.Ville__c,
								Etablissement__r.Entite__c
							FROM Planificiations_de_facturation__r LIMIT 1)
					FROM Facture__c 
					WHERE (Statut__c = 'Envoyée'
							OR Statut__c = 'Validée')
						AND Mission__c IN :this.availableMissionIds
					ORDER BY Echeance__c DESC];
	}
	
	
	
		
	/************************************************************************************/
	/************************************************************************************/
	/*																					*/
	/*									Formations										*/
	/*																					*/
	/************************************************************************************/
	/************************************************************************************/
	
	public List<AppATdateFormationPortail__c> getDatesFormations(){
		return [SELECT Id, Formation__c, Formation__r.Name, Date__c, VilleFormation__c FROM AppATdateFormationPortail__c WHERE Formation__r.Active__c = true AND Date__c >= TODAY ORDER BY Date__c];
	}
	
	
	public List<AppATformationPortail__c> getFormations(){
		return [SELECT Id, Name, Programme__c, (SELECT Id, Date__c, Horaires__c, Lieu__c,VilleFormation__c FROM DatesFormationPortail__r WHERE Date__c >= TODAY) FROM AppATformationPortail__c WHERE Active__c = true];
	}
	
	
	
	public void sendInscriptionEmail(){
		
		AppATdateFormationPortail__c formation;
		if(String.isNotBlank(this.inscriptionSelectedFormation)){
			formation = [SELECT Id, Formation__r.Name, Formation__r.EmailReceptionInscriptions__c, Date__c, Horaires__c, Lieu__c FROM AppATdateFormationPortail__c WHERE Id = :this.inscriptionSelectedFormation][0];
		}
		else
			formation = [SELECT Id, Formation__r.EmailReceptionInscriptions__c FROM AppATdateFormationPortail__c ORDER BY CreatedDate DESC LIMIT 1][0];
		
		
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(new List<String>{formation.Formation__r.EmailReceptionInscriptions__c}); 
		mail.setSubject('Nouvelle inscription à une formation depuis le Portail AT');
		
		String mailBody = '--- Stagiaire ---\n' + 
							myContact.FirstName + ' ' + myContact.LastName + '\n' + 
							myContact.Email + '\n' + 
							myContact.Title + '\n\n';
		
		if(String.isNotBlank(this.inscriptionSelectedFormation)){
			mailBody += '--- Formation ---\n' + 
						formation.Formation__r.Name + '\n' + 
						formation.Date__c.format() + ' ' + formation.Horaires__c + '\n' + 
						formation.Lieu__c + '\n\n';
		}
		
		mailBody += '--- Commentaires ---\n' + 
					this.inscriptionComment;
		
		mail.setPlainTextBody(mailBody);
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Votre demande à bien été prise en compte, vous serez contacter prochainement pour confirmer votre inscription.'));
	}
	
	
		
		
	/************************************************************************************/
	/************************************************************************************/
	/*																					*/
	/*								Espace documents										*/
	/*																					*/
	/************************************************************************************/
	/************************************************************************************/
	
	public List<List<AppATespaceDocument__c>> getDocuments(){
		
		Map<String, List<AppATespaceDocument__c>> docsByCategory = new Map<String, List<AppATespaceDocument__c>>();
		
		String category;
		List<AppATespaceDocument__c> tempDocs;
		for(AppATespaceDocument__c doc : [SELECT Id, Name, LienSite__c, Description__c, Categorie__c, (SELECT Id, Name FROM Attachments ORDER BY CreatedDate DESC LIMIT 1) FROM AppATespaceDocument__c WHERE Actif__c = true ORDER BY Categorie__c, Name]){

			category = (String.isBlank(doc.Categorie__c) ? 'Autres' : doc.Categorie__c);
			tempDocs = docsByCategory.get(category);
			if(tempDocs == null){
				tempDocs = new List<AppATespaceDocument__c>();
				docsByCategory.put(category, tempDocs);
			}
			tempDocs.add(doc);
		}
		
		List<List<AppATespaceDocument__c>> docsByCategoryOrdered = new List<List<AppATespaceDocument__c>>();
		if(docsByCategory.containsKey('Liens utiles'))
			docsByCategoryOrdered.add(docsByCategory.get('Liens utiles'));
		if(docsByCategory.containsKey('Actualités'))
			docsByCategoryOrdered.add(docsByCategory.get('Actualités'));
		if(docsByCategory.containsKey('Nos publications'))
			docsByCategoryOrdered.add(docsByCategory.get('Nos publications'));
		if(docsByCategory.containsKey('Autres'))
			docsByCategoryOrdered.add(docsByCategory.get('Autres'));

		return docsByCategoryOrdered;
	}
}