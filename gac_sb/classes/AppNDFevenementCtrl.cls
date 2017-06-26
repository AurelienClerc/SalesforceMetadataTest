public with sharing class AppNDFevenementCtrl {

    private Id IdEvenement;
    private final Event oEvenement;
    public final List<String> lsEtapeActive = new List<String> {'En cours','Refusé'};
    public Note_De_Frais__c oNDF {get;set;}
    public Note_De_Frais_Recap__c oNDFrecap {get;set;}
    public Boolean bNDFexiste {get;set;} // signifie existe déjà dans la base
    public Boolean bNDFrecapExiste {get;set;} // signifie existe déjà dans la base
    public Boolean bHasEvent {get;set;}
    public List<Note_De_Frais_Depense__c> lsDepense {get;set;}
    public List<Note_De_Frais_Depense__c> lsDepenseKilo {get;set;}
    public String sTempKeySelected {get;set;}
    public List<selectOption> lsNatureOption {get;set;}
    public List<selectOption> lsNatureOptionKilo {get;set;}
    public List<Note_De_Frais_Nature_Depense__c> lsNature;
    public String sNature {get;set;}
    public String sType {get;set;}
    public String pays{get;set;}
    public AppNDFevenementCtrl(ApexPages.StandardController controller) {
        
        this.oEvenement = (Event) controller.getRecord(); 
        
        this.bHasEvent = this.oEvenement.Id != null ? true : false;
        
        this.initSNature();
        this.initNDF();
        this.initRecapNDF();
        this.initLsDepense();
    }
    
    /*
    * Initialise une map avec les enregistrements actifs de Note_De_Frais_Nature_Depense
    * plus la liste de sélection des natures dépense
    */
    public void initSNature(){
        Map<Id, Map<String, String>> mpNature = new Map<Id, Map<String, String>>();
        
        this.lsNature = [
                    Select 
                        n.Type__c,
                        n.Name,
                        n.Id,
                        n.Aide__c,
                        n.Actif__c
                    From Note_De_Frais_Nature_Depense__c n 
                    Where n.doInclude__c = true //Do include gère notamment le pays
                    Order by n.Name asc];
        
        Map<String, String> mpAttr;
        this.lsNatureOption = new List<selectOption>();
        this.lsNatureOption.add(new selectOption('', '- None -'));
        this.lsNatureOptionKilo = new List<selectOption>();
        for(Note_De_Frais_Nature_Depense__c oNature : lsNature){
            mpAttr = new Map<String, String>();
            mpAttr.put('libelle', oNature.Name);
            mpAttr.put('aide', oNature.Aide__c);
            mpAttr.put('type', oNature.Type__c);
            
            mpNature.put(oNature.Id, mpAttr);
            
            // picklist des natures dépense, à la place d'un lookup
            if(oNature.Type__c != 'Frais kilométrique')
                this.lsNatureOption.add(new selectOption(oNature.Id, oNature.Name));
            else
                this.lsNatureOptionKilo.add(new selectOption(oNature.Id, oNature.Name));
            
        }
        
        this.sNature = JSON.serialize(mpNature);                
    }
    
    /*
    * pas d'évènement: soit on est sur un récap et on crée une NDF associée
    * soit on crée à partir de rien et on vérifie l'existance du récap, sinon on crée
    */
    /*public void initRecapAndNDF(){
        if(Apexpages.currentPage().getParameters().get('idRecap') != null){
            this.bNDFrecapExiste = true;
            
            Note_De_Frais_Recap__c recap = [
                    Select
                        n.Traitement_comptabilite__c,
                        n.Periode_label__c,
                        n.OwnerId,
                        n.Name,
                        n.IsDeleted,
                        n.Id,
                        n.Etape__c,
                        n.Date_Debut_De_Periode__c,
                        n.Date_fin_de_periode__c,
                        n.Date_de_traitement_comptabilite__c,
                        n.Collaborateur__c
                    From Note_De_Frais_Recap__c n
                    Where n.Id =: Apexpages.currentPage().getParameters().get('idRecap')];
            
            // on vérifie si le recap est bien en cours ou refusé       
            if(new Set<String>(this.lsEtapeActive).contains(recap.Etape__c) == false ){
                // FIXME gérer ce cas??
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Vous ne pouvez pas ajouter de note de frais sur cet élément'));   
            }else{
                this.oNDFrecap = recap;
                
                // on récupère la NDF (page de view après enregistrement par exemple, ou de modification)
                this.bNDFexiste = true;
                this.oNDF = [
                        Select 
                            n.RecordTypeId,
                            n.Name,
                            n.Description__c,
                            n.IsDeleted,
                            n.Id,
                            n.Total_Frais_Kilometrique__c,
                            n.Total_Train__c,
                            n.Total_Taxi__c,
                            n.Total_Poste__c,
                            n.Total_Peage_Parking_Metro_Bus__c,
                            n.Total_Location_Vehicule__c,
                            n.Total_Hotel_Nuitee__c,
                            n.Total_Carburant__c,
                            n.Total_Avion__c,
                            n.Total_Autres_HT__c,
                            n.Total_Autres_TTC__c,
                            n.Total_Petit_Dejeuner__c,
                            n.Total_Dejeuner__c,
                            n.Total_Diner__c,
                            n.Total__c,
                            n.Recap_Note_De_Frais__c,
                            n.Recap_Note_De_Frais__r.Etape__c,
                            n.Evenement_Id__c,
                            n.Departement__c,
                            n.Date_des_frais__c,
                            n.Compte__c
                        From Note_De_Frais__c n
                        Where n.Id =: Apexpages.currentPage().getParameters().get('idNDF')];
            }
        }else{
            // on crée une NDF
            
    }*/


    /*
    * TODO
    */
    public void initNDF(){
    
        String soqlQueryBase = 'Select n.RecordTypeId, n.pays__c,n.Name,n.Description__c,n.IsDeleted,n.Id,n.Total_Frais_Kilometrique__c,n.Total_Train__c,n.Total_Taxi__c,n.Total_Poste__c,n.Total_Parking__c ,n.Total_Peage_Parking_Metro_Bus__c,n.Total_Location_Vehicule__c,n.Total_Hotel_Nuitee__c,n.Total_Carburant__c,n.Total_Avion__c,n.Total_Autres_HT__c,n.Total_Autres_TTC__c,n.Total_Petit_Dejeuner__c,n.Total_Dejeuner__c,n.Total_Diner__c,n.Total_TTC__c,n.Total_HT__c,n.Total_TVA__c,n.Total__c,n.Nombre_De_Dejeuners__c,n.Recap_Note_De_Frais__r.Etape__c,n.Recap_Note_De_Frais__r.OwnerId,n.Evenement_Id__c,n.Departement__c,n.Date_des_frais__c,n.Compte__c From Note_De_Frais__c n';
        String soqlQueryCond;
        
        // il y a l'Id NDF dans l'URL (on  est sur la page de recap)
        if(Apexpages.currentPage().getParameters().get('idNDF') != null){
            this.bNDFexiste = true;
            
            soqlQueryCond = ' Where n.Id =\'' + Apexpages.currentPage().getParameters().get('idNDF') + '\'';
            /*if(Apexpages.currentPage().getParameters().get('appro') != 'true')
                soqlQueryCond += ' And n.Recap_Note_De_Frais__r.OwnerId =\'' + UserInfo.getUserId() + '\'';*/
            
            this.oNDF = Database.query(soqlQueryBase + soqlQueryCond);
            this.pays = this.oNDF.pays__c;        
            return;
        }
        
        // il y a pas d'Id NDF mais y a un évenement (on est sur l'évenement)
        if(this.oEvenement.Id != null){
            
            // on rajoute des ' à this.lsEtapeActive
            String sEtapeActive = '(';
            for(String sEtape : this.lsEtapeActive){
                sEtapeActive += '\'' + sEtape + '\',';
            }
            sEtapeActive = sEtapeActive.left(sEtapeActive.length() - 1);
            sEtapeActive += ')';
            
            soqlQueryCond = ' Where n.Recap_Note_De_Frais__r.Etape__c in ' + sEtapeActive;
            soqlQueryCond += ' And n.Evenement_Id__c = \'' + this.oEvenement.Id + '\'';
            soqlQueryCond += ' And n.Recap_Note_De_Frais__r.OwnerId = \'' + UserInfo.getUserId() + '\'';
            
            List<Note_De_Frais__c> lsNDF = Database.query(soqlQueryBase + soqlQueryCond);

            this.bNDFexiste = lsNDF.size() > 0 ? true : false;
             
            // Si la liste n'est pas vide, on prend le premier enregistrement.
            // il ne peut y avoir qu'un seul enregistrement dans cette liste, sinon c'est un bug
            if(this.bNDFexiste)
                this.oNDF = lsNDF[0];
            else{
                this.oNDF = new Note_De_Frais__c(
                    Evenement_Id__c = this.oEvenement.Id);
                        
                this.oNDF.RecordTypeId = this.getRT('Note_De_Frais__c', 'Evenement');
            }
            
        }else{ // pas d'Id NDF dans l'url, pas d'évenement (on veut ajouter une note de frais libre)
            this.bNDFexiste = false;
            this.oNDF = new Note_De_Frais__c();
            this.oNDF.RecordTypeId = this.getRT('Note_De_Frais__c', 'Libre');
        }
        if(!bNDFexiste){
            this.oNDF.pays__c = AppNdfSetting__c.getInstance().pays__c == null ? 'FR' :  AppNdfSetting__c.getInstance().pays__c.left(2);
            this.pays = this.oNDF.pays__c;
        }
            
    }
    
    /*
    * TODO
    */
    public void initRecapNDF(){
            
        // si l'objet NDF existe, c'est que le récap existe aussi (inutile de prendre l'Id Recap qu'est dans l'URL)
        if(this.bNDFexiste){
            this.bNDFrecapExiste = true;
            this.oNDFrecap = [
                        Select
                            n.Traitement_comptabilite__c,
                            n.Nombre_De_Dejeuners__c,
                            n.Periode_label__c,
                            n.OwnerId,
                            n.Name,
                            n.IsDeleted,
                            n.Id,
                            n.Etape__c,
                            n.Date_Debut_De_Periode__c,
                            n.Date_fin_de_periode__c,
                            n.Date_de_traitement_comptabilite__c,
                            n.Collaborateur__c
                        From Note_De_Frais_Recap__c n
                        Where n.Id =: this.oNDF.Recap_Note_De_Frais__c];
        }else{ // sinon, on cherche en fonction de la date du jour
            List<Note_De_Frais_Recap__c> lsNDFrecap = [
                        Select
                            n.Traitement_comptabilite__c,
                            n.Nombre_De_Dejeuners__c,
                            n.Periode_label__c,
                            n.OwnerId,
                            n.Name,
                            n.IsDeleted,
                            n.Id,
                            n.Etape__c,
                            n.Date_Debut_De_Periode__c,
                            n.Date_fin_de_periode__c,
                            n.Date_de_traitement_comptabilite__c,
                            n.Collaborateur__c,
                			n.Pays__c
                        From Note_De_Frais_Recap__c n
                        Where n.Etape__c in : lsEtapeActive
                            /*And n.Date_Debut_De_Periode__c <: date.newInstance(2013,8,22)
                            And n.Date_fin_de_periode__c >: date.newInstance(2013,8,22)];*/
                            And n.Date_Debut_De_Periode__c <=: date.today()
                            And n.Date_fin_de_periode__c >=: date.today()
                            And n.OwnerId =: UserInfo.getUserId()];
                
            this.bNDFrecapExiste = (lsNDFrecap.size() > 0) ? true : false;
            
            if(this.bNDFrecapExiste){
                this.oNDFrecap = lsNDFrecap[0];
                this.oNDF.Recap_Note_De_Frais__c = this.oNDFrecap.Id;
            }else{ // sinon on crée un nouveau recap
                // construction de la date de début et de fin de la période
                Date dtDebut = date.newInstance(date.today().year(), date.today().month(), 20);
                //Date dtDebut = date.newInstance(date.newInstance(2013,8,22).year(), date.newInstance(2013,8,22).month(), 20);
                    
                if(date.today().day() < 20)
                //if(date.newInstance(2013,8,22).day() < 20)
                    dtDebut = dtDebut.addMonths(-1);
                
                Date dtFin = dtDebut.addMonths(1);
                dtFin = dtFin.addDays(-1);
                
                this.oNDFrecap = new Note_De_Frais_Recap__c(
                        Etape__c = 'En cours',
                        Collaborateur__c = UserInfo.getUserId(),
                    	Pays__c = this.pays,
                        Date_Debut_De_Periode__c = dtDebut,
                        Date_fin_de_periode__c = dtFin);
            }
        }
    }
    
    public void initLsDepense(){
        
        this.lsDepense = new List<Note_De_Frais_Depense__c>();
        this.lsDepenseKilo = new List<Note_De_Frais_Depense__c>();
        if(this.bNDFexiste){
            List<Note_De_Frais_Depense__c> lsD = [
                Select n.Note_De_Frais__c,
                    n.Nature_Depense__c,
                    n.Nature_Depense__r.Name,
                    n.Nature_Depense__r.Type__c,
                    n.Name,
                    n.Temp_Key__c,
                    n.Montant_TVA__c,
                    n.Montant_TTC__c,
                    n.Montant_HT__c,
                    n.Indemnites_Kilometriques__c,
                    n.Taux_Indemnites__c,
                    n.Nombre_De_Kilometres__c,  
                    n.Description__c,
                    n.Num_PJ__c,
                    n.IsDeleted,
                	n.statutClientBR__c,
                    n.Id
                From Note_De_Frais_Depense__c n
                Where n.Note_De_Frais__c =: this.oNDF.Id];

            for(Note_De_Frais_Depense__c depense : lsD){
                depense.Temp_Key__c = this.getRandomKey();
                
                if(depense.Nature_Depense__r.Type__c == 'TTC' || depense.Nature_Depense__r.Type__c == 'HT')
                    this.lsDepense.add(depense);
                
                if(depense.Nature_Depense__r.Type__c == 'Frais kilométrique')
                    this.lsDepenseKilo.add(depense);
            }   
        }
    }
    
    public void addRow() {
        Note_De_Frais_Depense__c depense = new Note_De_Frais_Depense__c(Temp_Key__c = this.getRandomKey());
        
        if(this.sType.startsWithIgnoreCase('Autre_Frais')){
            depense.RecordTypeId = this.getRT('Note_De_Frais_Depense__c', this.sType);
            this.lsDepense.add(depense);
        }

        if(this.sType == 'Frais_Kilometrique'){
            // FIXME: peut mieux faire...
            List<Note_De_Frais_Nature_Depense__c> lsNature = [
                        Select 
                            n.Type__c,
                            n.Name,
                            n.Id,
                            n.Aide__c,
                            n.Actif__c
                        From Note_De_Frais_Nature_Depense__c n
                        Where n.Type__c = 'Frais kilométrique' and doInclude__c = true];
            
            depense.Nature_Depense__c = lsNature[0].Id;
            depense.RecordTypeId = this.getRT('Note_De_Frais_Depense__c', this.sType);
            this.lsDepenseKilo.add(depense);
        }
    }
    
    public void deleteRow(){
        List<Note_De_Frais_Depense__c> ls;
        if(this.sType == 'Frais_Kilometrique')
            ls = this.lsDepenseKilo;
        else
            ls = this.lsDepense;
        
        Boolean bError;
        for(Integer i = 0; i < ls.size(); i++){
            if(ls.get(i).Temp_Key__c == this.sTempKeySelected){
                bError = false;
                if(ls.get(i).Id != null){
                    try{
                        delete ls.get(i);
                    }catch(Exception ex){
                        bError = true;
                        ApexPages.addMessages(ex);
                    }
                }
                if(!bError)
                    ls.remove(i);
            }
        }
    }
    
    public Boolean save(){
        
        Savepoint sp = Database.setSavepoint();
        
        // enregistrement de Note de frais recap si existe pas déjà
        if(!this.bNDFrecapExiste){
            try{
                insert this.oNDFrecap;
            }catch(DmlException ex){
                system.debug(ex.getMessage());
                system.debug(ex.getStackTraceString());
                ApexPages.addMessages(ex);
                return false;
            }
            
        }
        
        if(this.bHasEvent == true){
            if(this.oEvenement.What.Type == 'Opportunity' || this.oEvenement.What.Type == 'Account' || this.oEvenement.What.Type == 'Contract')
                this.oNDF.Compte__c = this.oEvenement.AccountId;
            
            if(this.oEvenement.What.Type == 'Contract')
                this.oNDF.Contrat__c = this.oEvenement.WhatId;
            
            if(this.oEvenement.What.Type == 'Opportunity')
                this.oNDF.Opportunite__c = this.oEvenement.WhatId;
                
            if(this.oEvenement.What.Type == 'Mission__c'){
                this.oNDF.Mission__c = this.oEvenement.WhatId;
                this.oNDF.Compte__c = [Select Id, Compte__c From Mission__c Where Id =: this.oEvenement.WhatId][0].Compte__c;
            }    
                
            if(this.oEvenement.What.Type == 'INNOmission__c'){
                this.oNDF.Compte__c = [Select Id, Contrat__r.AccountId From INNOmission__c Where Id =: this.oEvenement.WhatId][0].Contrat__r.AccountId;
            }
        }else{
            this.oNDF.Opportunite__c = null;
            this.oNDF.Mission__c = null;
            this.oNDF.Compte__c = null;
            this.oNDF.Contrat__c = null;
        }    
        this.oNdf.Recap_Note_De_Frais__c = this.oNDFrecap.Id;
        try{
            upsert this.oNDF;
        }catch(DmlException ex){
            system.debug(ex.getMessage());
                system.debug(ex.getStackTraceString());
            if(!this.bNDFrecapExiste)
                this.oNDFrecap.Id = null; // on reinit a null l'id sinon la fois suivante, il va essayer de faire un insert avec Id
            Database.rollback(sp); // rollback en cas d'erreur
            ApexPages.addMessages(ex);
            return false;
        }
        for(Note_De_Frais_Depense__c d : this.lsDepense)
            d.Note_De_Frais__c = this.oNDF.Id;
        
        for(Note_De_Frais_Depense__c d : this.lsDepenseKilo)
            d.Note_De_Frais__c = this.oNDF.Id;

        // enregistrement des dépenses
        try{
            upsert this.lsDepense;
        }catch(DmlException ex){
            system.debug(ex.getMessage());
                system.debug(ex.getStackTraceString());
            if(!this.bNDFrecapExiste)
                this.oNDFrecap.Id = null; // on reinit a null l'id sinon la fois suivante, il va essayer de faire un insert avec Id
            if(!this.bNDFexiste)
                this.oNDF.Id = null;  // dans le cas d'un insert on reinit a null l'id sinon la fois suivante, il va essayer de faire un insert avec Id
            Database.rollback(sp); // rollback en cas d'erreur
            ApexPages.addMessages(ex);
            return false;
            
        }
        
        try{
            upsert this.lsDepenseKilo;
        }catch(DmlException ex){
            system.debug(ex.getMessage());
                system.debug(ex.getStackTraceString());
            if(!this.bNDFrecapExiste)
                this.oNDFrecap.Id = null; // on reinit a null l'id sinon la fois suivante, il va essayer de faire un insert avec Id
            if(!this.bNDFexiste)
                this.oNDF.Id = null;  // dans le cas d'un insert on reinit a null l'id sinon la fois suivante, il va essayer de faire un insert avec Id
            Database.rollback(sp); // rollback en cas d'erreur
            ApexPages.addMessages(ex);
            return false;
        }
        
        return true;
    }
    
    public PageReference saveRecords(){
        
        if(this.lsDepense.size() == 0 && this.lsDepenseKilo.size() == 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Vous devez saisir au minimum une dépense ou des frais kilométriques'));
            return null;
        }
        
        if(!this.save())
            return null;
        
        PageReference page;
        if(this.bHasEvent == true)
            page = new PageReference('/apex/AppNDFevenementView?appro=' + Apexpages.currentPage().getParameters().get('appro') + '&refresh=' + Apexpages.currentPage().getParameters().get('refresh') + '&idNDF=' + this.oNDF.Id + '&id=' + this.oEvenement.Id);
        else
            page = new PageReference('/apex/AppNDFevenementView?appro=' + Apexpages.currentPage().getParameters().get('appro') + '&refresh=' + Apexpages.currentPage().getParameters().get('refresh') + '&idNDF=' + this.oNDF.Id);
        
        page.setRedirect(true); 
        return page;
    }
    
    public PageReference deleteAll(){
        
        try{
            delete this.oNDF;
        }catch(DmlException ex){
            ApexPages.addMessages(ex);
            return null;
        }
        
        // redirection vers une page qui se ferme (en js)   
        // un simple oncomplete="self.close();" ferme même si il y a des erreurs...
        PageReference page;
        if(Apexpages.currentPage().getParameters().get('refresh') == '1')
            page = new PageReference('/apex/AppNDFcloseAndRefresh?idRecap='+this.oNDFrecap.Id); 
        else
            page = new PageReference('/apex/AppNDFclose'); 
        page.setRedirect(true); 
        return page;

    }
    
    public PageReference saveRecordsAndClose(){
        
        if(this.lsDepense.size() == 0 && this.lsDepenseKilo.size() == 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Vous devez saisir au minimum une dépense ou des frais kilométriques'));
            return null;
        }
        
        if(!this.save())    
            return null;
        
        // redirection vers une page qui se ferme (en js)   
        // un simple oncomplete="self.close();" ferme même si il y a des erreurs...
        PageReference page;
        if(Apexpages.currentPage().getParameters().get('refresh') == '1'){
            String sPage = Apexpages.currentPage().getParameters().get('appro') != 'true' ? 'AppNDFrecap' : 'AppNDFsingleRecap';
            page = new PageReference('/apex/AppNDFcloseAndRefresh?idRecap='+this.oNDFrecap.Id+'&page='+sPage); 
        }
        else
            page = new PageReference('/apex/AppNDFclose'); 
        page.setRedirect(true); 
        return page;
    }
    
    public String getRandomKey(){
        return EncodingUtil.convertToHex(crypto.generateAesKey(128)).substring(1,15).toUpperCase();
    }
    
    public Id getRt(String sObjectType, String sDeveloperName){
        List<RecordType> lsRT = [
            Select
                r.SobjectType,
                r.Name,
                r.DeveloperName,
                r.Id
            From RecordType r
            Where r.SobjectType =: sObjectType
                And r.DeveloperName =: sDeveloperName];

        if(lsRT.size() > 0)
            return lsRT[0].Id;
        else
            return null;
    }
    
    
}