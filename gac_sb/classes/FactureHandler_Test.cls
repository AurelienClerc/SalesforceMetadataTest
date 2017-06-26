@isTest
public class FactureHandler_Test {

	public static testmethod void testFactureHandlerErrorOnPrevisions(){
		
		FactuTestBase.Init();
		test.startTest();
		FactuTestBase.InitFactures();
		facture__c f = FactuTestBase.factures.get(1);
		prevision_de_facturation__c planif = FactuTestBase.createPlanif(1,'ACS',1000);
		planif.percent_Prestation__c = 10;
		planif.Prestataire__c = 'Test Prestataire';
		planif.Prestataire_comptabilise_paye__c = true;
		planif.Apporteur_d_affaire_comptabilise_paye__c = true;
		planif.Facture__c = f.id;
		insert planif;
		
		prevision_de_facturation__c planif2 = FactuTestBase.createPlanif(1,'ACS',5000);
		planif2.Prestataire__c = 'ERR Prestataire';
		planif2.Prestataire_comptabilise_paye__c = false;
		planif2.percent_Prestation__c = 50;
		planif2.Facture__c = f.id;
		string err = '';
		
		system.debug('testFactureHandlerErrorOnPrevisions');
		//Il devrait y avoir une erreur ici étant donné qu'on essaie de mettre 2 prévisions différentes:
		try{
			insert planif2;
		}catch(Exception e){
			system.debug('Exception Catched!');
			err=e.getMessage();
		}
		system.debug('Erreur obtenue : '+err);
		
		system.assert(err.contains('est pas possible de saisir 2 prestataires différents sur 2 planifications liées à la même facture. Vous avez renseigné'));
		system.assert(err.contains('est pas possible de saisir 2 pourcentages de rémunération prestataires différents'));
		
		test.stopTest();
		
	}

	public static testmethod void testFactureHandlerValidation(){
				
		FactuTestBase.Init();
		
		Test.startTest();
		// Creation des factures
		FactuTestBase.InitFactures();
		
		// factures FI et avoir FI
		Facture__c f = FactuTestBase.Factures.get(4);
		
		
		
		f.Statut__c = 'Validée';
		f.Date_validation__c = date.today();
		// Validation de la facture
		update f;

		FactuTestBase.refreshFacture();
		f = FactuTestBase.Factures.get(4);
		
		Test.stopTest();
		
	}
	
	public static testmethod void testFactureHandlerValidationAvoir(){
				
		FactuTestBase.Init();
		
		Test.startTest();
		
		// Creation des factures
		FactuTestBase.InitFactures();
		
		// factures FI et avoir FI
		Facture__c f = FactuTestBase.Factures.get(4);


		Facture__c a = FactuTestBase.Factures.get(5);
		a.Facture_liee__c = f.Id;
		a.Statut__c = 'Validée';
		a.Date_validation__c = date.today();
		// Validation de l'avoir en le liant à la facture
		update a;
		
		FactuTestBase.refreshFacture();
		a = FactuTestBase.Factures.get(5);
		f = FactuTestBase.Factures.get(4);
		
		Test.stopTest();
	}
	
	public static testmethod void testFactureHandlerSuppression(){
				
		FactuTestBase.Init();
		
		Test.startTest();
		
		// Creation des factures
		FactuTestBase.InitFactures();
		
		// factures FI et avoir FI
		Facture__c f = FactuTestBase.Factures.get(4);
		
		f.Statut__c = 'Validée';
		f.Date_validation__c = date.today();
		// Validation de la facture
		update f;
		FactuTestBase.refreshFacture();
		f = FactuTestBase.Factures.get(4);
		
		f.Statut__c = 'En attente';
		f.Date_validation__c = null;
		// Devalidation
		update f;

		FactuTestBase.refreshFacture();
		f = FactuTestBase.Factures.get(4);
		// Delete
		delete f;

		Test.stopTest();

	}
	
	public static testmethod void testFactureHandlerEncaissement(){
				
		FactuTestBase.Init();
		
		Test.startTest();
		
		// Creation des factures
		FactuTestBase.InitFactures();
		
		// factures FI et avoir FI
		Facture__c f = FactuTestBase.Factures.get(4);
		
		f.Statut__c = 'Validée';
		f.Date_validation__c = date.today();
		// Validation de la facture
		update f;
		FactuTestBase.refreshFacture();
		f = FactuTestBase.Factures.get(4);
		
		// Saisie d'un encaissement sur la facture
		Encaissement__c Encaissement = new Encaissement__c (Facture__c = f.Id, Montant_TTC__c = f.Montant_TTC__c, Date_encaissement__c = date.today());
		insert Encaissement;
		
		FactuTestBase.refreshFacture();
		f = FactuTestBase.Factures.get(4);
		
		system.assertEquals('Soldée',f.Statut__c);
		
		Test.stopTest();
		
	}

	public static testmethod void testFactureHandlerPrevisions(){
		FactuTestBase.Init();
		test.startTest();
		FactuTestBase.InitFactures();
		facture__c f = FactuTestBase.factures.get(1);
		prevision_de_facturation__c planif = FactuTestBase.createPlanif(1,'ACS',1000);
		planif.percent_Prestation__c = 10;
		planif.Prestataire__c = 'Test Prestataire';
		planif.Prestataire_comptabilise_paye__c = true;
		planif.Apporteur_d_affaire_comptabilise_paye__c = true;
		planif.Facture__c = f.id;
		insert(planif);
		Facture__c f2= [select	id,
							Prestataire_comptabilise_paye__c,
							Apporteur_d_affaire_comptabilise_paye__c,
							percent_Prestation__c,
							Prestataire__c from facture__c where id = : f.id]; 
		system.assert(f2.Prestataire_comptabilise_paye__c,'La case prestataire comptabilisé payé devrait être cochée car elle l\'est sur une des planifs de la facture');
		system.assert(f2.Apporteur_d_affaire_comptabilise_paye__c,'La case apporteur d\'affaire comptabilisé payé devrait être cochée car elle l\'est sur une des planifs de la facture');
		system.assert(f2.percent_Prestation__c == 10,'le pourcentage de prestation devrait être de 10 étant donné qu\'il est de 10 sur la planif associée');
		system.assert(f2.Prestataire__c == 'Test Prestataire','Le prestataire devrait être "Test prestataire"');
		test.stopTest();
		
	}


}