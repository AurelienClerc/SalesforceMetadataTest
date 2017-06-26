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
public class INNOtestBase {

	private static Map<String, Map<String, Id>> recordTypes = new Map<String, Map<String, Id>>();

	public static List<Account> Accs;
	public static List<Contract> Contracts;
	public static List<Opportunity> Opportunities;
	public static List<INNOmission__c> missions;
	public static List<INNOvalo__c> valos;


	private static void initRecordTypes(){
		for(RecordType rt : [SELECT Id, DeveloperName, SobjectType FROM RecordType WHERE SobjectType IN ('Contract', 'Opportunity', 'INNOmission__c', 'INNOvalo__c')]){
			if(!recordTypes.containsKey(rt.SobjectType))
				recordTypes.put(rt.SObjectType, new Map<String, Id>());
			
			recordTypes.get(rt.SObjectType).put(rt.DeveloperName, rt.Id);
		}
	}
	
	
    private static Opportunity createOppFermeeGagnee(Id AccountId,String Annees_intervention) {
        String type = 'CIR';
        String Name = 'Test';
        Opportunity o = new Opportunity(Name = Name, AccountId = AccountId, RecordTypeId = recordTypes.get('Opportunity').get(type), StageName = 'Fermée gagnée',closeDate = Date.today(), Amount=5000,Probability=100);
        
       
        
       /* type_de_compte__c = Name,
								Suivi_proposition__c = 'test',Type_de_mission__c='test',Type_de_contrat__c='test',Conditions_de_facturation__c='test',Condition_de_paiement__c='test',Annees_intervention__c=Annees_intervention,
								Condition_de_r_mun_ration__c='test',Decision__c='test',Perimetre__c='test',Concurrent__c='test',Date_1er_RDV__c = date.today(),Contexte__c='test',
								Attente_Besoin__c='test',Enjeux__c='test',Timing_Prochaine_etape__c='test',Processus_de_decision__c='test',Objections__c='test',Date_dernier_RDV__c = date.today(),
								Conditions_de_renouvellement__c='Tacite',Date_de_validation_RDV__c = date.today(),CIR_Enjeux_CIR__c = 'test',type = 'test',
								FI_Type_d_aide_envisagee__c = 'test');
		*/
		 //Pour éviter les erreurs lors du packaging de l'application
		o.put('Origine_du_RDV__c', System.Userinfo.getUserId());
		o.put('Type_de_compte__c', Name);
		o.put('Suivi_proposition__c', 'test');
		o.put('Type_de_mission_multi__c', 'test');
		o.put('Type_de_contrat__c', 'test');
		o.put('Conditions_de_facturation__c', 'test');
		o.put('Condition_de_paiement__c', 'test');
		o.put('Annees_intervention__c', Annees_intervention);
		o.put('Condition_de_r_mun_ration__c', 'test');
		o.put('Decision__c', 'test');
		o.put('Perimetre__c', 'test');
		o.put('Concurrent__c', 'test');
		o.put('Date_1er_RDV__c', date.today());
		o.put('Contexte__c', 'test');
		o.put('Attente_Besoin__c', 'test');
		o.put('Enjeux__c', 'test');
		o.put('Timing_Prochaine_etape__c', 'test');
		o.put('Processus_de_decision__c', 'test');
		o.put('Objections__c', 'test');
		o.put('Date_dernier_RDV__c', date.today());
		o.put('Conditions_de_renouvellement__c', 'Tacite');
		o.put('Date_de_validation_RDV__c', date.today());
		o.put('Enjeux_Opportunite__c', 'test');
		o.put('type', 'test');
		o.put('FI_Type_d_aide_envisagee__c', 'test');
		o.put('CIR_Budget_R_D__c', 123456);
		o.put('CIR_Effectif_RD__c', 123456);
		o.put('CIR_Depenses_eligibles__c', 123456);
		o.put('CIR_Dernier_CIR__c', 123456);
		o.put('CIR_Annee_dernier_CIR__c', '2010');
		o.put('CIR_Dans_le_dispositif__c', 'Non');
		
		//DIDIER 13022014 nouveau champs type de credit d impot
		o.put('type_de_credit_d_impot__c', 'CIR + CII + JEI');
		return o;
    }
    
