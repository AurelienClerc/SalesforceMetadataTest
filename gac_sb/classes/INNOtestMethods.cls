@isTest
private class INNOtestMethods {

	public static testmethod void TestINNOamortissementCtrl(){
		
		INNOtestBase.initRecords();
		
		
		INNOamortissement__c a = new INNOamortissement__c(
															Name						=			'test_name',
															Annuite_amortissement__c	=			10000,
															Num_immobilisation__c		=			'test_num_immo',
															Valorisation__c				=			INNOtestBase.valos.get(0).Id);
		insert a;
		
		PageReference p = new pageReference( '/apex/INNOamortissementList' );
		Test.setCurrentPage(p);
		Test.startTest();
		
		// Si page différent de AppCIRamortissementEdit
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(a);
		INNOamortissementCtrl ctrl = new INNOamortissementCtrl(stdCtrl);

		p = new pageReference( '/apex/INNOamortissementEdit' );
		
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('valoId', INNOtestBase.valos.get(0).Id);
		System.currentPageReference().getParameters().put('tab', 'amortissementBrevet');
		
		// Record existant
		stdCtrl = new ApexPages.StandardController(a);
		ctrl = new INNOamortissementCtrl(stdCtrl);
		
		ctrl.save();
		ctrl.deleteAndRedirect();
		
		// Nouveau record
		ApexPages.StandardController stdCtrl2 = new ApexPages.StandardController(new INNOamortissement__c());
		INNOamortissementCtrl ctrl2 = new INNOamortissementCtrl(stdCtrl2);
		
		ctrl2.save();
			
		Test.stopTest();
	}
	

	public static testmethod void TestINNOamortissementListCtrl(){
		
		INNOtestBase.initRecords();
		INNOamortissement__c a = new INNOamortissement__c(
							Name						=			'test_name',
							Annuite_amortissement__c	=			10000,
							Num_immobilisation__c		=			'test_num_immo',
							Valorisation__c				=			INNOtestBase.valos.get(0).Id,
							Methode_de_calcul__c		=			'manuelle');
		insert a;
		
		PageReference p = new pageReference( '/apex/INNOamortissementTauxRD' );
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('id', a.Valorisation__c);
		System.currentPageReference().getParameters().put('valoId', a.Valorisation__c);
		System.currentPageReference().getParameters().put('amortissementId', a.Id);
		Test.startTest();
		  
		INNOamortissementListCtrl ctrl = new INNOamortissementListCtrl(new ApexPages.StandardController(INNOtestBase.valos[0]));

		ctrl.saveMethodeCalculTauxRD();
		
		Test.stopTest();
	}
	
	
	static testmethod void TestINNOamortissementUtils(){ 
		
		
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos.get(0).Id;
		
		INNOdepartement__c d = new INNOdepartement__c(
												Name						=			'test',
												Entite__c					=			INNOtestBase.Accs[0].Id);
		insert d;
		
		Test.startTest();
		
		

		Id salarieRtId = [Select Id From RecordType r Where SobjectType = 'INNOdepensePersonnel__c' And DeveloperName = 'salarie' LIMIT 1][0].Id;
		
		INNOdepensePersonnel__c[] dps = new List<INNOdepensePersonnel__c>{
												new INNOdepensePersonnel__c(
																Name						=			'test',
																Nom__c						=			'test_nom',
																Prenom__c					=			'test_prenom',
																//Salaire_brut_annuel__c		=			100000,
																Departement__c				=			d.Id,
																Actif__c 					=			true,
																Salaire_charge_option1__c	=			100000,
																Total_heures_travaillees_option1__c = 	100,
																Valorisation__c				=			valoId,
																RecordTypeId				=			salarieRtId),
												new INNOdepensePersonnel__c(
																Name						=			'test2',
																Nom__c						=			'test_nom2',
																Prenom__c					=			'test_prenom2',
																//Salaire_brut_annuel__c		=			50000,
																Departement__c				=			d.Id,
																Actif__c 					=			true,
																Salaire_charge_option1__c	=			50000,
																Total_heures_travaillees_option1__c = 	100,
																Valorisation__c				=			valoId,
																RecordTypeId				=			salarieRtId),
												new INNOdepensePersonnel__c(
																Name						=			'test3',
																Nom__c						=			'test_nom3',
																Prenom__c					=			'test_prenom3',
																//Salaire_brut_annuel__c		=			200000,
																Actif__c 					=			true,
																Salaire_charge_option1__c	=			200000,
																Total_heures_travaillees_option1__c = 	200,
																Valorisation__c				=			valoId,
																RecordTypeId				=			salarieRtId)
													};
		insert dps;
		
		INNOprojet__c pr = new INNOprojet__c(
							Name						=			'test',
							Num_projet__c				=			'2',
							Type__c						=			'projet',
							Valorisation__c				=			valoId);
		insert pr;
		
		INNOpersonnelToProjet__c[] ptps = new List<INNOpersonnelToProjet__c>{
												new INNOpersonnelToProjet__c(
														Depense_de_personnel__c		=			dps[0].Id,
														Projet__c					=			pr.Id,
														Heures_RD_option1__c		=			50,
														Type_projet__c				=			'projet'),
												new INNOpersonnelToProjet__c(
														Depense_de_personnel__c		=			dps[1].Id,
														Projet__c					=			pr.Id,
														Heures_RD_option1__c		=			80,
														Type_projet__c				=			'projet'),
												new INNOpersonnelToProjet__c(
														Depense_de_personnel__c		=			dps[2].Id,
														Projet__c					=			pr.Id,
														Heures_RD_option1__c		=			20,
														Type_projet__c				=			'projet')
											};
		insert ptps;
		
		
		
		INNOamortissementUtils amoUtils = new INNOamortissementUtils(valoId);
		
		
		
		System.assertEquals(amoUtils.TauxRD.get(null).getSommeMoyennesOpt1(), 0);
		System.assertEquals(amoUtils.TauxRD.get('').getSommeMoyennesOpt1(), 0);

		Id amoRtId = [Select Id From RecordType r Where SobjectType = 'INNOamortissement__c' And DeveloperName = 'amortissement' LIMIT 1][0].Id;
		INNOamortissement__c amo = new INNOamortissement__c(Name = 'test',
																Valorisation__c = valoId,
																Num_immobilisation__c = '12',
																Annuite_amortissement__c = 1000,
																Methode_de_calcul__c = 'Manuelle',
																Taux_RD_option1__c = 50,
																Departement__c = d.Id,
																RecordTypeId = amoRtId);
													
		insert amo;
		
		amoUtils.refreshTauxRD(amo);
		
		System.assertEquals(50, amo.Taux_RD_option1__c);
		System.assertEquals(0, amoUtils.TauxRD.get('').getSommeMoyennesOpt1());
		
		
		amo.Methode_de_calcul__c = 'Moyenne des sommes';
		amoUtils.refreshTauxRD(amo);
		System.assertEquals(37.5, amo.Taux_RD_option1__c);
		
		amo.Methode_de_calcul__c = 'Somme des moyennes';
		amoUtils.refreshTauxRD(amo);
		System.assertEquals(46.667, amo.Taux_RD_option1__c);
		
		amo.Methode_de_calcul__c = 'Moyenne des sommes du département';
		amoUtils.refreshTauxRD(amo);
		System.assertEquals(65, amo.Taux_RD_option1__c);
		
		amo.Methode_de_calcul__c = 'Somme des moyennes du département';
		amoUtils.refreshTauxRD(amo);
		System.assertEquals(65, amo.Taux_RD_option1__c);
		
		
		Test.stopTest();
		
	}
	
	
	
	
        
