@isTest
public class AppNDF_test {

	public static testmethod void testAppNDFevenementCtrl(){
				
		AppNDFtestBase.Init();
		Event e = AppNDFtestBase.lsEvents.get(0);
		
		Test.startTest();
		
		// 1 - on veut ajouter une note de frais libre
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(new Event());
		AppNDFevenementCtrl ctrl = new AppNDFevenementCtrl(stdCtrl);
		
		stdCtrl = new ApexPages.StandardController(e);
		ctrl = new AppNDFevenementCtrl(stdCtrl); 
		
		ctrl.saveRecordsAndClose();
		system.assert(ApexPages.getMessages().size() > 0);
		
		// 2 crée
		
		// on ajoute et on supprime une dépense
		ctrl.sType = 'Autre_Frais';
		ctrl.addRow();
		system.assertEquals(ctrl.lsDepense.size(), 1);
		ctrl.sTempKeySelected = ctrl.lsDepense[0].Temp_Key__c;
		ctrl.deleteRow();
		system.assertEquals(ctrl.lsDepense.size(), 0);
		
		// on ajoute et on supprime une dépense
		ctrl.sType = 'Frais_Kilometrique';
		ctrl.addRow();
		system.assertEquals(ctrl.lsDepenseKilo.size(), 1);
		ctrl.sTempKeySelected = ctrl.lsDepenseKilo[0].Temp_Key__c;
		ctrl.deleteRow();
		system.assertEquals(ctrl.lsDepenseKilo.size(), 0);
		
		// on ajoute une dépense
		ctrl.sType = 'Autre_Frais';
		ctrl.addRow();
		system.assertEquals(ctrl.lsDepense.size(), 1);
		
		// enregistrement sans les champs obligatoires
		ctrl.saveRecordsAndClose();
		system.assert(ApexPages.getMessages().size() > 0);
		
		// une dépense OK 
		Note_De_Frais_Depense__c d = ctrl.lsDepense[0];
		d.Nature_Depense__c = AppNDFtestBase.getNature('TTC').Id;
		d.Montant_TTC__c = 10;	
								
		ctrl.saveRecordsAndClose();
		ctrl.saveRecords();
		
		// 3 on modifie
		stdCtrl = new ApexPages.StandardController(e);
		ctrl = new AppNDFevenementCtrl(stdCtrl);
		
		// 4 on est sur la page de récap
		System.currentPageReference().getParameters().put('idNDF', ctrl.oNDF.Id);
		stdCtrl = new ApexPages.StandardController(e);
		ctrl = new AppNDFevenementCtrl(stdCtrl);
		
		// 5 on supprime tout
		ctrl.deleteAll();
	
		
		Test.stopTest();

    }
    
