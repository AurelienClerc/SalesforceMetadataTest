public class SF2VFP01_UpdateOpportunitySegmentation {
    
   // public static final list<String> lSegmentationsFields = new List<String>{'CIR_Annee_dernier_CIR__c','CIR_Budget_R_D__c','CIR_Depenses_eligibles__c','CIR_Effectif_RD__c','CIR_Dernier_CIR__c','CIR_2014_k__c','CIR_2011_k__c','CIR_2012_k__c','CIR_2013_k__c','CIR_Enjeux_CIR__c','CIR_Dans_le_dispositif__c','Type_de_Credit_d_impot__c','Type_de_CIR__c','Concurrent__c','Annees_concernees_concurrent__c','ACS_Date_dernier_controle_URSSAF__c','ACS_Dernier_ACS__c','ACS_Effectif_concerne__c','ACS_MS_concernee__c','ACS_Nb_itinerants__c','ACS_Service_paie_central__c','ACS_Service_paie_ext__c','ACS_absenteisme__c','ACS_bas_salaires__c','Taux_VT__c','Utilisation_du_dispositif_CIR__c','Service_export__c','Pourcentage_du_CA_l_export__c','Pourcentage_programm_dans_les_5_ans__c','Effectif_export__c','Directeur_commercial__c','Levee_de_fonds__c','Existence_de_clients__c','Implantations_locales__c','Interets__c','Aides_l_international__c','FI_Type_d_aide_envisagee__c','IL_Typologie_site__c','Ev_nement_juridique__c','IL_Dernier_controle_fiscal__c','IL_Credit_bail__c','Redevable__c','Modification_du_site__c','Montant_CFE__c','Montant_CVAE__c','Montant_TB__c','Montant_TF__c','TAT_Montant_IPP__c','TAT_Montant_IT__c','TAT_Nb_IPP__c','TAT_Nb_IT_20__c','TAT_Taux_AT_MP_n_1__c','TAT_Taux_AT_MP_n__c'};
    
    public ApexPages.standardController oStdCtrl;
    
    public SF2VFP01_UpdateOpportunitySegmentation(ApexPages.standardController sc){
        oStdCtrl = sc;
    }
    
    public pageReference populateAndRedirect(){
        pageReference ret = oStdCtrl.view();
        sObject oRecord = oStdCtrl.getRecord();
        Id oId = oRecord.id;
        V2AP01_SegmentationManager.addItem( (Opportunity) oRecord);
        V2AP01_SegmentationManager.processCopySegmentation();
        try{
            update oRecord;
        }catch(DMLException e){
            ApexPages.addMessage(New ApexPages.Message(ApexPages.Severity.FATAL,e.getDMLMessage(0)));
            ret = null;
        }
        
        return ret;
    }
}