@isTest
public class AppATRecoursTrigger_Test {

    @isTest public static void testAppATRecoursTrigger(){
        
        //Création d'une mission en réutilisant le code de FactuTestBase
        FactuTestBase.Init();
        Mission__c missionAT;
        for(Mission__c m : FactuTestBase.Missions){
            if(m.RecordType.developerName == 'TAT'){
                missionAT = m;
                break;
            }
        }
        
        
        //Création organisme
        AppATorganisme__c org = new AppATorganisme__c(Name = 'organisme test');
        insert org;
        
        //Création dossier salarié
        AppATdossiersSalaries__c sal = new AppATdossiersSalaries__c(Name = 'dossier salarié test', Nom__c = 'dossier salarié test', DateSinistre__c = system.today(), Mission__c = missionAT.Id, NumeroSecuriteSociale__c = '1234567891234');
        insert sal;        
        
        test.startTest();

        List<AppATrecours__c> recToInsert = new List<AppATrecours__c> ();
        AppATrecours__c recour1 = new AppATrecours__c(OrganismeJuridiction__c = org.Id, DossierSalarie__c = sal.Id, Statut__c = 'Rejet');
        recToInsert.add(recour1);
        
        AppATrecours__c recour2 = new AppATrecours__c(OrganismeJuridiction__c = org.Id, DossierSalarie__c = sal.Id, Statut__c = 'Accord');
        recToInsert.add(recour2);
        
        insert recToInsert;
        
        org = [SELECT Id, NombreTotalRecours__c, NombreRecoursGagnes__c FROM AppATorganisme__c WHERE Id = :org.Id][0];
        
        system.assertEquals(2, org.NombreTotalRecours__c);
        system.assertEquals(1, org.NombreRecoursGagnes__c);
        
        
        test.stopTest();
    }
}