   public static testmethod void TestINNOmissionCtrl(){
		
		INNOtestBase.initRecords();
		
		PageReference p = new pageReference( '/apex/INNOmissionView' );
		p.getParameters().put('id', INNOtestBase.missions[0].Id);
		Test.setCurrentPage(p);
		Test.startTest();
		
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(INNOtestBase.missions[0]);
		INNOmissionCtrl ctrl = new INNOmissionCtrl(stdCtrl);
		ctrl.checkParams();
        p.getParameters().put('missionId', INNOtestBase.missions[0].Id);
        Test.setCurrentPage(p);
        
        ctrl = new INNOmissionCtrl(stdCtrl);
		ctrl.getContrat();
		ctrl.getMissionsSoeurs();
		
		INNOmissionTemplateCtrl templateCtrl = new INNOmissionTemplateCtrl();
		
		System.assertEquals(1, templateCtrl.getValos().size());
		
        Test.setCurrentPage(p);
		INNOmissionCtrl_withoutSharing missionCtrl_withoutSharing = new INNOmissionCtrl_withoutSharing(stdCtrl);
		
		
		
		p.getParameters().put('id', INNOtestBase.valos[0].Id);
		stdCtrl = new ApexPages.StandardController(INNOtestBase.valos[0]);
		INNOvalorisationCtrl valoCtrl = new INNOvalorisationCtrl(stdCtrl);
		valoCtrl.checkParams();
		p.getParameters().put('valoId', INNOtestBase.valos[0].Id);
		valoCtrl.deleteValo();
		
		
		missionCtrl_withoutSharing.deleteMission();
		System.assertEquals(0, [SELECT Id FROM INNOmission__c WHERE Id = :INNOtestBase.missions[0].Id].size());
		
		Test.stopTest();
    }
	
	
	public static testmethod void TestINNOcommentaireMissionCtrl(){
		
		INNOtestBase.initRecords();
					
		PageReference p = new pageReference( '/apex/INNOamortissementList' );
		p.getParameters().put('valoId', INNOtestBase.valos[0].Id);
		p.getParameters().put('tab', 'amortissement');
		Test.setCurrentPage(p);
		Test.startTest();
		
		INNOcommentaireValoCtrl ctrl = new INNOcommentaireValoCtrl();
		ctrl.valo.Commentaires_amortissement__c = 'test';
		ctrl.saveComment();
		
		System.assertEquals('test', [SELECT Id, Commentaires_amortissement__c FROM INNOvalo__c][0].Commentaires_amortissement__c);
		
		Test.stopTest();
	}
	
	
    public static testmethod void TestINNOmissionCreateCtrl(){
	
		INNOtestBase.initRecords();
					
		
		
		PageReference p = new pageReference( '/apex/INNOcreateMission' );
		p.getParameters().put('id', INNOtestBase.Contracts[0].id);
		Test.setCurrentPage(p);
		Test.startTest();
		
		INNOmissionCreateCtrl ctrl = new INNOmissionCreateCtrl();
		ctrl.contrat.Annees_concernees__c = '2018';
		ctrl.selectedEntites.add(INNOtestBase.Accs[0].Id);
		ctrl.consultants[0].utilisateur__c = Userinfo.getUserId();
		ctrl.saveMission();
		
		System.assertEquals(2, [SELECT COUNT() FROM INNOmission__c]);	//2018 + 2017 dans INNOtestBase.initRecords()
		System.assertEquals(2, [SELECT COUNT() FROM INNOvalo__c]);
		System.assertEquals(1, [SELECT COUNT() FROM Mission__c]);

		Test.stopTest();
	}
	
		
	public static testmethod void TestINNOdepensePersonnelCtrl(){
		
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		INNOdepartement__c d = new INNOdepartement__c(
											Name						=			'test',
											Entite__c					=			INNOtestBase.Accs[0].Id);
		insert d;

		INNOdepensePersonnel__c dp = new INNOdepensePersonnel__c(
							Name						=			'test',
							Nom__c						=			'test_nom',
							Prenom__c					=			'test_prenom',
							//Salaire_brut_annuel__c		=			100000,
							Departement__c				=			d.Id,
							Valorisation__c				=			valoId);
		insert dp;
		
		INNOprojet__c pr = new INNOprojet__c(
							Name						=			'test',
							Num_projet__c				=			'2',
							Valorisation__c				=			valoId,
							Type__c						=			'Projet');
		insert pr;
		
		INNOpersonnelToProjet__c ptp = new INNOpersonnelToProjet__c(
							Depense_de_personnel__c		=			dp.Id,
							Projet__c					=			pr.Id);
		insert ptp;
		
		PageReference p = new pageReference( '/apex/INNOdepensePersonnelEdit' );
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('valoId', valoId);
		Test.startTest();
		
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(dp);
		INNOdepensePersonnelCtrl ctrl = new INNOdepensePersonnelCtrl(stdCtrl);

		ctrl.savePersonnelEtHeuresTravaillees();
		ctrl.deleteAndRedirect();

		System.currentPageReference().getParameters().put('tab', 'salarie');
		// NOUVEAU record
		ApexPages.StandardController stdCtrl2 = new ApexPages.StandardController(new INNOdepensePersonnel__c(
							Name						=			'test',
							Nom__c						=			'test_nom',
							Prenom__c					=			'test_prenom',
							//Salaire_brut_annuel__c		=			100000,
							Departement__c				=			d.Id,
							Valorisation__c				=			valoId));
							
		INNOdepensePersonnelCtrl ctrl2 = new INNOdepensePersonnelCtrl(stdCtrl2);

		ctrl2.savePersonnelEtHeuresTravaillees();
		ctrl2.deleteAndRedirect();
		
		Test.stopTest();
	}
	
	
	public static testmethod void TestINNOdepensePersonnelListCtrl(){
		
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		
		INNOdepartement__c d = new INNOdepartement__c(
											Name						=			'test',
											Entite__c					=			INNOtestBase.Accs[0].Id);
		insert d;

		INNOdepensePersonnel__c dp = new INNOdepensePersonnel__c(
							Name						=			'test',
							Nom__c						=			'test_nom',
							Prenom__c					=			'test_prenom',
							//Salaire_brut_annuel__c		=			100000,
							Departement__c				=			d.Id,
							Valorisation__c				=			valoId,
							RecordTypeId				=			[Select Id From RecordType r Where SobjectType = 'INNOdepensePersonnel__c' And DeveloperName = 'salarie' LIMIT 1][0].Id);
		insert dp;
		
		INNOprojet__c pr = new INNOprojet__c(
							Name						=			'test',
							Num_projet__c				=			'2',
							Valorisation__c				=			valoId,
							Type__c						=			'Projet');
		insert pr;
		
		
		INNOpersonnelToProjet__c ptp = new INNOpersonnelToProjet__c(
							Depense_de_personnel__c		=			dp.Id,
							Projet__c					=			pr.Id);
		insert ptp;
		

		
		PageReference p = new pageReference( '/apex/INNOdepensePersonnelList' );
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('personnelId', dp.Id);
		System.currentPageReference().getParameters().put('valoId', valoId);
		Test.startTest();
		
		INNOdepensePersonnelListCtrl ctrl = new INNOdepensePersonnelListCtrl();

		
		Test.stopTest();
	}
	
