public with sharing class INNOimport_depensePersonnel extends INNOimport{

	
	private Id valoId;
	
	
	private Map<String, Id> recordTypes;
	
	public Map<Integer, Map<String, String>> importProjectsInfos {get; set;}
	
	private Map<String, Project> projectsInfosByName;
	private Map<String, Id> projectsIdsByName;
	
	private Map<String, INNOpersonnelToProjet__c> importPersonnelToProjets;
	private Set<String> usedPersonnelsProjetKeys = new Set<String>();




	public override void init(Id valoId){
		
		this.valoId = valoId;
		
		this.existingRecordsWhereClause = 'WHERE Valorisation__c = \'' + this.valoId + '\'';
		
		this.importTypeName = 'Dépenses de personnel';
		
		List<INNOvalo__c> valos = [SELECT Id, Name, Entite__c FROM INNOvalo__c WHERE Id = :this.valoId LIMIT 1];
		
		this.pageTitle = valos[0].Name;
				
		this.excelFileName = 'INNO-Imports_salaries.xlsx';

		this.sObjectDescribe = INNOdepensePersonnel__c.SObjectType;
		
		this.standardColumns = new List<Map<String, String>>{ 
															new Map<String, String>{'Name'=>'Nom*', 'FieldName'=>'Nom__c', 'Required'=>'true', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Prénom*', 'FieldName'=>'Prenom__c', 'Required'=>'true', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Matricule', 'FieldName'=>'Matricule__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Actif (oui/non)', 'FieldName'=>'Actif__c', 'Required'=>'false', 'Type'=>'Boolean', 'Default'=>'oui'},
															new Map<String, String>{'Name'=>'Fonction', 'FieldName'=>'Fonction__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Département', 'FieldName'=>'Departement__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Mise à disposition (saisir société d\'appartenance)', 'FieldName'=>'Societe_appartenance__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Organisme de normalisation', 'FieldName'=>'Organisme_normalisation__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Jeune docteur (oui/non)', 'FieldName'=>'JeuneDocteur', 'Required'=>'false', 'Type'=>'Boolean', 'Default'=>'non'},
															new Map<String, String>{'Name'=>'Cadre (oui/non)', 'FieldName'=>'Cadre__c', 'Required'=>'false', 'Type'=>'Boolean', 'Default'=>'non'},
															new Map<String, String>{'Name'=>'Ingénieur/Docteur (oui/non)', 'FieldName'=>'Ingenieur_Docteur__c', 'Required'=>'false', 'Type'=>'Boolean', 'Default'=>'non'},
															new Map<String, String>{'Name'=>'Diplôme', 'FieldName'=>'Diplome__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Statut (Salarié / TNS / Stagiaire / Intérimaire / Apprenti / Thésard / Gérant)', 'FieldName'=>'Statut__c', 'Required'=>'false', 'Type'=>'Picklist'},
															new Map<String, String>{'Name'=>'Date entrée (jj/mm/yyyy)', 'FieldName'=>'Date_entree__c', 'Required'=>'false', 'Type'=>'Date'},
															new Map<String, String>{'Name'=>'Date sortie (jj/mm/yyyy)', 'FieldName'=>'Date_sortie__c', 'Required'=>'false', 'Type'=>'Date'},
															new Map<String, String>{'Name'=>'Commentaires', 'FieldName'=>'Commentaires__c', 'Required'=>'false', 'Type'=>'String'},
															new Map<String, String>{'Name'=>'Salaire brut annuel opt1', 'FieldName'=>'Salaire_brut_annuel_option1__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Salaire brut annuel opt2', 'FieldName'=>'Salaire_brut_annuel_option2__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Salaire brut annuel opt3', 'FieldName'=>'Salaire_brut_annuel_option3__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Intéressement opt1', 'FieldName'=>'Interessement_option1__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Intéressement opt2', 'FieldName'=>'Interessement_option2__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Intéressement opt3', 'FieldName'=>'Interessement_option3__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Participation opt1', 'FieldName'=>'Participation_option1__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Participation opt2', 'FieldName'=>'Participation_option2__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Participation opt3', 'FieldName'=>'Participation_option3__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Salaire chargé opt1', 'FieldName'=>'Salaire_charge_option1__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Salaire chargé opt2', 'FieldName'=>'Salaire_charge_option2__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Salaire chargé opt3', 'FieldName'=>'Salaire_charge_option3__c', 'Required'=>'false', 'Type'=>'Currency'},
															new Map<String, String>{'Name'=>'Total heures/jours travaillées opt1', 'FieldName'=>'Total_heures_travaillees_option1__c', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours travaillées opt2', 'FieldName'=>'Total_heures_travaillees_option2__c', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours travaillées opt3', 'FieldName'=>'Total_heures_travaillees_option3__c', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours PM brevet opt1', 'FieldName'=>'Total_heures_brevetPM_option1', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours PM brevet opt2', 'FieldName'=>'Total_heures_brevetPM_option2', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours PM brevet opt3', 'FieldName'=>'Total_heures_brevetPM_option3', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours veille opt1', 'FieldName'=>'Total_heures_veille_option1', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours veille opt2', 'FieldName'=>'Total_heures_veille_option2', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours veille opt3', 'FieldName'=>'Total_heures_veille_option3', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours normalisation opt1', 'FieldName'=>'Total_heures_normalisation_option1', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours normalisation opt2', 'FieldName'=>'Total_heures_normalisation_option2', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Total heures/jours normalisation opt3', 'FieldName'=>'Total_heures_normalisation_option3', 'Required'=>'false', 'Type'=>'Number'},
															new Map<String, String>{'Name'=>'Unité de temps', 'FieldName'=>'UniteTempsDepensesPersonnel__c', 'Required'=>'true', 'Type'=>'Picklist'}
															};
															
		this.upsertKeyFieldName = 'CleUnique__c';
	
		this.importIdField = 'ImportId__c';
		
		this.retPage = new pageReference( '/apex/INNOdepensePersonnelList' );
		this.retPage.getParameters().put('id', this.valoId);
		this.retPage.getParameters().put('valoId', this.valoId);
		this.retPage.getParameters().put('tab', 'salarie');
		
		
		
		/*
		*	Initialisation des départements possibles du champ 'Departement'
		*/
		
		List<SelectOption> departements = new List<SelectOption>{new SelectOption('', '-Aucun-')};
		
		for(INNOdepartement__c dept : [SELECT Id, Name FROM INNOdepartement__c WHERE Entite__c = :valos[0].Entite__c ORDER BY Name])
			departements.add(new SelectOption(dept.Id, dept.Name));
			
		this.picklistValues.put('Departement__c', departements);
		
		
	}



	public class Project{
		public String projectName;
		public Map<Integer, Integer> optionColumnIndexes = new Map<Integer, Integer>{1 => null, 2 => null, 3 => null};
		public Integer firstColumnIndex;

		public Project(String projectName){
			this.projectName = projectName;
		}
		
		public void setOptionColumnIndex(Integer option, Integer columnIndex){
			this.optionColumnIndexes.put(option, columnIndex);
			if(this.firstColumnIndex == null)
				this.firstColumnIndex = columnIndex;
		}
		
		public String getErrors(){
			String errors = '';
			for(Integer option = 1; option <= 3; option ++){
				if(this.optionColumnIndexes.get(option) == null){
					errors += 'Le projet \'' + this.projectName + '\' n\'a pas de colonne pour l\'option fiscale ' + option + '<br />';
				}
			}
			
			return errors.removeEnd('<br />');
		}
	}


	
	
	
	
	/**
	*	Effectue les vérifications sur les cellules d'en-têtes du fichier
	*/
	public override ImportRow checkImportHeader(String headerRow){
		
		
		ImportRow importRow = new ImportRow(null);
		List<String> headers;
		Integer columnIndex = 0;
		Map<String, Map<Integer, Boolean>> projectsName = new Map<String, Map<Integer, Boolean>>();
		
		if(String.isBlank(headerRow)){
			importRow.nbErrors = 1;
		}
		else{
			
			String errorMessage;
			
			Pattern projectPattern = Pattern.compile('^(.*) opt([1-3]{1}) *$');
			Matcher projectMatcher;
			
			this.importProjectsInfos = new Map<Integer, Map<String, String>>(); 
			this.projectsInfosByName = new Map<String, Project>();
			Project tempProject;
			
			headers = this.getHeaders();
			for(String cellValue : headerRow.split('\t')){
				
				cellValue = cellValue.trim();
				
				if(columnIndex < standardColumns.size()){
					
					if(cellValue != standardColumns.get(columnIndex).get('Name')){
						errorMessage = 'La colonne ' + (columnIndex + 1) + ' (' + cellValue + ') devrait se nommer \'' + standardColumns.get(columnIndex).get('Name') + '\'';
						importRow.nbErrors ++;
					}
					else
						errorMessage = null;
						
					system.debug(errorMessage);
					importRow.addCell(new ImportCell(headers[columnIndex], errorMessage, this.standardColumns.get(columnIndex).get('Required') == 'true'));
				}
				
				else{
					projectMatcher = projectPattern.matcher(cellValue);
					//Si le nom de la colonne match le pattern
					if(projectMatcher.matches() && projectMatcher.hitEnd()){
						
						tempProject = this.projectsInfosByName.get(projectMatcher.group(1));
						if(tempProject == null){
							tempProject = new Project(projectMatcher.group(1));
							this.projectsInfosByName.put(projectMatcher.group(1), tempProject);
						}
						
						tempProject.setOptionColumnIndex(Integer.valueOf(projectMatcher.group(2)), columnIndex);
						
						importRow.addCell(new ImportCell(projectMatcher.group(1) + ' opt ' + projectMatcher.group(2), null, false));
					}
					
					else{
						importRow.addCell(new ImportCell(cellValue, 'Le nom du projet en colonne ' + (columnIndex + 1) + ' (' + cellValue + ') n\'est pas valide, celui-ci doit contenir le nom du projet suivi de l\'option fiscale (opt1, opt2 ou opt3)', false));
					}
				}
				columnIndex ++;
			}
		}
		
		
		
		
		Set<String> existingProjects = new Set<String>();
		for(INNOprojet__c project : [SELECT Id, Name, Type__c FROM INNOprojet__c WHERE Valorisation__c = :this.valoId AND Type__c = 'projet']){
			existingProjects.add(project.Name);
		}
		/**
		*	Verif qu'on a bien les 3 options fiscale par projet
		* 	Vérif que les projets existent bien déjà en base
		*/
		for(Project p : this.projectsInfosByName.values()){
			if(!existingProjects.contains(p.projectName))
				importRow.addError(p.firstColumnIndex, 'Le projet \'' + p.projectName + '\' n\'existe pas, tous les projets présents dans le fichier Excel doivent exister dans l\'application');
				
			importRow.addError(p.firstColumnIndex, p.getErrors());
		}
		
		
		return importRow;
	}
	
	
	
	
	
		
	protected override ImportRow checkImportRow(String row, Integer rowIndex, INNOimport.ImportRow headerRow){
		
		List<String> cells = row.split('\t', headerRow.cells.size());
		
		ImportRow importRow = new ImportRow(rowIndex);

		Integer colIndex = 0;
		Boolean lineIsEmpty = true;
		
		//Boucle sur toutes le colonnes de la ligne
		for(String cellValue : cells){
			
			cellValue = cellValue.trim();
			
			/*
			*	Création de la cellule
			*/
			if(colIndex < this.standardColumns.size())
				importRow.addCell( new ImportCell(cellValue, this.standardColumns.get(colIndex).get('FieldName'), this.standardColumns.get(colIndex).get('Required') == 'true',  this.standardColumns.get(colIndex).get('Type'), this.picklistValues.get(this.standardColumns.get(colIndex).get('FieldName'))) );
			else
				importRow.addCell( new ImportCell(cellValue, headerRow.cells[colIndex].value, false, 'Number', null) );
				
			colIndex ++;
		}
		
		
		
		return importRow;
		
	}
	
	
	
	
	/**
	*	Permet de faire d'éventuels traitements AVANT de lancer les appels à this.getRecord() sur chaque ligne du fichier
	*/
	protected override void beforeLoadRecords(List<ImportRow> rows){
		
		/**
		*	Initialisation de this.recordTYpes
		*/
		this.recordTypes = new Map<String, Id>();
		for(RecordType rt : [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = 'INNOdepensePersonnel__c' ])
			this.recordTypes.put(rt.DeveloperName, rt.Id);
			
		
		Set<Id> existingPersonnelsIds = new Set<Id>();
		for(ImportRow row : rows){
			if(row.existingRecordId != null){
				existingPersonnelsIds.add(row.existingRecordId);
			}
		}
		
		this.importPersonnelToProjets = new Map<String, INNOpersonnelToProjet__c>();
		if(!existingPersonnelsIds.isEmpty()){
			
			for(INNOpersonnelToProjet__c ptp : [SELECT Id, Depense_de_personnel__c, Projet__c, Projet__r.Name, Type_projet__c, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c FROM INNOpersonnelToProjet__c WHERE Depense_de_personnel__c IN :existingPersonnelsIds]){
				this.importPersonnelToProjets.put(ptp.Depense_de_personnel__c + '¤' + (ptp.Type_projet__c == 'projet' ? ptp.Projet__r.Name : ptp.Type_projet__c), ptp);
			}
			
		}
	
		this.projectsIdsByName = new Map<String, Id>();
		for(INNOprojet__c projet : [SELECT Id, Name, Type__c FROM INNOprojet__c WHERE Valorisation__c = :this.valoId])
			this.projectsIdsByName.put((projet.Type__c == 'projet' ? projet.Name : projet.Type__c), projet.Id);
			
	}
	
	
	
	
	
	
	
	protected override sObject getRecord(ImportRow row){
		sObject record = new INNOdepensePersonnel__c(Id = row.existingRecordId, Valorisation__c = this.valoId);
		
		if(row.cells[8].value == 'oui')
			record.put('RecordTypeId', this.recordTypes.get('jeuneDocteur'));
		else if(String.isNotBlank(row.cells[6].value))
			record.put('RecordTypeId', this.recordTypes.get('miseDisposition'));
		else 
			record.put('RecordTypeId', this.recordTypes.get('salarie'));
		
		
		String projectName, option, key;
		INNOpersonnelToProjet__c tempPersonnelToProjet;
		Integer colIndex = 0;
		for(INNOimport.ImportCell cell : row.cells){
			
			
			if(cell.fieldName != null && cell.fieldName.endsWith('__c')){
					
				system.debug(cell.fieldName);
					
				if(cell.datatype == 'Number')
					record.put(cell.fieldName, cell.value == null ? 0 : Decimal.valueOf(cell.value));
				else if(cell.datatype == 'Boolean')
					record.put(cell.fieldName, cell.value == 'oui' ? true : false);
				else if(cell.datatype == 'Date')
					record.put(cell.fieldName, cell.value == null ? null : Date.parse(cell.value));
				else
					record.put(cell.fieldName, cell.value);
					
			}
			
			else if(cell.fieldName != 'JeuneDocteur'){
				
				//Pour les veille/brevetPM/normalisation
				if(colIndex < this.standardColumns.size()){
					projectName = cell.fieldName.substringAfter('Total_heures_').substringBefore('_option');
					option = cell.fieldName.substringAfter('_option');
				}
				//Pour les autres projets
				else{
					projectName = cell.fieldName.substringBefore(' opt ');
					option = cell.fieldName.substringAfter(' opt ');
				}
				
				if(row.existingRecordId == null)
					key = '¤' + row.cells[0].value + row.cells[1].value + row.cells[2].value + '¤' + projectName;
				else
					key = row.existingRecordId + '¤' + projectName;
				
				this.usedPersonnelsProjetKeys.add(key);
				
				tempPersonnelToProjet = this.importPersonnelToProjets.get(key);
				
				if(tempPersonnelToProjet == null){
					tempPersonnelToProjet = new INNOpersonnelToProjet__c(Projet__c = this.projectsIdsByName.get(projectName), Depense_de_personnel__c = row.existingRecordId);
					this.importPersonnelToProjets.put(key, tempPersonnelToProjet);
				}
				
				tempPersonnelToProjet.put('Heures_RD_option' + option + '__c', (cell.value == null ? 0 : Decimal.valueOf(cell.value)));
			}
			colIndex ++;
		}
		
		return record;
	}
	
	
	/**
	*	Permet de faire d'éventuels traitements APRES avoir lancé les appels à this.getRecord() sur chaque ligne du fichier
	*/
	protected override void afterLoadRecords(){
		
		/**
		*	On enleve les elements de this.importPersonnelToProjets qui ne servent a rien (qui n'ont pas été modifiés lors de l'import)
		*/
		for(String key : this.importPersonnelToProjets.keySet()){
			
			if(!this.usedPersonnelsProjetKeys.contains(key))
				this.importPersonnelToProjets.remove(key);
		}
		
	}
	
	
	
	/**
	*	Permet de faire d'éventuels traitements APRES inséré/updaté les records du fichier Excel
	*	ICI ON LA SURCHARGE POUR INSERER/UPDATER LES TEMPS PASSES SUR LES PROJET ('personnelToProjet')
	*/
	protected override void afterExecuteImport(INNOimport.ImportResult importResult, List<sObject> insertRecords, List<sObject> updateRecords){

		
		/**
		*	Boucle sur les personnelToProjet pour remplir les Id de dépense de personnel (Depense_de_personnel__c) pour les insertion de depense de personnel
		*/
		for(String key : this.importPersonnelToProjets.keySet()){

			if(key.startsWith('¤')){
				
				for(sObject record : insertRecords){
					if((String) record.get('Nom__c') + (String) record.get('Prenom__c') + (String) record.get('Matricule__c') == key.substringBetween('¤')){
						if(record.get('Id') != null)
							this.importPersonnelToProjets.get(key).put('Depense_de_personnel__c', (Id) record.get('Id'));
						else
							this.importPersonnelToProjets.remove(key);
					}
				}
			}
		}
		
		List<INNOpersonnelToProjet__c> upsertRecords = new List<INNOpersonnelToProjet__c>();
		List<INNOpersonnelToProjet__c> deleteRecords = new List<INNOpersonnelToProjet__c>();
		
		
		Boolean hasTimes;
		for(INNOpersonnelToProjet__c record : this.importPersonnelToProjets.values()){
			
			hasTimes = (record.get('Heures_RD_option1__c') == null ? 0 : (Decimal) record.get('Heures_RD_option1__c')) + (record.get('Heures_RD_option2__c') == null ? 0 : (Decimal) record.get('Heures_RD_option2__c')) + (record.get('Heures_RD_option3__c') == null ? 0 : (Decimal) record.get('Heures_RD_option3__c')) > 0;
			
			if(hasTimes){
				if(record.get('Id') == null)
					record.put(this.importIdField, importResult.importId);

				upsertRecords.add(record);
			}
			else if(record.get('Id') != null){
				deleteRecords.add(record);
			}
		}
		
		Integer i = 0;
		for(Database.UpsertResult result : Database.upsert(upsertRecords, false)){
			if(!result.isSuccess()){
				importResult.addError(upsertRecords[i].Depense_de_personnel__c, result.getErrors());
			}
			i++;
		}
		
		i = 0;
		for(Database.DeleteResult result : Database.delete(deleteRecords, false)){
			importResult.addError(deleteRecords[i].Depense_de_personnel__c, result.getErrors());
			i++;
		}
		
	}
	
	
	
	
	protected override String getRowUpsertKeyValue(INNOimport.ImportRow row){
		return row.cells[0].value + row.cells[1].value + (String.isBlank(row.cells[2].value) ? '' : row.cells[2].value) + (row.cells[8].value == 'oui' ? 'jeuneDocteur' : (String.isNotBlank(row.cells[6].value) ? 'miseDisposition' : 'salarie'));
	}
	

		
	
	
}