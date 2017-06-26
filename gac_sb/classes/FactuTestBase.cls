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
public class FactuTestBase {

  public static List<Account> Accounts;
  public static List<Opportunity> Opportunities;
  public static List<Contract> Contracts {get;set;}
  public static List<Mission__c> Missions {get;set;}
  public static List<Prevision_de_facturation__c> Planifications {get;set;}
  public static List<Facture__c> Factures {get;set;}  
  public static List<Prevision_encaissement__c> Previsions {get;set;}  
  
  static Set<Id> AccountsIds;
  static Set<Id> OpportunitiesIds;
  static Set<Id> ContractsIds;
  static Set<Id> MissionsIds;
  
  static Map<String,Id> OpportunityRecordTypes;
  static Map<String,Id> ContractRecordTypes;
  static Map<String,Id> MissionRecordTypes;
  static Map<String,Id> PlanificationRecordTypes;
  static Map<String,Id> FactureRecordTypes;
  
  static void refreshAccount(){
    Accounts = [select Id,Name,
          (Select Id,recordTypeId,recordType.DeveloperName, Name from Opportunities)
          from Account WHERE Name like 'TestFactu %' order by name ASC];
          
    AccountsIds = new Set<Id>();
    for(Account a:Accounts){
      AccountsIds.add(a.Id);
    }
  }
  
  static void refreshOpportunity(){
    Opportunities = [select Id,Name,RecordTypeId from Opportunity WHERE AccountId IN:AccountsIds order by name ASC];
    
    OpportunitiesIds = new Set<Id>();
    for(Opportunity o:Opportunities){
      OpportunitiesIds.add(o.Id);
    }
  }
  
  static void refreshContract(){
    Contracts = [Select Id,RecordTypeId,ContractNumber,RecordType.developerName,Account.Name,Account.Id,Conditions_de_renouvellement__c,Conditions_de_facturation__c,Conditions_de_paiement__c,Conditions_de_remuneration__c,Precision_facturation__c,Precision_paiement__c,Precision_remuneration__c,Consultant_Commercial__c,Consultant_Commercial__r.Name,Conditions_particuli_res__c,ContractTerm,Preavis_de_resiliation__c,Remuneratuin_future__c,Taux_de_remuneration__c from Contract WHERE AccountId IN:AccountsIds];
    
    ContractsIds = new Set<Id>();
    for(Contract c:Contracts){
      ContractsIds.add(c.Id);
    }
  }
  
  static void refreshMission(){
    Missions = [Select Id,RecordTypeId,Name,RecordType.developerName,Contrat__c,Contrat__r.ContractNumber,Contrat__r.Entite_GAC__c,Contrat__r.N_compte_client__c,Contrat__r.Conditions_de_remuneration__c,
            (Select Id,Name,Prevision_HT__c,Statut__c,Mois__c,Periode_debut__c,Periode_fin__c,Typologie_facturation__c,Nature_facturation__c,Commentaire_prevision__c,Dossier_salarie__c,Produit__c FROM Planifications_de_facturation__r WHERE Statut__c = 'Prévue' ORDER BY Date_prevue__c ASC)
          from Mission__c WHERE Contrat__c IN:ContractsIds];
    
    MissionsIds = new Set<Id>();
    for(Mission__c m:Missions){
      MissionsIds.add(m.Id);
    }
  }
  
