@isTest
private class V2AP01_SegmentationManager_TEST {

    static{
        V2Params__c par = new V2Params__c(AutoSynchOpp__c = true,BuInno__c = 'CIR,FI,CIN',buOpti__c = 'ACS,TAT',BuFL__c ='IL',BuDescribeId__c='TEST BU');
        insert par;
    }

	private static testMethod void TestBasicMethods() {
        FactuTestBase.init();
        Account a = FactuTestBase.Accounts.get(0);
        test.startTest();
        V2AP01_SegmentationManager.datesMercato = new map<id,map<string,Date>>();
        V2AP01_SegmentationManager.datesMercato.put(a.id,new map<string,Date>{'CIR_date_Mercato__c'=> date.today()});
        a.CIR_Dans_le_dispositif__c = 'Oui';
        a.CIR_Concurrent__c = 'Test Concurrent';
        update a;
        Historique_Segmentation__c h = V2AP01_SegmentationManager.applyToHisto(a, null);
        system.assertEquals(date.today().year(), h.annee__c);
        system.assertEquals('Oui', h.CIR_Dans_le_dispositif__c);
        
        h.CIR_Effectif_RD__c = 30;
        Account a2 = V2AP01_SegmentationManager.ApplyToAccount(h,a.id);
        a2.CIR_Concurrent__c = 'Test Concurrent';
        system.assertEquals(30, a2.CIR_Effectif_RD__c);
        Opportunity o = new Opportunity(AccountId = a2.id);
        V2AP01_SegmentationManager.applyToOpp(a2,o,'CIR',true);
        system.assertEquals('Test Concurrent', o.concurrent__c);
        test.stopTest();
        
	}
	
	private static testMethod void testTriggerSegmentationHandler(){
	    Account a =  new Account(Name = 'TestFactu 1',Siret__c='12343678900001', BillingStreet = '1 avenue de la cristallerie', BillingCity = 'SEVRES' , BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',
	    CIR_Dans_le_dispositif__c = 'Oui',CIR_Concurrent__c='Test Concurrent');
        insert a;
        Historique_Segmentation__c h = V2AP01_SegmentationManager.applyToHisto(a, null);  
        h.compte__c = a.id;
        insert h;
        Historique_SegmentationHandler.bAlreadyDone = false;
        Historique_SegmentationHandler.lAccountToUp.clear();
        test.startTest();
        h.CIR_Dans_le_dispositif__c = 'Non';
        update h;
        Account a2 = [SELECT id,CIR_Dans_le_dispositif__c from account where id = :a.id][0];
        system.assertEquals('Non', a2.CIR_Dans_le_dispositif__c);
        delete h;   //Couverture uniquement
	    
	}
	
