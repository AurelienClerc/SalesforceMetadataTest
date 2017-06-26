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
 *@author Didier HUGUET
 *@created 13/06/2012
 	//TODO faire des test avec la date de fin de tacite + opp en renouvellement
 */
@isTest
private class ContractGateway_Test {


	/*
	
	############################################
	############################################
	####									####
	####									####
	####		Initialisation				####
	####									####
	####									####
	############################################
	############################################
	
	*/
	

	static List<Account> Accs;
	static List<Contract> Contracts;
	static List<Opportunity> Opportunities;
	
	static Map<String,Id> ContractRecordTypes;
	static Map<String,Id> OpportunityRecordTypes;
	
	static Integer CurrentYear;
	
	static void refreshAccount(){
		Accs = [select Id,Name,Etat_du_compte__c,Etat_du_compte_annee_JSON__c,Etat_du_compte_CIR__c,Etat_du_compte_ACS__c,
					Etat_du_compte_IL__c,Etat_du_compte_FI__c,Etat_du_compte_DI__c,Etat_du_compte_TAT__c,
					(Select Id,recordTypeId,recordType.DeveloperName, Name, stageName from Opportunities order by type_de_compte__c ASC)
		 from Account order by name ASC];
	}
	
	static void refreshContract(){
		Contracts = [Select Id,RecordTypeId from Contract WHERE AccountId=:accs.get(0).Id OR AccountId =:accs.get(1).Id];
	}
	