  public static void refreshFacture(){
    Factures = [Select Id, Entite_GAC__c, Contrat__c, Mission__c, RecordType.developerName,RecordTypeId, Statut__c, Montant_TTC__c, Account_Record_Type__c, Commentaires_recouvrement__c, Date_de_derniere_relance__c, (Select Id, Description__c, Montant_HT__c, Ordre__c FROM Details_facture__r)
          from Facture__c WHERE Mission__c IN:MissionsIds];
  }
  public static void refreshPrevisions(){
    Previsions = [Select Id, Date_prevue__c 
          from Prevision_encaissement__c WHERE Facture__c IN:Factures];
  }
  
  
  /**
  *  EDIT THIBAULT 14/02/2014 pour remplacer InitContractRecordType(), InitMissionRecordType(), InitPlanificationRecordType(), InitOpportunityRecordType et InitFactureRecordType()
  *  Pour réduire le nombre de SOQL queries
  */
  static void InitRecordTypes(){
    ContractRecordTypes = new Map<String,Id>();
    MissionRecordTypes = new Map<String,Id>();
    PlanificationRecordTypes = new Map<String,Id>();
    OpportunityRecordTypes = new Map<String,Id>();
    FactureRecordTypes = new Map<String,Id>();
    List<String> sObjectTypes = new List<String>{'Contract', 'Mission__c', 'Prevision_de_facturation__c', 'Opportunity', 'Facture__c'};
    
    for(RecordType rtype : [SELECT Id , DeveloperName, SobjectType FROM RecordType WHERE SobjectType IN :sObjectTypes]){
      if(rtype.SobjectType == 'Contract')
        ContractRecordTypes.put(rtype.DeveloperName,rtype.Id);
      else if(rtype.SobjectType == 'Mission__c')
        MissionRecordTypes.put(rtype.DeveloperName,rtype.Id);
      else if(rtype.SobjectType == 'Prevision_de_facturation__c')
        PlanificationRecordTypes.put(rtype.DeveloperName,rtype.Id);
      else if(rtype.SobjectType == 'Opportunity')
        OpportunityRecordTypes.put(rtype.DeveloperName,rtype.Id);
      else if(rtype.SobjectType == 'Facture__c')
        FactureRecordTypes.put(rtype.DeveloperName,rtype.Id);  
      
    }
    
  }
  
  /*
  static void InitContractRecordType(){
    ContractRecordTypes = new Map<String,Id>();
    for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Contract']){
      ContractRecordTypes.put(rtype.DeveloperName,rtype.Id);
    }
  }
  
  static void InitMissionRecordType(){
    MissionRecordTypes = new Map<String,Id>();
    for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Mission__c']){
      MissionRecordTypes.put(rtype.DeveloperName,rtype.Id);
    }
  }
  
  static void InitPlanificationRecordType(){
    PlanificationRecordTypes = new Map<String,Id>();
    for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Prevision_de_facturation__c']){
      PlanificationRecordTypes.put(rtype.DeveloperName,rtype.Id);
    }
  }
  
  static void InitOpportunityRecordType(){
    OpportunityRecordTypes = new Map<String,Id>();
    for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Opportunity']){
      OpportunityRecordTypes.put(rtype.DeveloperName,rtype.Id);
    }
  }
  
  static void InitFactureRecordType(){
    FactureRecordTypes = new Map<String,Id>();
    for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Facture__c']){
      FactureRecordTypes.put(rtype.DeveloperName,rtype.Id);
    }
  }
  */
  
  public static void InitFactures(){
    Factures = new Facture__c[]{
      createFacture(0,0,'Facture_non_valide'),
      createFacture(1,1,'Facture_non_valide'),
      createFacture(2,2,'Facture_non_valide'),
      createFacture(3,3,'Facture_non_valide'),
      createFacture(4,4,'Facture_non_valide'),
      createFacture(4,5,'Avoir_non_valide')
    };
    insert Factures;
    refreshFacture();
  }
  
  public static void InitPrevEncaissement(){
     Previsions = new Prevision_encaissement__c[]{
       createPrevision(0),
       createPrevision(1),
       createPrevision(2),
       createPrevision(3),
       createPrevision(4)
     };
     insert Previsions;
     refreshPrevisions();
  }
  
