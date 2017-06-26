@isTest
private class PortailATctrl_Test {

	private static testMethod void test() {
		
		Account acc = new Account(Name = 'Synefo');
		insert acc;
		
		Contact cont = new Contact(LastName = 'weber', AccountId = acc.Id);
		insert cont;
		
		Mission__c mission = new Mission__c(Name = 'Synefo', Compte__c = acc.Id, RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Mission__c' AND DeveloperName = 'TAT'][0].Id);
		insert mission;
		
		AppATetablissement__c etab = new AppATetablissement__c(Name = 'Synefo', Mission__c = mission.Id, SIRET__c = '12345678912345');
		insert etab;
		
		AppATdossiersSalaries__c dossier = new AppATdossiersSalaries__c(Name = 'Weber', Nom__c = 'Weber', Mission__c = mission.Id, EtablissementConcerne__c = etab.Id);
		insert dossier;
		
		insert new Prevision_de_facturation__c(Mission__c = mission.Id, Statut__c = 'Prévue', Prevision_HT__c = 1000, Motif_attente_facturation__c = 'Prêt à facturer', Date_prevue__c = System.today());
		
		insert new Facture__c(Mission__c = mission.Id, Montant_HT__c = 2000, Statut__c = 'Envoyée');
		
		AppATformationPortail__c formation = new AppATformationPortail__c(Name = 'Portail AT', Active__c = true);
		insert formation;
		
		AppATdateFormationPortail__c dateFormation = new AppATdateFormationPortail__c(Formation__c = formation.Id, Date__c = System.today(), Lieu__c = 'Synefo', CodePostalFormation__c = '92310', RueFormation__c='1 avenue de la cristalerie' , VilleFormation__c='Sèvres');
		insert dateFormation; 
		
		insert new AppATespaceDocument__c(Name = 'Synefo', LienSite__c = 'www.synefo.fr');
		
		User portalUser = new User(Alias = 'weber', Email = 'tweber@synefo.fr', EmailEncodingKey = 'UTF-8', ContactId = cont.Id, LastName = 'Weber', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = [SELECT Id FROM Profile WHERE Name = 'ZZ - EXT - Portail AT'][0].Id, TimeZoneSidKey = 'Europe/Paris', UserName = 'tweber@synefo.fr');
		
		
		
		Test.startTest();
		
		System.runAs(portalUser){
			
			PortailATctrl ctrl = new PortailATctrl();
			
			System.assertEquals(ctrl.myContact.Id, cont.Id);
			
			System.assert(ctrl.getDossiersJSON().contains(dossier.Id));
			
			System.assertEquals(1, ctrl.getEtablissements().size());
			
			System.assertEquals(etab.Id, PortailATctrl.getEtablissementDetails(etab.Id).Id);
			
			PortailATctrl.getEtablissementChartData(etab.Id);
			
			System.assertEquals(1, ctrl.getPrevisionsFactures().size());
			
			System.assertEquals(1, ctrl.getFactures().size());
			
			System.assertEquals(1, ctrl.getDatesFormations().size());
			
			System.assertEquals(1, ctrl.getFormations().size());
			
			ctrl.inscriptionSelectedFormation = dateFormation.Id;
			ctrl.sendInscriptionEmail();
			
			System.assertEquals(1, ctrl.getDocuments().size());
			
		}
		
		Test.stopTest();
	}

}