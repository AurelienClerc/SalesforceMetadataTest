/*
*
* GILDAS 17/11/2014 
*Classe de Test du trigger de la creation automatique de missions et de société à auditer pour tous les années concernées 
*Test du controleur des missions LDB(AppLDBmissionCtrl)
*
*/
@isTest
private class AppLDB_Test {

    private static testMethod void test() {
        /*
        Test du trigger de creation automatique des missions de type LDB 
        */
        //Initialisation de l'ensemble des recordType necessaires
        String brasilAccountRT, brasilContractRT, brasilMissionRT;
        for (RecordType rec : [SELECT Id, SobjectType, DeveloperName FROM RecordType WHERE SobjectType IN ('Account', 'Contract', 'Mission__c') AND DeveloperName IN ('BRASIL_ACCOUNT', 'LDB')]){
            if(rec.SObjectType == 'Account' && rec.DeveloperName == 'BRASIL_ACCOUNT')
                brasilAccountRT = rec.Id;
            else if (rec.SObjectType == 'Contract' && rec.DeveloperName == 'LDB')
                brasilContractRT = rec.Id;
            else if(rec.SObjectType == 'Mission__c' && rec.DeveloperName == 'LDB')
                brasilMissionRT = rec.Id;
        }
        // Création de deux instances de compte une pour le compte du contrat et l'autre pour la c=société à auditer rattaché au contrat
        Account acct = new Account(Name = 'Test 1',Siret__c='12345678900001',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',  RecordTypeId = brasilAccountRT);
        Account soc = new Account(Name = 'Test Compte Contract',Siret__c='12385678970111',Type_d_etablissement__c = 'Filiale', BillingPostalCode = '93700', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie',RecordTypeId = brasilAccountRT);
        
        
        insert new List<Account>{acct, soc};
        
        Contract ctr = new Contract(AccountId = acct.Id, Name ='Contract test' , Status = 'Non activé', Annees_concernees__c = '2012;2013;2014', RecordTypeId = brasilContractRT);

        insert ctr;
        Societe_a_auditer__c societeAuditer = new Societe_a_auditer__c(Societe_a_auditer__c = soc.Id, Contract__c = ctr.Id);
        insert societeAuditer;
        
       
        
        Test.startTest();
        ctr.Status = 'Activé';
        update ctr;
        Contract con = [Select Id, (Select Id,RecordTypeId From Missions__r) From Contract Where Id =: ctr.Id ][0];
        System.assertEquals(6, con.Missions__r.size());
        System.assertEquals(brasilMissionRT, con.Missions__r[0].RecordTypeId);
        
        
        //Test du controller AppLDBmissionCtrl
        PageReference p = new pageReference( '/apex/AppLDBmissionEdit' );
        Test.setCurrentPage(p);
        AppLDBmissionCtrl ctrl = new AppLDBmissionCtrl( new ApexPages.StandardController(con.Missions__r[0]) );
        ctrl.saveAndReturn();
        
        Test.StopTest();
        
    }

}