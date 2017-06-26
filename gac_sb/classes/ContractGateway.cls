/*
* Classe qui fait la passerelle entre les comtpes et les contrats
* Permet de mettre a jour les champs d'état du compte en client / prospect ...etc,
* Va également vérifier les sociétés a auditer dans le contrat pour ajouter les comptes en client
* Depuis le 27/11, ce trigger NE MET PLUS A JOUR les opportunités
* @author Didier HUGUET
* @created 14/06/2012
*/
public with sharing class ContractGateway {

	public Set<Id> AccsToCheck = new Set<Id>();
	
	public Set<Id> OppsToCheck = new Set<Id>();
	public Map<Id,Id> ContractToOppId = new Map<Id,Id>();
	
	public Map<Id,String> rTypes = new Map<Id,String> ();
	
	public Map<Id,String> AccountIdToCIF = new Map<Id,String>();
	
	/*
	* Constructeur
	* Initialisation des type de contrats
	*/
	public ContractGateway(){
		for(RecordType rtype : [SELECT Id,DeveloperName from RecordType where sObjectType='Contract'])
			this.rTypes.put(rtype.Id,rtype.DeveloperName);
	}
	
	/*
	* Permet d'ajouter un compte a recaluler en fonction du contrat qu'on est en train de mettre a jour
	*/
	public void AddItem(Contract co){
		if(co.AccountId!=null){
			this.AddItem(co.AccountId);
			//EDIT DIDIER 03 12 13
			if(co.CIF__c != null){
				AccountIdToCIF.put(co.AccountId,co.CIF__c);
			}
			//FIN DIDIER 03 !@
		}
		
		
	}
	
	/*
	* Methode commune
	*/
	public void AddItem(Id AccountId){
		if(!this.AccsToCheck.contains(AccountId)){
				this.AccsToCheck.add(AccountId);
			}
	}
	
	
	//Deprecated, on n'update plus les opporutinté a la modification d'un contrat
	//Historiquement, l'activation d'un contrat passait l'opportunité en fermée gagnée
	/*public void AddOppToUpdate(Id OppId){
		if(!this.OppsToCheck.contains(OppId)){
			this.OppsToCheck.add(OppId);
		}
	}*/
	
	public void AddPerimeterFromOpportunity(Id ContractId ,Id OppId){
		system.debug(ContractId);
		this.ContractToOppId.put(OppId, contractId);
	}
	
	
	
	/*
	* Permet en plus de charger les sociétés a auditer pour également mettre les comptes concernés a jour
	*/
	public void AddSoc(List<Societe_a_auditer__c> Soc){
		for(Societe_a_auditer__c So : Soc){
			if(!this.AccsToCheck.contains(So.Societe_a_auditer__c)){
				this.addItem(So.Societe_a_auditer__c);
			}
		}
	}
	
	
	/*
	* Méthode appelée après chaque DML request sur les contrats.
	* Va mettre a jour le champ Etat_du_compte_annee_JSON__c sur le compte rattaché 
	* avec les valeurs renseignés dans les contrats.
	* De cette façon, les champs formule d'état du compte se calculent bien
	*/
	public List<sObject> processAccUpdate(){
		
		List<sObject> accs = new List<sObject>();
		
		Map<String,String> Statuses = new Map<String,String> ();
		Boolean IsActive = false;
		
		for(Account Ac : [
			SELECT Id,Etat_du_compte_annee_JSON__c,/*EDIT DIDIER 03/12/13*/Siret__c/*FIN EDIT DIDIER*/,
			
			(Select Id, RecordTypeId, Status from Contracts where Status = 'Activé' OR Status = 'Clos'),
			(Select Contract__c, Contract__r.Status, Contract__r.RecordTypeId from Auditee_contrat__r where Contract__r.Status = 'Activé' OR Contract__r.status = 'Clos')
			
			FROM Account where Id in :this.AccsToCheck
		]){
			String Etat_du_compte_annee_JSON = '';
			Statuses.clear();
			
			if(!Ac.Contracts.isEmpty()){
				
				for(Contract c : Ac.Contracts){
					String Type = this.rTypes.get(c.RecordTypeId);
					if(!Statuses.containsKey(Type) || (Statuses.containsKey(Type) && c.Status == 'Activé' && Statuses.get(Type) == 'Clos')){
						Statuses.put(Type,c.Status);
					}
				}
			}
			if(!Ac.Auditee_contrat__r.isEmpty()){
				for(Societe_a_auditer__c Soc : Ac.Auditee_contrat__r){
					String Type = this.rTypes.get(Soc.contract__r.RecordTypeId);
					if(!Statuses.containsKey(Type) || (Statuses.containsKey(Type) && Soc.contract__r.Status == 'Activé' &&  Statuses.get(Type) == 'Clos')){
						Statuses.put(Type,Soc.contract__r.Status);
					}
				}
			}
			
			//List<Date> dates = new List<Date>();
			//dates = LastEndDate.values();
			//dates.sort();
			/*
			for(Integer i = dates.size()-1;i >= 0;i--){
				for(String finalType:LastEndDate.keySet()){
					if(LastEndDate.get(finalType) == dates[i] && !Etat_du_compte_annee_JSON.contains(finalType)){
						Etat_du_compte_annee_JSON = this.appendContractType(Etat_du_compte_annee_JSON,finalType,LastEndDate.get(finalType));
					}
				}
			}
			Précédement, on travaillait avec des dates cf le trigger
			IF(CONTAINS( Etat_du_compte_annee_JSON__c, 'IL'),IF(DATEVALUE(MID(Etat_du_compte_annee_JSON__c,FIND('IL',Etat_du_compte_annee_JSON__c)+LEN('IL'),10))>TODAY(),'Client actif','Client inactif'),'Prospect')
			*/
			for(String Type:Statuses.keySet()){
				Etat_du_compte_annee_JSON += Type + (Statuses.get(Type) == 'Activé' ? ':2' : ':1'); 
			}
			
			
			if(Ac.Etat_du_compte_annee_JSON__c != Etat_du_compte_annee_JSON){
				Ac.Etat_du_compte_annee_JSON__c = Etat_du_compte_annee_JSON;
				accs.add(Ac);
			}
			
			//EDIT DIDIER 03/12/13
			if(Ac.Siret__c == null && AccountIdToCIF.containsKey(Ac.Id))
				Ac.Siret__c = AccountIdToCIF.get(Ac.Id);
			
		}
		return accs;
	}
	
	/*
	* Insertion des sociétés a auditer en fonction des périmètres du contrat
	*/
	public List<Societe_a_auditer__c> processPerimetreInsert(){
		List<Societe_a_auditer__c> ret = new List<Societe_a_auditer__c>();
		for(Opportunity o : [SELECT Id, ( SELECT compte__c from filliales_concernees__r ) from opportunity where id in :ContractToOppId.KeySet()]){
			if(!o.filliales_concernees__r.isEmpty()){
				for(Perimetre_opportunite__c p : o.filliales_concernees__r){
					ret.add(new Societe_a_auditer__c(Societe_a_auditer__c = p.compte__c, contract__c = ContractToOppId.get(o.id)));
				}
			}
		}
		return ret;
	}
	
	
	/*
	*  Mise a jour de l'étape de l'opportunité
	//Didier 27/11 : Plus besoin de faire ça, on est sur que l'opportunité est gagnée a la création du contrat
	public List<sObject> processOppUpdate(){
		List<sObject> opps = new List<sObject>();
		/*
		//Didier 27/11 : Plus besoin de faire ça, on est sur que l'opportunité est gagnée a la création du contrat
		for(opportunity o :[SELECT stageName,Id,Precision_etape__c from opportunity where id in :OppsToCheck]){
			if(o.StageName != 'Fermée gagnée'){
				o.StageName = 'Fermée gagnée';
				opps.add(o);
			}
		}
		return opps;
		*
	}

	/*
	Cette méthode n'a plus lieu d'être, on se sert du statut du contrat pour dire si c'est un client.
	private string appendContractType(String Etat_du_compte_annee_JSON,String Type,Date EndDate){
		if(EndDate != null){
			if(!Etat_du_compte_annee_JSON.contains(Type + EndDate)){
				Etat_du_compte_annee_JSON += Type + EndDate;
			}
		}
		return Etat_du_compte_annee_JSON;
	}
	*/
}