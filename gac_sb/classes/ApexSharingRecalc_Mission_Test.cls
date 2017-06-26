@isTest
public with sharing class ApexSharingRecalc_Mission_Test {


	public static testMethod void testMissionApexSharingRecalculation() {
		
		
		
	//Insertion de 100 Contracts
    	Account acc = new Account(Name = 'Test 1', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé', Activity__c = 'Biotech, biologie', Date_de_creation_societe__c = system.today().addYears(-1), SIRET__c = '1284621900001', Type_d_etablissement__c = 'Principal');
    	insert acc;

		Id CIRcontractRecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Contract' AND DeveloperName = 'CIR'][0].Id;
		List<Contract> contracts = new List<Contract>();
		for(Integer i = 0; i < 100; i++){
			contracts.add(new Contract( AccountId = acc.Id, Status = 'Non activé', recordTypeId = CIRcontractRecordTypeId, Date_de_reception_du_contrat__c = date.today(), Annees_concernees__c = '2017'));
		}
		insert contracts;

	//Insertion de 100 missions INNO Advance et 100 missions Factu
		Id CIRmissionRecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Mission__c' AND DeveloperName = 'CIR'][0].Id;
		List<INNOmission__c> missionsINNO = new List<INNOmission__c>();
		List<Mission__c> missionsFactu = new List<Mission__c>();
		for(Contract c : contracts){
			missionsINNO.add(new INNOmission__c(Contrat__c = c.Id, Name = c.Annees_concernees__c, Annee_CIR__c = '2017', Taux_CIR__c = 30));
			missionsFactu.add(new Mission__c(Contrat__c = c.Id, Annee_concernee__c = c.Annees_concernees__c, RecordTypeId = CIRmissionRecordTypeId));
		}
		    										
		insert missionsINNO;
		insert missionsFactu;
		
		
	//Insertion des equipes consulting (1 Manager et 1 Consultant extérieur sur chaquune des 100 missions INNO Advance précédemment insérées)
		User manager = [SELECT ID, UserName FROM User WHERE IsActive = true AND UserType = 'Standard' AND Profile.Name = 'FR - Tech - Manager - Inno'][0];
		User consultant = [SELECT ID, UserName FROM User WHERE IsActive = true AND UserType = 'Standard' AND Profile.Name = 'FR - Tech - Consultant - Inno'][0];
		
		List<INNOequipeConsulting__c> equipes = new List<INNOequipeConsulting__c>();
		for(INNOmission__c m : missionsINNO){
			equipes.add(new INNOequipeConsulting__c(MissionCIR__c = m.Id, Role__c = 'Manager', Utilisateur__c = manager.Id, Actif__c = true));
			equipes.add(new INNOequipeConsulting__c(MissionCIR__c = m.Id, Role__c = 'Consultant extérieur', Utilisateur__c = consultant.Id, Actif__c = true));
		}
		insert equipes;
		
		
		
	//Lancement du batch ApexSharingRecalc_Mission
		Test.StartTest();
		
		ApexSharingRecalc_Mission missionApexSharingRecalculation = new ApexSharingRecalc_Mission();
		Database.executeBatch(missionApexSharingRecalculation);
		System.enqueueJob(new ApexSharingRecalc_Mission());
        
		Test.stopTest();
	
	
	//Test du partage des missions Factus par le batch ApexSharingRecalc_Mission	
		List<Mission__Share> missionsFactuShare = [SELECT Id, ParentId, UserOrGroupId, AccessLevel FROM Mission__Share WHERE RowCause = :Schema.Mission__Share.RowCause.INNO_Advance__c];
		
		Boolean managerFound, consultantFound;
		for(Mission__c m : missionsFactu){
			
			managerFound = consultantFound = false;
			
			for(Mission__Share ms : missionsFactuShare){
				if(ms.ParentId == m.Id && ms.UserOrGroupId == manager.Id && ms.AccessLevel == 'Edit')
					managerFound = true;
				else if(ms.ParentId == m.Id && ms.UserOrGroupId == consultant.Id && ms.AccessLevel == 'Read')
					consultantFound = true;
				
				if(managerFound && consultantFound)
					break;
			}
			
			system.assert(managerFound);
			system.assert(consultantFound);
		}
	}
	
	
}