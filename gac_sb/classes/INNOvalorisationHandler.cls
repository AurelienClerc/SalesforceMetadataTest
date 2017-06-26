/**
 * Class INNOvalorisationHandler
 *
 * Trigger Handler for the INNOvalo__c	 SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */

public with sharing class INNOvalorisationHandler implements ITrigger {
	
	//Contiendra tous les Id des missions dans lesquelles il faudra mettre à jour les faux rollups
	private Set<Id> missionsIdsToUpdateRollups = new Set<Id>();
	
	private List<INNOmission__c> missionsToUpdate = new List<INNOmission__c>();
	private Map<Id, INNOmission__c> missionsToUpsert = new Map<Id, INNOmission__c>();
	
	private Set<Id> tempMissionsToUpsert = new Set<Id>();
	private Set<Id> missionsValoDeleted = new Set<Id>();
	// Constructor
	public INNOvalorisationHandler(){
	}

	public void bulkBefore(){
	}
	
	public void bulkAfter(){
	    //EDIT Aurélien CLERC 13/06/2017
	    if(!Trigger.isDelete){
	        for(INNOvalo__c valo : (List<INNOvalo__c>)[SELECT Id, MissionCIR__c FROM INNOvalo__c WHERE Id IN :Trigger.New AND (Date_validation_perimetre__c != null OR Date_envoi_valorisation__c != null)]){
	            this.tempMissionsToUpsert.add(valo.MissionCIR__c);
	        }
	    }
	}
		
	public void beforeInsert(SObject so){
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
	}
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
	    //EDIT Aurélien CLERC 15/06/2017
	    INNOvalo__c valo = (INNOvalo__c) so;
	   
	    if(valo.Date_envoi_valorisation__c == null || valo.Date_validation_perimetre__c == null){
	        if(valo.Date_envoi_valorisation__c == null)
	            missionsToUpsert.put(valo.MissionCIR__c, new INNOmission__c(Id                          = valo.MissionCIR__c,
		                                                                    Date_fin_valorisation__c    = null));
		        if(valo.Date_validation_perimetre__c == null)
		            missionsToUpsert.get(valo.MissionCIR__c).Date_fin_audit__c  = null;
		    else if(valo.Date_validation_perimetre__c == null)
		        missionsToUpsert.put(valo.MissionCIR__c, new INNOmission__c(Id                          = valo.MissionCIR__c,
		                                                                    Date_fin_audit__c           = null));
		        if(valo.Date_envoi_valorisation__c == null)    
		            missionsToUpsert.get(valo.MissionCIR__c).Date_fin_valorisation__c  = null;
	    }
		else
	        if(!this.tempMissionsToUpsert.isEmpty())
    	        this.missionDateFin(tempMissionsToUpsert);
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
		INNOvalo__c oldValo = (INNOvalo__c) oldSo;
		INNOvalo__c valo = (INNOvalo__c) so;
		
		if(oldValo.Montant_CIR_definitif_option1__c != valo.Montant_CIR_definitif_option1__c 
			|| oldValo.Montant_CIR_definitif_option2__c != valo.Montant_CIR_definitif_option3__c
			|| oldValo.Montant_CIR_definitif_option3__c != valo.Montant_CIR_definitif_option3__c
			|| oldValo.Montant_CIR_definitif_optionFinale__c != valo.Montant_CIR_definitif_optionFinale__c){
			
			this.missionsIdsToUpdateRollups.add(valo.MissionCIR__c);
		}
		
		//EDIT Aurélien CLERC 15/06/2017
		if(oldValo.Date_envoi_valorisation__c != valo.Date_envoi_valorisation__c || oldValo.Date_validation_perimetre__c != valo.Date_validation_perimetre__c){
		    if(valo.Date_envoi_valorisation__c == null){
		        missionsToUpsert.put(valo.MissionCIR__c, new INNOmission__c(Id                          = valo.MissionCIR__c,
		                                                                    Date_fin_valorisation__c    = null));
		        if(valo.Date_validation_perimetre__c == null)
		            missionsToUpsert.get(valo.MissionCIR__c).Date_fin_audit__c  = null;
		    }
		    else if(valo.Date_validation_perimetre__c == null)
		        missionsToUpsert.put(valo.MissionCIR__c, new INNOmission__c(Id                          = valo.MissionCIR__c,
		                                                                    Date_fin_audit__c           = null));
		}
        if(!this.tempMissionsToUpsert.isEmpty())
    	   this.missionDateFin(tempMissionsToUpsert);      
	}
	
	public void afterDelete(SObject so){
	    INNOvalo__c valo = (INNOvalo__c) so;
	    
	    this.missionsValoDeleted.add(valo.MissionCIR__c);
	    
	    if(!this.missionsValoDeleted.isEmpty())
    	   this.missionDateFin(missionsValoDeleted);
	}
	
	public void andFinally(){
		
		if(!this.missionsIdsToUpdateRollups.isEmpty()){
			List<INNOmission__c> missionsToUpdate = new List<INNOmission__c>();
			for(AggregateResult aggr : [SELECT MissionCIR__c, 
												SUM(Montant_total_depenses_option1__c) depensesOpt1,
												SUM(Montant_total_depenses_option2__c) depensesOpt2,
												SUM(Montant_total_depenses_option3__c) depensesOpt3,
												SUM(Montant_total_depenses_optionFinale__c) depensesRetenu,
												SUM(Montant_CIR_definitif_option1__c) cirOpt1,
												SUM(Montant_CIR_definitif_option2__c) cirOpt2,
												SUM(Montant_CIR_definitif_option3__c) cirOpt3,
												SUM(Montant_CIR_definitif_optionFinale__c) cirRetenu
												
											FROM INNOvalo__c
											WHERE MissionCIR__c IN :this.missionsIdsToUpdateRollups
											GROUP BY MissionCIR__c]){
				missionsToUpdate.add(new INNOmission__c(Id 										= (Id) aggr.get('MissionCIR__c'),
														Montant_total_depenses_option1__c		= (Decimal) aggr.get('depensesOpt1'),
														Montant_total_depenses_option2__c		= (Decimal) aggr.get('depensesOpt2'),
														Montant_total_depenses_option3__c		= (Decimal) aggr.get('depensesOpt3'),
														Montant_total_depenses_optionFinale__c	= (Decimal) aggr.get('depensesRetenu'),
														Montant_CIR_definitif_option1__c 		= (Decimal) aggr.get('cirOpt1'),
														Montant_CIR_definitif_option2__c 		= (Decimal) aggr.get('cirOpt2'),
														Montant_CIR_definitif_option3__c 		= (Decimal) aggr.get('cirOpt3'),
														Montant_CIR_definitif_optionFinale__c	= (Decimal) aggr.get('cirRetenu')));
			}
			update missionsToUpdate;
		}
		upsert missionsToUpsert.values();
	}
	
	private void missionDateFin(Set<Id> setId){
	    //EDIT Aurélien CLERC 13/06/2017
	    for(AggregateResult aggr : [SELECT MissionCIR__c, MAX(Date_envoi_valorisation__c) maxDate, COUNT(Date_envoi_valorisation__c) valoDateRemplie, COUNT(Id) valoTotal FROM INNOvalo__c WHERE ValoA0__c = false AND MissionCIR__c IN :setId GROUP BY MissionCIR__c]){
	        if(aggr.get('valoDateRemplie') == aggr.get('valoTotal')){ 
	            if(!this.missionsToUpsert.containsKey((Id) aggr.get('MissionCIR__c'))){
	                this.missionsToUpsert.put((Id) aggr.get('MissionCIR__c'), new INNOmission__c(Id                          = (Id) aggr.get('MissionCIR__c'),
	                                                                                             Date_fin_valorisation__c    = (Date) aggr.get('maxDate')));
	            }
	        }
	    }
	    
	    for(AggregateResult aggr : [SELECT MissionCIR__c, MAX(Date_validation_perimetre__c) maxDate, COUNT(Date_validation_perimetre__c) valoDateRemplie, COUNT(Id) valoTotal FROM INNOvalo__c WHERE MissionCIR__c IN :setId GROUP BY MissionCIR__c]){
	        if(aggr.get('valoDateRemplie') == aggr.get('valoTotal')){
	            if(!this.missionsToUpsert.containsKey((Id) aggr.get('MissionCIR__c'))){
	                this.missionsToUpsert.put((Id) aggr.get('MissionCIR__c'), new INNOmission__c(Id                 = (Id) aggr.get('MissionCIR__c'),
	                                                                                             Date_fin_audit__c  = (Date) aggr.get('maxDate')));
	            }
	            else
	                this.missionsToUpsert.get((Id) aggr.get('MissionCIR__c')).Date_fin_audit__c  = (Date) aggr.get('maxDate');
	        }
	    }
	}
}