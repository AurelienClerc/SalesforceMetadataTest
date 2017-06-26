public without sharing class Historique_SegmentationHandler implements ITrigger {
    
    public static boolean updateAccountFields = true;
	
	public static list<Account> lAccountToUp;
	
	public static final integer iCurrentYear = date.today().year();
	
	public static Boolean bAlreadyDone = false;
	
	public static Boolean updateConcurrents = false;
	
	public static map<Id, map<Integer, Historique_Segmentation__c>> modifiedSegmentation;
	
	static {
	    lAccountToUp = new list<Account>();
	    modifiedSegmentation = new Map<Id,map<Integer, Historique_Segmentation__c>>();
	}
	
	public void bulkBefore(){
	    updateConcurrents = !bAlreadyDone && trigger.new != null && trigger.new.size() < 200; //Ne marche pas si plusieurs batch
	}
	
	public void bulkAfter(){
	}
		
	public void beforeInsert(SObject so){
	    Historique_Segmentation__c histo = (Historique_Segmentation__c) so;
	    if(histo.id_externe__c == null)
	        histo.id_externe__c = V2AP01_SegmentationManager.getHistoIdExterne(histo.compte__c,Integer.valueOf(histo.annee__c));
	  
	    if(updateConcurrents){ 
            V2AP02_SegmentationConcurrentManager.addItem(histo);
        }
	}
	
	public void beforeUpdate(SObject oldSo, SObject so){
	   if(updateConcurrents){ 
            V2AP02_SegmentationConcurrentManager.addItem( (Historique_Segmentation__c) so );
        }
	}
	
	public void beforeDelete(SObject so){	
	}
	
	public void afterInsert(SObject so){
	   Historique_Segmentation__c histo = (Historique_Segmentation__c) so;
       /*if(histo.annee__c == iCurrentYear)
            lAccountToUp.add(V2AP01_SegmentationManager.applyToAccount(histo, histo.compte__c));*/
        if(!modifiedSegmentation.containsKey(histo.compte__c))
            modifiedSegmentation.put(histo.compte__c, new map<Integer, Historique_Segmentation__c>());
        modifiedSegmentation.get(histo.compte__c).put(Integer.valueOf(histo.annee__c), histo);
        
	}
	
	public void afterUpdate(SObject oldSo, SObject so){
	   Historique_Segmentation__c histo = (Historique_Segmentation__c) so;
       /*if(histo.annee__c == iCurrentYear)
            lAccountToUp.add(V2AP01_SegmentationManager.applyToAccount(histo, histo.compte__c));*/
        if(!modifiedSegmentation.containsKey(histo.compte__c))
            modifiedSegmentation.put(histo.compte__c, new map<Integer, Historique_Segmentation__c>());
        modifiedSegmentation.get(histo.compte__c).put(Integer.valueOf(histo.annee__c), histo);
	}
	
	public void afterDelete(SObject so){
	}

	public void andFinally(){
	        system.debug('###IN Historique Segmentation handler, andFinally isBefore ');
	    /*if(!lAccountToUp.isEmpty())
	        update lAccountToUp;*/
	    if(trigger.isBefore && !trigger.isDelete){
    	    List<Historique_Segmentation__c> toUpsert = V2AP02_SegmentationConcurrentManager.processCalc();
    	    if( !toUpsert.isEmpty() ){
    	        bAlreadyDone = true;
    	        database.upsert(toUpsert , Historique_Segmentation__c.fields.id_externe__c );
    	    }
	    }
	    if(trigger.isAfter){
    	    system.debug('Historique Segmentation , updating related Opportunities');
    	    Opportunity[] ret = V2AP01_SegmentationManager.updateOpps(modifiedSegmentation, trigger.new);
    	    Account[] retAccount = V2AP01_SegmentationManager.updateAccounts(modifiedSegmentation, trigger.new);
    	    if(!ret.isEmpty()){
    	        system.debug(ret);
    	        try{
    	           update ret;
    	        }catch(DMLException e){
    	            system.debug('EXCEPTION THROWN');
    	            system.debug(e);
    	            trigger.new.get(0).addError('Une erreur est survenue lors de la mise à jour d\'une opportunité liée. La première erreur était : '+e.getDMLMessage(0));
    	        }
    	    }else
    	        system.debug('historique Segmentation modified, no opp to update');
    	   if(!retAccount.isEmpty()){
    	        system.debug(ret);
    	        try{
    	           update retAccount;
    	        }catch(DMLException e){
    	            system.debug('EXCEPTION THROWN');
    	            system.debug(e);
    	            trigger.new.get(0).addError('Une erreur est survenue lors de la mise à jour du compte lié. La première erreur était : '+e.getDMLMessage(0));
    	        }
    	    }else
    	        system.debug('historique Segmentation modified, no opp to update');
	    }
	    if(!trigger.isDelete)
	        system.debug('###OUT Historique Segmentation handler, andFinally isBefore');
	}
	
}