	private static testMethod void TestSF2VFC02_AccountFRView(){
	     //FactuTestBase.init();
        Account a = new Account(Name = 'TestFactu 1',Siret__c='12343678900001', BillingStreet = '1 avenue de la cristallerie', BillingCity = 'SEVRES' , BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie');
        insert a;
	     //Insertion d'un produit field id
	     insert new FieldIds__c(Name = 'Task.Produit__c',id__c='000000000000000');
	     Contact[] cons = new Contact[]{
	            new Contact(LastName = 'Test Contact', AccountId=a.id),
	            new Contact(LastName = 'Test Contact 2', AccountId=a.id)
	     };
	     insert cons;
	    Contact con0 = cons.get(0);
        Contact con1 = cons.get(1);
	     AccountContactRole[] oACRs = new AccountContactRole[]{
	         new AccountContactRole(AccountId = a.id, role = 'Interlocuteur commerce CIR',ContactId = con0.id),
	         new AccountContactRole(AccountId = a.id, role = 'Interlocuteur facturation CIR',ContactId = con0.id)
	     };


	     insert oACRs;
	     
	     AccountContactRole oIntCommerce = oACRs.get(0);
	     
	     test.startTest();
	     //Test du controller du composant:(couverture)
	     SF2VFC02_AccountFRView ctrlComp = new SF2VFC02_AccountFRView();
	     
	     //Test du vrai controller
	     ApexPages.StandardController sc = new ApexPages.StandardController(a);
	     SF2VFC02_AccountFRView ctrl = new SF2VFC02_AccountFRView(sc);
	     system.assertEquals(ctrl, ctrl.getCtrl());
	     
	     ctrl.getFieldsByBu();
	     ctrl.SwitchEdit();
	     system.assert(ctrl.bEdit);
	     Historique_Segmentation__c h = ctrl.lHistos.get(0);
         h.CIR_Budget_R_D__c = h.CIR_Effectif_RD__c = h.CIR_Depenses_eligibles__c = h.CIR_Dernier_CIR__c = 2010;
         h.CIR_Annee_dernier_CIR__c = '2010';
         h.CIR_Dans_le_dispositif__c = 'Non';
         h.type_de_credit_d_impot__c = 'CIR + CII + JEI';
	     h.CIR_enjeux_opportunite__c = 'PREMIUM';
	     
	     ctrl.refContactRoles.get(oIntCommerce.role).contactId = con1.id;
	     ctrl.refContactRoles.get('Interlocuteur facturation CIR').contactID = null;
	     ctrl.refContactRoles.get('Interlocuteur mission CIR').contactID = con0.id;
	     
	     ctrl.saveSegmentation();
	     
	     if(ApexPages.hasMessages()){
	         string msg = 'On ne devrait pas avoir de message d\'erreur, on obtient:';
	         for(ApexPages.Message m : ApexPages.getMessages()){
	             msg += m.getDetail();
	         }
	         system.assert(false,msg);
	     }
	     
	     
	     test.stopTest();
	     Map<Id,AccountContactRole> refACRs = new map<Id,AccountContactRole>([Select id, contactId, role from AccountContactRole where isDeleted = false]);
	     Account a2 = [Select id,CIR_Effectif_RD__c,CIR_Concurrent__c from account where id = : a.id Limit 1 ][0];
	     
	     system.assertEquals(2, refACRs.size());                                    //Test de la bonne insertion du nouveau role de contact
	     system.assert(!refACRs.containsKey(oACRs.get(1).id));                       //Test de la suppression du contact
	     system.assertEquals(con1.id,refACRs.get(oIntCommerce.id).contactId);    //Test de la modification de contact
	     
	     system.assertEquals(2010, a2.CIR_Effectif_RD__c);
	     ctrl.cancelSegmentation();
	}
	
	private static testMethod void TestSF2VFC02_AccountFRViewWithError(){
	    FactuTestBase.init();
	    Account a = FactuTestBase.Accounts.get(0);
	    test.startTest();
	     ApexPages.StandardController sc = new ApexPages.StandardController(a);
	     SF2VFC02_AccountFRView ctrl = new SF2VFC02_AccountFRView(sc);  // Erreur static, exception catchée
	    system.assert(ApexPages.hasMessages(ApexPages.severity.FATAL));
	    apexPages.getMessages().clear();
	    //On essaye d'enregistrer une valeur txt dans un champs numéro
	    ctrl.lHistos.get(0).put('IL_nb_sites_commerce__c',1234567); //ERREUR Sur l'update d'une opportunité liée
	    ctrl.saveSegmentation();
	    system.assert(ApexPages.hasMessages(ApexPages.severity.FATAL));
	    test.stopTest();
	}

    private static testMethod void TestPopulateOpportunity(){
        FactuTestBase.init();
        Opportunity o = FactuTestBase.Opportunities.get(0);
        o.AccountId = FactuTestBase.Accounts.get(0).id;
        ApexPages.StandardController sc = new ApexPages.StandardController(o);
	    SF2VFP01_UpdateOpportunitySegmentation ctrl = new SF2VFP01_UpdateOpportunitySegmentation(sc);
	    ctrl.populateAndRedirect();
	    //system.assert(ApexPages.hasMessages()); //On a forcément un message catché d'erreur étant donné qu'on a pas rempli de RV
    }
    
    private static testMethod void Testv2AP02_Concurrents(){
         Account a = new Account(Name = 'TestFactu 1',Siret__c='12343678900001', BillingStreet = '1 avenue de la cristallerie', BillingCity = 'SEVRES' , BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie');
        insert a;
         Integer year = Date.today().year();
         test.startTest();
         Historique_Segmentation__c h = new Historique_Segmentation__c(Annee__c = year - 3, compte__c = a.id);
         h.CIR_Concurrent__c = 'Test Concurrent';
         h.CIR_annees_concernees_concurrent__c = (year -3)+';'+(year-2)+';'+(year-1)+';'+year;
         h.CIR_Budget_R_D__c = h.CIR_Effectif_RD__c = h.CIR_Depenses_eligibles__c = h.CIR_Dernier_CIR__c = 2010;
         h.CIR_Annee_dernier_CIR__c = '2010';
         h.CIR_Dans_le_dispositif__c = 'Non';
         h.type_de_credit_d_impot__c = 'CIR + CII + JEI';
          h.CIR_enjeux_opportunite__c = 'PREMIUM';
         insert h;
         Historique_Segmentation__c[] lHistos = [Select id , CIR_Concurrent__c from Historique_Segmentation__c where compte__c = : a.id];
         Account a2 = [Select id , CIR_Concurrent__c from Account where Id = : a.id LIMIT 1];
         system.assertEquals(4, lHistos.size());
         system.assertEquals('Test Concurrent', lHistos.get(0).CIR_Concurrent__c);
         system.assertEquals('Test Concurrent', lHistos.get(1).CIR_Concurrent__c);
         system.assertEquals('Test Concurrent', a2.CIR_Concurrent__c);
         system.debug('1ere partie du test effectuée; on continue');
         test.stopTest();
         
         //On reset le trigger bAlreadyDone
         Historique_SegmentationHandler.bAlreadyDone = false;
         Historique_Segmentation__c h2 = new Historique_Segmentation__c(Annee__c = year - 4, compte__c = a.id);
         h2.CIR_Concurrent__c = 'Test Concurrent 2';
         h2.CIR_annees_concernees_concurrent__c = (year -4)+';'+(year-3);
         h2.ACS_Concurrent__c = 'Test Concurrent 3';
         h2.ACS_annees_concernees_concurrent__c = (year -4)+';'+(year-3);
         Historique_Segmentation__c h3 = new Historique_Segmentation__c(Annee__c = year -5, compte__c = a.id); //On insere un autre historique pour vérifier les update concurrrent
         h3.TAT_Concurrent__c = 'Test Concurrent TAT';
         h3.TAT_annees_concernees_concurrent__c = (year -5)+';'+ (year -4)+';'+(year-3);
         insert new Historique_Segmentation__c[]{h2,h3};
         //On vérifie qu'on n' overwrite pas le cir et qu'on rempli l'ACS
         Historique_Segmentation__c[] lHistos2 = [Select id , CIR_Concurrent__c, ACS_Concurrent__c,TAT_Concurrent__c, annee__c from Historique_Segmentation__c where compte__c = : a.id and (annee__c = : (year-3) OR annee__c = : (year-4)) order by Annee__c ASC];
         system.assertEquals('Test Concurrent 2', lHistos2.get(0).CIR_Concurrent__c, 'Annee : '+ lHistos2.get(0).annee__c+ ' CIR champ concurrent ');
         system.assertEquals('Test Concurrent', lHistos2.get(1).CIR_Concurrent__c, 'Annee : '+ lHistos2.get(1).annee__c+' CIR champ concurrent ');  //Ne doit pas avoir été mis a jour
         system.assertEquals('Test Concurrent 3', lHistos2.get(1).ACS_Concurrent__c, 'Annee : '+ lHistos2.get(1).annee__c+' ACS champ concurrent ');
         system.assertEquals('Test Concurrent TAT', lHistos2.get(1).TAT_Concurrent__c, 'Annee : '+ lHistos2.get(1).annee__c+' TAT champ concurrent ');
         system.assertEquals('Test Concurrent TAT', lHistos2.get(0).TAT_Concurrent__c, 'Annee : '+ lHistos2.get(0).annee__c+' TAT champ concurrent ');
         
    }

}