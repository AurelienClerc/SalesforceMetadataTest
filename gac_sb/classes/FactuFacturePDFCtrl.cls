public with sharing class FactuFacturePDFCtrl {
    
    public List<Detail_facture__c> DetailFactuList{get;set;}
    public Facture__c factu{get;set;}
    private ApexPages.standardController stdCtrl;
    //Informations du footer (FacturationEntite__c est un custom setting)
    public FacturationEntite__c footerInfos {get; set;}
    
     public FactuFacturePDFCtrl(ApexPages.standardController stdCtrl){
                
        this.stdCtrl = stdCtrl;
        this.factu = (Facture__c)stdCtrl.getRecord();
        this.initDetailFactuList();
        this.initFooterInfos();

    }
    
    private void initDetailFactuList(){
        
        this.DetailFactuList = new List<Detail_facture__c>();
    
        for(Detail_facture__c df : [SELECT Id, Description__c, Montant_HT__c, Ordre__c, des_credits__c, R_clamation__c
                                                FROM Detail_facture__c 
                                                WHERE Facture__c = :this.factu.Id
                                                ORDER BY Ordre__c ASC]){
                this.DetailFactuList.add(df);                                       
        }
        
    }
    
    private void initFooterInfos(){
        //Récupération des infos du footer relatives au paiement (FacturationEntite__c est un custom setting)
        this.footerInfos = FacturationEntite__c.getInstance(this.factu.Entite_GAC__c);
    }

}