	public static testmethod void TestINNOdepensePrestationCtrl(){
		
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		INNOprojet__c pr = new INNOprojet__c(
							Name						=			'test',
							Num_projet__c				=			'2',
							Valorisation__c				=			valoId,
							Type__c						=			'Projet');
		insert pr;
		
		INNOdepensePrestation__c dp = new INNOdepensePrestation__c(
							Valorisation__c					=			valoId,
							Montant_HT__c					=			10,
							Prestataire__c					=			'test_prestataire',
							Num_piece__c					=			'test_num_piece');
		insert dp;
		
		PageReference p = new pageReference( '/apex/INNOdepensePrestationEdit' );
		Test.setCurrentPage(p);
		Test.startTest();
		
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(dp);
		INNOdepensePrestationCtrl ctrl = new INNOdepensePrestationCtrl(stdCtrl);
		ctrl.save();
		ctrl.deleteAndRedirect();

		System.currentPageReference().getParameters().put('tab', 'prestataire');
		System.currentPageReference().getParameters().put('valoId', valoId);
		ApexPages.StandardController stdCtrl2 = new ApexPages.StandardController(new INNOdepensePrestation__c());
		INNOdepensePrestationCtrl ctrl2 = new INNOdepensePrestationCtrl(stdCtrl2);

				
		Test.stopTest();
	}
	
	
	
  	public static testmethod void TestINNOdepensePrestationListCtrl(){
		
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		Id idRt = [Select r.SobjectType, r.Id, r.DeveloperName From RecordType r Where r.SobjectType = 'INNOdepensePrestation__c' AND r.DeveloperName = 'brevetPM' LIMIT 1][0].Id;
		INNOdepensePrestation__c dp;
		for(Integer i = 1; i <= 2; i++){
			dp = new INNOdepensePrestation__c(
							Valorisation__c					=			valoId,
							Montant_HT__c					=			10,
							Prestataire__c					=			'test_prestataire',
							Num_piece__c					=			'test_num_piece',
							RecordTypeId					=			idRt);
			insert dp;
		}
		PageReference p = new pageReference( '/apex/INNOdepensePrestationList' );
		Test.setCurrentPage(p);
		Test.startTest();
		
		System.currentPageReference().getParameters().put('prestationId', dp.Id);
		System.currentPageReference().getParameters().put('valoId', valoId);
		
		//Suppression d'une prestation
		System.currentPageReference().getParameters().put('recordId',  dp.Id);
		System.currentPageReference().getParameters().put('retURL',  '/');
		
		INNOmissionBaseCtrl c = new INNOmissionBaseCtrl();
		c.deleteRecord();
		
		INNOdepensePrestationListCtrl ctrl = new INNOdepensePrestationListCtrl();
		
		System.assert(ctrl.prestations.size() == 1);
		
		Test.stopTest();
	}
	
	
	
	
	
