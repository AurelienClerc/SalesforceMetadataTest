public with sharing class FactuSelectPlanificationsCtrl {
    
    public Mission__c mission{get;set;}
    
    
    public List<Selectoption> lsSelectOptionPlanifications{get;set;}
    
    public List<Id> selectedPlanifications{get;set;} 
    
    private Map<String,Id> recordTypes = new Map<String,Id>();
    
    
    
    
    /*
    * constructor
    */
    public FactuSelectPlanificationsCtrl () {
        
        this.selectedPlanifications = new List<Id>();
        
        ApexPages.getMessages().clear();

        this.initInfos(ApexPages.currentPage().getParameters().get('id'));
        
        if(this.mission.Planifications_de_facturation__r.size() > 0)
            this.initCheckBoxes();
        else
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, Label.Factu_CreatePlanificationFirst));
            
            
        for(RecordType rtype : [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType='Facture__c']){
            this.recordTypes.put(rtype.DeveloperName, rtype.Id);
        }
    }
    
    /*
    * get mission and all associated planifications
    */
    private void initInfos(Id id){
        
        this.mission = [Select  m.name,
                                m.Id,
                                m.Contrat__c,
                                m.Contrat__r.Id,
                                m.RecordType.developerName,
                                (Select Id,
                                        Name,
                                        Prevision_HT__c,
                                        Statut__c,
                                        Mois__c,
                                        Periode_debut__c,
                                        Periode_fin__c,
                                        Pourcentage_Factur__c,
                                        Typologie_facturation__c,
                                        Nature_facturation__c,
                                        Commentaire_prevision__c,
                                        Dossier_salarie__c,
                                        Montant_HGNF__c,
                                        Date_d_HGNF__c,
                                        CurrencyIsoCode
                                        FROM Planifications_de_facturation__r
                                        WHERE Statut__c = 'Prévue'
                                            OR Statut__c = 'HGNF'
                                        ORDER BY Date_prevue__c ASC)
                                From Mission__c m
                                Where m.Id =:id];
        
    }
    
    /*
    * create list of planifications checkboxes
    */
    private void initCheckBoxes(){
        this.lsSelectOptionPlanifications = new List<Selectoption>();
        String description;
        
        for(Prevision_de_facturation__c pr : this.mission.Planifications_de_facturation__r){



            if(pr.Statut__c== 'HGNF' )
                description = pr.Mois__c + ' : ['+pr.CurrencyIsoCode+' ' + ((Decimal)pr.Prevision_HT__c).format() + '] '+' - Date HGNF : '+ pr.Date_d_HGNF__c.format() +' - Montant HGNF : ['+ pr.CurrencyIsoCode+' ' + ((Decimal)pr.Montant_HGNF__c).format()+']';
           else
            description = pr.Mois__c + ' : ['+pr.CurrencyIsoCode+' ' + ((Decimal)pr.Prevision_HT__c).format() + '] ';

			description +=  (pr.Pourcentage_Factur__c != null) ? ' [' + pr.Pourcentage_Factur__c +' %]' : '';   
            description +=  (pr.Commentaire_prevision__c != null) ? ' [' + pr.Commentaire_prevision__c +']' : '';   
            description +=  (pr.Typologie_facturation__c != null) ? ' [' + pr.Typologie_facturation__c + ']' : '';
            description +=  (pr.Nature_facturation__c != null) ? ' [' + pr.Nature_facturation__c + ']' : '';       
            description +=  (pr.Dossier_salarie__c != null) ? ' [' + pr.Dossier_salarie__c + ']' : '';
            description +=  (pr.Periode_debut__c != null) ? '['+System.Label.Factu_Periode + ' : ' + pr.Periode_debut__c.format() + ' - ' + pr.Periode_fin__c.format() + '] ' : '';
            
            this.lsSelectOptionPlanifications.add(new Selectoption(pr.Id, description));
            
        }
    }
    
    public PageReference CreateFactu(){
        
        
        if(this.selectedPlanifications.size() > 0){
            Pagereference ret = new Pagereference('/apex/FactuCreateFacture');
     
            ret.getParameters().put('MissionId',mission.Id);
            ret.getParameters().put('PlanifsId',string.join(this.selectedPlanifications,':'));
            
            ret.getParameters().put('retURL','apex/FactuSelectPlanifications?id='+mission.Id);
            return ret;
        }
        
        else{
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Vous devez selectionner au moins une planification'));
        }
        
        return null;
    }
    
    private Id getRecordTypeId(String RecordTypeName) {
        
        return this.recordTypes.get(RecordTypeName);
        
    }

    
    
  
    
}