public with sharing class FactuCreateMissionCtrl {
	
	private ApexPages.standardController stdCtrl;
	
	protected Map<String,Id> recordTypes = new Map<String,Id>();
	
	public FactuCreateMissionCtrl(ApexPages.standardController stdCtrl){
		this.stdCtrl = stdCtrl;
		for(RecordType rtype : [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType='Mission__c']){
			this.recordTypes.put(rtype.DeveloperName, rtype.Id);
		}
	}
	
	public PageReference createMission(){
		
		Contract c = (Contract) this.stdCtrl.getRecord();
		Pagereference ret = new Pagereference('/' + Mission__c.sObjectType.getDescribe().getKeyPrefix() + '/e');

		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Contrat__c').Id__c,c.ContractNumber); 
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Contrat__c').Id__c+'_lkid',c.Id);
		
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Compte__c').Id__c,c.Account.Name); 
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Compte__c').Id__c+'_lkid',c.Account.Id);
		
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Cond_renouvellement__c').Id__c,c.Conditions_de_renouvellement__c);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Conds_facturation__c').Id__c,c.Conditions_de_facturation__c);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Conds_paiement__c').Id__c,c.Conditions_de_paiement__c);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Conds_remuneration__c').Id__c,c.Conditions_de_remuneration__c);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Precision_facturation__c').Id__c,c.Precision_facturation__c);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Precision_paiement__c').Id__c,c.Precision_paiement__c);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Precision_remuneration__c').Id__c,c.Precision_remuneration__c); 
		
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Contrat_signe_par__c').Id__c,c.Consultant_Commercial__r.Name);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Contrat_signe_par__c').Id__c+'_lkid',c.Consultant_Commercial__c); 
		
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Conditions_particuli_res__c').Id__c,c.Conditions_particuli_res__c);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Dur_e_initiale_mois__c').Id__c,String.valueOf(c.ContractTerm));
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Pr_avis_r_siliation_mois__c').Id__c,String.valueOf(c.Preavis_de_resiliation__c));
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.R_mun_ration_future__c').Id__c,c.Remuneratuin_future__c);
		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Taux_de_r_mun_ration__c').Id__c,String.valueOf(c.Taux_de_remuneration__c));
        
        if(c.recordType.developerName == 'TAT'){
            ret.getParameters().put(FieldIds__c.getValues('Mission__c.Statut_deploi_AT_Advance__c').Id__c,c.Statut_deploiement_AT_Advance__c);
    		ret.getParameters().put(FieldIds__c.getValues('Mission__c.AT_Advance__c').Id__c,c.AT_Advance__c);
    		ret.getParameters().put(FieldIds__c.getValues('Mission__c.nb_lic_atadvance__c').Id__c,String.valueOf(c.Nombre_de_licence_AT_Advance__c));
    		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Risk_Pro_Online__c').Id__c,c.Risk_Pro_Online__c?'1':'0');
    		ret.getParameters().put(FieldIds__c.getValues('Mission__c.ConditionsATA_RPO__c').Id__c,c.Conditions_AT_Advance_Risk_Pro_Online__c);
    		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Modalit_de_facturation__c').Id__c,c.Modalit_de_facturation__c);
    		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Montant_forfait__c').Id__c,String.valueOf(c.Montant_forfait__c)); 
    		ret.getParameters().put(FieldIds__c.getValues('Mission__c.Periode_Fact_forfait__c').Id__c,c.Periode_Facturation_forfait__c);
        }

		ret.getParameters().put('retURL',c.Id);
		ret.getParameters().put('RecordType',this.getRecordTypeId(c.RecordType.developerName));
		return ret;

    }
	
	private Id getRecordTypeId(String RecordTypeName) {
		
		return this.recordTypes.get(RecordTypeName);
		
	}

}