	public static testMethod void TestINNOvalorisationRecap(){
		INNOtestBase.initRecords();
		
		
		Test.startTest();
		Pagereference p = new Pagereference('/apex/INNOvalorisationRecap');
		Test.setCurrentPage(p);
		p.getParameters().put('id', INNOtestBase.valos[0].Id);
		p.getParameters().put('valoId', INNOtestBase.valos[0].Id);
		Apexpages.Standardcontroller ctrl = new apexpages.Standardcontroller(INNOtestBase.valos[0]);
		INNOvalorisationRecapCtrl customCtrl = new INNOvalorisationRecapCtrl(ctrl);
		
		
		p.getParameters().put('Option_retenue_amortissement__c', '1');
		p.getParameters().put('Option_retenue_amortissementBrevet__c', '1');
		p.getParameters().put('Option_retenue_brevetAssu__c', '1');
		p.getParameters().put('Option_retenue_avanceRemboursable__c', '2');
		p.getParameters().put('Option_retenue_brevetDef__c', '2');
		p.getParameters().put('Option_retenue_honoraires_N1__c', '2');
		p.getParameters().put('Option_retenue_jeuneDocteur__c', '2');
		p.getParameters().put('Option_retenue_miseDisposition__c', '2');
		p.getParameters().put('Option_retenue_normalisation__c', '2');
		p.getParameters().put('Option_retenue_brevetPM__c', '2');
		p.getParameters().put('Option_retenue_prestataire_agree__c', '2');
		p.getParameters().put('Option_retenue_prestataire_public__c', '2');
		p.getParameters().put('Option_retenue_remboursementAvance__c', '2');
		p.getParameters().put('Option_retenue_salarie__c', '3');
		p.getParameters().put('Option_retenue_subvention__c', '3');
		p.getParameters().put('Option_retenue_veille__c', '3');
		customCtrl.saveOptionsFiscales();
		
		INNOvalo__c valo = [SELECT Id, Option_retenue_amortissement__c, Option_retenue_amortissementBrevet__c, Option_retenue_brevetAssu__c, Option_retenue_avanceRemboursable__c, Option_retenue_brevetDef__c, Option_retenue_honoraires_N1__c, Option_retenue_jeuneDocteur__c, Option_retenue_miseDisposition__c, Option_retenue_normalisation__c, Option_retenue_brevetPM__c, Option_retenue_prestataire_agree__c, Option_retenue_prestataire_public__c, Option_retenue_remboursementAvance__c, Option_retenue_salarie__c, Option_retenue_subvention__c, Option_retenue_veille__c FROM INNOvalo__c WHERE Id = :INNOtestBase.valos[0].Id limit 1][0];
		System.assertEquals(1, valo.Option_retenue_amortissement__c);
		System.assertEquals(1, valo.Option_retenue_amortissementBrevet__c);
		System.assertEquals(1, valo.Option_retenue_brevetAssu__c);
		System.assertEquals(2, valo.Option_retenue_avanceRemboursable__c);
		System.assertEquals(2, valo.Option_retenue_brevetDef__c);
		System.assertEquals(2, valo.Option_retenue_honoraires_N1__c);
		System.assertEquals(2, valo.Option_retenue_jeuneDocteur__c);
		System.assertEquals(2, valo.Option_retenue_miseDisposition__c);
		System.assertEquals(2, valo.Option_retenue_normalisation__c);
		System.assertEquals(2, valo.Option_retenue_brevetPM__c);
		System.assertEquals(2, valo.Option_retenue_prestataire_agree__c);
		System.assertEquals(2, valo.Option_retenue_prestataire_public__c);
		System.assertEquals(2, valo.Option_retenue_remboursementAvance__c);
		System.assertEquals(3, valo.Option_retenue_salarie__c);
		System.assertEquals(3, valo.Option_retenue_subvention__c);
		System.assertEquals(3, valo.Option_retenue_veille__c);

		
		Test.stopTest();
		
		
	}
	
	
	public static testMethod void TestINNOvalorisationChecker(){
		INNOtestBase.initRecords();
		
		INNOmission__c missionN1 = INNOtestBase.missions[0].clone();
		missionN1.Annee_CIR__c = '2016';
		INNOtestBase.missions.add(missionN1);
		upsert INNOtestBase.missions;
		
		INNOvalo__c valoN1 = INNOtestBase.valos[0].clone();
		valoN1.MissionCIR__c = INNOtestBase.missions[1].Id;
		INNOtestBase.valos.add(valoN1);
		upsert INNOtestBase.valos;
		
		
		List<INNOprojet__c> projets = new List<INNOprojet__c>{new INNOprojet__c(Name = 'test', type__c = 'projet' , Valorisation__c = INNOtestBase.valos[0].Id),
																new INNOprojet__c(Name = 'test', type__c = 'projet' , Valorisation__c = INNOtestBase.valos[1].Id)};
		insert projets;
		
		List<INNOdepensePersonnel__c> salaries = new List<INNOdepensePersonnel__c>{new INNOdepensePersonnel__c(name = 'test', Nom__c = 'test', preNom__c = 'test',Valorisation__c = INNOtestBase.valos[0].Id),
																					new INNOdepensePersonnel__c(name = 'test', Nom__c = 'test', preNom__c = 'test',Valorisation__c = INNOtestBase.valos[1].Id)};
		insert salaries;
		
		List<INNOpersonnelToProjet__c> ptos = new List<INNOpersonnelToProjet__c>{ new INNOpersonnelToProjet__c(projet__c = projets[0].id, Depense_de_personnel__c = salaries[0].Id,	Heures_RD_option1__c = 1000, Heures_RD_option2__c = 1000, Heures_RD_option3__c = 1000),
																					new INNOpersonnelToProjet__c(projet__c = projets[1].id, Depense_de_personnel__c = salaries[1].Id,	Heures_RD_option1__c = 1000, Heures_RD_option2__c = 1000, Heures_RD_option3__c = 1000)};
		insert ptos;

		Test.startTest();
		
		Pagereference p = new Pagereference('/apex/INNOvalorisationRecap');
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('valoId', INNOtestBase.valos[0].Id); // on utilise le n+1 pour avoir les infos
		INNOvalorisationChecker customCtrl = new INNOvalorisationChecker();
		
		
		Test.stopTest();
	}
	
	
	public static testMethod void TestINNOsubventionListCtrl(){
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		Id subventionRtId = [Select Id From RecordType r Where SobjectType = 'INNOsubvention__c' And DeveloperName = 'subvention' LIMIT 1][0].Id;		
		
		INNOsubvention__c sub = new INNOsubvention__c(organisme__c = 'test', Valorisation__c = valoId, RecordTypeId = subventionRtId);
		insert sub;

		Test.startTest();
		Pagereference p = new Pagereference('/apex/INNOsubventionList');
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('valoId', valoId);
		System.currentPageReference().getParameters().put('tab','subvention');
		INNOsubventionListCtrl customCtrl = new INNOsubventionListCtrl(new ApexPages.standardController(INNOtestBase.valos[0]));
		
		System.assertEquals(1, customCtrl.subventions.size());
		
		
		//Suppression d'une subvention
		System.currentPageReference().getParameters().put('recordId',  sub.Id);
		System.currentPageReference().getParameters().put('retURL',  '/');
		
		INNOmissionBaseCtrl c = new INNOmissionBaseCtrl();
		c.deleteRecord();
		
		//Pour réinitialiser les subventions
		customCtrl = new INNOsubventionListCtrl(new ApexPages.standardController(INNOtestBase.valos[0]));
				
		System.assert(customCtrl.subventions.isEmpty());
		Test.stopTest();
		
		
	}
	
	
	public static testMethod void TestINNOsubventionCtrl(){
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		


		Test.startTest();
		Pagereference p = new Pagereference('/apex/INNOsubventionEdit');
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('valoId', valoId);
		INNOsubvention__c sub = new INNOsubvention__c();
		INNOsubventionCtrl ctrl = new INNOsubventionCtrl(new Apexpages.Standardcontroller(sub));
		sub.Organisme__c = 'test';
		
		Pagereference ret = ctrl.save();
		System.assertEquals(1, [SELECT COUNT() FROM INNOsubvention__c]);
		
		System.assert(ret.getUrl().startsWith('/apex/INNOsubventionView'));
		
		ret = ctrl.deleteAndRedirect();
		System.assert(ret.getUrl().startsWith('/apex/INNOsubventionList'));	
		Test.stopTest();
	}
	
	
	
	
	public static testMethod void TestINNOprojetListCtrl(){
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		INNOprojet__c projet = new INNOprojet__c(Name = 'test', Type__c = 'projet', Valorisation__c = valoId);
		insert projet;
		
		ApexPages.Standardcontroller stdCtrl = new apexPages.Standardcontroller(INNOtestBase.valos[0]);
		Test.startTest();
		Pagereference p = new Pagereference('/apex/INNOprojetList');
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('valoId', valoId);
		INNOprojetListCtrl customCtrl = new INNOprojetListCtrl(stdCtrl);
		System.assertEquals(1, customCtrl.projets.size());
		
		//Suppression d'un projet
		p.getParameters().put('recordId',  projet.Id);
		p.getParameters().put('retURL',  '/');
		
		INNOmissionBaseCtrl c = new INNOmissionBaseCtrl();
		c.deleteRecord();
		
		//Pour réinitialiser les projets
		customCtrl = new INNOprojetListCtrl(stdCtrl);
		
		System.assert(customCtrl.projets.isEmpty());
		Test.stopTest();
		
        p.getParameters().put('objectName', 'INNOprojet__c');
        c.deleteAllRecords();
	}
	
	
	public static testMethod void TestINNOprojetCtrl(){
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		INNOprojet__c projet = new INNOprojet__c(Name = 'test', Type__c = 'projet', Valorisation__c = valoId);
		insert projet;

		Apexpages.Standardcontroller stdctrl = new Apexpages.Standardcontroller(projet);

		Test.startTest();
		Pagereference p = new Pagereference('/apex/INNOprojetEdit');
		Test.setCurrentPage(p);
		p.getParameters().put('valoId', valoId);
		INNOprojetCtrl customCtrl = new INNOprojetCtrl(stdCtrl);
		
		customCtrl.checkParams();
		
		Pagereference ret = customCtrl.save();
		
		System.assert(ret.getUrl().startsWith('/apex/INNOprojetView'));
		System.assert(stdctrl.getId() != null);
		
		ret = customCtrl.deleteAndRedirect();
		System.assert(ret.getUrl().startsWith('/apex/INNOprojetList'));	
		Test.stopTest();
	}
	
	
	
	
	
	
	public static testMethod void TestINNOimportCtrl_1(){
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		INNOprojet__c projet = new INNOprojet__c(Name = 'test', Num_projet__c = '2', Type__c = 'projet', Valorisation__c = valoId);
		insert projet;
		
		Test.startTest();
		
		
		Pagereference p = new Pagereference('/apex/INNOimport');
		Test.setCurrentPage(p);
		p.getParameters().put('valoId', valoId);
		
		INNOimportCtrl ctrl;
		
		
		//Imports Amortissements
		p.getParameters().put('tab', 'amortissement');
		Test.setCurrentPage(p);
		
		ctrl = new INNOimportCtrl();
		
		
		INNOimport.ImportRow headerRow = INNOimportCtrl.checkImportHeader('amortissement', valoId, 'Désignation*	N° d\'immobilisation*	Département	Projet	Date d\'acquisition	Montant d\'acquisition	Annuité d\'amortissement* 	Méthode de calcul du taux R&D*	Taux R&D opt1 (Si méthode manuelle)	Taux R&D opt2 (Si méthode manuelle)	Taux R&D opt3 (Si méthode manuelle)	Commentaires');
		System.assertEquals(0, headerRow.nbErrors);
		
		List<INNOimport.ImportRow> rows = INNOimportCtrl.checkImportRows('amortissement', valoId, new List<String>{'test	123		' + projet.Name + '	10/10/2012	10000	1000	Erreur	10	20	30	com'}, 0, headerRow);
		System.assertEquals(1, rows[0].nbErrors);
		
		rows[0].cells[7].value = 'Manuelle';
		rows = INNOimportCtrl.reCheckImportRows('amortissement', valoId, rows);
		System.assertEquals(0, rows[0].nbErrors);
		
		INNOimport.ImportResult result = INNOimportCtrl.importRows('amortissement', valoId, 1, rows);
		System.assert(result.results[0].success);
		
		
		
		//Imports Amortissements Brevet
		p.getParameters().put('tab','amortissementBrevet');
		
		ctrl = new INNOimportCtrl();
		
		headerRow = INNOimportCtrl.checkImportHeader('amortissementBrevet', valoId, 'Désignation*	Département	Projet	Date d\'acquisition	Annuité d\'amortissement*	Taux R&D opt1	Taux R&D opt2	Taux R&D opt3	Commentaires');
		System.assertEquals(0, headerRow.nbErrors);
		
		rows = INNOimportCtrl.checkImportRows('amortissementBrevet', valoId, new List<String>{'test		' + projet.Name + '	10/10/2012	error	10	20	30	com'}, 0, headerRow);
		System.assertEquals(1, rows[0].nbErrors);
		
		rows[0].cells[4].value = '1000';
		rows = INNOimportCtrl.reCheckImportRows('amortissementBrevet', valoId, rows);
		System.assertEquals(0, rows[0].nbErrors);
		
		result = INNOimportCtrl.importRows('amortissementBrevet', valoId, 1, rows);
		System.assert(result.results[0].success);
		
		
		
		//Imports brevetPM
		p.getParameters().put('tab', 'brevetPM');
		
		ctrl = new INNOimportCtrl();
		
		headerRow = INNOimportCtrl.checkImportHeader('brevetDefPM', valoId, 'Prestataire*	Nature prestation	Département	Projet	N° pièce*	Date pièce	N° du brevet	Date de dépôt	Date de délivrance	Défense de brevet (oui /non)	Montant HT*	Taux R&D opt1	Taux R&D opt2	Taux R&D opt3	Commentaires');
		System.assertEquals(0, headerRow.nbErrors);
		
		rows = INNOimportCtrl.checkImportRows('brevetDefPM', valoId, new List<String>{'	nature		'+projet.Name+'	4162	10/10/2012	sdf	10/10/2012	10/10/2012	non	2000	20	30	40	dfkj'}, 0, headerRow);
		System.assertEquals(1, rows[0].nbErrors);
		
		rows[0].cells[0].value = 'nomTest';
		rows = INNOimportCtrl.reCheckImportRows('brevetDefPM', valoId, rows);
		System.assertEquals(0, rows[0].nbErrors);
		
		result = INNOimportCtrl.importRows('brevetDefPM', valoId, 1, rows);
		System.assert(result.results[0].success);
		
	}
	
