public with sharing class FactuCreateFactureCtrl {

    public Facture__c factu{get;set;}

    public List<DetailFacture> DetailFactuList{get;set;}

    public Mission__c mission{get;set;}

    public String mode{get;set;}

    public Boolean isAdminOrDaf{get;set;}

    public Boolean isRecouvrement{get;set;}

    private ApexPages.standardController stdCtrl;

    public List<Selectoption> listeAdresseClients {get;set;}

    //Informations du footer (FacturationEntite__c est un custom setting)
    public FacturationEntite__c footerInfos {get; set;}

    //L'année de la facture avant modification (pour vérification dans le save)
    // private Integer previousFactureYear;



    /**
     *  Action permettant de dévalider une facture
     *  Appelé par la page VF FactuUnvalidateFacture
     */
    public PageReference unvalidateFacture(){    


        //On ne peut pas dévalider une facture qui est liée à un avoir
        if([SELECT Id FROM Facture__c WHERE Facture_liee__c = :this.factu.Id].size() > 0){
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, Label.Factu_devalider_facture_avec_avoir));
            return null;
        }

        //Supprime les encaissements rattachés
        delete [SELECT Id FROM Encaissement__c WHERE Facture__c = :this.factu.Id];

        //Change le statut et la date de validation
        this.factu.Statut__c = 'En attente';
        this.factu.Date_validation__c = null;

        update this.factu;


        return this.stdCtrl.view();
    }


    public FactuCreateFactureCtrl(ApexPages.standardController stdCtrl){


        this.stdCtrl = stdCtrl;
        this.factu = (Facture__c)stdCtrl.getRecord();

        this.isAdminOrDaf = false;
        this.isRecouvrement = false;

        List<GroupMember> Groupe_Admin_ou_DAF = [SELECT UserOrGroupId
                                                 FROM GroupMember
                                                 WHERE Group.Name = 'Groupe Admin ou DAF'];
        for(GroupMember m : Groupe_Admin_ou_DAF){
            if(Userinfo.getUserId() == m.UserOrGroupId)
                this.isAdminOrDaf = true;
        }                    

        List<GroupMember> Groupe_Recouvrement = [SELECT UserOrGroupId
                                                 FROM GroupMember
                                                 WHERE Group.Name = 'Groupe Recouvrement'];
        for(GroupMember m : Groupe_Recouvrement){
            if(Userinfo.getUserId() == m.UserOrGroupId)
                this.isRecouvrement = true;
        }                      

        //Si c'est pas la page de dévalidation de facture
        if(!ApexPages.currentPage().getUrl().startsWith('/apex/FactuUnvalidateFacture')) {
            if(ApexPages.currentPage().getParameters().get('id') != null){
                /*
                 * Mode edition
                 */
                this.mode = 'edit';
                this.mission = [SELECT Id, Name, CurrencyIsoCode, Contrat__r.Account.RecordType.DeveloperName FROM Mission__c WHERE Id = :this.factu.Mission__c];   //Notamment pour récupérer le CurrencyIsoCode utile dans addDetailFacture
                this.initDetailFactuList();
                if(this.factu.Account_Record_Type__c == 'FRANCE_ACCOUNT'){

                    this.initFooterInfos();
                    this.initListeAdresseClients(true);

                }else if(this.factu.Account_Record_Type__c == 'SPAIN_ACCOUNT'){

                    this.initFooterInfos();
                    this.initListeAdresseClients(true);

                }else if(this.factu.Account_Record_Type__c == 'BRASIL_ACCOUNT'){

                    // Rien à faire

                }else if(this.factu.Account_Record_Type__c == 'CANADA_ACCOUNT'){
                    this.initFooterInfos();
                    this.initListeAdresseClients(false);

                }else{

                    this.initFooterInfos();
                    this.initListeAdresseClients(true);

                }    
            }else{
                /*
                 * Mode création
                 */
                this.mode = 'create';
                this.initInfos(ApexPages.currentPage().getParameters().get('MissionId'),ApexPages.currentPage().getParameters().get('PlanifsId').split(':'));
                this.initDetailFactuList();
                if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'FRANCE_ACCOUNT'){

                    this.initFooterInfos();
                    this.initListeAdresseClients(true);

                }else if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'SPAIN_ACCOUNT'){

                    this.initFooterInfos();
                    this.initListeAdresseClients(true);

                }else if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'BRASIL_ACCOUNT'){

                    // Rien à faire

                }else if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'CANADA_ACCOUNT'){
                    this.initFooterInfos();
                    this.initListeAdresseClients(false);

                }else{

                    this.initFooterInfos();
                    this.initListeAdresseClients(true);

                }  
            }
        }
    }

    /*
     * get mission and contrat and planif selectionnées
     */
    private void initInfos(Id id, List<Id> selectedPlanifs){

        this.mission = [Select  m.name,
                        m.Id,
                        m.CurrencyIsoCode,
                        m.OwnerId,
                        m.Contrat__c,
                        m.Contrat__r.Id,
                        m.Contrat__r.Conditions_de_paiement__c,
                        m.Contrat__r.N_compte_client__c,
                        m.Contrat__r.N_r_f_rence_client__c,
                        m.Contrat__r.Contact_facturation__c,
                        m.Contrat__r.Conditions_de_remuneration__c,
                        m.Contrat__r.Precision_remuneration__c,
                        m.Contrat__r.Entite_GAC__c,
                        m.Contrat__r.Account.BillingStreet,
                        m.Contrat__r.Account.BillingPostalCode,
                        m.Contrat__r.Account.BillingCity,
                        m.Contrat__r.Account.BillingState,
                        m.Contrat__r.Account.BillingCountry,
                        m.Contrat__r.Account.Name,
                        m.Contrat__r.Account.TVA_Intracommunautaire__c,
                        m.Contrat__r.Account.SIRET__c,
                        m.Contrat__r.Account.RecordType.DeveloperName,
                        m.Contrat__r.StartDate,
                        m.Contrat__r.Numero_de_dossier_GAC__c,
                        m.Contrat__r.Nom_du_client_sur_la_facture__c,
                        m.Contrat__r.BillingStreet,
                        m.Contrat__r.BillingPostalCode,
                        m.Contrat__r.BillingCity,
                        m.Contrat__r.BillingState,
                        m.Contrat__r.BillingCountry,
                        m.RecordType.developerName,
                        m.Annee_concernee__c,
                        m.Contrat__r.Entite_GAC_forcee__c,

                        m.Date_de_r_ception_avis_de_cot_f_d_rale__c,
                        m.Date_de_r_ception_avis_de_cot_provincial__c,

                        m.Numero_du_client__c,
                        (Select Id,
                                Name,
                                Prevision_HT__c,
                                Statut__c,
                                Pourcentage_Factur__c,
                                Mois__c,
                                Periode_debut__c,
                                Periode_fin__c,
                                Typologie_facturation__c,
                                Nature_facturation__c,
                                Date_de_cloture_fiscale__c,
                                Gouvernement__c,
                                Commentaire_prevision__c,
                                Montant_demand__c,
                                Dossier_salarie__c,
                                Facture__c,
                                Date_prevue__c,
                                Produit__c,
                                Sous_produit__c,
                                Projet_Concept__c,
                                Projet_europ_ens__c,
                                Subventions_nationales__c,
                                Fees_base__c
                        From Planifications_de_facturation__r
                        Where Id in:selectedPlanifs limit 999)
                        From Mission__c m
                        Where m.Id =:id];

        Decimal Montant_HT = 0;

        for(Prevision_de_facturation__c pr : this.mission.Planifications_de_facturation__r){
            if(pr.Prevision_HT__c != null)
                Montant_HT += pr.Prevision_HT__c;
        }

        this.factu.Mission__c = id;
        this.factu.CurrencyIsoCode = this.mission.CurrencyIsoCode;
        this.factu.Contrat__c = this.mission.Contrat__r.Id;

        this.factu.Date__c = date.today();
        this.factu.Entite_GAC__c = this.mission.Contrat__r.Entite_GAC__c;
        if(this.mission.Contrat__r.Nom_du_client_sur_la_facture__c != null)
            this.factu.Client__c = this.mission.Contrat__r.Nom_du_client_sur_la_facture__c;
        else
            this.factu.Client__c = this.mission.Contrat__r.Account.Name;
        this.factu.Contact_facturation__c = this.mission.Contrat__r.Contact_facturation__c;
        

        Boolean showCountryOnAddress = this.mission.Contrat__r.Account.RecordType.DeveloperName != 'CANADA_ACCOUNT';
        
        if(this.mission.Contrat__r.BillingCity != null)
            this.factu.Adresse__c = FactuUtils.getAddress(this.mission.Contrat__r, '\n', showCountryOnAddress);
        else
            this.factu.Adresse__c = FactuUtils.getAddress(this.mission.Contrat__r.Account, '\n', showCountryOnAddress);
        
        this.factu.Statut__c = 'En attente';
        this.factu.Consultant__c = this.mission.OwnerId;

        if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'FRANCE_ACCOUNT'){

            this.factu.Montant_HT__c = Montant_HT;
            this.factu.Name = FactuUtils.getFactureTempNumber();
            this.factu.Mode_de_paiement__c = this.mission.Contrat__r.Conditions_de_paiement__c;
            this.factu.Echeance__c = date.today();
          this.factu.Taux_TVA__c = 20;
            this.factu.N_compte_client__c = this.mission.Contrat__r.N_compte_client__c;
            this.factu.N_r_f_rence_client__c = this.mission.Contrat__r.N_r_f_rence_client__c;
            this.factu.TVA_Intracommunautaire__c = this.mission.Contrat__r.Account.TVA_Intracommunautaire__c;
            this.factu.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Facture__c' AND DeveloperName = :(Montant_HT < 0 ? 'Avoir_non_valide' : 'Facture_non_valide') LIMIT 1][0].Id;


        }else if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'SPAIN_ACCOUNT'){
                  
     
             this.factu.Taux_TVA__c = (this.mission.Contrat__r.Entite_GAC__c == 'Internacional' ? 0 : 21);
     
             
            this.factu.Montant_HT__c = Montant_HT;
            this.factu.Name = FactuUtils.getFactureTempNumber();                        
            this.factu.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Facture__c' AND DeveloperName = :(Montant_HT < 0 ? 'ES_Avoir_non_valide' : 'ES_Facture_non_valide') LIMIT 1][0].Id;
            this.factu.Echeance__c = date.today();

        }
        else if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'BRASIL_ACCOUNT'){

            this.factu.BR_CA_Brut__c = Montant_HT;
            this.factu.BR_CSLL__c = 1;
            this.factu.BR_IRPJ__c = 1.5;
            this.factu.BR_PIS_COFINS__c = 3.65;
            this.factu.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Facture__c' AND DeveloperName = :(Montant_HT < 0 ? 'BR_Avoir_non_valide' : 'BR_Facture_non_valide') LIMIT 1][0].Id;
            this.factu.Echeance__c = date.today();


        }else if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'CANADA_ACCOUNT'){

            this.factu.Montant_HT__c = Montant_HT;
            this.factu.Name = FactuUtils.getFactureTempNumber();
            this.factu.TVQ__C = 9.975  ;
            this.factu.TPS__C = 5 ;
            this.factu.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Facture__c' AND DeveloperName = :(Montant_HT < 0 ? 'Canada_avoir_non_valid' : 'Canada_Facture_non_valid_e') LIMIT 1][0].Id;
            this.factu.Echeance__c = date.today();
            this.factu.Reference__c = this.mission.Numero_du_client__c ;
            
         }else if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'SINGAPORE_ACCOUNT'){

            this.factu.Montant_HT__c = Montant_HT;
            this.factu.Name = FactuUtils.getFactureTempNumber();
            this.factu.Taux_TVA__c = 0;
            this.factu.Mode_de_paiement__c = this.mission.Contrat__r.Conditions_de_paiement__c;
            this.factu.Echeance__c = date.today();
            this.factu.N_r_f_rence_client__c = this.mission.Contrat__r.N_r_f_rence_client__c;
            this.factu.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Facture__c' AND DeveloperName = :(Montant_HT < 0 ? 'SGP_Avoir_non_valide' : 'SGP_Facture_non_validee') LIMIT 1][0].Id;




        }else{

            this.factu.Montant_HT__c = Montant_HT;
            this.factu.Name = FactuUtils.getFactureTempNumber();
            this.factu.Mode_de_paiement__c = this.mission.Contrat__r.Conditions_de_paiement__c;
            this.factu.Echeance__c = date.today();
            this.factu.Taux_TVA__c = 20;
            this.factu.N_compte_client__c = this.mission.Contrat__r.N_compte_client__c;
            this.factu.N_r_f_rence_client__c = this.mission.Contrat__r.N_r_f_rence_client__c;
            this.factu.TVA_Intracommunautaire__c = this.mission.Contrat__r.Account.TVA_Intracommunautaire__c;
            this.factu.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Facture__c' AND DeveloperName = :(Montant_HT < 0 ? 'Avoir_non_valide' : 'Facture_non_valide') LIMIT 1][0].Id;

        }

        /*TODO : custom label */
        if(this.mission.RecordType.developerName == 'TAT'){
            this.factu.Reference__c = 'Optimisation des taux AT/MP - ' + this.mission.Contrat__r.Numero_de_dossier_GAC__c;
        }
        if(this.mission.RecordType.developerName == 'CIR' || this.mission.RecordType.developerName == 'VEILLE' ){
            if(this.mission.Contrat__r.StartDate != null)
                this.factu.Reference__c = 'Convention du ' + this.mission.Contrat__r.StartDate.format();
            else
                this.factu.Reference__c = 'Convention du ';
        }
        if(this.mission.RecordType.developerName == 'CIN' ){
            if(this.mission.Contrat__r.StartDate != null)
                this.factu.Reference__c = 'Convention du ' + this.mission.Contrat__r.StartDate.format();
            else
                this.factu.Reference__c = 'Convention du ';
        }
        if(this.mission.RecordType.developerName == 'ACS'){
            this.factu.Reference__c = 'Audit des charges sociales';
        }
        if(this.mission.RecordType.developerName == 'IL'){
            this.factu.Reference__c = 'Mission Imposition Directe Locale';
        }

    }

    private void initDetailFactuList(){

        this.DetailFactuList = new List<DetailFacture>();

        if(this.mode == 'create'){

            for(Prevision_de_facturation__c pr : this.mission.Planifications_de_facturation__r){

                decimal prevision = pr.Prevision_HT__c;

                /* Intialisation du texte de la facture en fonction du type */
                String defaultText = '<br/><br/>';

                if(this.mission.RecordType.developerName == 'IL' && this.factu.Montant_HT__c > 0){
                    defaultText += 'Commissions de '+(this.mission.Contrat__r.Conditions_de_remuneration__c != null?(this.mission.Contrat__r.Conditions_de_remuneration__c.contains('Pourcentage')?this.mission.Contrat__r.Precision_remuneration__c:''):'') +' sur ...';
                    defaultText += '<br/><br/>';
                }

                else if(this.mission.RecordType.developerName == 'ACS' && this.factu.Montant_HT__c > 0){
                    defaultText += 'Honoraires de '+(this.mission.Contrat__r.Conditions_de_remuneration__c != null?(this.mission.contrat__r.Conditions_de_remuneration__c.contains('Pourcentage')?this.mission.contrat__r.Precision_remuneration__c:''):'') + ' sur la régularisation des Charges Sociales portant sur '+pr.Produit__c;
                    defaultText += '<br/><br/>';
                }

                else if(this.mission.RecordType.developerName == 'TAT' ){

                    String Annees = '';

                    if(pr.Periode_debut__c != null && pr.Periode_fin__c != null){
                        Integer nbAnnees =  pr.Periode_fin__c.year() - pr.Periode_debut__c.year();
                        Annees = String.valueOf(pr.Periode_debut__c.year());
                        for(Integer c = 1;c <= nbAnnees;c++){
                            Annees += ',' + (pr.Periode_debut__c.year() + c);
                        }
                    }


                    if(pr.Nature_facturation__c == 'Avoir'){
                        defaultText += '<u>Avoir à appliquer sur la facture n° ...</u>';
                        defaultText += '<br/><br/>';
                        defaultText += 'Régularisation de nos honoraires concernant le(s) dossier(s):';
                        defaultText += '<br/><br/>';
                        defaultText += '<b>'+pr.Dossier_salarie__c+'</b>';
                        defaultText += '<br/><br/>Suite à la réception de votre Masse Salariale';
                    }else if(pr.Nature_facturation__c == 'Regul'){
                        defaultText += 'Régularisation de nos honoraires sur la facture n° ... concernant le(s) dossier(s):';
                        defaultText += '<br/><br/>';
                        defaultText += '<b>'+pr.Dossier_salarie__c+'</b>';
                        defaultText += '<br/><br/>Suite à la réception de votre Masse Salariale';
                    }else if(pr.Nature_facturation__c == 'Facturation avec estimation'){
                        defaultText += '<u>Facture émise d\'après les éléments en notre possession à cette date.</u>';
                        defaultText += '<br/><br/>';
                        defaultText += 'Honoraires de '+(this.mission.Contrat__r.Conditions_de_remuneration__c != null?(this.mission.Contrat__r.Conditions_de_remuneration__c.contains('Pourcentage')?this.mission.Contrat__r.Precision_remuneration__c:''):'') +' sur la baisse du taux AT/MP '+Annees+' concernant le dossier:';
                        defaultText += '<br/><br/>';
                        defaultText += '<b>'+pr.Dossier_salarie__c+'</b>';
                        defaultText += '<br/><br/>';
                        if(pr.Periode_debut__c != null && pr.Periode_fin__c != null)
                            defaultText += '<u>Période</u>: du '+pr.Periode_debut__c.format()+' au '+pr.Periode_fin__c.format();
                    }else if(pr.Nature_facturation__c == 'Facturation avec tous les éléments'){
                        defaultText += 'Honoraires de '+(this.mission.Contrat__r.Conditions_de_remuneration__c != null?(this.mission.Contrat__r.Conditions_de_remuneration__c.contains('Pourcentage')?this.mission.Contrat__r.Precision_remuneration__c:''):'') +' sur la baisse du taux AT/MP '+Annees+' concernant le dossier:';
                        defaultText += '<br/><br/>';
                        defaultText += '<b>'+pr.Dossier_salarie__c+'</b>';
                        defaultText += '<br/><br/>';
                        if(pr.Periode_debut__c != null && pr.Periode_fin__c != null)
                            defaultText += '<u>Période</u>: du '+pr.Periode_debut__c.format()+' au '+pr.Periode_fin__c.format();
                    }
                }

                else if(this.mission.RecordType.developerName == 'CIR'){

                    // TODO : mettre le texte en custom label
                    defaultText += '<u>Honoraires sur mission d\'audit</u> :';
                    defaultText += '<br/><br/>';
                    defaultText += 'Dépense R&D année '+ this.mission.Annee_concernee__c;

                }
                else if(this.mission.RecordType.developerName == 'CIN'){

                    // TODO : mettre le texte en custom label
                    defaultText += '<u>Honoraires sur mission d\'audit</u> :';
                    defaultText += '<br/><br/>';
                    defaultText += 'Dépense R&D année '+ this.mission.Annee_concernee__c;

                }

                else if(this.mission.RecordType.developerName == 'LDB' && this.factu.BR_CA_Brut__c > 0){
                    defaultText += 'Serviço de consultoria para aplicaçao da lei do bem';
                    defaultText += '<br/><br/>';
                }

                else  if((this.mission.RecordType.developerName == 'DED' || this.mission.RecordType.developerName == 'AYUDAS') && this.factu.Montant_HT__c > 0){
                    defaultText += '<u>Concepto</u> :';
                    defaultText += '<br/><br/>';
                    defaultText += 'Cantidad correspondiente al pago por la colaboración y la gestión del proyecto ' + pr.Projet_Concept__c + ', programa '+ (pr.Projet_europ_ens__c != null?pr.Projet_europ_ens__c:pr.Subventions_nationales__c) +', anualidad '+this.mission.Annee_concernee__c;
                    defaultText += '<br/><br/>';
                }

                else if(this.mission.RecordType.developerName == 'CIR_CANADA'){
                    if(pr.Gouvernement__c=='Fédéral'){
                        defaultText += 'Honoraires pour préparation des rapports technique, financier et fiscal pour les crédits d\'impôt à la recherche scientifique et développement expérimental pour l\'année financière se terminant le ' + pr.Date_de_cloture_fiscale__c +' '+ this.mission.Annee_concernee__c+'.';
                        defaultText += '<br/><br/>';
                        defaultText += '<strong>REVENU CANADA ';
                        //EDIT DIDIER 31/01/14
                        //DIDIER 18/02/14
                        /*
                        Si possible oui, ajouter la date de cotisation pour les factures où le pourcentage est de 100% et où il n'y a pas de pourcentage spécifié. 
                        case #00006230 (GAC)
                        */
                        if((pr.Pourcentage_Factur__c == 60 || pr.Pourcentage_Factur__c == 100 || pr.Pourcentage_Factur__c == null)  && this.mission.Date_de_r_ception_avis_de_cot_f_d_rale__c != null){
                            defaultText += dbDate(this.mission.Date_de_r_ception_avis_de_cot_f_d_rale__c)+' ';
                        }
                    }
                    else{
                        defaultText += 'Honoraires pour préparation des rapports technique, financier et fiscal pour les crédits d\'impôt à la recherche scientifique et développement expérimental pour l\'année financière se terminant le ' + pr.Date_de_cloture_fiscale__c +' '+ this.mission.Annee_concernee__c+'.';
                        defaultText += '<br/><br/>';
                        defaultText += '<strong>REVENU QUÉBEC ';
                        
                        //DIDIER 18/02/14
                        /*
                        Si possible oui, ajouter la date de cotisation pour les factures où le pourcentage est de 100% et où il n'y a pas de pourcentage spécifié. 
                        case #00006230 (GAC)
                        */
                        if((pr.Pourcentage_Factur__c == 60 || pr.Pourcentage_Factur__c == 100 || pr.Pourcentage_Factur__c == null) && this.mission.Date_de_r_ception_avis_de_cot_provincial__c != null){
                            defaultText += dbDate(this.mission.Date_de_r_ception_avis_de_cot_provincial__c)+' ';
                        }
                    }
                    //DIDIER 18/02
                    // nous désirions que le libellé soit différent si la facture était de 40% (inscrire « RÉCLAMÉ » au lieu de « COTISÉ »)
                    //CASE #00006228 (GAC)
                    defaultText += pr.Pourcentage_Factur__c == 40 ? ' MONTANT RÉCLAMÉ' : ' MONTANT COTISÉ';
                    //FinEdit didier 18/02/14
                    defaultText += '</strong>';

                    if(pr.Pourcentage_Factur__c != null && pr.Pourcentage_Factur__c != 100){
                        this.factu.Pourcentage_facture__c = pr.Pourcentage_Factur__c;
                        prevision = pr.Pourcentage_Factur__c == 0 ? 0 : pr.Prevision_HT__c * 100 / pr.Pourcentage_Factur__c;
                    }
                }
                
                else if(this.mission.RecordType.developerName == 'SGP_PIC'){
                    if(pr.Fees_base__c != null && pr.Fees_base__c != 0)
                        defaultText += '&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;Fees base = S$ ' + pr.Fees_base__c.format();
                    
                }


                Detail_facture__c detail = new Detail_facture__c(Description__c = defaultText, CurrencyIsoCode = this.mission.CurrencyIsoCode, Montant_HT__c = (prevision != null ? prevision : this.Factu.Montant_HT__c), Ordre__c = this.DetailFactuList.size() + 1, Facture__c = null);

                if(this.mission.RecordType.developerName == 'CIR_CANADA')
                    detail.R_clamation__c = pr.Montant_demand__c;

                this.DetailFactuList.add(new DetailFacture(detail, this.DetailFactuList.size()));


            }


        }else if(this.mode == 'edit'){

            
            for(Detail_facture__c df : [SELECT Id, Facture__c, CurrencyIsoCode, Description__c, Montant_HT__c,des_credits__c,R_clamation__c, Ordre__c
                                        FROM Detail_facture__c 
                                        WHERE Facture__c = :this.factu.Id
                                        ORDER BY Ordre__c ASC]){
                this.DetailFactuList.add(new DetailFacture(df, this.DetailFactuList.size()));                                       
            }

        }

    }


    private static string dbDate(date d){
        String ret =  d.year() +'-';
        if(d.month() <10)
            ret +='0'+d.month()+'-';
        else
            ret += d.month()+'-';
        if(d.day() <10)
            ret +='0'+d.day()+'';
        else
            ret += d.day()+'';
        
        return ret;
    }

    private void initListeAdresseClients(Boolean showCountry){

        this.listeAdresseClients = new List<Selectoption>{new Selectoption('','')};

        Contract contrat = [SELECT   Id,
                            Account.Name,
                            Account.BillingStreet,
                            Account.BillingPostalCode,
                            Account.BillingCity,
                            Account.BillingState,
                            Account.BillingCountry,
                            Nom_du_client_sur_la_facture__c,
                            BillingStreet,
                            BillingPostalCode,
                            BillingCity,
                            BillingState,
                            BillingCountry,
                            (Select Id,
                                    Societe_a_auditer__r.Name,
                                    Societe_a_auditer__r.BillingStreet,
                                    Societe_a_auditer__r.BillingPostalCode,
                                    Societe_a_auditer__r.BillingCity,
                                    Societe_a_auditer__r.BillingState,
                                    Societe_a_auditer__r.BillingCountry
                                    From Societes_a_auditer__r limit 255)
                                    FROM Contract 
                                    WHERE Id = :this.factu.Contrat__c 
                                    LIMIT 1][0];


        if(contrat.BillingCity != null)
            this.listeAdresseClients.add(new Selectoption((contrat.Nom_du_client_sur_la_facture__c != null?contrat.Nom_du_client_sur_la_facture__c:contrat.Account.Name) + '#¤#' + FactuUtils.getAddress(contrat, '\n', showCountry), 'Adresse de facturation: ' + (contrat.Nom_du_client_sur_la_facture__c != null?contrat.Nom_du_client_sur_la_facture__c:contrat.Account.Name) + ' (' + FactuUtils.getAddress(contrat, ', ', showCountry) + ')'));

        this.listeAdresseClients.add(new Selectoption(contrat.Account.Name + '#¤#' + FactuUtils.getAddress(contrat.Account, '\n', showCountry), 'Compte principal: ' +  contrat.Account.Name + ' (' + FactuUtils.getAddress(contrat.Account, ', ', showCountry) + ')'));

        for(Societe_a_auditer__c societeAAuditer : contrat.Societes_a_auditer__r)
            this.listeAdresseClients.add(new Selectoption(societeAAuditer.Societe_a_auditer__r.Name + '#¤#' + FactuUtils.getAddress(societeAAuditer.Societe_a_auditer__r, '\n', showCountry) , 'Société à auditer: ' + societeAAuditer.Societe_a_auditer__r.Name + ' (' + FactuUtils.getAddress(societeAAuditer.Societe_a_auditer__r, ', ', showCountry) + ')'));


        for(Etablissement_secondaire__c etabSecond : [SELECT Id, Name, Rue__c, Code_postal__c, Ville__c, D_partement_R_gion__c, Pays__c FROM Etablissement_secondaire__c WHERE Account__c = :contrat.Account.Id limit 600])
            this.listeAdresseClients.add(new Selectoption(etabSecond.Name + '#¤#' + FactuUtils.getAddress(etabSecond, '\n', showCountry) , 'Etablissement secondaire: ' +  etabSecond.Name + ' (' + FactuUtils.getAddress(etabSecond, ', ', showCountry)  + ')'));

    }




    public void initFooterInfos(){
        //Récupération des infos du footer relatives au paiement (FacturationEntite__c est un custom setting)
        this.footerInfos = FacturationEntite__c.getInstance(this.factu.Entite_GAC__c);
    }





    /**
     *   Insert une nouvelle facture avec ses détails facture
     *   Update les planifications insérées dans cette facture (champs Facture__c et Statut__c)
     */
    public PageReference saveFacture(){


        if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'FRANCE_ACCOUNT'){

            //Re-récupère le nom de facture au cas ou il y ai eu une nouvelle facture depuis la génération de la page ou si on a changé la date de facture
            if(this.mode == 'create')
                this.factu.Name = FactuUtils.getFactureTempNumber(this.factu.Name);

        }else if(this.mission.Contrat__r.Account.RecordType.DeveloperName == 'BRASIL_ACCOUNT'){

            // Rien a faire

        }else{

            //Re-récupère le nom de facture au cas ou il y ai eu une nouvelle facture depuis la génération de la page ou si on a changé la date de facture
            if(this.mode == 'create')
                this.factu.Name = FactuUtils.getFactureTempNumber(this.factu.Name);

        }

        try{
            //Upsert de la facture
            upsert this.factu;
        }catch (DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }


        /*
         *   Récupération et insertion des détails facture
         */
        List<Detail_facture__c> detailFactuListToUpsert = new List<Detail_facture__c>();
        for(DetailFacture detailFac : this.DetailFactuList){
            if(detailFac.detail.Facture__c == null )
                detailFac.detail.Facture__c = this.factu.Id;

            detailFactuListToUpsert.add(detailFac.detail);
        }
        upsert detailFactuListToUpsert;


        /*
         *   Update les planifications avec leur Id de facture et le statut 'Facturé'
         */
        if(this.mode == 'create'){
            for(Prevision_de_facturation__c prev : this.mission.Planifications_de_facturation__r){
                prev.Facture__c = this.factu.Id;
                prev.Date_prevue__c = this.factu.Date__c;
            }
            update this.mission.Planifications_de_facturation__r;
        }

        Pagereference ret = new Pagereference('/'+this.factu.Id);

        return ret;

    }




    /**
     *   Ajoute un détail facture à la fin des détails facture de la section "Contenu facture"
     */
    public void addDetailFacture(){
        this.DetailFactuList.add(new DetailFacture(new Detail_facture__c(Ordre__c = this.DetailFactuList.size() + 1, CurrencyIsoCode = this.mission.CurrencyIsoCode), this.DetailFactuList.size()));
    }


    /**
     *   Retire un détail facture de la section "Contenu facture"
     *   @PageReferenceParam Integer detailFactureIndex: l'index du détail facture à retirer (les index commencent à 0)
     */
    public void removeDetailFacture(){
        Integer detailFactureIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('detailFactureIndex'));

        if(detailFactureIndex != null)
            this.DetailFactuList.remove(detailFactureIndex);

        //Remet en ordre les index des détails factures suivants le détail facture supprimé 
        for(Integer i = detailFactureIndex; i < this.DetailFactuList.size(); i++)
            this.DetailFactuList[i].index --;

    }



    /**
     *   Inner class correspondant à un détail facture
     *   Permet d'associer un index à un détail facture
     */
    public class DetailFacture{

        public Integer index {get; set;}
        public Detail_facture__c detail {get; set;}

        public DetailFacture(Detail_facture__c detail, Integer index){
            this.detail = detail;
            this.index = index;
        }
    }


}