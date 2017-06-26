@isTest
private class INNOplanningTest {


	/**
	 * Tests de la classe INNOtauxOccupationTheoriqueCtrl (+INNOtauxOccupationBase)
	 */
	private static testMethod void testTauxOccupationTheorique() {


		INNOtestBase.initRecords();
		
		
		Date planningStartDate = System.today().toStartOfMonth();
		
		INNOmission__c mission = new INNOmission__c(Contrat__c 									= INNOtestBase.Contracts[0].Id, 
														Annee_CIR__c 							= '2015', 
														Phase__c 								= 'Audit', 
														Taux_cir__c 							= 30, 
														Date_debut_Audit__c						= planningStartDate,
														Date_fin_audit__c					 	= planningStartDate.addMonths(1).addDays(-1),
														Date_debut_valorisation__c				= planningStartDate.addMonths(1),
														Date_fin_valorisation__c				= planningStartDate.addMonths(2).addDays(-1),
														Date_debut_justification__c				= planningStartDate.addMonths(2));
		insert mission;
		
		insert new INNOvalo__c(MissionCIR__c = mission.Id, Entite__c = INNOtestBase.Accs[0].Id, Date_echeance_DT__c = planningStartDate.addMonths(2).addDays(20));											
		
		
		User superviseur = [SELECT Id FROM User WHERE IsActive = true AND UserType = 'Standard' AND UserRole.DeveloperName = 'SCIENTIFIQUE_SUPERVISEUR' LIMIT 1][0];
		
		Integer startMonthIndex = planningStartDate.month() - 1;
		INNOequipeConsulting__c eq = new INNOequipeConsulting__c(MissionCIR__c = mission.Id, Utilisateur__c = superviseur.Id, Role__c = 'Superviseur', Actif__c = true, Nombre_jours_theoriques_Audit__c = INNOtauxOccupationTheoriqueCtrl.nbBusinessDaysInMonth.get('SCIENTIFIQUE_SUPERVISEUR').get(startMonthIndex), Nombre_jours_theoriques_Valorisation__c = INNOtauxOccupationTheoriqueCtrl.nbBusinessDaysInMonth.get('SCIENTIFIQUE_SUPERVISEUR').get(Math.mod(startMonthIndex + 1, 12)), Nombre_jours_theoriques_Justification__c = INNOtauxOccupationTheoriqueCtrl.nbBusinessDaysInMonth.get('SCIENTIFIQUE_SUPERVISEUR').get(Math.mod(startMonthIndex + 2, 12)) / 2);
		insert eq;
		
		//RunAs Admin
		INNOtauxOccupationTheoriqueCtrl ctrl = new INNOtauxOccupationTheoriqueCtrl();
		
		
		//RunAs SCIENTIFIQUE_SUPERVISEUR
		System.runAs(superviseur){
		
			Test.startTest();
			
			ctrl = new INNOtauxOccupationTheoriqueCtrl();
			ctrl.dummyEquipeManager.Utilisateur__c = superviseur.Id;
			ctrl.applyFilters();
			
			ctrl.getHeaderValues();
			ctrl.getThis();
			
			system.debug(ctrl.usersOccupancyRates.size());
		
			system.assertEquals(100, ctrl.usersOccupancyRates[0].occupancyRates[0]);
			system.assertEquals(100, ctrl.usersOccupancyRates[0].occupancyRates[1]);
			system.assertEquals(50, ctrl.usersOccupancyRates[0].occupancyRates[2]);
			
			
			Test.stopTest();
		}
		
	}
	
	
	