	static void InitContractRecordType(){
		ContractRecordTypes = new Map<String,Id>();
		for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Contract']){
			ContractRecordTypes.put(rtype.DeveloperName,rtype.Id);
		}
	}
	
	static void InitOpportunityRecordType(){
		OpportunityRecordTypes = new Map<String,Id>();
		for(RecordType rtype : [SELECT Id , DeveloperName FROM RecordType WHERE SobjectType='Opportunity']){
			OpportunityRecordTypes.put(rtype.DeveloperName,rtype.Id);
		}
	}
	
	static void Init(){
		InitContractRecordType();
		InitOpportunityRecordType();
		CurrentYear = date.today().year();
		insert new Account[]{
			new Account(Name = 'Test 1',Siret__c='12345678900001',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 2',Siret__c='12345678800002',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie'),
			new Account(Name = 'Test 3',Siret__c='12345678700003',Type_d_etablissement__c = 'Principal', BillingPostalCode = '92370', BillingCountry = 'FRANCE',Industry = 'Santé',Activity__c='Biotech, biologie')
		};
		refreshAccount();
		Opportunities = new Opportunity[]{
			createOppFermeeGagnee('test 1',0,'CIR'),
			createOppFermeeGagnee('test 2',0,'ACS'),
			createOppFermeeGagnee('test 3',0,'TAT'),
			createOppFermeeGagnee('test 4',0,'IL'),
			createOppFermeeGagnee('test 5',0,'FI'),
			//createOppFermeeGagnee('test 6',0,'ACHAT'),
			createOppFermeeGagnee('test 1',1,'CIR'),
			createOppFermeeGagnee('test 2',1,'ACS'),
			createOppFermeeGagnee('test 3',1,'TAT'),
			createOppFermeeGagnee('test 4',1,'IL'),
			createOppFermeeGagnee('test 5',1,'FI')//,
			//createOppFermeeGagnee('test 6',0,'ACHAT'),
			
			
		};
		insert Opportunities;
		refreshAccount();
	}


	static Opportunity createOppFermeeGagnee(String Name,Integer AccountKey,string Type){
		Opportunity o = new Opportunity(Name = Name, AccountId = accs.get(AccountKey).Id, RecordTypeId = OpportunityRecordTypes.get(Type),StageName = 'Fermée gagnée',closeDate = Date.today(), type_de_compte__c = Name,
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


	//Is Active vaut 0 pour non activé, 1 pour clos et 2 pour activé
	static Contract createContract(Integer AccountKey,String rType){
		map<String,Integer> typesNumber = new Map<String,Integer>{'CIR'=>0,'ACS'=>1,'TAT'=>2,'IL'=>3,'FI'=>4,'HA'=>5};
		//map<Integer,String> ActivationStatus = new Map<Integer,String>{0=>'Non activé',1=>'Clos',2 => 'Activé'};
		return new Contract( AccountId = accs.get(AccountKey).Id,
							 Status = 'Non activé',
							 Date_de_reception_du_contrat__c = Date.valueOf('2010-03-07'),
							 recordTypeId = ContractRecordTypes.get(rType),
							 Opportunite__c=accs.get(AccountKey).Opportunities.get(typesNumber.get(rType)).Id,
							 CustomerSignedDate = Date.valueOf('2010-03-07'),
							 StartDate = (Date.Today() - 7),
							  //DIDIER 12/05/2014 Rémy a mis une RV qui rend ce champs obligatoire pour les contrats TAT
             				  Conditions_de_facturation__c = 'A l\'accord contractuel',
							 //EndDate = (Date.Today() + 7),
							 Annees_concernees__c = '2012');
		
	}
	
	
	
	
	/*
	
	############################################
	############################################
	####									####
	####									####
	####			Assertions				####
	####									####
	####									####
	############################################
	############################################
	
	*/
	
	
	/*
	* Vérifie la cohérence de tous les champs d'état du compte en fonctions des contrats renseignés
	*/
	static void Assertions(Integer AccountKey,string ClientActifsStr,string clientInactifsStr){
		set<String> All = new Set<String>{'CIR','TAT','ACS','IL','FI','DI'}; 
		List<String> ClientsActifs = ClientActifsStr.split(',');
		List<String> ClientsInactifs = ClientInactifsStr.split(',');
		if(!ClientsActifs.isEmpty()){
			for(String rtype :ClientsActifs){
				if(rtype != ''){
					String FieldToTest = 'Etat_du_compte_'+rtype+'__c';
					All.remove(rtype);
					system.assertEquals(rtype + ' => Client actif',rtype + ' => '+accs.get(AccountKey).get(FieldToTest));
				}
			}
		}
		if(!ClientsInactifs.isEmpty()){
			for(String rtype :ClientsInactifs){
				if(rtype != ''){
					String FieldToTest = 'Etat_du_compte_'+rtype+'__c';
					All.remove(rtype);
					system.assertEquals(rtype + ' => Client inactif',rtype + ' => '+accs.get(AccountKey).get(FieldToTest));
				}
			}
		}
		if(!All.isEmpty()){
			for(String rtype :All){
				String FieldToTest = 'Etat_du_compte_'+rtype+'__c';
				system.assertEquals(rtype + ' => Prospect',rtype + ' => '+accs.get(AccountKey).get(FieldToTest));
			}
		}
		
		if(!ClientsActifs.isEmpty() && ClientsActifs.get(0) != ''){
			system.assertEquals('GLOBAL Client actif','GLOBAL ' + accs.get(AccountKey).Etat_du_compte__c);
		}else if(!ClientsInactifs.isEmpty() && ClientsInactifs.get(0) != ''){
			system.assertEquals('GLOBAL Client inactif','GLOBAL ' + accs.get(AccountKey).Etat_du_compte__c);
		}else {
			system.assertEquals('GLOBAL Prospect','GLOBAL ' + accs.get(AccountKey).Etat_du_compte__c);
		}
	}
	
	/*
	
	############################################
	############################################
	####									####
	####									####
	####		Démarrage des tests			####
	####									####
	####									####
	############################################
	############################################
	
	*/
	
	/*
	* On vérifie que les champs d'états du compte s'initialisent
	*
	*/
	static testMethod void testNoContract(){
		test.startTest();
		init();
		test.stopTest();
		Assertions(0,'','');
		Assertions(1,'','');
	}
	
	/*
	* On vérifie que les champs d'états du compte CIR se remplissent bien 
	*
	*/
	static testMethod void testCIR(){
		init();
		test.startTest();
		Contract[] c = new List<Contract>{
			createContract(0,'CIR'),
			createContract(1,'CIR')
			};
		insert c;
		refreshAccount();
		Assertions(0,'','');	
		Assertions(1,'','');	
		c.get(0).Status = 'Activé';
		c.get(1).Status = 'Clos';
		update c;
		refreshAccount();
		test.stopTest();
		Assertions(0,'CIR','');	
		Assertions(1,'','CIR');	
	}
	

	/*
	* On vérifie que les champs d'états du compte ACS se remplissent bien 
	*
	*/
	static testMethod void testACS(){
		init();
		test.startTest();
		Contract[] c = new List<Contract>{
			createContract(0,'ACS'),
			createContract(1,'ACS')
			};
		insert c;
		refreshAccount();
		Assertions(0,'','');	
		Assertions(1,'','');	
		c.get(0).Status = 'Activé';
		c.get(1).Status = 'Clos';
		update c;
		refreshAccount();
		test.stopTest();
		Assertions(0,'ACS','');	
		Assertions(1,'','ACS');	
	}
	
	/*
	* On vérifie que les champs d'états du compte ACS se remplissent bien 
	*
	*/
	static testMethod void testTAT(){
		init();
		test.startTest();
		Contract[] c = new List<Contract>{
			createContract(0,'TAT'),
			createContract(1,'TAT')
			};
		insert c;
		refreshAccount();
		Assertions(0,'','');	
		Assertions(1,'','');	
		c.get(0).Status = 'Activé';
		c.get(1).Status = 'Clos';
		update c;
		refreshAccount();
		test.stopTest();
		Assertions(0,'TAT','');
		Assertions(1,'','TAT');		
	}
	
	/*
	* On vérifie que les champs d'états du compte FI se remplissent bien 
	*
	*/
	static testMethod void testFI(){
		init();
		test.startTest();
		Contract[] c = new List<Contract>{
			createContract(0,'FI'),
			createContract(1,'FI')
			};
		insert c;
		refreshAccount();
		Assertions(0,'','');	
		Assertions(1,'','');	
		c.get(0).Status = 'Activé';
		c.get(1).Status = 'Clos';
		update c;
		refreshAccount();
		test.stopTest();
		Assertions(0,'FI','');
		Assertions(1,'','FI');		
	}
	
	/*
	* On vérifie que les champs d'états du compte IL se remplissent bien 
	*
	*/
	static testMethod void testIL(){
		init();
		test.startTest();
		Contract[] c = new List<Contract>{
			createContract(0,'IL'),
			createContract(1,'IL')
			};
		insert c;
		refreshAccount();
		Assertions(0,'','');	
		Assertions(1,'','');	
		c.get(0).Status = 'Activé';
		c.get(1).Status = 'Clos';
		update c;
		refreshAccount();
		test.stopTest();
		Assertions(0,'IL','');
		Assertions(1,'','IL');	
	}
	
	/*
	* On vérifie que les champs d'états du compte se remplissent bien en bulk aussi 
	* On vérifie également la priorité du client actif sur le client inactif pour le champ global
	*
	*/
	static testMethod void testBulk(){
		init();
		List<Contract> ContractsTest = new List<Contract>{
			//0 est inactif
			createContract(0,'CIR'),
			createContract(0,'ACS'),
			createContract(0,'FI'),
			createContract(0,'TAT'),
			createContract(0,'CIR'),
			
			createContract(1,'CIR'),
			createContract(1,'FI'),
			createContract(1,'TAT'),
			createContract(1,'CIR')
		};
		insert ContractsTest;
		for(Contract c : ContractsTest){
			c.Status = 'Clos';
		}
		ContractsTest.get(0).Status = 'Activé';	//On acrive le CIR (Alors qu'il y a aussi un contrat désactivé)
		ContractsTest.get(5).Status = 'Activé';
		
		
		test.startTest();
		update ContractsTest;
		test.stopTest();
		refreshAccount();
		Assertions(0,'CIR','ACS,FI,TAT');
		Assertions(1,'CIR','FI,TAT');
	}
	
	/*
	* On vérifie que les champs d'états du compte se remplissent bien en update aussi 
	*
	*/
	static testMethod void testUpdate(){
		init();
		Contract c = createContract(0,'IL');
		insert c;
		c.Status = 'Clos';
		test.startTest();
		update c;
		refreshAccount();
		test.stopTest();
		Assertions(0,'','IL');
	}
	
	/*
	* On vérifie que les champs d'états du compte se remplissent bien en delete aussi 
	*
	*/
	static testMethod void testDelete(){
		init();
		Contract c = createContract(0,'IL');
		insert c;
		c.status = 'Activé';
		update c;
		test.startTest();
		delete c;
		refreshAccount();
		test.stopTest();
		Assertions(0,'','');
	}
	/*
	Cette méthode n'a plus lieu d'être étant donné qu'on autorise plus l'insertion de contrats sans opp gagnées
	static testMethod void testMajStatutOpp(){
		init();
		Opportunity o = (opportunity) accs.get(0).Opportunities.get(0);
		Contract c = createContract(0,'CIR');
		c.Opportunite__c = o.Id;
		o.StageName = 'Négociation';
		update o;
		test.startTest();
		insert c;
		c.Status = 'Activé';
		update c;
		test.stopTest();
		refreshAccount();
		system.assertEquals(accs.get(0).Opportunities.get(0).get('StageName'), 'Fermée gagnée');
		
	}
	*/
	
	/*
	* On vérifie que les champs d'états du compte se remplissent bien en undelete aussi 
	*
	*/
	static testMethod void testUndelete(){
		init();
		Contract c = createContract(0,'IL');
		insert c;
		c.status = 'Activé';
		update c;
		delete c;
		test.startTest();
		undelete c;
		test.stopTest();
		refreshAccount();
		Assertions(0,'IL','');		
	}
	
	/*
	* test des mise a jour des comptes lors de modifications des societes a auditer dans les contrats
	*/
	static testMethod void testAudite_ds_les_contrats(){
		init();
		List<sObject> l = new sObject[] {
			new Contact(LastName = 'test' , AccountId = Accs.get(0).Id),
			createContract(0,'IL') 	
		};
	
		insert l;
		l.get(1).put('Status','Activé');
		update l;
		Id ContactId = (Id)  l.get(0).get('id');
		Id ContractId = (Id)  l.get(1).get('id');
		
		Societe_a_auditer__c so = new Societe_a_auditer__c(Societe_a_auditer__c = Accs.get(1).id,Contact_a_facturer__c = contactId,Contract__c = contractId,Suivi_du_dossier__c = contactId);
		test.startTest();
		insert so;
		refreshAccount();
		Assertions(0,'IL','');
		Assertions(1,'IL','');
		Assertions(2,'','');
		so.Societe_a_auditer__c = Accs.get(2).id;
		update so;
		refreshAccount();
		Assertions(0,'IL','');
		Assertions(1,'','');
		Assertions(2,'IL','');
		delete so;
		refreshAccount();
		Assertions(0,'IL','');
		Assertions(1,'','');
		Assertions(2,'','');
		test.stopTest();		
	}
	
	/*
	* Test du périmètre des contrats opporutnité
	*
	*/
	static testMethod void testPerimetreOpportunite(){
		init();
		List<sObject> l = new sObject[] {
			new Perimetre_opportunite__c(Opportunite__c = Opportunities.get(0).Id , compte__c = Accs.get(2).id)	//L'opporutinté 0 est sur du CIR, on va devoir faire le contrat CIR
		};
		insert l;
		test.startTest();
		
		Contract c = createContract(0, 'CIR');
		insert c;
		//On va vérifier que le périmètre est bien renseigné
		Societe_a_auditer__c[] s = [Select id from Societe_a_auditer__c where contract__c =: c.Id and Societe_a_auditer__c =: Accs.get(2).id];
		System.assertEquals(1,s.size());
		
		c.status = 'Activé';
		update c;
		
		refreshAccount();
		
		Assertions(2,'CIR','');
		test.stopTest();
	}
	
	
	
	/*
	static testMethod void testOpportunityHandler(){
		init();
		Contract c = createContract(0,'CIR','2005'); // On le met en ancient client et on test que ca se met bien a jour avec l'opp;
		insert c;
		Opportunities.get(0).Annees_intervention__c = '2010;2011;2012';
		test.startTest();
		update Opportunities.get(0);
		refreshAccount();
		Assertions(0,'CIR','');
		test.stopTest();
		//Couverture.
		delete Opportunities.get(0);
	}
	*/
	

	
	
	
	
	
	
}