	public static testmethod void testAppNDFrecapListCtrl(){
		
		List<User> users = [SELECT Id FROM User WHERE IsActive = true AND UserType = 'Standard' LIMIT 10];
		
		List<Note_De_Frais_Recap__c> recaps = new List<Note_De_Frais_Recap__c>(); 
		
		for(Integer i = 0; i < 10; i++){
			recaps.add(new Note_De_Frais_Recap__c(
				Collaborateur__c = users[i].Id,
				Etape__c = 'En cours',
				Date_fin_de_periode__c = date.newinstance(2013, 5, 19),
				Date_debut_de_periode__c = date.newinstance(2013, 4, 20)));
		}
		
		insert recaps;
		
		
		/*
		*	Debut des tests
		*/
		Test.startTest();
		
		
		
		//Appel du constructeur
		PageReference recapListPage = Page.AppNDFrecapList;
		
		Test.setCurrentPage(recapListPage);
		System.currentPageReference().getParameters().put('periode', '2013-05');
		System.currentPageReference().getParameters().put('user', 'tous');
		AppNDFrecapListCtrl ctrl = new AppNDFrecapListCtrl();
		object ret = ctrl.lsEtapesNonVides;
        ret = ctrl.getLsMoisOption();
        ret = ctrl.getLsAnneeOption();
        ret = ctrl.getLsUserOption();
		//On a 10 recap "En cours"
		system.assertEquals(10, ctrl.mpRecapsParEtape.get('En cours').size());	
		
		
		//On va soumettre pour approbation les 3 premiers recaps
		List<Approval.ProcessSubmitRequest> reqs = new List<Approval.ProcessSubmitRequest>{new Approval.ProcessSubmitRequest(), new Approval.ProcessSubmitRequest(), new Approval.ProcessSubmitRequest()};
		reqs[0].setObjectId(recaps[0].Id);
		reqs[1].setObjectId(recaps[1].Id);
		reqs[2].setObjectId(recaps[2].Id);
        List<Approval.ProcessResult> results = Approval.process(reqs);
		
		
		ctrl.viewRecapList();
		
		//On a 3 recap "Soumis pour approbation"
		//system.assertEquals(3, ctrl.mpRecapsParEtape.get('Soumis pour approbation').size());		
		
		//On test la methode approve() avec des mauvais parametres
		recapListPage.getParameters().put('recapId', recaps[0].Id);
		recapListPage.getParameters().put('action', 'wrong');
		ctrl.approve();
		ctrl.viewRecapList();
		//On a 3 toujours recap "Soumis pour approbation"
		//system.assertEquals(3, ctrl.mpRecapsParEtape.get('Soumis pour approbation').size());		
		
		
		//On approuve le 1er recap
		recapListPage.getParameters().put('action', 'Approve');
		ctrl.approve();
		
		
		//On rejete le 2eme recap
		recapListPage.getParameters().put('recapId', recaps[1].Id);
		recapListPage.getParameters().put('action', 'Reject');
		ctrl.sRejectComment = 'Commentaire rejet';
		ctrl.approve();
		
		Test.stopTest();
	}
    public static testmethod void testAppNDFrecapCtrl(){
   		AppNDFtestBase.Init();
		AppNDFtestBase.initRecap();
		AppNDFtestBase.initNDF();
		AppNDFtestBase.initNDFdepense();
		
		Test.startTest();
		
		System.currentPageReference().getParameters().put('id', AppNDFtestBase.oNDFrecap.Id);
		
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(AppNDFtestBase.oNDFrecap);
		AppNDFrecapCtrl ctrl = new AppNDFrecapCtrl(stdCtrl);
		
		Test.stopTest();
    }
    
    public static testmethod void testAppNDFexportComptaCtrl(){
				
		AppNDFtestBase.Init();
		AppNDFtestBase.initRecap();
		
		Test.startTest();
		
		System.currentPageReference().getParameters().put('debut', '01/01/2013');
		System.currentPageReference().getParameters().put('fin', '31/01/2013');
		
		AppNDFexportComptaCtrl ctrl = new AppNDFexportComptaCtrl();
		
		Test.stopTest();
		
    }
    
    public static testmethod void testAppNDFsftreeComponentCtrl(){
    	AppNDFtestBase.Init();
		AppNDFtestBase.initRecap();
		
		Test.startTest();
		
		AppNDFsftreeComponentCtrL ctrl = new AppNDFsftreeComponentCtrl();
		
		Test.stopTest();
    }
    
	public static testmethod void testAppNDFrecapFullComponent(){
		AppNDFtestBase.Init();
		AppNDFtestBase.initRecap();
		AppNDFtestBase.initNDF();
		AppNDFtestBase.initNDFdepense();
		
		Test.startTest();
		
		AppNDFrecapFullComponent ctrl = new AppNDFrecapFullComponent();
		ctrl.oNDFrecap = AppNDFtestBase.oNDFrecap;
		ctrl.initVar();
		Object ret = ctrl.lsNDFdepenseHistory;
        ret = ctrl.lsNDFevent;
        ret = ctrl.lsNDFlibre;
        ret = ctrl.mpEvent;
        ret = ctrl.iLsDepenseSize;
        ret = ctrl.iLsFraisKiloSize;
        
		Test.stopTest();
	}
}