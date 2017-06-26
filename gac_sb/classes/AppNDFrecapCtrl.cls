public with sharing class AppNDFrecapCtrl {

    public Note_De_Frais_Recap__c oNDFrecap {get;set;}
    public Boolean bIsEmpty {get;set;}
    public Boolean bApproval {get;set;}
    public String sIdNDF {get;set;}
    public Id id {get;set;}
    public List<Note_De_Frais_Recap__c> lsRecapEnCours {get;set;}
    public List<String> lsEtapeActive = new List<String> {'En cours','Refusé'};
 
    public AppNDFrecapCtrl(Apexpages.Standardcontroller controller) { 
        this.bIsEmpty = true;
        this.bApproval = true;

        // si il y a un id dans l'url et qu'on n'est pas en train de recharger un recap en ajax, on lance viewRecap
        if(Apexpages.currentPage().getParameters().get('id') != null && Apexpages.currentPage().getParameters().get('idRecap') == null)
            this.viewRecap();
            
        this.initRecapEnCours();
        
    }
    
    public void initRecapEnCours(){
        this.lsRecapEnCours = [
                    Select
                        n.Id,
                        n.Name,
                        n.Periode__c,
                        n.Periode_label__c,
                        n.Etape__c,
                        n.Total__c,
                        n.Date_Debut_De_Periode__c,
                        n.Collaborateur__c 
                    From Note_De_Frais_Recap__c n
                    Where n.Etape__c in : this.lsEtapeActive
                    And n.OwnerId =: UserInfo.getUserId()
                    order by n.Date_Debut_De_Periode__c];
    }
  
    public void viewRecap(){
        
        // soit y a un id dans l'url, soit on recharge un recap en ajax
        if(Apexpages.currentPage().getParameters().get('idRecap') != null)
            this.id = Apexpages.currentPage().getParameters().get('idRecap');
        else
            this.id = Apexpages.currentPage().getParameters().get('id');
            
        // on récupère le record récap
        List<Note_De_Frais_Recap__c> lsNDFrecap = [
                    Select 
                        n.Traitement_comptabilite__c,
            			n.Pays__c,
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
            			n.Total_Parking__c ,
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
                        n.Nombre_De_Dejeuners__c,
                        n.Name,
                        n.Id,
                        n.Etape__c,
                        n.Numero_Compte_Autres_HT__c,
                        n.Numero_Compte_Autres_TTC__c,
                        n.Date_fin_de_periode__c, 
                        n.Date_de_traitement_comptabilite__c, 
                        n.Date_Debut_De_Periode__c, 
                        n.Collaborateur__c
                    From Note_De_Frais_Recap__c n
                    Where n.Id =: this.id
                    And n.OwnerId =: UserInfo.getUserId()];
        
        if(lsNDFrecap.size() > 0){
            this.oNDFrecap = lsNDFrecap[0];
            
            this.bIsEmpty = false;
        }
        else{
            this.bApproval = false;
        }
    }
    
   
}