    private static Contract createContract(Id AccountId, Id OpportunityId , String Year,String Annees_concernees){
		Contract c = new Contract( AccountId = AccountId,
							 Status = 'Non activé',
							 recordTypeId = recordTypes.get('Contract').get('CIR'),
							 CustomerSignedDate = Date.valueOf(Year + '-03-07'));
		
		//Pour éviter les erreurs lors du packaging de l'application						 
		c.put('Opportunite__c', OpportunityId);			
		c.put('Date_de_reception_du_contrat__c', date.today());	 
		c.put('Annees_concernees__c', Annees_concernees);
		return c;
		
	}
    
    private static Account createAccount(){
    	Account acc = new Account(Name = 'Test 1', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé');
    	
    	//Pour éviter les erreurs lors du packaging de l'application		
    	acc.put('Activity__c', 'Biotech, biologie');
    	acc.put('Date_de_creation_societe__c', system.today().addYears(-1));
    	acc.put('SIRET__c', '12345678900001');
    	acc.put('Type_d_etablissement__c', 'Principal'); 
    	
    	return acc;
    }
    
    
    private static INNOmission__c createMission(Id contractId, String accountName){
    	INNOmission__c mission = new INNOmission__c(Contrat__c = contractId,
		    										RecordTypeId = recordTypes.get('INNOmission__c').get('CIR'),
		    										Name = accountName + ' - CIR 2017',
		    										Taux_cir__c = 30,
		    										TauxCII__c = 20,
		    										Annee_CIR__c = '2017',
		    										Phase__c = 'Audit');
    	return mission;
    }
    
    private static INNOvalo__c createValo(Id filialeId, String filialeName, Id missionId){
    	INNOvalo__c valo = new INNOvalo__c(Entite__c = filialeId,
    										MissionCIR__c = missionId,
    										RecordTypeId = recordTypes.get('INNOvalo__c').get('CIR'),
    										Name = 'V2017 - ' + filialeName + ' - CIR',
    										Date_validation_perimetre__c = system.today(),
    										Date_envoi_valorisation__c = system.today());
    	return valo;
    }
    
    public static void initRecords(){
    	initRecords(1);
    }
    
    public static void initRecords(Integer batchSize){
    	initRecordTypes();
    	Integer Year = date.today().year();
    	String Annees_intervention = String.valueOf(Year - 1)+';'+String.valueOf(Year)+';'+String.valueOf(Year + 1);
    	Accs = new List<Account>();
    	for(Integer i = 0; i<batchSize; i++){
    		Accs.add(createAccount());
    	}
    	insert Accs;
    	Opportunities = new List<Opportunity>();
    	for(Integer i = 0; i<batchSize; i++){
    		Opportunities.add(createOppFermeeGagnee(Accs.get(i).id,Annees_intervention));
    	}
    	insert Opportunities;
    	Contracts = new List<Contract>();
    	for(Integer i = 0; i<batchSize; i++){
    		Contracts.add(createContract(Accs.get(i).id, Opportunities.get(i).id, String.valueOf(Year),Annees_intervention));
    	}
    	insert Contracts;
    	
    	missions = new List<INNOmission__c>();
    	for(Integer i = 0; i<batchSize; i++){
    		missions.add(createMission(Contracts.get(i).Id, Accs.get(i).Name));
    	}
    	insert missions;
    	
    	List<INNOequipeConsulting__c> equipes = new List<INNOequipeConsulting__c>();
    	for(INNOmission__c m : missions){
    		equipes.add(new INNOequipeConsulting__c(MissionCIR__c = m.Id, Utilisateur__c = Userinfo.getUserId(), Role__c = 'Consultant'));
    	}
    	insert equipes;
    	
    	
    	valos = new List<INNOvalo__c>();
    	for(Integer i = 0; i<batchSize; i++){
    		valos.add(createValo(Accs.get(i).Id, Accs.get(i).Name, missions.get(i).Id));
    	}
    	insert valos;
    	
    	List<INNOprojet__c> projets = new List<INNOprojet__c>();
    	for(INNOvalo__c valo : valos){
    		projets.add(new INNOprojet__c(Name = 'PM brevet',       Type__c = 'brevetPM',       Valorisation__c = valo.Id));
    		projets.add(new INNOprojet__c(Name = 'Veille',          Type__c = 'veille',         Valorisation__c = valo.Id));
    		projets.add(new INNOprojet__c(Name = 'Normalisation',   Type__c = 'normalisation',  Valorisation__c = valo.Id));    
    	}
    	insert projets;
    	
    	
    }
    
    public static Account[] getAccs(){
    	return accs;
    }
    
    public static Contract[] getContracts(){
    	return Contracts;
    }
    
}