  public static void Init(){
    InitRecordTypes();

    Accounts = new Account[]{
      new Account(Name = 'TestFactu 1',Siret__c='12343678900001', BillingStreet = '1 avenue de la cristallerie', BillingCity = 'SEVRES' , BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie')
    };
    insert Accounts;
    refreshAccount();

    
    Opportunities = new Opportunity[]{
      createOppFermeeGagnee('test 1',0,'CIR'),
      createOppFermeeGagnee('test 2',0,'ACS'),
      createOppFermeeGagnee('test 3',0,'TAT'),
      createOppFermeeGagnee('test 4',0,'IL'),
      createOppFermeeGagnee('test 5',0,'FI')
    };
    insert Opportunities;
    refreshOpportunity();
    refreshAccount();
    
    Contracts = new Contract[]{
      createContract(0,'CIR'),
      createContract(0,'ACS'),
      createContract(0,'TAT'),
      createContract(0,'IL'),
      createContract(0,'FI')
    };
    insert Contracts;
    refreshContract();
    
    Missions = new Mission__c[]{
      createMission(0,'CIR'),
      createMission(1,'ACS'),
      createMission(2,'TAT'),
      createMission(3,'IL'),
      createMission(4,'FI')
    };
    insert Missions;
    refreshMission();
    
    
    Planifications = new Prevision_de_facturation__c[]{
      createPlanif(0,'CIR',2500.00),
      createPlanif(1,'ACS',1500.56),
      createPlanif(2,'TAT',5000.00),
      createPlanif(3,'IL',250.00),
      createPlanif(4,'FI',500.00),
      createPlanif(4,'FI',-500.00)
    };
    
    
    
    Planifications.get(5).Type_d_avoir__c = 'Non provisionné';
    insert Planifications;
    refreshMission();
    
    
  }


  static Opportunity createOppFermeeGagnee(String Name,Integer AccountKey,string Type){
    Opportunity o = new Opportunity(Name = Name, AccountId = Accounts.get(AccountKey).Id, RecordTypeId = OpportunityRecordTypes.get(Type),StageName = 'Fermée gagnée',closeDate = Date.today(), type_de_compte__c = Name,
                Suivi_proposition__c = 'test',Type_de_mission_multi__c='test',Type_de_contrat__c='test',Conditions_de_facturation__c='test',Condition_de_paiement__c='test',Annees_intervention__c='2011;2012;2013;2014;2015',Amount=5000,
                Probability=100,Condition_de_r_mun_ration__c='test',Decision__c='test',Perimetre__c='test',Concurrent__c='test',Date_1er_RDV__c = date.today(),Contexte__c='test',
                Attente_Besoin__c='test',Enjeux__c='test',Timing_Prochaine_etape__c='test',Processus_de_decision__c='test',Objections__c='test',Origine_du_RDV__c = System.Userinfo.getUserId(),Date_dernier_RDV__c = date.today(),
                Conditions_de_renouvellement__c='Tacite',Date_de_validation_RDV__c = date.today(),Enjeux_opportunite__c = 'test',type = 'test',
                FI_Type_d_aide_envisagee__c = 'test');
    if(Type == 'CIR' || Type == 'FI'){
      o.CIR_Budget_R_D__c = o.CIR_Effectif_RD__c = o.CIR_Depenses_eligibles__c = o.CIR_Dernier_CIR__c = 2010;
      o.CIR_Annee_dernier_CIR__c = '2010';
      o.CIR_Dans_le_dispositif__c = 'Non';
      //DIDIER 13022014 nouveau champs type de credit d impot
      if(type == 'CIR')
        o.type_de_credit_d_impot__c = 'CIR + CII + JEI';
    }
    else if(Type == 'IL' ){
      o.IL_Typologie_site__c = o.Ev_nement_juridique__c = o.IL_Dernier_controle_fiscal__c = o.Montant_CFE__c = o.Montant_TB__c = o.Montant_TF__c= o.Montant_CVAE__c= 'test' ;
    }
    else if(Type == 'ACS'){
      o.ACS_effectif_concerne__c = o.ACS_bas_salaires__c = o.ACS_MS_concernee__c = o.ACS_Nb_itinerants__c = o.ACS_absenteisme__c = 220;
      o.ACS_Service_paie_ext__c = true;
    }
    else if(Type == 'TAT'){
      o.TAT_Taux_AT_MP_n__c = o.ACS_MS_concernee__c = o.ACS_Nb_itinerants__c =o.TAT_Montant_IPP__c =o.TAT_Montant_IT__c= o.ACS_absenteisme__c = 220;
      o.TAT_Nb_IT_20__c = o.TAT_Nb_IPP__c = 'Non';
    }
    return o;
  }

  static Contract createContract(Integer AccountKey,String rType){
    map<String,Integer> typesNumber = new Map<String,Integer>{'CIR'=>0,'ACS'=>1,'TAT'=>2,'IL'=>3,'FI'=>4};
    
    return new Contract( Status = 'Non activé',
               AccountId = Accounts.get(AccountKey).Id,
               recordTypeId = ContractRecordTypes.get(rType),
               Opportunite__c=Accounts.get(AccountKey).Opportunities.get(typesNumber.get(rType)).Id,
               CustomerSignedDate = Date.valueOf('2012-03-03'),
               StartDate = Date.valueOf('2012-03-03'),
               Date_de_reception_du_contrat__c = Date.valueOf('2012-03-03'),
               Annees_concernees__c = '2012',
               Conditions_de_remuneration__c = 'Pourcentage',
               //DIDIER 12/05/2014 Rémy a mis une RV qui rend ce champs obligatoire pour les contrats TAT
               Conditions_de_facturation__c = 'A l\'accord contractuel',
               ContractTerm = 24);
    
  }
  
  static Mission__c createMission(Integer ContractKey, String rType){
    Mission__c m = new Mission__c (Name = 'test',
                  Contrat__c = Contracts.get(ContractKey).Id,
                  recordTypeId = MissionRecordTypes.get(rType)
                  );
    if(rType == 'CIR'){            
      m.Typologie_business__c = 'New Business';
      m.Annee_concernee__c = '2012';
    }
    return m;
  }
  
  static Facture__c createFacture(Integer MissionKey, Integer PlanificationKey, String rType){
      Facture__c f = new Facture__c (
                  Adresse__c = '1 avenue de la Cristallerie 92310 SEVRES',
                  Client__c = 'SYNEFO',
                  Contrat__c = Missions.get(MissionKey).Contrat__c,
                  Date__c = date.today(),
                  Echeance__c = date.today(),
                  Entite_GAC__c = Missions.get(MissionKey).Contrat__r.Entite_GAC__c,
                  Mission__c = Missions.get(MissionKey).Id,
                  Mode_de_paiement__c = 'A 30 jours',
                  Montant_HT__c = Planifications.get(PlanificationKey).Prevision_HT__c,
                  N_compte_client__c = Missions.get(MissionKey).Contrat__r.N_compte_client__c,
                  Reference__c = 'Optimisation',
                  Statut__c = 'En attente',
                  Taux_TVA__c = 0.196,
                  recordTypeId = FactureRecordTypes.get(rType)
                );
    return f;
  }
  
  static Prevision_encaissement__c createPrevision(Integer FactureKey){
    Date d = date.today().addMonths(-1); //On met les previsions au mois precedent pour pouvoir les décaler
    Prevision_encaissement__c p = new Prevision_encaissement__c(
      Facture__c = factures.get(FactureKey).id,
      Date_prevue__c = d,
      Montant_prevu_TTC__c = factures.get(FactureKey).montant_TTC__c
    );
    return p;
  }
  
  public static Prevision_de_facturation__c createPlanif(Integer MissionKey, String rType, Decimal prevHT){
    Prevision_de_facturation__c p = new Prevision_de_facturation__c (
                  Commentaire_prevision__c = 'test',
                  Contrat__c = Missions.get(MissionKey).Contrat__c,
                  Mission__c = Missions.get(MissionKey).Id,
                  Date_prevue__c = date.today() - 1,
                  Date_prevision_encaissement__c = date.today() + 1,
                  Prevision_HT__c = prevHT,
                  Statut__c = 'Prévue',
                  recordTypeId = PlanificationRecordTypes.get(rType)
                  );
    if(rType == 'CIR'){            
      p.Annees__c = '2013';
      p.Categorie_estimation__c = 'Estimé (après valorisation)';
      p.Date_prevision_encaissement__c = date.today();
      p.Motif_attente_facturation__c = 'CERFA pas encore remis au client';
      p.Prevision_basse__c = prevHT - 10;
      p.Prevision_haute__c = prevHT + 10;
    }
    if(rType == 'TAT'){            
      p.Annees_CE_concernees__c = 'New Business';
      p.Dossier_salarie__c = 'Pierre DUPONT';
      p.Periode_debut__c = date.today();
      p.Periode_fin__c = date.today();
      p.Typologie_facturation__c = 'Re-facturation';
      p.Nature_facturation__c = 'Facturation avec estimation';
      p.Motif_attente_facturation__c = 'Appel CPAM';
      p.Type_facturation__c = 'A l\'accord contractuel';
    }
    if(rType == 'ACS'){           
      p.Produit__c = 'Fillon';
    }
    if(rType == 'IL'){            
      p.Date_de_depot__c = date.today();
      p.Date_de_la_decision__c = date.today();
      p.Degrevements_estimes__c = prevHT + 3000;
      p.Lieu_d_imposition__c = 'Nom etablissement';
      p.Motifs__c = 'calcul CVAE';
      p.Office__c = prevHT + 3000;
      p.Saisie_du_TA__c = false;
      p.Taxe__c = 'CVAE';
    }
    return p;
  }

}