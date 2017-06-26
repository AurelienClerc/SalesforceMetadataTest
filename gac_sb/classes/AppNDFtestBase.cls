/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
 
@isTest
public class AppNDFtestBase {

    public static List<Account> lsAccounts;
    public static List<Event> lsEvents;
    public static Note_De_Frais_Recap__c oNDFrecap;
    public static List<Note_De_Frais__c> lsNDF;
    public static List<Note_De_Frais_Depense__c> lsNDFdepense;
    
    static Map<String,Id> recordTypes;
    static List<Note_De_Frais_Nature_Depense__c> lsNatures;
    static Set<Id> setAccountsIds;
    static Set<Id> setEventsIds;
    
    static void refreshAccount(){
        lsAccounts = [select Id,Name
                    from Account WHERE Name like 'TestNDF %' order by name ASC];
                    
        setAccountsIds = new Set<Id>();
        for(Account a:lsAccounts){
            setAccountsIds.add(a.Id);
        }
    }
    
    public static void Init(){

        initRecordTypes();
        initNatures();
        
        
        Account[] Accs = new Account[]{
            new Account(Name = 'TestNDF 1',Siret__c='12343678900001', BillingStreet = '1 avenue de la cristallerie', BillingCity = 'SEVRES' , BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie')
        };
        
        insert Accs;
        refreshAccount();
        
        initEvents();
        
    }
    
    public static Note_De_Frais_Nature_Depense__c getNature(String sType){
        Note_De_Frais_Nature_Depense__c n;
        if(sType == 'TTC')
            n = lsNatures.get(0);
        
        if(sType == 'HT')
            n = lsNatures.get(1);
        
        if(sType == 'Frais')
            n = lsNatures.get(2);
            
        return n;
    }
    
    static void initNatures(){
        lsNatures = new Note_De_Frais_Nature_Depense__c[]{
            new Note_De_Frais_Nature_Depense__c(
                Type__c = 'TTC',
                Categorie__c = 'Train',
                Name = 'Train',
                Aide__c = 'Help',
                Pays__c = 'France',
                Actif__c = true),
            new Note_De_Frais_Nature_Depense__c(
                Type__c = 'HT',
                Name = 'Avion',
                Categorie__c = 'Avion',
                Aide__c = 'Help',
                Pays__c = 'France',
                Actif__c = true),
            new Note_De_Frais_Nature_Depense__c(
                Type__c = 'Frais Kilométrique',
                Name = 'Frais Kilométrique',
                Categorie__c = 'Frais Kilométrique',
                Pays__c = 'France',
                Aide__c = 'Help',
                Actif__c = true)
        };
        
        insert lsNatures;
        
    }
    
    
    static void initRecordTypes(){
        recordTypes = new Map<String,Id>();
        for(RecordType rtype : [SELECT Id, SobjectType, DeveloperName FROM RecordType WHERE SobjectType='Event' or sObjectType = 'Note_De_Frais_Depense__c' or sObjectType = 'Note_De_Frais__c']){
            recordTypes.put(rtype.SobjectType + '_' + rtype.DeveloperName, rtype.Id);
        }
    }
    
    static void initEvents(){
        Event[] Evts = new Event[]{
                new Event(
                    Subject = 'Test 1',
                    RecordTypeId = recordTypes.get('Event_RDV_Commercial') ,
                    WhatId = lsAccounts[0].Id,
                    startDateTime = datetime.now()-5,
                    endDateTime = datetime.now(),
                    objet_evenement__c = 'RDV Commercial',
                    nature_evenement__c = 'RDV Physique')
        };
        
        insert Evts;
        refreshEvents();
    }

    static void refreshEvents(){
        lsEvents = [select Id, Subject, WhatId, AccountId, What.Type
                    from Event WHERE Subject like 'Test%' order by Subject ASC];
                    
        setEventsIds = new Set<Id>();
        for(Event e:lsEvents){
            setEventsIds.add(e.Id);
        }
    }
    
    public static void initRecap(){
        
        oNDFrecap = new Note_De_Frais_Recap__c(
            Date_fin_de_periode__c = date.today() - 15,
            Date_Debut_De_Periode__c = date.today() + 15,
            Collaborateur__c = UserInfo.getUserId()
        );
        
        insert oNDFrecap;
    }
    
    public static void initNDF(){
        
        lsNDF = new List<Note_De_Frais__c> {
            new Note_De_Frais__c(
                RecordTypeId = recordTypes.get('Note_De_Frais__c_Libre'),
                Recap_Note_De_Frais__c = oNDFrecap.Id,
                Date_Des_Frais__c = date.today()),
            new Note_De_Frais__c(
                RecordTypeId = recordTypes.get('Note_De_Frais__c_Evenement'),
                Recap_Note_De_Frais__c = oNDFrecap.Id,
                Evenement_Id__c = lsEvents[0].Id)
        };
        
        insert lsNDF;
    }
    
    public static void initNDFdepense(){
        system.debug(recordTypes);
        lsNDFdepense = new List<Note_De_Frais_Depense__c> {
            
            new Note_De_Frais_Depense__c(
                RecordTypeId = recordTypes.get('Note_De_Frais_Depense__c_Autre_Frais'),
                Note_De_Frais__c = lsNDF[0].Id,
                Nature_Depense__c = getNature('TTC').Id,
                Montant_TTC__c = 10
                ),
            new Note_De_Frais_Depense__c(
                RecordTypeId = recordTypes.get('Note_De_Frais_Depense__c_Autre_Frais'),
                Note_De_Frais__c = lsNDF[1].Id,
                Nature_Depense__c = getNature('TTC').Id,
                Montant_TTC__c = 10
                )
        };
        
        insert lsNDFdepense;
    }
}