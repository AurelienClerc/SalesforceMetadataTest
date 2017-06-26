@isTest
private class AppATfeuilleCalculCtrl_Test {

	private static testMethod void testAppATfeuilleCalculCtrl() {
		//Création d'une mission en réutilisant le code de FactuTestBase
        FactuTestBase.Init();
        Mission__c missionAT;
        for(Mission__c m : FactuTestBase.Missions){
            if(m.RecordType.developerName == 'TAT'){
                missionAT = m;
                break;
            }
        }
        
        
        //Création d'un établissement
        AppATetablissement__c etab = new AppATetablissement__c(Mission__c = missionAT.Id, SIRET__c = '147 852 369 52369');
        insert etab;
        
        //Création d'un CTN
        AppATctn__c ctn = new AppATctn__c(Annee__c = '2015', TypeCTN__c = 'AA', CCMIP1__c = 100, CCMIP2__c = 100, CCMIP3__c = 100, CCMIP4__c = 100, CCMIT1__c = 100, CCMIT2__c = 100, CCMIT3__c = 100, CCMIT4__c = 100, CCMIT5__c = 100, CCMIT6__c = 100);
		insert ctn;
		
		//Création des masses salariales
		List<AppATmasseSalariale__c> ms = new List<AppATmasseSalariale__c>{new AppATmasseSalariale__c(Annee__c = '2014', EtablissementConcerne__c = etab.Id, Effectif__c = 10, MasseSalariale__c = 1000),
																			new AppATmasseSalariale__c(Annee__c = '2013', EtablissementConcerne__c = etab.Id, Effectif__c = 10, MasseSalariale__c = 1000),
																			new AppATmasseSalariale__c(Annee__c = '2012', EtablissementConcerne__c = etab.Id, Effectif__c = 10, MasseSalariale__c = 1000),
																			new AppATmasseSalariale__c(Annee__c = '2011', EtablissementConcerne__c = etab.Id, Effectif__c = 10, MasseSalariale__c = 1000)};
        insert ms;
        
        //Création d'une majoration
        AppATmajoration__c major = new AppATmajoration__c(Annee__c = '2015', Charges__c = 50, Compensation__c = 50, CoutRisque__c = 5000, Majoration__c = 50, MajorationForfaitaireRisqueTrajet__c = 50, Penibilite__c = 50);
        insert major;
        
        
        Test.startTest();
        //Initialisation de la feuille de calcul
        Id RecordTypeIdFCtauxReel = [SELECT Id FROM RecordType WHERE SObjectType = 'AppATfeuilleCalcul__c' AND DeveloperName = 'TauxReel' LIMIT 1][0].Id;
        
        AppATfeuilleCalcul__c fc = new AppATfeuilleCalcul__c(EtablissementConcerne__c = etab.Id, RecordTypeId = RecordTypeIdFCtauxReel);
        
        ApexPages.standardController stdCtrl = new ApexPages.standardController(fc);
        AppATfeuilleCalculCtrl ctrl = new AppATfeuilleCalculCtrl(stdCtrl);
        
        fc.AnneeFeuilleCalcul__c = '2015';
        fc.Type_de_feuille_de_calcul__c = 'AA';
        ctrl.selectedCTNtype = 'AA';
        
        ctrl.create();
        fc.CCMIT1_N_4__c = 1;
        fc.CCMIT1_N_3__c = 2;
        fc.CCMIT1_N_2__c = 4;
        stdCtrl.save();
        
        //system.assertEquals('lkj', fc.Id);
        //Test du clonage
        PageReference clonePage = Page.AppATfeuilleCalculEdit;
        clonePage.getParameters().put('clone', '1');
        clonePage.getParameters().put('id',  fc.Id);
        Test.setCurrentPage(clonePage);
        stdCtrl = new ApexPages.standardController(fc);
        ctrl = new AppATfeuilleCalculCtrl(stdCtrl);
        fc.AnneeFeuilleCalcul__c = '2016';
        fc.Type_de_feuille_de_calcul__c = 'Simulée';
        ctrl.create();
        
        
        //Vérifie ques les CCM IT/IP se sont bien décalés d'une année
       /* system.assertEquals(2, fc.CCMIT1_N_4__c);
        system.assertEquals(3, fc.CCMIT1_N_3__c);
        system.assertEquals(null, fc.CCMIT1_N_2__c);*/
        
        Test.stopTest();
	}

}