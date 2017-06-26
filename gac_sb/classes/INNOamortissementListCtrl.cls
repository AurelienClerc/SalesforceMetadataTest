global with sharing class INNOamortissementListCtrl extends INNOmissionBaseCtrl{

    public transient ApexPages.StandardSetController setController;
    
    public String tab {get; set;}
    
    
    public transient List<INNOamortissement__c> amortissements {get; set;}

    /*
    *   Variables ci-dessous: Pour la page AppCIRamortissementTauxRD uniquement
    */
    public INNOamortissementUtils tauxRDcls {get; set;}
    public List<INNOdepartement__c> departements {get; set;}
    public List<INNOprojet__c> projets {get; set;}  //Pour les filtres de la partie methode de calcul du taux R&D
    public Map<String, Checkbox> tauxRDupdates {get; set;}  //Bug VF: ca ne fonctionne pas si on met un boolean directement à la place de la inner class "Checkbox"
    private static final Map<String, String> methodesLabelsToValues = new Map<String, String>{'Manuelle' => 'manuelle',
                                                                                            'Moyenne des sommes' => 'moyenneSommes',
                                                                                            'Somme des moyennes' => 'sommeMoyennes',
                                                                                            'Moyenne des sommes du département' => 'moyenneSommesDepartements',
                                                                                            'Somme des moyennes du département' => 'sommeMoyennesDepartements'};
    
    public INNOamortissementListCtrl(ApexPages.StandardController stdCtrl){
        
        this.tab = ApexPages.currentPage().getParameters().get('tab');
        
        if(this.tab == null)
            this.tab = 'amortissement';
        
        this.amortissements = [SELECT Id, 
                                    Name, 
                                    Num_immobilisation__c, 
                                    Departement__c, 
                                    Departement__r.Name, 
                                    Projet__c,
                                    Projet__r.Name,
                                    Annuite_amortissement__c,
                                    Methode_de_calcul__c, 
                                    Taux_RD_option1__c ,
                                    Taux_RD_option2__c ,
                                    Taux_RD_option3__c ,
                                    Montant_RD_retenu_option1__c, 
                                    Montant_RD_retenu_option2__c, 
                                    Montant_RD_retenu_option3__c 
                            FROM INNOamortissement__c 
                            WHERE Valorisation__c = :this.valo.Id 
                                AND RecordType.DeveloperName = :this.tab];
        
        
        /*
        *   Pour la page AppCIRamortissementTauxRD uniquement
        */
        if(ApexPages.currentPage().getUrl().startsWith('/apex/INNOamortissementTauxRD') && this.tab == 'amortissement'){    
            this.tauxRDcls = new INNOamortissementUtils(this.valo.Id);
            this.departements = [SELECT Id, Name FROM INNOdepartement__c WHERE Entite__c = :(Id) stdCtrl.getRecord().get('Entite__c') ORDER BY Name];
            this.projets = [SELECT Id, Name FROM INNOprojet__c WHERE Valorisation__c = :this.valo.Id AND Type__c = 'projet' ORDER BY Name];
            
            this.tauxRDupdates = new Map<String, Checkbox>();
            
            for(INNOamortissement__c amo : this.amortissements){
                for(String methodeLabel : methodesLabelsToValues.keyset()){
                    this.tauxRDupdates.put(amo.Id + '_' + methodesLabelsToValues.get(methodeLabel), new Checkbox(amo.Methode_de_calcul__c == methodeLabel));
                }
            }
        }
    }
    
    
    
    
        
    
    
    /**
    *   Sauvegarde en masse les methode de calcul des tauc R&D
    *   Pour la page AppCIRamortissementTauxRD uniquement
    *   @return PageReference vers la page de modification des taux R&D (on refresh la page pour que tous les recalculs soit faits)
    */
    public PageReference saveMethodeCalculTauxRD(){
        
        //La liste des dotations aux amortissements dont la methode de calcul à changé
        List<INNOamortissement__c> dotationToUpdate = new List<INNOamortissement__c>();
        
        system.debug(this.tauxRDupdates.get('a1x5E0000000s2gQAA_manuelle'));
        system.debug(this.tauxRDupdates.get('a1x5E0000000s2gQAA_moyenneSommes'));
        system.debug(this.tauxRDupdates.get('a1x5E0000000s2gQAA_sommeMoyennes'));
        
        
        //Boucle sur toutes les dotations aux amortissements
        for(INNOamortissement__c amo : [SELECT Id, Methode_de_calcul__c FROM INNOamortissement__c WHERE Valorisation__c = :this.valo.Id AND RecordType.DeveloperName = :this.tab]){
            
            if(amo.Id=='a1x5E0000000s2gQAA'){
                
                system.debug(amo);
                system.debug(methodesLabelsToValues.get(amo.Methode_de_calcul__c));
                system.debug(this.tauxRDupdates.get(amo.Id + '_' + methodesLabelsToValues.get(amo.Methode_de_calcul__c)));
            }
            
            //Si la methode de calcul a changé
            if( ! this.tauxRDupdates.get(amo.Id + '_' + methodesLabelsToValues.get(amo.Methode_de_calcul__c)).selected ){
                    system.debug(amo);
                        
                //Boucle sur toutes les methodes de calcul pour savoir laquelle est coché
                for(String methodeLabel : methodesLabelsToValues.keyset()){
                    
                    if ( this.tauxRDupdates.get( amo.Id + '_' + methodesLabelsToValues.get(methodeLabel) ).selected){
                        system.debug(amo);
                        amo.Methode_de_calcul__c = methodeLabel;
                        dotationToUpdate.add(amo);
                        break;
                    }
                }
            }
        }

        //Update des dotaions aux amortissements qui ont changées
        if(dotationToUpdate.size() > 0)
            update dotationToUpdate;
        
        system.debug(dotationToUpdate);
        PageReference retPage = new pageReference( '/apex/INNOamortissementTauxRD' );
        retPage.getParameters().put('valoId', this.valo.Id);
        retPage.getParameters().put('tab', this.tab);
        retPage.setRedirect(true);
        return retPage; 
    }
    
    
    
    
    /**
    *   Inner class pour palier au bug VF qui fait qu'on ne peut pas mettre directement un Boolean dans les checkbox...
    */
    public class Checkbox{
        
        public Boolean selected {get; set;}
        
        public Checkbox(Boolean selected){
            this.selected = selected;
        }
    }
    
    

}