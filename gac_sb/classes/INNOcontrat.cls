/**
*	Cette classe sert à mettre tous les champs d'un contrat dans la propriété 'champs'
*	C'est indispensable ici car les consultants avec des licences force.com ne peuvent pas afficher ces champs de manière classique en visualforce (ils n'ont pas accès à l'objet contrat)
*	On créé donc une map qui contiendra tous ces champs sous la forme nomDuChamp => {label => labelDuChamp, value => valeurDuChamp}
*/

public with sharing class INNOcontrat {

	public Map<String, Map<String, Object>> champs {get;set;}


	public INNOcontrat(Id contractId){
		this.initChamps(contractId);
	}
	
	
	private void initChamps(Id contractId){
		this.champs = new Map<String, Map<String,Object>>();
		
		//Récupère tous les champs de l'objet contrat
		Map<String, Schema.SObjectField> contractFields = Contract.sObjectType.getDescribe().fields.getMap();
		   
		Schema.DescribeFieldResult fieldDescription;

		//Contiendra la requete SOQL permettant de recupérer tous les champs du contrat dont l'Id est passé en paramètre
		String req = 'SELECT ';
		   
		//Boucle sur tous les champs du contrat
		for(Schema.SObjectField contractField : contractFields.values()){
			fieldDescription = contractField.getDescribe();
			
			//Construction de la requete SOQL
			req += fieldDescription.getName() + ', ';
			
			//Ajoute le champ a this.champs (pour l'instant on a que le nom du champ et son label)
			this.champs.put(fieldDescription.getName(), new Map<String,Object>{ 'label' => fieldDescription.getLabel() });
		}

		//Exectute la requete SOQL permettant de récupérer le contrat avec tous ces champs
		Contract contrat = Database.query(req.substring(0, req.length() - 2) + ' FROM Contract WHERE Id = :contractId LIMIT 1');
		   
		//On re-boucle maintenant sur this.champs pour y ajouter la valeur du champ pour le contrat dont l'id est passé en parametre
		for(String fieldName : this.champs.keyset()){
			this.champs.get(fieldName).put('value', contrat.get(fieldName) != null ? contrat.get(fieldName) : '');
		}
		
		
		//Si les champs CA estimé N et CA estimé N+1 n'existent pas, on les met à null pour éviter une erreur visualforce
		Integer contractYear = ((Date) this.champs.get('Date_de_reception_du_contrat__c').get('value')).year();
		if(!this.champs.containsKey('CA_estime_' + String.valueOf(contractYear) + '__c' ))
			this.champs.put('CA_estime_' + String.valueOf(contractYear) + '__c', new Map<String, Object>{'label' => 'CA estimé ' + String.valueOf(contractYear), 'value' => ''});
		
		if(!this.champs.containsKey('CA_estime_' + String.valueOf(contractYear + 1) + '__c' ))
			this.champs.put('CA_estime_' + String.valueOf(contractYear + 1) + '__c', new Map<String, Object>{'label' => 'CA estimé ' + String.valueOf(contractYear + 1), 'value' => ''});   
		
	}
}