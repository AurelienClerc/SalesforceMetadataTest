public with sharing class INNOimport_projet extends INNOimport{
	
	private Id valoId;
	
	
	public override void init(Id valoId){
		
		this.valoId = valoId;
		
		this.existingRecordsWhereClause = 'WHERE Valorisation__c = \'' + this.valoId + '\' AND Type__c = \'projet\'';
		
		this.importTypeName = 'Projets';
		
		system.debug(this.valoId);
		List<INNOvalo__c> valos = [SELECT Id, Name, Entite__c FROM INNOvalo__c WHERE Id = :this.valoId LIMIT 1];
		
		this.pageTitle = valos[0].Name;
				
		this.excelFileName = 'INNO-Imports_projets.xlsx';

		this.sObjectDescribe = INNOprojet__c.SObjectType;
		
		this.standardColumns = new List<Map<String, String>>{ 
															new Map<String, String>{'Name'=>'Nom*', 'FieldName'=>'Name', 'Required'=>'true', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Nom du regroupement de projet', 'FieldName'=>'Nom_regroupement_projet__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'N° de projet', 'FieldName'=>'Num_projet__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Département', 'FieldName'=>'Departement__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Etat de l\'art', 'FieldName'=>'Etat_de_art__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Objectifs du projet', 'FieldName'=>'Objectifs_projet__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Difficultés techniques', 'FieldName'=>'Difficultes_techniques__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Travaux menés', 'FieldName'=>'Travaux_menes__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Progrès accomplis', 'FieldName'=>'Progres_accomplis__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Existence de documents justificatifs', 'FieldName'=>'Existence_documents_justificatifs__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Commentaires', 'FieldName'=>'Commentaires__c', 'Required'=>'false', 'Type'=>'String'}
															};
															
		this.upsertKeyFieldName = 'Name';
	
		this.importIdField = 'ImportId__c';
		
		this.retPage = new pageReference( '/apex/INNOprojetList' );
		this.retPage.getParameters().put('id', this.valoId);
		this.retPage.getParameters().put('valoId', this.valoId);
		
		
		
		/*
		*	Initialisation des départements possibles du champ 'Departement'
		*/
		List<SelectOption> departements = new List<SelectOption>{new SelectOption('', '-Aucun-')};
		
		for(INNOdepartement__c dept : [SELECT Id, Name FROM INNOdepartement__c WHERE Entite__c = :valos[0].Entite__c ORDER BY Name])
			departements.add(new SelectOption(dept.Id, dept.Name));
			
		this.picklistValues.put('Departement__c', departements);	
	
	}



	protected override String getRowUpsertKeyValue(INNOimport.ImportRow row){
		return row.cells[0].value;
	}
	
	

	
	protected override sObject getRecord(ImportRow row){
		sObject record = new INNOprojet__c(Id = row.existingRecordId, Valorisation__c = this.valoId, Type__c = 'projet');
		
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