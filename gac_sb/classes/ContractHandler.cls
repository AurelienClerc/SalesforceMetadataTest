/**
 * Class ContractHandler
 *
 * Trigger Handler for the Contract SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */
virtual public without sharing class ContractHandler implements iTrigger{

	protected ContractGateway ContractGateway = new ContractGateway(); 
	//Map pour recuperer la liste des developperName associé aux recordtype des contracts 
	private Map<Id, String> recordTypeDevNameById = new Map<Id, String>();
	
	//Map pour recuperer la liste Id des record Type associé aux missions 
	private Map<String, Id> recordTypeIdbyDevName = new Map<String, Id>();
	
    //Liste des missions créées pour chaque année 
	private List<Mission__c> missionLDBToContracts = new List<mission__c>();
	
	//Map contenant Id des contrats et une liste de societe à auditer pour chancun  
	private Map<Id, Set<Id>> societesAuditeerByContractId = new Map <ID, Set<Id>>();
	
	public map<string,string> refRemarquesByAccount;

	// Constructor
	public ContractHandler(){
	}

	
	virtual public void bulkBefore(){
	    refRemarquesByAccount = new map<string,string>();
	    Set<Id> sid = new set<Id>();
	    if(trigger.isInsert){
    	    for(sObject so : trigger.new){
    	        if(!refRemarquesByAccount.containsKey((string) so.get('AccountId')+'_'+(string) so.get('recordTypeId'))){
    	            refRemarquesByAccount.put((string) so.get('AccountId')+'_'+(string) so.get('recordTypeId'),null);
    	            
    	        }
    	        if(!sid.contains((id) so.get('AccountId')))
    	            sid.add((id) so.get('AccountId'));
    	    }
    	    if(!sid.isEmpty()){
        	    for(Contract c : [SELECT accountId, remarques_factu__c,recordTypeId from Contract WHERE AccountId in : sid and remarques_factu__c != null order by Date_de_reception_du_contrat__c DESC ]){
        	        if(refRemarquesByAccount.containsKey(c.AccountId+'_'+c.recordTypeId) && refRemarquesByAccount.get(c.AccountId+'_'+c.recordTypeId ) == null ){
        	            refRemarquesByAccount.put(c.AccountId+'_'+c.recordTypeId , c.remarques_factu__c);
        	        }
        	    }
    	    }
	    }
		
	}
	
	virtual public void bulkAfter(){
		if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
			for(Contract c : [select id, (select Societe_a_auditer__c from Societes_a_auditer__r) from contract where id in:trigger.newMap.keySet()]){
				if(! c.Societes_a_auditer__r.isEmpty()){
					this.contractGateway.addSoc(c.Societes_a_auditer__r);
				}
				
			
			}
		}
		
		if(trigger.isUpdate){
			for(Contract c : [select id, (select Societe_a_auditer__c from Societes_a_auditer__r) from contract where id in:trigger.oldMap.keySet()]){
				if(! c.Societes_a_auditer__r.isEmpty()){
					this.contractGateway.addSoc(c.Societes_a_auditer__r);
				}
				
				/**Gildas 04/11/2014
				 * Préparation de la map permettant de stocker la liste des société à auditer pour chaque contrat
				 **/
				this.societesAuditeerByContractId.put(c.Id, new Set<Id>());
                for(Societe_a_auditer__c soc: c.Societes_a_auditer__r)
                {
                    this.societesAuditeerByContractId.get(c.Id).add(soc.societe_a_auditer__c);
                    
                }
			}
		    
		    for (RecordType rec : [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = 'Contract']){
		        recordTypeDevNameById.put(rec.Id, rec.DeveloperName); 
		    }
			
			for (RecordType rec : [SELECT ID , DeveloperName FROM RecordType WHERE SobjectType = 'Mission__c']){
		        recordTypeIdbyDevName.put(rec.DeveloperName, rec.Id ); 
		    }
		    /*Fin modification gildas*/
		}
			
			
	}
	
		
	virtual public void beforeInsert(SObject so){
	    if(so.get('remarques_factu__c') == null && refRemarquesByAccount.containsKey((string) so.get('AccountId')+'_'+(string) so.get('recordTypeId')) && refRemarquesByAccount.get((string) so.get('AccountId')+'_'+(string) so.get('recordTypeId')) != null )
	        so.put('remarques_factu__c' , refRemarquesByAccount.get((string) so.get('AccountId')+'_'+(string) so.get('recordTypeId')));
	}
	
	virtual public void beforeUpdate(SObject oldSo, SObject so){
	}
	
	virtual public void beforeDelete(SObject so){	
	}
	
	virtual public void afterInsert(SObject so){
		this.ContractGateway.addItem((Contract) so);
		//DIDIER 19/12/12
		//Après l'insertion d'un contrat, on va renseigner son périmètre d'étude ON LE FAIT UNIQUEMENT A L"INSERTION
		this.ContractGateway.AddPerimeterFromOpportunity(so.Id, (Id) so.get('Opportunite__c'));
	}
	
	virtual public void afterUpdate(SObject oldSo, SObject so){
	    Contract oldContrat =  (Contract) oldSo;
	    Contract contrat =  (Contract) so;
	    
		this.ContractGateway.addItem(oldContrat); //On ajoute le oldso pour modifier également le vieux contrat
		this.ContractGateway.addItem(contrat);
		
		
		
		/*if(so.get('Status') == 'Activé')	//TODO, ne sert plus a rien, on ne modifie plus d'étape de l'opportiunoté a l'activation de contrat
			this.ContractGateway.AddOppToUpdate((Id) so.get('Opportunite__c'));
		*/
	
		/**gildas 04/11/2014
		 * Creation des missions pour chaque année concernée pour le compte associé au contrat de même que pour toutes les sociétés à auditer rattachées aux contrats
		 **/
		
		if(oldContrat.Status != 'Activé' && contrat.Status == 'Activé' && recordTypeDevNameById.get(contrat.RecordTypeId) == 'LDB'){
				
				if(String.isNotBlank(contrat.Annees_concernees__c)){
		        
    		        String IdRecordType = recordTypeIdbyDevName.get('LDB');
        	        for (String an : contrat.Annees_concernees__c.split(';'))
        	        {
        	            missionLDBToContracts.add(new Mission__c(Compte__c=contrat.AccountId,Annee_concernee__c=an , Contrat__c = Contrat.Id, Type_de_mission__c ='LDB' ,  RecordTypeId = IdRecordType));
        	               
        	           
        	            for (Id socId : societesAuditeerByContractId.get(contrat.Id) )
        	            {
        	               
        	                if(contrat.AccountId != socId)
        	                {
        	                   
        	                    missionLDBToContracts.add(new Mission__c(Compte__c=socId,Annee_concernee__c=an , Contrat__c = Contrat.Id, Type_de_mission__c ='LDB' ,  RecordTypeId = IdRecordType));        
        	                }
        	                
        	            }
        	                       
        	        }
    	        }
    	              
    	    } 
		}

	
	
	virtual public void afterDelete(SObject so){
		this.ContractGateway.addItem((Contract) so);
	}
	
	/**
	 * andFinally
	 *
	 * This method is called once all records have been processed by the trigger. Use this 
	 * method to accomplish any final operations such as creation or updates of other records.
	 */
	virtual public void andFinally(){
		if(Trigger.isAfter || Trigger.IsUndelete){
			List<Sobject> ToUpdate = this.ContractGateway.processAccUpdate();
			List<Societe_a_auditer__c> ToInsert = this.contractGateway.processPerimetreInsert();
			
			try{
				update ToUpdate;
				if(!ToInsert.isEmpty())
					insert ToInsert;
			
			}catch(Exception e){
				String Message = e.getMessage();
				if(Message.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION,')){
					Message = Message.replaceAll('.*FIELD_CUSTOM_VALIDATION_EXCEPTION,','');
				}
				if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
					trigger.new.get(0).addError('L\'enregistrement n\'a pas pu être enregistré car un objet lié n\'est pas à jour. Corrigez l\'erreur suivante sur l\'opportunité avant de continuer :' + Message );
				}else
					trigger.old.get(0).addError('L\'enregistrement n\'a pas pu être enregistré car un objet lié n\'est pas à jour. Corrigez l\'erreur suivante sur l\'opportunité avant de continuer :' + Message );
					
				//return;
			}
		
			insert missionLDBToContracts;
            
		}
	}
}