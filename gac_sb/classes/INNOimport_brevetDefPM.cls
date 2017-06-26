public with sharing class INNOimport_brevetDefPM extends INNOimport{

    
    private Id valoId;
    
    //Clé: le developerName du recordtype, valeur: l'Id du recordType
    private Map<String, Id> recordTypes;
    
    
    public override void init(Id valoId){
		
		this.valoId = valoId;
        
        this.existingRecordsWhereClause = 'WHERE Valorisation__c = \'' + this.valoId + '\' AND (RecordType.DeveloperName = \'brevetPM\' OR RecordType.DeveloperName = \'brevetDef\' )';
        
        this.importTypeName = 'Prises et maintenances / Défenses de brevet';
        
        List<INNOvalo__c> valos = [SELECT Id, Name, Entite__c FROM INNOvalo__c WHERE Id = :this.valoId LIMIT 1];
		
		this.pageTitle = valos[0].Name;
                
        this.excelFileName = 'INNO-Imports_PM_Def_brevets.xlsx';

        this.sObjectDescribe = INNOdepensePrestation__c.SObjectType;
        
        this.standardColumns = new List<Map<String, String>>{ 
                                                            new Map<String, String>{'Name'=>'Prestataire*', 'FieldName'=>'Prestataire__c', 'Required'=>'true', 'Type'=>'String'},
                                                            new Map<String, String>{'Name'=>'Nature prestation', 'FieldName'=>'Nature_prestation__c', 'Required'=>'false', 'Type'=>'String'},
                                                            new Map<String, String>{'Name'=>'Département', 'FieldName'=>'Departement__c', 'Required'=>'false', 'Type'=>'Picklist'},
                                                            new Map<String, String>{'Name'=>'Projet', 'FieldName'=>'Projet__c', 'Required'=>'false', 'Type'=>'Picklist'},
                                                            new Map<String, String>{'Name'=>'N° pièce*', 'FieldName'=>'Num_piece__c', 'Required'=>'true', 'Type'=>'String'},
                                                            new Map<String, String>{'Name'=>'Date pièce', 'FieldName'=>'Date_piece__c', 'Required'=>'false', 'Type'=>'Date'},
                                                            new Map<String, String>{'Name'=>'N° du brevet', 'FieldName'=>'Num_brevet__c', 'Required'=>'false', 'Type'=>'String'},
                                                            new Map<String, String>{'Name'=>'Date de dépôt', 'FieldName'=>'Date_de_depot__c', 'Required'=>'false', 'Type'=>'Date'},
                                                            new Map<String, String>{'Name'=>'Date de délivrance', 'FieldName'=>'Date_delivrance__c', 'Required'=>'false', 'Type'=>'Date'},
                                                            new Map<String, String>{'Name'=>'Défense de brevet (oui /non)', 'FieldName'=>'defenseBrevet', 'Required'=>'false', 'Type'=>'Boolean', 'Default'=>'non'},
                                                            new Map<String, String>{'Name'=>'Montant HT*', 'FieldName'=>'Montant_HT__c', 'Required'=>'true', 'Type'=>'Currency'},
                                                            new Map<String, String>{'Name'=>'Taux R&D opt1', 'FieldName'=>'Taux_option1__c', 'Required'=>'false', 'Type'=>'Percent'},
                                                            new Map<String, String>{'Name'=>'Taux R&D opt2', 'FieldName'=>'Taux_option2__c', 'Required'=>'false', 'Type'=>'Percent'},
                                                            new Map<String, String>{'Name'=>'Taux R&D opt3', 'FieldName'=>'Taux_option3__c', 'Required'=>'false', 'Type'=>'Percent'},
                                                            new Map<String, String>{'Name'=>'Commentaires', 'FieldName'=>'Commentaires__c', 'Required'=>'false', 'Type'=>'String'}
                                                            };
                                                            
        this.upsertKeyFieldName = 'CleUnique__c';
    
        this.importIdField = 'ImportId__c';
        
        this.retPage = new pageReference( '/apex/INNOdepensePrestationList' );
        this.retPage.getParameters().put('id', this.valoId);
        this.retPage.getParameters().put('valoId', this.valoId);
        this.retPage.getParameters().put('tab', 'brevetPM');
        
        
        
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



    /**
    *   Permet de faire d'éventuels traitements AVANT de lancer les appels à this.getRecord() sur chaque ligne du fichier
    */
	protected override void beforeLoadRecords(List<ImportRow> rows){
        
        /**
        *   Initialisation de this.recordTYpes
        */
        this.recordTypes = new Map<String, Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = 'INNOdepensePrestation__c' AND (DeveloperName = 'brevetPM' OR DeveloperName = 'brevetDef' )])
            this.recordTypes.put(rt.DeveloperName, rt.Id);
    
    }
    
    
    
    
	protected override String getRowUpsertKeyValue(INNOimport.ImportRow row){
		return (row.cells[9].value == 'oui' ? 'brevetDef' : 'brevetPM') + row.cells[4].value;
	}
	

	
	protected override sObject getRecord(ImportRow row){
		sObject record = new INNOdepensePrestation__c(Id = row.existingRecordId, Valorisation__c = this.valoId, RecordTypeId = this.recordTypes.get(row.cells[9].value == 'oui' ? 'brevetDef' : 'brevetPM'));
		
		for(INNOimport.ImportCell cell : row.cells){
			
			if(cell.fieldName != 'defenseBrevet'){
				if(cell.datatype == 'Number')
					record.put(cell.fieldName, Decimal.valueOf(cell.value));
				else if(cell.datatype == 'Boolean')
					record.put(cell.fieldName, cell.value == 'oui' ? true : false);
				else if(cell.datatype == 'Date')
					record.put(cell.fieldName, cell.value == null ? null : Date.parse(cell.value));
				else
					record.put(cell.fieldName, cell.value);
			}
				
		}
		
		return record;
	}
	
    
    
}