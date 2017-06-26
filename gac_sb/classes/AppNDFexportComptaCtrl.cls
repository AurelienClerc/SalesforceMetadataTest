public with sharing class AppNDFexportComptaCtrl {

	public List<Note_De_Frais_Recap__c> lsNDFrecap {get;set;}
	
	public AppNDFexportComptaCtrl(){
		Date dtDebut = Date.parse(Apexpages.currentPage().getParameters().get('debut'));
		Date dtFin = Date.parse(Apexpages.currentPage().getParameters().get('fin'));
		
		this.lsNDFrecap = [
                    Select
                        n.Traitement_comptabilite__c,
                        n.Periode_label__c,
                        n.Periode__c,
                        n.OwnerId,
                        n.Total_Taxi__c,
                        n.Total_Train__c,
                        n.Total_Petit_Dejeuner__c,
                        n.Total_Dejeuner__c,
                        n.Total_Diner__c,
                        n.Total_Poste__c,
                        n.Total_Peage_Parking_Metro_Bus__c,
                        n.Total_Location_Vehicule__c,
                        n.Total_Hotel_Nuitee__c,
                        n.Total_Carburant__c,
                        n.Total_Avion__c,
                        n.Total_Autres_HT__c,
                        n.Total_Autres_TTC__c,
                        n.Total_Frais_Kilometrique__c,
                        n.Total_TTC__c,
                        n.Total_HT__c,
                        n.Total_TVA__c,
                        n.Total__c,
                        n.Numero_Compte_Autres_HT__c,
                        n.Numero_Compte_Autres_TTC__c,
                        n.Nombre_De_Dejeuners__c,
                        n.Date_De_Validation__c,
                        n.Name,
                        n.Id,
                        n.Etape__c, 
                        n.Date_fin_de_periode__c, 
                        n.Date_de_traitement_comptabilite__c, 
                        n.Date_Debut_De_Periode__c, 
                        n.Collaborateur__c,
                        n.Collaborateur__r.LastName,
                        n.Collaborateur__r.Name,
                        n.Collaborateur__r.Code_analytique__c,
                        n.Collaborateur__r.Societe__c
                    From Note_De_Frais_Recap__c n
                    Where n.Date_De_Validation__c >=: dtDebut
                    And n.Date_De_Validation__c <=: dtFin];
	}
}