public without sharing class V2AP01_SegmentationManager {
        
        public static list<String> lSegmentationsFields; /*= new List<String>{'CIR_Annee_dernier_CIR__c','CIR_Budget_R_D__c','CIR_Depenses_eligibles__c','CIR_Effectif_RD__c','CIR_Dernier_CIR__c','CIR_2014_k__c','CIR_2011_k__c','CIR_2012_k__c','CIR_2013_k__c','CIR_Enjeux_CIR__c','CIR_Dans_le_dispositif__c','Type_de_Credit_d_impot__c','Type_de_CIR__c','Concurrent__c','Annees_concernees_concurrent__c','ACS_Date_dernier_controle_URSSAF__c','ACS_Dernier_ACS__c','ACS_Effectif_concerne__c','ACS_MS_concernee__c','ACS_Nb_itinerants__c','ACS_Service_paie_central__c','ACS_Service_paie_ext__c','ACS_absenteisme__c','ACS_bas_salaires__c','Taux_VT__c','Utilisation_du_dispositif_CIR__c','Service_export__c','Pourcentage_du_CA_l_export__c','Pourcentage_programm_dans_les_5_ans__c','Effectif_export__c','Directeur_commercial__c','Levee_de_fonds__c','Existence_de_clients__c','Implantations_locales__c','Interets__c','Aides_l_international__c','FI_Type_d_aide_envisagee__c','IL_Typologie_site__c','Ev_nement_juridique__c','IL_Dernier_controle_fiscal__c','IL_Credit_bail__c','Redevable__c','Modification_du_site__c','Montant_CFE__c','Montant_CVAE__c','Montant_TB__c','Montant_TF__c','TAT_Montant_IPP__c','TAT_Montant_IT__c','TAT_Nb_IPP__c','TAT_Nb_IT_20__c','TAT_Taux_AT_MP_n_1__c','TAT_Taux_AT_MP_n__c',
                                                                                //Ajout de champs v2'
                                                                                'TAT_NbIT4__c','TAT_NbIT5__c','TAT_NbIT6__c','TAT_NbIP2__c','TAT_NbIP3__c','TAT_NbIP4__c',
                                                                                'ACS_convention_collective__c'
                                                                                
        };
                                                        */
        
        public static map<string,list<string>> refFieldsByBU;
        
        public static String[] lBuInno;
        
        public static String[] lBuOpti;
        
        public static String[] lBuFL;
        
        public static String[] lBus;
        
        public static final set<string> lFieldsPrefixed = new set<String>{'Decisionnaire__c','concurrent__c','annees_concernees_concurrent__c','enjeux_opportunite__c','autre_concurrent__c'};
        
        
        public static map<Id,map<string,Date>> datesMercato;
        
        public static Map<string,Opportunity[]> refOpportunityToAccount;
        
        public static Map<Schema.sObjectType,map<String,DescribeFieldResult>> descFields;
        
        public static V2Params__c v2Param;
        
        static{
            v2Param = V2Params__c.getInstance();
            system.debug(v2param);
            /*if(v2Param == null)
                v2Param = new V2Params__c(BuInno__c = 'CIR,FI,CIN',buOpti__c = 'ACS,TAT',BuFL__c ='IL',BuDescribeId__c='TEST BU');
                */
            lBuInno = V2Param.BuInno__c.split(',');
            lBuOpti = v2Param.BuOpti__c.split(',');
            lBuFL = v2Param.BuFL__c.split(',');
            lBus = new list<String>();
            if(lBuInno != null)
                lBus.addAll(lBuInno);
            if(lBuOpti != null)
                lBus.addAll(lBuOpti);
            if(lBuFL != null)
                lBus.addAll(lBuFL);
            
            Document[] d = [Select body from Document where id =: v2Param.BuDescribeId__c ];
            if(!d.isEmpty()){
                refFieldsByBU = (map<string,list<string>>) json.deserialize(d[0].body.toString(), map<string,list<string>>.class);
            }else
                refFieldsByBU = new map<String,list<String>>{'CIR'=>new list<String>{'CIR_Enjeux_opportunite__c','CIR_Dans_le_dispositif__c','CIR_Effectif_RD__c','CIR_Budget_R_D__c','Type_de_Credit_d_impot__c','Type_de_CIR__c','Montant_CIR__c','CIR_Concurrent__c','CIR_Autre_Concurrent__c','CIR_Annees_concernees_concurrent__c','CIR_Decisionnaire__c'},
                                                            'FI' =>new list<String>{'FI_Enjeux_opportunite__c',/*'CIR_Effectif_RD__c','CIR_Budget_R_D__c',*/'FI_Type_d_aide_envisagee__c','AS_Fonds_propres__c','FI_Concurrent__c','FI_Autre_Concurrent__c','FI_Annees_concernees_concurrent__c','FI_Decisionnaire__c'},
                                                            'ACS'=>new list<String>{'ACS_Enjeux_opportunite__c','ACS_Effectif_concerne__c','ACS_bas_salaires__c','ACS_Service_paie_ext__c','ACS_MS_concernee__c','ACS_Service_paie_central__c','ACS_Date_dernier_controle_URSSAF__c','ACS_absenteisme__c','ACS_Dernier_ACS__c','ACS_convention_collective__c','ACS_Nb_itinerants__c','Taux_VT__c','ACS_Concurrent__c','ACS_Autre_Concurrent__c','ACS_Annees_concernees_concurrent__c','ACS_Decisionnaire__c'},
                                                            'TAT'=>new list<string>{'TAT_Enjeux_opportunite__c','TAT_Taux_AT_MP_n__c','TAT_Taux_AT_MP_n_1__c','TAT_NbIT4__c','TAT_NbIT5__c','TAT_NbIT6__c','TAT_NbIP2__c','TAT_NbIP3__c','TAT_NbIP4__c','TAT_Concurrent__c','TAT_Autre_Concurrent__c','TAT_Annees_concernees_concurrent__c','TAT_Decisionnaire__c'},
                                                            'IL' =>new list<String>{'IL_Enjeux_opportunite__c','IL_nb_sites_commerce__c','IL_nb_sites_indus__c','IL_nb_sites_tf_100k__c','IL_surface_estimee__c','IL_Typologie_site__c','Ev_nement_juridique__c','IL_Dernier_controle_fiscal__c','Montant_TB__c','Montant_TF__c','Montant_CFE__c','Montant_CVAE__c','IL_montant_CET_plafone__c','Redevable__c','IL_role_sup__c','IL_Concurrent__c','IL_Autre_Concurrent__c','IL_Annees_concernees_concurrent__c','IL_commentaires__c','IL_Decisionnaire__c'},
                                                            'CIN'=>new list<String>{'CIN_Enjeux_opportunite__c','CIN_Concurrent__c','CIN_Autre_Concurrent__c','CIN_Annees_concernees_concurrent__c','CIN_Decisionnaire__c'}};
            lSegmentationsFields = new String[]{};
            refOpportunityToAccount = new  Map<string,Opportunity[]>();
            set<String> stFields = new set<String>();
            for(String bu : refFieldsByBU.keyset()){
                for(String sField : refFieldsByBU.get(bu) )
                    if(!stFields.contains(sField)){
                        lSegmentationsFields.add( sField );
                        stFields.add( sField );
                    }
            }
            descFields = new map<Schema.sObjectType,map<String,DescribeFieldResult>>();
            descFields.put(Opportunity.sObjectType,getDescribe(Opportunity.sObjectType));
            descFields.put(Account.sObjectType,getDescribe(Account.sObjectType));
            descFields.put(historique_segmentation__c.sObjectType,getDescribe(historique_segmentation__c.sObjectType));
            
        }
        
        private static map<String,DescribeFieldResult> getDescribe(sObjectType soType){
            map<String,DescribeFieldResult> ret = new map<String,DescribeFieldResult>();
            Map<String,Schema.sObjectField> refFields = soType.getDescribe().fields.getMap();
            for(string field : refFields.keySet() )
                ret.put(field.toLowerCase(),refFields.get(field).getDescribe());
            
            return ret;
        }
        
        public static void addItem(Opportunity oOpportunity){
            
            Integer iAnneeSegmentation = oOpportunity.annee_segmentation__c == null ? Date.today().year() : integer.valueOf(oOpportunity.annee_segmentation__c);
            String sHistoIdExterne = getHistoIdExterne(oOpportunity.AccountId,iAnneeSegmentation);
            if(!refOpportunityToAccount.containsKey(sHistoIdExterne))
                refOpportunityToAccount.put(sHistoIdExterne, new Opportunity[]{});
            refOpportunityToAccount.get(sHistoIdExterne).add(oOpportunity);
                
        }
        
        public static void processCopySegmentation(){
        processCopySegmentation(null,false);
        }
        
        public static void processCopySegmentation(List<Historique_Segmentation__c> histos, boolean emptyIfnull){
            system.debug('###IN V2AP01_SegmentationManager Copy Segmentation with '+refOpportunityToAccount.size()+' Items to compute');
            system.debug(refOpportunityToAccount);
            system.debug(histos);
            if(!refOpportunityToAccount.isEmpty()){
                
                Map<id,RecordType> refRecordTypes = new Map<Id,RecordType>([Select id, developerName from RecordType where SobjectType = 'Opportunity' ]);
                
                
                List<String> idExternes = new List<String>();
                if(histos == null){
                    idExternes.addAll(refOpportunityToAccount.keySet());
                    String sQuery ='SELECT id,Id_Externe__c,Annee__c,'+ String.join(getSegmentationFields(true),',')+' from Historique_Segmentation__c where id_Externe__c in : idExternes';
                    histos = database.query(sQuery);
                }

                Set<string> foundIds = new Set<String>();
                for ( Historique_Segmentation__c h : histos ){
                    if(refOpportunityToAccount.containsKey(h.id_Externe__c)){
                        system.debug(h.id_Externe__c + ' TROUVE dans la liste des opp a update');
                        foundIds.add(h.id_Externe__c);
                        for(Opportunity o : refOpportunityToAccount.get(h.id_Externe__c)){
                            system.debug('###V2AP01_SegmentationManager applyingSegmentation');
                            applyToOpp(h,o,refRecordTypes.get(o.recordtypeId).developerName,emptyIfnull);
                            o.annee_segmentation__c = String.valueOf(math.round(h.annee__c));
                        }
                    }else{
                        system.debug(h.id_Externe__c + ' non trouvé dans la liste des opp a update');
                        system.debug(refOpportunityToAccount.keySet());
                        
                    }
                }
                if(v2Param.ForceSegmentation__c){
                    for(string idExt : refOpportunityToAccount.keySet()){
                        if(!foundIds.contains(idExt)){
                            refOpportunityToAccount.get(idExt).get(0).addError('Pour enregistrer votre opportunité, il est nécessaire de saisir les enjeux métiers obligatoires sur le compte et le champ « année segmentation » sur l’opportunité. Ce compte n\'a pas de segmentation renseignée pour cette l\'année '+idExt.right(4));
                        }
                    }
                }
            }
            system.debug('###OUT V2AP01_SegmentationManager Copy Segmentation with '+refOpportunityToAccount.size()+' Items to compute');
        }
        
        //Va remplir l'historique a partir des données du compte
        public static Historique_Segmentation__c applyToHisto(Account a,Integer annee){
            if(annee == null)
                annee = date.today().year();
            Historique_Segmentation__c ret = new Historique_Segmentation__c(id_Externe__c = getHistoIdExterne(a.id,annee),Name=(annee +' - '+a.Name).left(80),annee__c = annee);
            populateObject(a,ret,null);
            return ret;
        }
        
         //Va remplir l'historique a partir des données du compte
        public static Account applyToAccount(Historique_Segmentation__c Histo,Id AccountId){
            return applyToAccount(histo, new Account(Id = AccountId));
            
        }
        
        //Idem, mais se base sur un account existant
        public static Account applyToAccount(Historique_Segmentation__c Histo,Account a){
            populateObject(histo,a,null);
            if(datesMercato != null && datesMercato.containsKey(a.id)){
                for(string field : datesMercato.get(a.id).keySet()){
                    a.put(field,datesMercato.get(a.id).get(field));
                }
            }
            return a;
        }
        
        //Va remplir les champs segmentation de l'opportunité a partir de ceux du compte
        public static Opportunity applyToOpp(Account a , Opportunity o,String BU,Boolean emptyIfNull){
            populateObject(a,o,BU,emptyIfNull);
            return o;
        }
        
        //Va remplir les champs segmentation de l'opportunité a partir de ceux du compte
        public static Opportunity applyToOpp(Historique_Segmentation__c h , Opportunity o,String BU,Boolean emptyIfNull){
            populateObject(h,o,BU,emptyIfNull);
            return o;
        }
        
        
        
        public static string getHistoIdExterne(Id accountId, integer annee){
            return accountId+'_'+annee;
        }
        
        private static void populateObject(sObject source, sObject target, string usePrefixFromSource){
            populateObject(source,target,usePrefixFromSource,true); 
        }
        
        private static void populateObject(sObject source, sObject target, string usePrefixFromSource,boolean emptyIfNull){ //Pour passer les tests emptyIfNull est a false pour l'objet opportunité
            List<String> FieldsToPopulate;
            Map<String,DescribeFieldResult> destFieldsDescribe = descFields.get(target.getSobjectType());
            
            if(target instanceOf Opportunity ){
                FieldsToPopulate = refFieldsByBU.get(usePrefixFromSource);
            }
            else
                FieldsToPopulate = lSegmentationsFields;
            for(string sSegmentField : FieldsToPopulate){
                
                String sSourceField = sSegmentField.toLowerCase();
                String destField = sSourceField;
                String sCheckField = sSourceField;
                if(usePrefixFromSource != null){
                    sCheckField = sCheckField.replaceAll(usePrefixFromSource.toLowerCase()+'_','').toLowerCase();
                }
                if(lFieldsPrefixed.contains(sCheckField.toLowerCase()) && usePrefixFromSource != null)
                    destField = sCheckField.toLowerCase();
                try{
                    system.debug('Filling  ' + destField +  ' with value '+ source.get(sSourceField));
                    if( emptyIfNull || source.get(sSourceField) != null ){
                        if(destFieldsDescribe.containsKey(destField)){
                            if(destFieldsDescribe.get(destField).getType().name().toUpperCase() == 'BOOLEAN' && source.get(sSourceField) == null)
                                target.put(destField,false);
                            else{
                                target.put(destField,source.get(sSourceField));
                            }
                        }
                    }else{
                        system.debug('emptyIfNull '+emptyIfNull+' and '+sSourceField + ' = '+  source.get(sSourceField) + ' Skipping destfield '+ destField);
                    }
                }catch(Exception e){
                    system.debug('PopulateObject exception catched');
                    system.debug(e.getMessage());
                } //SOQL without requestedField
            }
        
        }
        
        public static list<string> getSegmentationFields(boolean splitByBu){
            List<string> ret = new list<string>();
            if(splitByBu){
                ret.addAll(lSegmentationsFields);
            }else{
                for(String field : lFieldsPrefixed ){
                    ret.add(field);
                }
                for(string sField : lSegmentationsFields){
                    boolean isIn = false;
                    for(String field : lFieldsPrefixed ){
                        if(sField.toLowerCase().endsWith(field.toLowerCase())){
                            isIn = true;
                            break;
                        }
                    }
                    if(!isIn)
                        ret.add(sField);
                    
                }
            }
                
            return ret;
        }
        
        public static List<Opportunity> updateOpps(Map<Id,map<Integer, Historique_Segmentation__c>> modifiedSegmentations, list<Historique_Segmentation__c> histos){
            Opportunity[] ret = new Opportunity[]{};
            V2Params__c par = V2Params__c.getInstance();
            if(par.autoSynchOpp__c){
                system.debug('####IN Update opps with opportunity to recompute');
                system.debug(modifiedSegmentations);
                refOpportunityToAccount = new Map<string,Opportunity[]> ();
                //On va récupérer toutes les opportunités impactées par ces changement.
                List<String> lIds = new list<String>();
                for(id AccountId : modifiedSegmentations.keySet()){
                    for(Integer i : modifiedSegmentations.get(accountId).keyset())
                        lIds.add(getHistoIdExterne(accountId, i));
                }
                List<String> watchBu = new String[]{};
                watchBu.addAll(refFieldsByBU.keyset());
                ret = database.query('SELECT id, annee_segmentation__c,AccountID, recordTypeId, '+String.join(getSegmentationFields(false),',')+ ' from opportunity where Segmentation_Id_Externe__c != null  and Segmentation_Id_Externe__c in : lIds and recordType.developerName in  : watchBu');
                for(Opportunity o : ret)
                    addItem(o);
                processCopySegmentation(histos,true);
                system.debug('####OUT Update opps with opportunity to recompute');
            }else{
                system.debug('####IN UpdateOpp : autoSynchOppDisabled');
            }
            return ret;
        }
        
        public static list<Account> updateAccounts(map<id,map<Integer, Historique_Segmentation__c>> modifiedSegmentations, List<Historique_Segmentation__c> histos){
            Account[] ret = new Account[]{};
            set<id> accid =  modifiedSegmentations.keySet() ;
            system.debug('###IN Update Account : refreshing account values with most recent values for each fields');
            String query = 'SELECT id, '+String.join(getSegmentationFields(true),',')+ ' from Account where id in : accid ';
            String query2 = 'SELECT id,compte__c,annee__c, '+String.join(getSegmentationFields(true),',')+ ' from Historique_Segmentation__c where compte__c in : accid order by annee__c DESC';
            
            map<Id, List<Historique_Segmentation__c>> histoByAccount = new map<Id, List<Historique_Segmentation__c>>();
            for(Historique_Segmentation__c h : database.query(query2)){
                if(!histoByAccount.containsKey(h.compte__c))
                    histoByAccount.put(h.compte__c, new Historique_Segmentation__c[]{});
                histoByAccount.get(h.compte__c).add(h);
            }
            
            for(Account a : database.query(query)){
                boolean addToRet = false;
                if(histoByAccount.containsKey(a.id)){
                    for(string field : getSegmentationFields(true)){
                        for(Historique_Segmentation__c h : histoByAccount.get(a.id)){
                            if( h.get(field) != null && (! field.endsWith('Enjeux_opportunite__c') || h.get(field) != 'Non communiqué' )  ){
                                if(a.get(field) != h.get(field)){
                                     a.put(field,h.get(field));
                                     addToRet = true;
                                }
                                break;
                            }
                        }
                    }
                }
                if(addToRet)
                    ret.add(a);
            }
            
            return ret;
        }
   
}