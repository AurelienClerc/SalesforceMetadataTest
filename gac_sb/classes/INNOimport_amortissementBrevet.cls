public with sharing class INNOimport_amortissementBrevet extends INNOimport{

	private Id valoId;
	
	private String recordTypeId;
	
	
	public override void init(Id valoId){
		
		this.valoId = valoId;
		
		this.recordTypeId = [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = 'INNOamortissement__c' AND DeveloperName = 'amortissementBrevet' LIMIT 1][0].Id;
		
		this.existingRecordsWhereClause = 'WHERE Valorisation__c = \'' + this.valoId + '\' AND RecordTypeId = \'' + this.recordTypeId + '\'';
		
		this.importTypeName = 'Dotations aux amortissements de brevets';
		
		List<INNOvalo__c> valos = [SELECT Id, Name, Entite__c FROM INNOvalo__c WHERE Id = :this.valoId LIMIT 1];
		
		this.pageTitle = valos[0].Name;
				
		this.excelFileName = 'INNO-Imports_amortissements_brevets.xlsx';

		this.sObjectDescribe = INNOamortissement__c.SObjectType;
		
		this.standardColumns = new List<Map<String, String>>{ 
															new Map<String, String>{'Name'=>'Désignation*', 'FieldName'=>'Name', 'Required'=>'true', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Département', 'FieldName'=>'Departement__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Projet', 'FieldName'=>'Projet__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Date d\'acquisition', 'FieldName'=>'Date_acquisition__c', 'Required'=>'false', 'Type'=>'Date'},
															new Map<String, String>{'Name'=>'Annuité d\'amortissement*', 'FieldName'=>'Annuite_amortissement__c', 'Required'=>'true', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Taux R&D opt1', 'FieldName'=>'Taux_RD_option1__c', 'Required'=>'false', 'Type'=>'Percent'},
															new Map<String, String>{'Name'=>'Taux R&D opt2', 'FieldName'=>'Taux_RD_option2__c', 'Required'=>'false', 'Type'=>'Percent'},
															new Map<String, String>{'Name'=>'Taux R&D opt3', 'FieldName'=>'Taux_RD_option3__c', 'Required'=>'false', 'Type'=>'Percent'},
															new Map<String, String>{'Name'=>'Commentaires', 'FieldName'=>'Commentaires__c', 'Required'=>'false', 'Type'=>'String'}
															};
															
		this.upsertKeyFieldName = 'Name';
	
		this.importIdField = 'ImportId__c';
		
		this.retPage = new pageReference( '/apex/INNOamortissementList' );
		this.retPage.getParameters().put('id', this.valoId);
		this.retPage.getParameters().put('valoId', this.valoId);
		this.retPage.getParameters().put('tab', 'amortissementBrevet');
		
		
		
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
		return row.cells[0].value;
	}
	

	
	protected override sObject getRecord(ImportRow row){
		sObject record = new INNOamortissement__c(Id = row.existingRecordId, Valorisation__c = this.valoId, RecordTypeId = this.recordTypeId);
		
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