	public static testMethod void TestINNOimportCtrl_2(){
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		INNOprojet__c projet = new INNOprojet__c(Name = 'test', Num_projet__c = '2', Type__c = 'projet', Valorisation__c = valoId);
		insert projet;
		
		Test.startTest();
		
		Pagereference p = new Pagereference('/apex/INNOimport');
		Test.setCurrentPage(p);
		p.getParameters().put('valoId', valoId);
		
		
		//Imports prestataire
		p.getParameters().put('tab', 'prestataire');
		
		INNOimportCtrl ctrl = new INNOimportCtrl();
		
		//2 erreurs dans le header
		INNOimport.ImportRow headerRow = INNOimportCtrl.checkImportHeader('prestataire', valoId, 'PrestataireErreur*	Nature prestationErreur	SIREN	Date début d\'agrément	Date fin d\'agrément	Type d\'organisme* (Public/Agréé)	Lien de dépendance* (Avec/Sans)	Localisation* (En France/A l\'étranger)	Précisez pays (si localisation à l\'étranger)	Département	Projet	N° pièce*	Date pièce	Montant HT*	Taux R&D opt1	Taux R&D opt2	Taux R&D opt3	Commentaires');
		System.assertEquals(2, headerRow.nbErrors);
		
		headerRow = INNOimportCtrl.checkImportHeader('prestataire', valoId, 'Prestataire*	Nature prestation	SIREN	Date début d\'agrément	Date fin d\'agrément	Type d\'organisme* (Public/Agréé)	Lien de dépendance* (Avec/Sans)	Localisation* (En France/A l\'étranger)	Précisez pays (si localisation à l\'étranger)	Département	Projet	N° pièce*	Date pièce	Montant HT*	Taux R&D opt1	Taux R&D opt2	Taux R&D opt3	Commentaires');
		System.assertEquals(0, headerRow.nbErrors);
		
		List<INNOimport.ImportRow> rows = INNOimportCtrl.checkImportRows('prestataire', valoId, new List<String>{'presta	nature	654	10/10/2012	12/10/2012	PrivéErreur	Sans	En France	dsf			4561	10/10/2012	5000€	10	20	30	jkdn'}, 0, headerRow);
		System.assertEquals(1, rows[0].nbErrors);
		
		rows[0].cells[5].value = 'Public';
		rows = INNOimportCtrl.reCheckImportRows('prestataire', valoId, rows);
		System.assertEquals(0, rows[0].nbErrors);
		
		INNOimport.ImportResult result = INNOimportCtrl.importRows('prestataire', valoId, 1, rows);
		System.assert(result.results[0].success);
		
		
		
		//Imports veilles
		p.getParameters().put('tab', 'veille');
		
		ctrl = new INNOimportCtrl();
		
		headerRow = INNOimportCtrl.checkImportHeader('veille', valoId, 'Prestataire*	Nature prestation	Département	Projet	N° pièce*	Date pièce	Montant HT*	Taux R&D opt1	Taux R&D opt2	Taux R&D opt3	Commentaires');
		System.assertEquals(0, headerRow.nbErrors);
		
		rows = INNOimportCtrl.checkImportRows('veille', valoId, new List<String>{'	Nature prestation		erreur	123	10/10/2012	425€	20	30	40	comment'}, 0, headerRow);
		System.assertEquals(2, rows[0].nbErrors);
		
		rows[0].cells[0].value = 'nomTest';
		rows[0].cells[3].value = projet.Id;
		rows = INNOimportCtrl.reCheckImportRows('veille', valoId, rows);
		System.assertEquals(0, rows[0].nbErrors);
		
		result = INNOimportCtrl.importRows('veille', valoId, 1, rows);
		System.assert(result.results[0].success);
		
		
		
		//Imports subvention
        p.getParameters().put('tab', 'avanceRemboursable');
        
        ctrl = new INNOimportCtrl();
		
		headerRow = INNOimportCtrl.checkImportHeader('subventionAvance', valoId, 'Organisme*	Type* (Subvention, Avance perçue, Avance remboursée)	Matricule	Date de versement	Nature	Salarié	Département	Projet	Montant opt1	Montant opt2	Montant opt3	Commentaires');
		System.assertEquals(0, headerRow.nbErrors);
		
		rows = INNOimportCtrl.checkImportRows('subventionAvance', valoId, new List<String>{'orga1	Avance perçue	1234	10/10Error/2013					1000	1200	1400	Com'}, 0, headerRow);
		System.assertEquals(1, rows[0].nbErrors);
		
		rows[0].cells[3].value = '10/10/2013';
		rows = INNOimportCtrl.reCheckImportRows('subventionAvance', valoId, rows);
		System.assertEquals(0, rows[0].nbErrors);
		
		result = INNOimportCtrl.importRows('subventionAvance', valoId, 1, rows);
		System.assert(result.results[0].success);
		
	}
	
	
	public static testMethod void TestINNOimportCtrl_3(){
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		INNOprojet__c projet = new INNOprojet__c(Name = 'test', Num_projet__c = '2', Type__c = 'projet', Valorisation__c = valoId);
		insert projet;
		
		Test.startTest();
		
		Pagereference p = new Pagereference('/apex/INNOimport');
		Test.setCurrentPage(p);
		p.getParameters().put('valoId', valoId);
		
		
		//Imports projets
		p.getParameters().put('tab', 'projet');
		
		INNOimportCtrl ctrl = new INNOimportCtrl();
		
		INNOimport.ImportRow headerRow = INNOimportCtrl.checkImportHeader('projet', valoId, 'Nom*	Nom du regroupement de projet	N° de projet	Département	Etat de l\'art	Objectifs du projet	Difficultés techniques	Travaux menés	Progrès accomplis	Existence de documents justificatifs	Commentaires');
		System.assertEquals(0, headerRow.nbErrors);
		
		List<INNOimport.ImportRow> rows = INNOimportCtrl.checkImportRows('projet', valoId, new List<String>{'Nom	aa	12	erreur	xxx	xxx	xxx	xxx	xxx	xxx	xxx'}, 0, headerRow);
		System.assertEquals(1, rows[0].nbErrors);
		
		rows[0].cells[3].value ='';
		rows = INNOimportCtrl.reCheckImportRows('projet', valoId, rows);
		System.assertEquals(0, rows[0].nbErrors);
		
		INNOimport.ImportResult result = INNOimportCtrl.importRows('projet', valoId, 1, rows);
		System.assert(result.results[0].success);
		
		
		
		//Imports depensePersonnel
		p.getParameters().put('tab', 'salarie');
		
		
		ctrl = new INNOimportCtrl();
		
		headerRow = INNOimportCtrl.checkImportHeader('depensePersonnel', valoId, 'Nom*	Prénom*	Matricule	Actif (oui/non)	Fonction	Département	Mise à disposition (saisir société d\'appartenance)	Organisme de normalisation	Jeune docteur (oui/non)	Cadre (oui/non)	Ingénieur/Docteur (oui/non)	Diplôme	Statut (Salarié / TNS / Stagiaire / Intérimaire / Apprenti / Thésard / Gérant)	Date entrée (jj/mm/yyyy)	Date sortie (jj/mm/yyyy)	Commentaires	Salaire brut annuel opt1	Salaire brut annuel opt2	Salaire brut annuel opt3	Intéressement opt1	Intéressement opt2	Intéressement opt3	Participation opt1	Participation opt2	Participation opt3	Salaire chargé opt1	Salaire chargé opt2	Salaire chargé opt3	Total heures/jours travaillées opt1	Total heures/jours travaillées opt2	Total heures/jours travaillées opt3	Total heures/jours PM brevet opt1	Total heures/jours PM brevet opt2	Total heures/jours PM brevet opt3	Total heures/jours veille opt1	Total heures/jours veille opt2	Total heures/jours veille opt3	Total heures/jours normalisation opt1	Total heures/jours normalisation opt2	Total heures/jours normalisation opt3	Unité de temps	test opt1	test opt2	test opt3');
		System.assertEquals(0, headerRow.nbErrors);
		
		rows = INNOimportCtrl.checkImportRows('depensePersonnel', valoId, new List<String>{ 'nom	prenom	16	oui	kjdf		soc	orga	non	non	oui	sddsf	Salarié	10/10/2012	10/12/212	ssdfdf	erreur	50000	50000	1000	1000	1000	100	100	100	50000	50000	50000	100	100	100	10	20	30	10	20	30	10	20	30	Heures	10	25	35',
																				            'nom2	prenom2	16	oui	kjdf		soc	orga	non	non	non	sdf	Salarié	10/10/2012	10/12/2012	sdf	50000	50000	50000	2000	2000	2000	5000	5000	5000	50000	50000	50000	100	100	100	10	20	30	10	20	30	10	20	30	Heures	10	25	35'}, 0, headerRow);
		System.assertEquals(2, rows[0].nbErrors);
		System.assertEquals(0, rows[1].nbErrors);
		
		rows[0].cells[14].value = '12/12/2012';
		rows[0].cells[16].value = '5000';
		rows = INNOimportCtrl.reCheckImportRows('depensePersonnel', valoId, rows);
		System.assertEquals(0, rows[0].nbErrors);
		
		result = INNOimportCtrl.importRows('depensePersonnel', valoId, 1, rows);
		System.assert(result.results[0].success);
		System.assert(result.results[1].success);
		
		
		
		Test.stopTest();
	}
	
	
	
	
	
