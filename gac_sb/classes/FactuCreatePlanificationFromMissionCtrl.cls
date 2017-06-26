public with sharing class FactuCreatePlanificationFromMissionCtrl {
    
    private ApexPages.standardController stdCtrl;
    
    protected Map<String,Id> recordTypes = new Map<String,Id>();
    
    public SelectOption[] recordTypeTATSelectList {get; set;}
    
    public String recordTypeTAT {get; set;}
    
    public FactuCreatePlanificationFromMissionCtrl(ApexPages.standardController stdCtrl){
        this.stdCtrl = stdCtrl;
        for(RecordType rtype : [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType='Prevision_de_facturation__c']){
            this.recordTypes.put(rtype.DeveloperName, rtype.Id);
        }
        
        // on init le menu list pour les missions TAT ou il y a le choix entre 2 planifs
        this.recordTypeTATSelectList = new List<selectOption>();
        this.recordTypeTATSelectList.add(new selectOption('TAT', 'TAT'));
        this.recordTypeTATSelectList.add(new selectOption('AT_Advance_Risk_Pro', 'AT Advance/Risk Pro Online'));
    }
    
    
    public PageReference createPlanification(){
        
        Mission__c m = (Mission__c) this.stdCtrl.getRecord();
        Pagereference ret = new Pagereference('/' + Prevision_de_facturation__c.sObjectType.getDescribe().getKeyPrefix() + '/e');

        // permet de transférer le bon contrat lors de la création de la planif
        ret.getParameters().put(FieldIds__c.getValues('Prevision_de_facturation__c.Contrat__c').Id__c,m.Contrat__r.ContractNumber); 
        ret.getParameters().put(FieldIds__c.getValues('Prevision_de_facturation__c.Contrat__c').Id__c+'_lkid',m.Contrat__c);
        
        // permet de transférer la bonne mission lors de la création de la planif
        ret.getParameters().put(FieldIds__c.getValues('Prevision_de_facturation__c.Mission__c').Id__c,m.Name); 
        ret.getParameters().put(FieldIds__c.getValues('Prevision_de_facturation__c.Mission__c').Id__c+'_lkid',m.Id);
        
        ret.getParameters().put('retURL',m.Id);
        
        // Si on est pas sur une mission TAT, on redirige tout de suite
        if(m.RecordType.developerName != 'TAT')
          ret.getParameters().put('RecordType',this.getRecordTypeId(m.RecordType.developerName));
        // Si on est sur du TAT, on return null pour afficher le formulaire de choix du type de planif ou alors on redirige si on est dans le cas où on a déja sélectionné le type de planif
        else if(m.RecordType.developerName == 'TAT'){
          if(this.recordTypeTAT != null)
            ret.getParameters().put('RecordType',this.getRecordTypeId(this.recordTypeTAT));
          else
            return null;
        }
        
        ret.setRedirect(true);
        return ret;
    }
    
    
    /**
    *   Methode utilisé pour la création de nouvelle planifs DEPUIS INNO Advance
    *   On ne passe donc pas une mission Factu mais une mission CIR
    *   @deprecated maintenant createPlanificationFromValoCIR()
    */
    public PageReference createPlanificationFromMissionCIR(){
       return null;
    }
    
    
    public PageReference createPlanificationFromValoCIR(){
        INNOvalo__c valo = (INNOvalo__c) this.stdCtrl.getRecord();
        Pagereference ret = new Pagereference('/' + Prevision_de_facturation__c.sObjectType.getDescribe().getKeyPrefix() + '/e');


        List<Mission__c> missionsFactu = [SELECT Id, Name FROM Mission__c WHERE Contrat__c = :valo.MissionCIR__r.Contrat__c AND Annee_concernee__c = :valo.MissionCIR__r.Annee_CIR__c];
        
        if(!missionsFactu.isEmpty()){
            ret.getParameters().put(FieldIds__c.getValues('Prevision_de_facturation__c.Mission__c').Id__c, missionsFactu[0].Name);
        }
        
        ret.getParameters().put(FieldIds__c.getValues('Prevision_de_facturation__c.Contrat__c').Id__c, valo.MissionCIR__r.Contrat__r.ContractNumber); 
        ret.getParameters().put(FieldIds__c.getValues('Prevision_de_facturation__c.Contrat__c').Id__c+'_lkid', valo.MissionCIR__r.Contrat__c);
        
        ret.getParameters().put(FieldIds__c.getValues('Prev_factu__c.ValoINNOadvance__c').Id__c, valo.Name); 
        ret.getParameters().put(FieldIds__c.getValues('Prev_factu__c.ValoINNOadvance__c').Id__c + '_lkid', valo.Id); 
        
        PageReference retUrl = Page.INNOfacturationValo;
        retUrl.getParameters().put('id', valo.Id);
        retUrl.getParameters().put('missionId', valo.MissionCIR__c);
        
        ret.getParameters().put('retURL', retUrl.getUrl());
        ret.getParameters().put('saveURL', retUrl.getUrl());
        ret.getParameters().put('RecordType',this.getRecordTypeId('CIR'));
        return ret;
    }
    
    
    private Id getRecordTypeId(String RecordTypeName) {
        
        return this.recordTypes.get(RecordTypeName);
        
    }
    
}