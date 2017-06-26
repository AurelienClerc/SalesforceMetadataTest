public class AppATfeuilleCalculCtrl {

    private AppATfeuilleCalcul__c feuilleCalcul;
    
    public List<SelectOption> CTNtypes {get; set;}
    public String selectedCTNtype {get; set;}
    
    public String clonedFromYear {get; set;}
    
/*  public List<SelectOption> recordTypes {get; set;}
    public String selectedRecordType {get; set;}
    */
    public AppATfeuilleCalculCtrl(ApexPages.standardController stdCtrl){
        
        this.feuilleCalcul = (AppATfeuilleCalcul__c) stdCtrl.getRecord();
        
        
        if(ApexPages.currentPage().getParameters().get('clone') == '1'){
                this.feuilleCalcul.Id = null;
                this.selectedCTNtype = this.feuilleCalcul.CTN__r.TypeCTN__c;
                this.feuilleCalcul.CTN__c = null;
                this.feuilleCalcul.Majoration__c = null;
                this.clonedFromYear = this.feuilleCalcul.AnneeFeuilleCalcul__c;
                
        }
        else{
            AppATetablissement__c etab = [SELECT Id, AlsaceMoselle__c FROM AppATetablissement__c WHERE Id = :this.feuilleCalcul.EtablissementConcerne__c][0];
                
            this.feuilleCalcul.AlsaceMoselle__c = etab.AlsaceMoselle__c;
        }
        
        if(this.feuilleCalcul.Id == null){
            this.initFCnew();
        }
    }
    
    
    private void initFCnew(){

        //Initialise le menu déroulant des Type de CTN
        this.CTNtypes = new List<SelectOption>();
        for(Schema.PicklistEntry pe : AppATctn__c.TypeCTN__c.getDescribe().getPicklistValues())
            this.CTNtypes.add( new SelectOption(pe.getValue(), pe.getLabel()) );
            
    

    }
    
    public PageReference create(){
        
        
        //Récupération du CTN
        List<AppATctn__c> CTNs = [SELECT Id, Annee__c FROM AppATctn__c WHERE Annee__c <= :this.feuilleCalcul.AnneeFeuilleCalcul__c AND TypeCTN__c = :this.selectedCTNtype ORDER BY Annee__c DESC LIMIT 1];
        
        //Cherche un CTN de l'année de la feuille de calcul, Si c'est une feuille Simulée, alors on accepte de prendre le dernier CTN en date même si l'année est inférieure
        if(!CTNs.isEmpty() && (CTNs[0].Annee__c == this.feuilleCalcul.AnneeFeuilleCalcul__c || this.feuilleCalcul.Type_de_feuille_de_calcul__c == 'Simulée')){
                this.feuilleCalcul.CTN__c = CTNs[0].Id;
        }
        else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Aucun CTN trouvé pour le type "' + this.selectedCTNtype + '"'));
                return null;
        }
        
        
        //Récupération des masses salariales
        Integer annee = Integer.valueOf(this.feuilleCalcul.AnneeFeuilleCalcul__c);
        for(AppATmasseSalariale__c ms : [SELECT Id, Annee__c FROM AppATmasseSalariale__c WHERE EtablissementConcerne__c = :this.feuilleCalcul.EtablissementConcerne__c]){
            if(ms.Annee__c == String.valueOf( annee - 2 ))
                this.feuilleCalcul.MasseSalarialeAnneeN_2__c = ms.Id;
            else if(ms.Annee__c == String.valueOf( annee - 3 ))
                this.feuilleCalcul.MasseSalarialeAnneeN_3__c = ms.Id;
            else if(ms.Annee__c == String.valueOf( annee - 4 ))
                this.feuilleCalcul.MasseSalarialeAnneeN_4__c = ms.Id;
        }
        if(this.feuilleCalcul.MasseSalarialeAnneeN_2__c == null || this.feuilleCalcul.MasseSalarialeAnneeN_3__c == null || this.feuilleCalcul.MasseSalarialeAnneeN_4__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Une ou plusieurs masses salariales sont manquantes'));
            return null;
        }
        
        
        //Récupération de la majoration
        List<AppATmajoration__c> majorations = [SELECT Id, Annee__c FROM AppATmajoration__c WHERE Annee__c <= :this.feuilleCalcul.AnneeFeuilleCalcul__c ORDER BY Annee__c DESC LIMIT 1];
        
        //Cherche une Majoration de l'année de la feuille de calcul, Si c'est une feuille Simulée, alors on accepte de prendre la derniere Majoration en date même si l'année est inférieure
        if(!majorations.isEmpty() && (majorations[0].Annee__c == this.feuilleCalcul.AnneeFeuilleCalcul__c || this.feuilleCalcul.Type_de_feuille_de_calcul__c == 'Simulée')){
                this.feuilleCalcul.Majoration__c = majorations[0].Id;
        }
        else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Aucune majoration trouvée'));
                return null;
        }
        
        
        system.debug(this.clonedFromYear);
        system.debug(this.feuilleCalcul.AnneeFeuilleCalcul__c);
        
                //Si on fait un clone en choisissant l'année suivante: On décale tous les CCM IP/IT d'une année        
        if(this.clonedFromYear != null && Integer.valueOf(this.clonedFromYear) == Integer.valueOf(this.feuilleCalcul.AnneeFeuilleCalcul__c) - 1){
                this.shiftCCM();
        }
        
        try{
                insert feuilleCalcul;
                PageReference retPage = Page.AppATfeuilleCalculEdit;
                retPage.getParameters().put('id', feuilleCalcul.Id);
                retPage.setRedirect(true);
                return retPage;
        }
        catch(System.DmlException e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, e.getDmlMessage(0)));
                return null;
        }
        
       
    }
    
    
    
    /**
     * Décales tous les CCM IT/IP d'une année (N-3 récupère les valeurs de N-4, N-3 récupère les valeurs de N-2, N-2 est vidée)
     */
    private void shiftCCM(){
        
        this.feuilleCalcul.CCMIT1_N_4__c = this.feuilleCalcul.CCMIT1_N_3__c;
        this.feuilleCalcul.CCMIT2_N_4__c = this.feuilleCalcul.CCMIT2_N_3__c;
        this.feuilleCalcul.CCMIT3_N_4__c = this.feuilleCalcul.CCMIT3_N_3__c;
        this.feuilleCalcul.CCMIT4_N_4__c = this.feuilleCalcul.CCMIT4_N_3__c;
        this.feuilleCalcul.CCMIT5_N_4__c = this.feuilleCalcul.CCMIT5_N_3__c;
        this.feuilleCalcul.CCMIT6_N_4__c = this.feuilleCalcul.CCMIT6_N_3__c;
        this.feuilleCalcul.CCMIP1_N_4__c = this.feuilleCalcul.CCMIP1_N_3__c;
        this.feuilleCalcul.CCMIP2_N_4__c = this.feuilleCalcul.CCMIP2_N_3__c;
        this.feuilleCalcul.CCMIP3_N_4__c = this.feuilleCalcul.CCMIP3_N_3__c;
        this.feuilleCalcul.CCMIP4_N_4__c = this.feuilleCalcul.CCMIP4_N_3__c;
        
        this.feuilleCalcul.CCMIT1_N_3__c = this.feuilleCalcul.CCMIT1_N_2__c;
                this.feuilleCalcul.CCMIT2_N_3__c = this.feuilleCalcul.CCMIT2_N_2__c;
                this.feuilleCalcul.CCMIT3_N_3__c = this.feuilleCalcul.CCMIT3_N_2__c;
                this.feuilleCalcul.CCMIT4_N_3__c = this.feuilleCalcul.CCMIT4_N_2__c;
                this.feuilleCalcul.CCMIT5_N_3__c = this.feuilleCalcul.CCMIT5_N_2__c;
                this.feuilleCalcul.CCMIT6_N_3__c = this.feuilleCalcul.CCMIT6_N_2__c;
                this.feuilleCalcul.CCMIP1_N_3__c = this.feuilleCalcul.CCMIP1_N_2__c;
                this.feuilleCalcul.CCMIP2_N_3__c = this.feuilleCalcul.CCMIP2_N_2__c;
                this.feuilleCalcul.CCMIP3_N_3__c = this.feuilleCalcul.CCMIP3_N_2__c;
                this.feuilleCalcul.CCMIP4_N_3__c = this.feuilleCalcul.CCMIP4_N_2__c;
                
                this.feuilleCalcul.CCMIT1_N_2__c = null;
                this.feuilleCalcul.CCMIT2_N_2__c = null;
                this.feuilleCalcul.CCMIT3_N_2__c = null;
                this.feuilleCalcul.CCMIT4_N_2__c = null;
                this.feuilleCalcul.CCMIT5_N_2__c = null;
                this.feuilleCalcul.CCMIT6_N_2__c = null;
                this.feuilleCalcul.CCMIP1_N_2__c = null;
                this.feuilleCalcul.CCMIP2_N_2__c = null;
                this.feuilleCalcul.CCMIP3_N_2__c = null;
                this.feuilleCalcul.CCMIP4_N_2__c = null;
    }
    
}