	public static testMethod void TestINNOhome(){
		INNOtestBase.initRecords();
		
		Test.startTest();
		INNOhomeCtrl ctrl = new INNOhomeCtrl();
		System.assertEquals(1, ctrl.missions.size());
		Test.stopTest();
	}
        
    
   /* public static testMethod void TestAppCIRequipeConsulting_withoutSharing(){
		AppCIRTestBase.initRecords();
		List<user> users = [Select id, Name from User where id != : Userinfo.getUserId() and isActive = true AND UserType = 'Standard' limit 2];
		//On crée des équipe member pour bien passer partout
		List<AppCIRequipeConsulting__c> EquipeConsulting = new AppCIRequipeConsulting__c[]{
			new AppCIRequipeConsulting__c(role__c = 'Manager' , utilisateur__c = Userinfo.getUserId()),
			new AppCIRequipeConsulting__c(role__c = 'Superviseur' , utilisateur__c = users[0].id),
			new AppCIRequipeConsulting__c(role__c = 'Consultant extérieur' , utilisateur__c = users[1].id)
		};
		AppCIRespaceCreator creator = new AppCIRespaceCreator(AppCIRTestBase.getAccs().get(0),AppCIRTestBase.getContracts().get(0),EquipeConsulting,Userinfo.getUserId());
		creator.insertCreatedData();
		
		Test.startTest();
		
		//Test le résultat du trigger qui a du recap les champs consultants scientifiques, fiscalistes, etc.
		AppCIRmission__c m = [SELECT Id, Entite__c, Consultants_scientifiques__c, Consultants_exterieurs__c, Consultants_fiscalistes__c, Superviseurs__c, Managers__c FROM AppCIRmission__c WHERE Id = :creator.missions[0].Id LIMIT 1][0];
		
		System.assertEquals(null, m.Consultants_scientifiques__c);
		System.assertEquals(Userinfo.getName(), m.Managers__c);
		System.assertEquals(users[0].Name, m.Superviseurs__c);
		System.assertEquals(users[1].Name, m.Consultants_exterieurs__c);
		System.assertEquals(null, m.Consultants_fiscalistes__c);
		
		Test.stopTest();
	}*/
	
	
	public static testMethod void TestINNOequipeConsultingWithoutSharingCtrl(){
		INNOtestBase.initRecords();
		
		Id valoId = INNOtestBase.valos[0].Id;
		
		Test.startTest();
		Pagereference p = new Pagereference('/apex/INNOequipeConsultingEdit');
		p.getParameters().put('valoId', valoId);
		Test.setCurrentPage(p);
		
		
		INNOequipeConsulting__c membre = [SELECT Id, Role__c, MissionCIR__c FROM INNOequipeConsulting__c LIMIT 1][0];
		INNOequipeConsultingWithoutSharingCtrl ctrl = new INNOequipeConsultingWithoutSharingCtrl(new ApexPages.standardController(membre));
		membre.Role__c = 'Superviseur';
		System.assert(ctrl.saveAndRedirect() != null); //On teste que tout ce passe bien
		
		System.assertEquals('Superviseur', [SELECT Id, Role__c FROM INNOequipeConsulting__c WHERE Id = :membre.Id][0].Role__c);
		Test.stopTest();
		
	}
	
