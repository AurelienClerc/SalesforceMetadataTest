public with sharing class INNOimport_subventionAvance extends INNOimport{

	private Id valoId;
	
	
	public override void init(Id valoId){
		
		this.valoId = valoId;
		
		this.existingRecordsWhereClause = 'WHERE Valorisation__c = \'' + this.valoId + '\' AND Matricule__c != null';
		
		this.importTypeName = 'Subventions et avances';
		
		List<INNOvalo__c> valos = [SELECT Id, Name, Entite__c FROM INNOvalo__c WHERE Id = :this.valoId LIMIT 1];
		
		this.pageTitle = valos[0].Name;
				
		this.excelFileName = 'INNO-Imports_subventions_avances.xlsx';

		this.sObjectDescribe = INNOsubvention__c.SObjectType;
		
		this.standardColumns = new List<Map<String, String>>{ 
															new Map<String, String>{'Name'=>'Organisme*', 'FieldName'=>'Organisme__c', 'Required'=>'true', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Type* (Subvention, Avance perçue, Avance remboursée)', 'FieldName'=>'RecordTypeId', 'Required'=>'true', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Matricule', 'FieldName'=>'Matricule__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Date de versement', 'FieldName'=>'Date_versement__c', 'Required'=>'false', 'Type'=>'Date'},
															new Map<String, String>{'Name'=>'Nature', 'FieldName'=>'Nature__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Salarié', 'FieldName'=>'Salarie__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Département', 'FieldName'=>'Departement__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Projet', 'FieldName'=>'Projet__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Montant opt1', 'FieldName'=>'Montant_option1__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Montant opt2', 'FieldName'=>'Montant_option2__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Montant opt3', 'FieldName'=>'Montant_option3__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Commentaires', 'FieldName'=>'Commentaires__c', 'Required'=>'false', 'Type'=>'String'}
															};
															
		this.upsertKeyFieldName = 'CleUnique__c';
	
		this.importIdField = 'ImportId__c';
		
		this.retPage = new pageReference( '/apex/INNOsubventionList' );
		this.retPage.getParameters().put('id', this.valoId);
		this.retPage.getParameters().put('valoId', this.valoId);
		this.retPage.getParameters().put('tab', 'subvention');
		
		
		Map<String, Id> recordTypes = new Map<String, Id>();
		for(RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = 'INNOsubvention__c' ])
			recordTypes.put(rt.DeveloperName, rt.Id);
			
		
		/*
		*   Initialisation des départements possibles du champ 'Type'
		*/
		List<SelectOption> types = new List<SelectOption>{
															new SelectOption( recordTypes.get('subvention'), 'Subvention'),
															new SelectOption( recordTypes.get('avanceRemboursable'), 'Avance perçue'),
															new SelectOption( recordTypes.get('remboursementAvance'), 'Avance remboursée')
														};
		
		this.picklistValues.put('RecordTypeId', types);	
		
		
	   
		/*
		*   Initialisation des départements possibles du champ 'Salarié'
		*/
		List<SelectOption> salaries = new List<SelectOption>{new SelectOption('', '- Aucun -')};
		for(INNOdepensePersonnel__c salarie : [SELECT Id, Name FROM INNOdepensePersonnel__c WHERE Valorisation__c = :this.valoId ORDER BY Name]){
			salaries.add( new SelectOption(salarie.Id, salarie.Name) );
		}
		
		this.picklistValues.put('Salarie__c', salaries);
		
		
		/*
		*   Initialisation des départements possibles du champ 'Departement'
		*/
		List<SelectOption> departements = new List<SelectOption>{new SelectOption('', '-Aucun-')};
		
		if(valos.size() > 0){
			for(INNOdepartement__c dept : [SELECT Id, Name FROM INNOdepartement__c WHERE Entite__c = :valos[0].Entite__c ORDER BY Name])
			    departements.add(new SelectOption(dept.Id, dept.Name));
		}
		
		this.picklistValues.put('Departement__c', departements);	
	
	
		/*
		*   Initialisation des projets possibles du champ 'Projet'
		*/
		List<SelectOption> projets = new List<SelectOption>{new SelectOption('', '-Aucun-')};
		
		for(INNOprojet__c projet : [SELECT Id, Name FROM INNOprojet__c WHERE Valorisation__c = :this.valoId AND Type__c = 'projet' ORDER BY Name])
			projets.add(new SelectOption(projet.Id, projet.Name));
			
		this.picklistValues.put('Projet__c', projets);
		
		
	}



	
	protected override String getRowUpsertKeyValue(INNOimport.ImportRow row){
		return row.cells[1].value + row.cells[2].value;
	}
	
	

	
	protected override sObject getRecord(ImportRow row){
		sObject record = new INNOsubvention__c(Id = row.existingRecordId, Valorisation__c = this.valoId);
		
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