	/**
	 * Tests de la classe INNOtauxOccupationReelCtrl (+INNOtauxOccupationBase)
	 * Tests de la classe INNOtimeSheetPlanningCtrl (+INNOtauxOccupationBase)
	 * Tests de la classe INNOtimeSheetPlanningCtrl2 (+INNOtauxOccupationBase)
	 */
	private static testMethod void testTauxOccupationReel() {


		INNOtestBase.initRecords();
		Id missionId = INNOtestBase.missions[0].Id;
		
		User superviseur = [SELECT Id FROM User WHERE IsActive = true AND UserType = 'Standard' AND UserRole.DeveloperName = 'SCIENTIFIQUE_SUPERVISEUR' LIMIT 1][0];
		
		INNOequipeConsulting__c eq = new INNOequipeConsulting__c(MissionCIR__c = missionId, Utilisateur__c = superviseur.Id, Role__c = 'Superviseur', Actif__c = true);
		insert eq;
		
		Date planningStartDate = System.today().toStartOfWeek().addDays(-7);
		
		List<INNOtimeSheet__c> timeSheets = new List<INNOtimeSheet__c>{ new INNOtimeSheet__c(Mission_CIR__c = missionId, Utilisateur__c = superviseur.Id, Date__c = planningStartDate.addDays(0), Duree__c = 1, Phase__c = 'Audit', Theorique__c = false),
																			new INNOtimeSheet__c(Mission_CIR__c = missionId, Utilisateur__c = superviseur.Id, Date__c = planningStartDate.addDays(7), Duree__c = 1, Phase__c = 'Audit', Theorique__c = false),
																			new INNOtimeSheet__c(Mission_CIR__c = missionId, Utilisateur__c = superviseur.Id, Date__c = planningStartDate.addDays(8), Duree__c = 1, Phase__c = 'Audit', Theorique__c = true)};
		insert timeSheets;
		
		
		//RunAs SCIENTIFIQUE_SUPERVISEUR
		System.runAs(superviseur){
		
			Test.startTest();
			
			INNOtauxOccupationReelCtrl ctrl = new INNOtauxOccupationReelCtrl();
			ctrl.dummyEquipeManager.Utilisateur__c = superviseur.Id;
			ctrl.applyFilters();
			
			ctrl.getHeaderValues();
			ctrl.getThis();
			
			system.debug(ctrl.usersOccupancyRates[0].occupancyRates);
			
			System.assertEquals(40, ctrl.usersOccupancyRates[0].occupancyRates[0]);		//Il y a 2j de TimeSheet sur la 1ere semaine => 40%
			
			
			
			INNOtimeSheetPlanningCtrl2 ctrlPlanning2 = new INNOtimeSheetPlanningCtrl2();
			ctrlPlanning2.dummyEquipeManager.Utilisateur__c = superviseur.Id;
			ctrlPlanning2.applyFilters();
			
			//Le 1er jour du 1er consultant est à 1j
			List<INNOtimeSheetPlanningCtrl2.Consultant> consultants = (List<INNOtimeSheetPlanningCtrl2.Consultant>) JSON.deserialize(ctrlPlanning2.consultantsJSON, List<INNOtimeSheetPlanningCtrl2.Consultant>.class);
			List<INNOtimeSheetPlanningCtrl2.Month> months = (List<INNOtimeSheetPlanningCtrl2.Month>) JSON.deserialize(ctrlPlanning2.monthsJSON, List<INNOtimeSheetPlanningCtrl2.Month>.class);
			System.assertEquals(1, consultants[0].durationsByDate.get(months[0].days[0].d));
			
			ctrlPlanning2 = new INNOtimeSheetPlanningCtrl2();
			ctrlPlanning2.dummyEquipeConsultant.MissionCIR__c = missionId;
			ctrlPlanning2.applyFilters();
			
			ctrlPlanning2 = new INNOtimeSheetPlanningCtrl2();
			ctrlPlanning2.dummyEquipeConsultant.Utilisateur__c = superviseur.Id;
			ctrlPlanning2.applyFilters();
			
			Test.stopTest();
		}
		
	}
	
	
	public static testMethod void TestINNOtimeSheetCtrl(){
        
        INNOtestBase.initRecords();
		Id missionId = INNOtestBase.missions[0].Id;

        
        test.startTest();
        Pagereference p = new Pagereference('/apex/AppCIRtimeSheetEdit');
        test.setCurrentPageReference(p);
        
        
        INNOtimeSheetCtrl ctrl = new INNOtimeSheetCtrl();
        
        //Une seule mission où le user courant est actif
        system.assertEquals(1, ctrl.missions.size());
        
        /*
        *   Tests de changements de semaine
        */
        Date lundi = system.today().toStartOfWeek();
        
        system.assertEquals(lundi, ctrl.dates[0]);
        
        p.getParameters().put('way', 'lower');
        ctrl.changeWeek();
        system.assertEquals(lundi.addDays(-7), ctrl.dates[0]);
        
        p.getParameters().put('way', 'upper');
        ctrl.changeWeek();
        system.assertEquals(lundi, ctrl.dates[0]);
        
        p.getParameters().put('way', null);
        p.getParameters().put('day', String.valueOf(lundi.addDays(2)));
        ctrl.changeWeek();
        system.assertEquals(lundi, ctrl.dates[0]);

        system.assertEquals(Integer.valueOf(DateTime.newInstance( lundi, Time.newInstance(12,0,0,0) ).format('w')), ctrl.numeroSemaine);
        
        
        /*
        *   Tests du save
        */
        INNOtimeSheetCtrl.saveTimeSheet(missionId, String.valueOf(lundi) , 'Audit', '0.2');
        INNOtimeSheetCtrl.saveTimeSheet(missionId, String.valueOf(lundi) , 'Audit', '0.2');

        String d = ctrl.dates[0].day() + '/' + ctrl.dates[0].month() + '/' + ctrl.dates[0].year();
        p.getParameters().put('firstDayOfWeekToValidate', d);
        ctrl.validateWeek();
        
        INNOtimeSheet.fillingLastWeekTimeSheetReminder();
	}
	
	public static testMethod void TestINNOtimeSheetHandler(){
        
        INNOtestBase.initRecords();
		Id missionId = INNOtestBase.missions[0].Id;
        User superviseur = [SELECT Id FROM User WHERE IsActive = true AND UserType = 'Standard' AND UserRole.DeveloperName = 'SCIENTIFIQUE_SUPERVISEUR' LIMIT 1][0];
        Date planningStartDate = System.today().toStartOfWeek().addDays(-7);
        
        test.startTest();
        
        List<INNOtimeSheet__c> timeSheets = new List<INNOtimeSheet__c>{ new INNOtimeSheet__c(Mission_CIR__c = missionId, Utilisateur__c = superviseur.Id, Date__c = planningStartDate.addDays(0), Duree__c = 0.5, Phase__c = 'Audit', Theorique__c = false),
																			new INNOtimeSheet__c(Mission_CIR__c = missionId, Utilisateur__c = superviseur.Id, Date__c = planningStartDate.addDays(7), Duree__c = 1, Phase__c = 'Audit', Theorique__c = false),
																			new INNOtimeSheet__c(Mission_CIR__c = missionId, Utilisateur__c = superviseur.Id, Date__c = planningStartDate.addDays(8), Duree__c = 1, Phase__c = 'Audit', Theorique__c = true)};
		insert timeSheets;
		
        timeSheets[0].Duree__c = 1;
        update timeSheets[0];
        delete timeSheets[2];
        
        Test.stopTest();
	}

}