	/*
	public static testMethod void TestAppCIRcerfa(){
		
		AppCIRTestBase.initRecords();
		AppCIRespaceCreator creator = new AppCIRespaceCreator(AppCIRTestBase.getAccs().get(0),AppCIRTestBase.getContracts().get(0));
		creator.insertCreatedData();
		
		AppCIRmission__c m = creator.missions.get(0);
		m.Option_retenue_brevetPM__c = 1;
		m.Option_retenue_prestataire_public__c = 1;
		m.Option_retenue_prestataire_agree__c = 1;
		update m;
		
		Id prestaRtId = [Select Id From RecordType r Where SobjectType = 'AppCIRdepensePrestation__c' And DeveloperName = 'prestataire' LIMIT 1][0].Id;		
		AppCIRdepensePrestation__c[] dps = new List<AppCIRdepensePrestation__c>{
												new AppCIRdepensePrestation__c(
														Mission_CIR__c					=			m.Id,
														RecordTypeId					=			prestaRtId,
														Montant_HT__c					=			10,
														Taux_option1__c					= 			100,
														Type_organisme__c				=			'Public',
														Lien_de_dependance__c 			= 			'Avec',
														Localisation__c					=			'En France',
														Prestataire__c					=			'test_prestataire',
														Num_piece__c					=			'test_num_piece'),
												new AppCIRdepensePrestation__c(
														Mission_CIR__c					=			m.Id,
														RecordTypeId					=			prestaRtId,
														Montant_HT__c					=			10,
														Taux_option1__c					= 			100,
														Type_organisme__c				=			'Public',
														Lien_de_dependance__c 			= 			'Avec',
														Localisation__c					=			'A l\'étranger',
														Prestataire__c					=			'test_prestataire2',
														Num_piece__c					=			'test_num_piece2'),
												new AppCIRdepensePrestation__c(
														Mission_CIR__c					=			m.Id,
														RecordTypeId					=			prestaRtId,
														Montant_HT__c					=			10,
														Taux_option1__c					= 			100,
														Type_organisme__c				=			'Public',
														Lien_de_dependance__c 			= 			'Sans',
														Localisation__c					=			'En France',
														Prestataire__c					=			'test_prestataire3',
														Num_piece__c					=			'test_num_piece3'),
												new AppCIRdepensePrestation__c(
														Mission_CIR__c					=			m.Id,
														RecordTypeId					=			prestaRtId,
														Montant_HT__c					=			10,
														Taux_option1__c					= 			100,
														Type_organisme__c				=			'Public',
														Lien_de_dependance__c 			= 			'Sans',
														Localisation__c					=			'A l\'étranger',
														Prestataire__c					=			'test_prestataire4',
														Num_piece__c					=			'test_num_piece4'),		
												new AppCIRdepensePrestation__c(
														Mission_CIR__c					=			m.Id,
														RecordTypeId					=			prestaRtId,
														Montant_HT__c					=			10,
														Taux_option1__c					= 			100,
														Type_organisme__c				=			'Agréé',
														Lien_de_dependance__c 			= 			'Avec',
														Localisation__c					=			'En France',
														Prestataire__c					=			'test_prestataire5',
														Num_piece__c					=			'test_num_piece5'),
												new AppCIRdepensePrestation__c(
														Mission_CIR__c					=			m.Id,
														RecordTypeId					=			prestaRtId,
														Montant_HT__c					=			10,
														Taux_option1__c					= 			100,
														Type_organisme__c				=			'Agréé',
														Lien_de_dependance__c 			= 			'Avec',
														Localisation__c					=			'A l\'étranger',
														Prestataire__c					=			'test_prestataire6',
														Num_piece__c					=			'test_num_piece6'),
												new AppCIRdepensePrestation__c(
														Mission_CIR__c					=			m.Id,
														RecordTypeId					=			prestaRtId,
														Montant_HT__c					=			10,
														Taux_option1__c					= 			100,
														Type_organisme__c				=			'Agréé',
														Lien_de_dependance__c 			= 			'Sans',
														Localisation__c					=			'En France',
														Prestataire__c					=			'test_prestataire7',
														Num_piece__c					=			'test_num_piece7'),
												new AppCIRdepensePrestation__c(
														Mission_CIR__c					=			m.Id,
														RecordTypeId					=			prestaRtId,
														Montant_HT__c					=			10,
														Taux_option1__c					= 			100,
														Type_organisme__c				=			'Agréé',
														Lien_de_dependance__c 			= 			'Sans',
														Localisation__c					=			'A l\'étranger',
														Prestataire__c					=			'test_prestataire8',
														Num_piece__c					=			'test_num_piece8')	
													};
			
		insert dps;											
												
		PageReference p = new pageReference( '/apex/AppCIRcerfa' );
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('missionId', creator.missions.get(0).Id);
		System.currentPageReference().getParameters().put('option', '1');
		Test.startTest();
		
		AppCIRcerfa cerfa = new AppCIRcerfa();
		
		
		//ON recommence avec on montant > 100000000
		insert new AppCIRdepensePrestation__c(
											Mission_CIR__c					=			m.Id,
											RecordTypeId					=			[Select Id From RecordType r Where SobjectType = 'AppCIRdepensePrestation__c' And DeveloperName = 'brevetPM' LIMIT 1][0].Id,
											Montant_HT__c					=			2000000000,
											Taux_option1__c					= 			100,
											Prestataire__c					=			'test_prestataire8',
											Num_piece__c					=			'test_num_piece8');
		cerfa = new AppCIRcerfa();								
		
		Test.stopTest();											
		
	}*/
    
    
    	
