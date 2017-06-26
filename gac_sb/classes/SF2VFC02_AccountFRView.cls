public without sharing class SF2VFC02_AccountFRView {
    
    public boolean bEdit {get;set;}
    
    public ApexPages.standardController oStdCtrl{get;set;}
    
    public map<string,list<string>> ContactRolesByBu{get;set;}
    
    //public list<integer> anneesHisto{get;set;}
    
    public Account mainRecord{get;set;}
    
    public Id TaskWhatId {get;set;}
    
    public static Id RecordTypeTaskFranceCommerce {get;set;} //Utilisé dans les raccourcis de tâche
    
    public list<Historique_Segmentation__c> lHistos{get;set;}
    
    public id AccountId;
    
    public list<INNOmission__c> missionsCir{get;set;}
    
    public boolean bHasMissionCir{get;set;}
    
    public static string  produitFieldId{get;set;} //Utilisé dans les raccourcis de taches
    
    static{
        Try {
            RecordTypeTaskFranceCommerce = [Select id from recordType where developerName = 'Taches_France_Commerce' LIMIT 1][0].Id;
            produitFieldId = FieldIds__c.getAll().get('Task.Produit__c').id__c;
        }catch (Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.FATAL,'Installation non terminée : Le recordType Taches_France_Commerce n\'existe pas ou le champs produit n\'est pas référencé dans le paramètre custom ProduitId '+e.getMessage()));
        }
        
    }
    
    public map<String,AccountContactRole> refContactRoles{get;set;}
    
    public map<String,List<String>> getFieldsByBu(){
        return V2AP01_SegmentationManager.refFieldsByBU;
    }
    
    public SF2VFC02_AccountFRView(ApexPages.standardController sc){
        boolean isFromOpport = sc.getRecord() instanceOf opportunity;
        
        //Id AccountId;
        if(isFromOpport){
            Opportunity o = (Opportunity) sc.getRecord();
            TaskWhatId = o.id;
            oStdCtrl = new ApexPages.standardController( new Account( id = (Id) sc.getRecord().get('AccountId'), Name= o.Account.Name) );
            accountId = oStdCtrl.getId();
        }else{
            accountId = sc.getId();
            missionsCir = [SELECT id,Name, Nombre_jours_programmes_Total__c,Nombre_jours_travailles_total__c,Annee_CIR__c,Date_lancement_mission__c,
                            Phase__c,ChiffreAffaire__c, 
                            Montant_CIR_definitif_optionFinale__c,
                            renta_nb_proj__c,renta_nb_interlocuteurs__c,renta_nb_redacs__c,renta_nb_sites__c,renta_nb_valo__c,
                            (SELECT id , Utilisateur__c, Utilisateur__r.Name from EquipesConsulting__r) from INNOmission__c where Contrat__r.AccountId = : accountId order by Annee_CIR__c ASC];
            bHasMissionCir = !missionsCir.isEmpty();
            /*
             <apex:column value="{!m.Name}" />
	            <apex:column headerValue="Equipe consulting">
	                <apex:repeat var="c" value="{!m.EquipesConsulting__r}" >
	                    <apex:outputField value="{!c.Utilisateur__c}" />
	                </apex:repeat>
	            </apex:column>
	            <apex:column value="{!m.Date_lancement_mission__c}" />
	            <apex:column value="{!m.Phase__c}" />
	            <apex:column headervalue="Jours travaillés + planifiés" >
	                <apex:outputtext >{!nbJoursTravaillePlusPlanifie}</apex:outputtext>
	            </apex:column>
	            <!--<apex:column value="{!m.Nombre_jours_estimes__c}" />-->
	             
	                <apex:column HeaderValue="Honoraires N / N - 1" >
	                     <apex:outputField value="{!m.Honoraires_N1_a_deduire_optionFinale__c}" /> / 
	                     <br />
	                     <apex:outputField value="{!m.Honoraires_N_a_deduire_optionFinaleManue__c}" />
	                </apex:column>
	           <!--<apex:column value="{!m.Montant_CIR_definitif_optionFinale__c}" />-->
	           <apex:column headerValue="CIR Base de calcul" value="{!m.Montant_CIR_N_base_optionFinale__c}" />
	           
	           <apex:column value="{!m.renta_nb_proj__c}" />
	           <apex:column value="{!m.renta_nb_interlocuteurs__c}" />
	           <apex:column value="{!m.renta_nb_redacs__c}" />
	           <apex:column value="{!m.renta_nb_sites__c}" />
	           <apex:column value="{!m.renta_nb_valo__c}" />
            */
            
            oStdCtrl = sc;
            TaskWhatId = accountId;
        }   
            
        bEdit = ApexPages.currentPage().getParameters().containsKey('editMode');
        
        init();
        
    }
    
    public SF2VFC02_AccountFRView(){
        
    }
    
    public List<String> getBuInno(){return V2AP01_SegmentationManager.lBuInno;}
    public List<String> getBuOpti(){return V2AP01_SegmentationManager.lBuOpti;}
    public List<String> getBuFL(){return V2AP01_SegmentationManager.lBuFL;}
    
    private void init(){
        
        //lSelectContact = new List<SelectOption>{new SelectOption('','-- Aucun --')};
        list<string> fieldsToAdd = V2AP01_SegmentationManager.getSegmentationFields(true);
        String sQuery = 'SELECT id,id_externe__c, annee__c , '+String.join(fieldsToAdd,',')+' from Historique_Segmentation__c where compte__c = : AccountId and Annee__c <= '+Date.today().year()+'  order by Annee__c DESC LIMIT 6';
        //fieldsToAdd.add('Fonds_propres__c');
        fieldsToAdd.add('Name');
        for(String bu : V2AP01_SegmentationManager.lBus)
            fieldsToAdd.add(bu+'_Date_Mercato__c');
        
        
        mainRecord = database.query('SELECT id,'+String.join(fieldsToAdd,',')+' from Account where id = :AccountId');
        //mainRecord = (Account) oStdCtrl.getRecord();
        //Création d'une liste ordonnée d'historiques segmentation
        lHistos = new list<Historique_Segmentation__c>();
        
        map<integer,Historique_Segmentation__c> histos = new map<integer,Historique_Segmentation__c>();
        
        integer[] tmpAnnees = new list<integer>();
        String accName = (String) mainRecord.Name;
        for(Historique_Segmentation__c h : database.query(sQuery)){
            h.Name = h.annee__c+' - '+accName;
            histos.put(Integer.valueOf(h.annee__c),h);
            tmpAnnees.add(Integer.valueOf(h.annee__c));
        }
        integer iYear = Date.today().year();
        for(integer i = iYear-6;i<=iYear;i++){
            if(!histos.containsKey(i)){
                histos.put(i,new Historique_Segmentation__c(compte__c = AccountId,annee__c=i,id_externe__c = V2AP01_SegmentationManager.getHistoIdExterne(AccountId,i), Name=i+' - '+accName));
                tmpAnnees.add(i);
            }
        }
        tmpAnnees.sort();
        for(Integer i = tmpAnnees.size()-1; i>=0;i--)
        {
            lHistos.add(histos.get(tmpAnnees.get(i)));
        }
        
        initContactRoleMap();
    }
    
    public pageReference SwitchEdit(){
        bEdit = !bEdit;
        initContactRoleMap();
        return null;
    }
    public pageReference saveSegmentation(){
       saveSegmentationNoSwith();
        return SwitchEdit();
    }
    public pageReference cancelSegmentation(){
        oStdCtrl.cancel();
        return SwitchEdit();
    }
    
    public pageReference saveSegmentationNoSwith(){
        //Insertion des roles de clients
        try{
            list<AccountContactRole> lACRToUp = new List<AccountContactRole>();
            list<AccountContactRole> lACRToIns = new List<AccountContactRole>();
            list<AccountContactRole> lACRToDel = new List<AccountContactRole>();
            set<string> ProcessedRoles = new set<string>();
            for(AccountContactRole oACR : [Select id, contactId, role from AccountContactRole where Accountid =: oStdCtrl.getId()]){
                if( refContactRoles.containsKey(oAcr.role) ){
                    ProcessedRoles.add(oACR.role);
                    if(refContactRoles.get(oAcr.role ) != null && refContactRoles.get( oAcr.role ).contactId != null && refContactRoles.get( oAcr.role ).contactId != oACR.contactId ){
                        lACRToUp.add(refContactRoles.get(oAcr.role));
                    }else if( refContactRoles.get(oAcr.role ) == null || refContactRoles.get(oAcr.role ).contactId == null){
                        lACRToDel.add(oAcr);
                    }
                }
            }
            for(string role : refContactRoles.keySet()){
                if(refContactRoles.get(role) != null && refContactRoles.get(role ).contactId != null && !ProcessedRoles.contains(role))
                    //lACRToIns.add(new AccountContactRole(AccountId = oStdCtrl.getId(), role = role, contactId = refContactRoles.get(role)));
                    LACRToIns.add(refContactRoles.get(role));
            }
            system.debug(system.loggingLevel.Error,'###MANAGING CONTACT ROlES');
            system.debug(system.loggingLevel.Error,lACRToIns);
            system.debug(system.loggingLevel.Error,lACRToUp);
            system.debug(system.loggingLevel.Error,lACRToDel);
            if(!lACRToUp.isEmpty())
                update lACRToUp;
            if(!lACRToIns.isEmpty())
                insert lACRToIns;
            if(!lACRToDel.isEmpty())
                delete lACRToDel;
            map<string,Date> DatesMercato = new map<string,date>();
            for(String bu : V2AP01_SegmentationManager.lBus)
                DatesMercato.put(bu+'_Date_Mercato__c',(Date) mainRecord.get(bu+'_Date_Mercato__c'));
            
           /* {
                                                        'CIN_Date_Mercato__c'=> mainRecord.CIN_Date_Mercato__c,
                                                        'CIR_Date_Mercato__c'=> mainRecord.CIR_Date_Mercato__c,
                                                        'TAT_date_Mercato__c'=> mainRecord.TAT_date_Mercato__c,
                                                        'FI_Date_Mercato__c' => mainRecord.FI_Date_Mercato__c,
                                                        'IL_Date_Mercato__c' => mainRecord.IL_Date_Mercato__c
                                                            };*/
            V2AP01_SegmentationManager.datesMercato = new map<id,map<string,Date>>{mainRecord.id=>datesMercato};
            //Insertion des histos Cette opération va déclencher un trigger qui va mettre a jour le compte.
            database.upsert(lHistos,Historique_Segmentation__c.id_externe__c,true);
            init();
        }catch(DMLException e){
            for(Historique_Segmentation__c histo : lHistos){
                histo.id = null;
            }
            String m = e.getDMLMessage(0);
            if(test.isRunningTest())
                m+=e.getStackTraceString();
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,m));
            
        }
        
        initContactRoleMap();
        return null;
    }
    
    private void initContactRoleMap(){
        ContactRolesByBu = new map<string,list<string>>();
        refContactRoles = new map<string,AccountContactRole>();
        set<string> sBus = new set<string>();/* = new set<string>{'ACS','CIR'/*,'DI'* /,'AS','TAT','IL','CIN'}*/
        for(String bu : V2AP01_SegmentationManager.lBus){
            if(bu == 'FI') //Cas particulier de renomage de FI en as
                bu = 'AS';
            if(!sBus.contains(bu))
                sBus.add(bu);
        }
        refContactRoles = new map<String,AccountContactRole>();
        
        map<string,AccountContactRole> refExistingContactRoles = new map<string,AccountContactRole>();
        
        for(Schema.PicklistEntry pke : AccountContactRole.Role.getDescribe().getPicklistValues()){
            string sLbl = pke.getLabel();
            string sBu = sLbl.right(3).trim();
            if(sBus.contains(sBu) && !sLbl.contains('partenariat')){
                refContactRoles.put(pke.getLabel().trim(),new AccountContactRole(contactId = null, accountId = mainRecord.id, role = sLbl));
                if(!ContactRolesByBu.containsKey(sBu)){
                    ContactRolesByBu.put(sBu,new List<string>());
                }
                ContactRolesByBu.get(sBu).add(sLbl);
            }
        }
        for(AccountContactRole oACR : [Select contactId, role from AccountContactRole where Accountid =: oStdCtrl.getId()]){
            if(refContactRoles.containsKey(oAcr.role))
                refContactRoles.put(oACR.role,oACR);
        }
        
    }
    
    public SF2VFC02_AccountFRView getCtrl(){
        return this;
    }
}