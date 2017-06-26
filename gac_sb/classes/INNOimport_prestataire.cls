public with sharing class INNOimport_prestataire extends INNOimport{

	private Id valoId;
	
	private String recordTypeId;
	

	public INNOimport_prestataire(){}
	
	
	public override void init(Id valoId){
		
		this.valoId = valoId;
		
		this.recordTypeId = [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = 'INNOdepensePrestation__c' AND DeveloperName = 'prestataire' LIMIT 1][0].Id;
		
		this.existingRecordsWhereClause = 'WHERE Valorisation__c = \'' + this.valoId + '\' AND RecordTypeId = \'' + this.recordTypeId + '\'';
		
		this.importTypeName = 'Prestataires';
		
		List<INNOvalo__c> valos = [SELECT Id, Name, Entite__c FROM INNOvalo__c WHERE Id = :this.valoId LIMIT 1];
		
		if(valos.size() > 0)
			this.pageTitle = valos[0].Name;
				
		this.excelFileName = 'INNO-Imports_prestataires.xlsx';

		this.sObjectDescribe = INNOdepensePrestation__c.SObjectType;
		
		this.standardColumns = new List<Map<String, String>>{ 
															new Map<String, String>{'Name'=>'Prestataire*', 'FieldName'=>'Prestataire__c', 'Required'=>'true', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Nature prestation', 'FieldName'=>'Nature_prestation__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'SIREN', 'FieldName'=>'SIREN__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Date début d\'agrément', 'FieldName'=>'Date_debut_agrement__c', 'Required'=>'false', 'Type'=>'Date'},
															new Map<String, String>{'Name'=>'Date fin d\'agrément', 'FieldName'=>'Date_fin_agrement__c', 'Required'=>'false', 'Type'=>'Date'},
															new Map<String, String>{'Name'=>'Type d\'organisme* (Public/Agréé)', 'FieldName'=>'Type_organisme__c', 'Required'=>'true', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Lien de dépendance* (Avec/Sans)', 'FieldName'=>'Lien_de_dependance__c', 'Required'=>'true', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Localisation* (En France/A l\'étranger)', 'FieldName'=>'Localisation__c', 'Required'=>'true', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Précisez pays (si localisation à l\'étranger)', 'FieldName'=>'Precisez_pays__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Département', 'FieldName'=>'Departement__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Projet', 'FieldName'=>'Projet__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'N° pièce*', 'FieldName'=>'Num_piece__c', 'Required'=>'true', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Date pièce', 'FieldName'=>'Date_piece__c', 'Required'=>'false', 'Type'=>'Date'},
															new Map<String, String>{'Name'=>'Montant HT*', 'FieldName'=>'Montant_HT__c', 'Required'=>'true', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Taux R&D opt1', 'FieldName'=>'Taux_option1__c', 'Required'=>'false', 'Type'=>'Percent'},
															new Map<String, String>{'Name'=>'Taux R&D opt2', 'FieldName'=>'Taux_option2__c', 'Required'=>'false', 'Type'=>'Percent'},
															new Map<String, String>{'Name'=>'Taux R&D opt3', 'FieldName'=>'Taux_option3__c', 'Required'=>'false', 'Type'=>'Percent'},
															new Map<String, String>{'Name'=>'Commentaires', 'FieldName'=>'Commentaires__c', 'Required'=>'false', 'Type'=>'String'}
															};
															
		this.upsertKeyFieldName = 'Num_piece__c';
		
		this.importIdField = 'ImportId__c';
		
		this.retPage = new pageReference( '/apex/INNOdepensePrestationList' );
		this.retPage.getParameters().put('id', this.valoId);
		this.retPage.getParameters().put('valoId', this.valoId);
		this.retPage.getParameters().put('tab', 'prestataire');
		
		
		
		/*
		*	Initialisation des départements possibles du champ 'Departement'
		*/
		List<SelectOption> departements = new List<SelectOption>{new SelectOption('', '-Aucun-')};
		
		for(INNOdepartement__c dept : [SELECT Id, Name FROM INNOdepartement__c WHERE Entite__c = :valos[0].Entite__c ORDER BY Name])
			departements.add(new SelectOption(dept.Id, dept.Name));
			
		this.picklistValues.put('Departement__c', departements);	
	
	
		/*
		*	Initialisation des projets possibles du champ 'Projet'
		*/
		List<SelectOption> projets = new List<SelectOption>{new SelectOption('', '-Aucun-')};
		
		for(INNOprojet__c projet : [SELECT Id, Name FROM INNOprojet__c WHERE Valorisation__c = :this.valoId AND Type__c = 'projet' ORDER BY Name])
			projets.add(new SelectOption(projet.Id, projet.Name));
			
		this.picklistValues.put('Projet__c', projets);
		
		
	}


	protected override String getRowUpsertKeyValue(INNOimport.ImportRow row){
		return row.cells[11].value;
	}
	
	

	
	protected override sObject getRecord(ImportRow row){
		sObject record = new INNOdepensePrestation__c(Id = row.existingRecordId, Valorisation__c = this.valoId, RecordTypeId = this.recordTypeId);
		
		for(INNOimport.ImportCell cell : row.cells){
			
			if(cell.datatype == 'Number')
				record.put(cell.fieldName, Decimal.valueOf(cell.value));
			else if(cell.datatype == 'Boolean')
				record.put(cell.fieldName, cell.value == 'oui' ? true : false);
			else if(cell.datatype == 'Date')
				record.put(cell.fieldName, cell.value == null ? null : Date.parse(cell.value));
			else
				record.put(cell.fieldName, cell.value);
				
		}
		
		return record;
	}
	
	
	
	
	
}