	public static testmethod void testINNOreportLinkCtrl(){
		
		INNOreportLinkCtrl ctrl = new INNOreportLinkCtrl();
		
		ctrl.repName = 'salarie';
		System.assert(ctrl.reports.size() >= 1);
	}
	
	
	
	
	public static testmethod void TestINNOexportValorisationCtrl(){
		
		INNOtestBase.initRecords();
		INNOmission__c m = INNOtestBase.missions.get(0);
		INNOvalo__c v = INNOtestBase.valos.get(0);
		
		Id idRtPresta = [Select r.SobjectType, r.Id, r.DeveloperName From RecordType r Where r.SobjectType = 'INNOdepensePrestation__c' And r.DeveloperName = 'prestataire' LIMIT 1][0].Id;
		
		List<INNOdepensePrestation__c> prestas = new List<INNOdepensePrestation__c>{
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Public', Lien_de_dependance__c = 'Avec', Localisation__c = 'En France', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Public', Lien_de_dependance__c = 'Avec', Localisation__c = 'En France', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Public', Lien_de_dependance__c = 'Avec', Localisation__c = 'A l\'étranger', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Public', Lien_de_dependance__c = 'Avec', Localisation__c = 'A l\'étranger', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Public', Lien_de_dependance__c = 'Sans', Localisation__c = 'En France', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Public', Lien_de_dependance__c = 'Sans', Localisation__c = 'En France', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Public', Lien_de_dependance__c = 'Sans', Localisation__c = 'A l\'étranger', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Public', Lien_de_dependance__c = 'Sans', Localisation__c = 'A l\'étranger', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Agréé', Lien_de_dependance__c = 'Avec', Localisation__c = 'En France', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Agréé', Lien_de_dependance__c = 'Avec', Localisation__c = 'En France', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Agréé', Lien_de_dependance__c = 'Avec', Localisation__c = 'A l\'étranger', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Agréé', Lien_de_dependance__c = 'Avec', Localisation__c = 'A l\'étranger', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Agréé', Lien_de_dependance__c = 'Sans', Localisation__c = 'En France', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Agréé', Lien_de_dependance__c = 'Sans', Localisation__c = 'En France', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Agréé', Lien_de_dependance__c = 'Sans', Localisation__c = 'A l\'étranger', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1),
			new INNOdepensePrestation__c(Valorisation__c = v.Id, Type_organisme__c = 'Agréé', Lien_de_dependance__c = 'Sans', Localisation__c = 'A l\'étranger', Montant_HT__c = 10, Prestataire__c =	'test_prestataire', Num_piece__c = 'test_num_piece', RecordTypeId = idRtPresta, Taux_option2__c = 1)
			
		};
		
		insert prestas;
		
		
		INNOdepensePersonnel__c perso = new INNOdepensePersonnel__c(name = 'test', Nom__c = 'test', preNom__c = 'test', Valorisation__c = v.Id, Actif__c = true, Total_heures_travaillees_option2__c = 20, RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'INNOdepensePersonnel__c' AND DeveloperName = 'salarie'][0].Id);
		insert perso;
		
		INNOprojet__c projet = new INNOprojet__c(Name = 'test', Valorisation__c = v.Id, Type__c = 'projet');
		insert projet;
		
		List<INNOpersonnelToProjet__c> persosToProjet = new List<INNOpersonnelToProjet__c>();
		for(INNOprojet__c p : [SELECT Id, Type__c FROM INNOprojet__c WHERE Valorisation__c = :v.Id]){
			persosToProjet.add(new INNOpersonnelToProjet__c(Depense_de_personnel__c = perso.Id, Projet__c = p.Id, Type_projet__c = p.Type__c, Heures_RD_option2__c = 2 ));
		}
		insert persosToProjet;
		
		
		PageReference p = new pageReference( '/apex/INNOexportValorisation' );
		Test.setCurrentPage(p);
		System.currentPageReference().getParameters().put('id', m.Id);
		System.currentPageReference().getParameters().put('opt', '2');
		Test.startTest();
		
		  
		ApexPages.StandardController stdCtrl = new Apexpages.Standardcontroller((INNOvalo__c) v);
		INNOvalorisationExportCtrl ctrl = new INNOvalorisationExportCtrl(stdCtrl);

		
		ctrl.getFileName();
		ctrl.initDatas();
		
		for(String o : ctrl.opts.values()){
			System.assertEquals('2', o);
		}
		
		for (String s : ctrl.prestataires.keySet()){
			System.assertEquals(2, ctrl.prestataires.get(s).size());
		}		
		
		Test.stopTest();
	}
			
			
			
	public static testmethod void TestINNOcontroleQualiteInnoCtrl(){
		
		INNOtestBase.initRecords();
		INNOmission__c m = INNOtestBase.missions.get(0);
		
		pageReference page = new PageReference('/apex/INNOcontroleQualite');
		page.getParameters().put('missionId', m.Id);
		Test.setCurrentPage(page);
		
		Test.startTest();
		
		INNOcontroleQualiteCtrl ctrl = new INNOcontroleQualiteCtrl(new ApexPages.Standardcontroller(new INNOcontroleQualite__c()));
		ctrl.checkParams();
		
		ctrl.saveCQ();
		Test.stopTest();
	}
	
	
	
	public static testmethod void TestINNOequipeConsultingReassignCtrl(){
		
		INNOtestBase.initRecords();
		
		INNOmission__c m = INNOtestBase.missions.get(0);
		
		User otherUser = [SELECT Id FROM User WHERE IsActive = true AND UserType = 'Standard' AND Id != :Userinfo.getUserId() LIMIT 1][0];
		List<INNOequipeConsulting__c> EquipeConsulting = new INNOequipeConsulting__c[]{
			new INNOequipeConsulting__c(MissionCIR__c = m.Id, role__c = 'Manager' , utilisateur__c = Userinfo.getUserId(), Nombre_jours_theoriques_Audit__c = 5, Actif__c = true),
			new INNOequipeConsulting__c(MissionCIR__c = m.Id, role__c = 'Superviseur' , utilisateur__c = otherUser.Id, Nombre_jours_theoriques_Audit__c = 0)
		};
		insert EquipeConsulting;
		
		Test.startTest();
		
		INNOequipeConsultingReassignCtrl ctrl = new INNOequipeConsultingReassignCtrl();
		
		ctrl.dummyEquipe.Utilisateur__c = Userinfo.getUserId();
		
		ctrl.searchEquipes();
		
		System.assertEquals(1, ctrl.results.size());
		
		
		
		ctrl.results[0].newMember.Utilisateur__c = otherUser.Id;
		ctrl.saveMembers();
		
		System.assertEquals(5, Integer.valueOf([SELECT SUM(Nombre_jours_theoriques_Audit__c) audit FROM INNOequipeConsulting__c WHERE Utilisateur__c = :otherUser.Id][0].get('audit')));
		
		Test.stopTest();
	}
	
	
		
    
}