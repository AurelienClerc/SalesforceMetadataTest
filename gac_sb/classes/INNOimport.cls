public abstract with sharing class INNOimport{


	/****************************************************************************************************/
	/*																									*/
	/*									DEBUT DES PARAMETRES SURCHARGEABLES								*/
	/*																									*/
	/****************************************************************************************************/
	
	/**
	*	Le label de l'objet importé (au pluriel)
	*	@example: Salariés
	*/
	public String importTypeName {get; set;}
	
	
	/**
	*	Le titre du header de la page
	*	@example: Vous importez des salariés dans la société 'SYNEFO', vous pouvez mettre 'SYNEFO' dans pageTitle
	*/
	public String pageTitle {get; set;}
	
	
	/**
	*	Le nom du fichier Excel servant de modele à l'import
	*	@warning: Ne doit pas contenir de caractères spéciaux (espaces, accents...)
	*	@warning: Vous devez ajouter le modèle Excel du même nom dans la ressource statique (fichier ZIP) nommé dans la page Visualforce au niveau de la balise <outputLink id="downloadExcelFile" ...>
	*	@example: Import_salaries.xlsx
	*/
	public String excelFileName {get; set;}


	/**
	*	Le sObjectType de l'objet importé
	*	@example: Salarie__c.SObjectType;
	*/
	protected Schema.SObjectType sObjectDescribe;
	
	/**
	*	Les colonnes de votre fichier Excel
	*	Pour chaque colonne, définir une Map du type:
	*		new Map<String, String>{'Name'=>'Nom*', 'FieldName'=>'Nom__c', 'Required'=>'true', 'Type'=>'String'}
	*	Avec Type = String, Boolean, Currency, Percent, Number, Date ou Picklist
	*	Si d'autres formats sont à rajouter, modifier la méthode checkCell() dans la classe interne ImportCell
	*/
	protected List<Map<String, String>> standardColumns;
	
	
	/**
	*	Les valeurs possibles des différentes picklist de l'objet importé
	*	Cette variable est remplie automatiquement pour les champs dont l'attribut 'Type' de this.standardColumns est égal à 'Picklist' 
	*	Vous pouvez cependant remplir certains champs manuellement dans le constructeur de votre format d'import
	*	@key:	Le nom API du champ
	*	@value:	Une liste de selectOption représentant les différentes valeurs possible pour le menu déroulant
	*	@example: Vous avez un champ 'Site géographique' sur le salarié qui est une relation de recherche vers un objet 'Site géographique' rattaché à un compte. 
	*				Normalement le champ site géographique n'est pas une picklist mais vous pouvez decider d'en faire un menu déroulant dans le module d'import en y proposant les différents sites géographique du compte du salarié
	*/
	protected Map<String, List<SelectOption>> picklistValues = new Map<String, List<SelectOption>>();
			
	
	/**
	*	Le nom API du champ servant de clé pour vérifier si une ligne importé existe déjà dans Salesforce, afin de savoir si il faut faire un insert ou un update d'enregistrement
	*	@exemple: 'CleUnique__c'
	*/
	protected String upsertKeyFieldName;
	
	
	/**
	*	L'éventuel nom API du champ (de type Numero sans décimal) de l'objet importé dans lequel on veut ajouter un identifiant d'import qui s'incrémente automatiquement
	*	@exemple: On importe des dizaines de salariés à la fois, ça peut être utile de savoir par la suite quels salariés ont étés importés dans cet import (pour faire un rollback par exemple)
	*				Sur tous ces salariés, on aura donc un champ ImportId = 24 par exemple
	*/
	protected String importIdField;
	
	
	/**
	*	La clause WHERE à rajouter dans la détection des enregistrements déjà existant en base.
	*	@exemple: On importe des salariés sur un compte, on a décidé que la clé d'identification sera le matricule du salarié ( this.upsertKeyFieldName = 'Matricule__c' )
	*				Seulement il est possible que sur un autre compte il y ait un autre salarié qui a le même matricule, il faut donc préciser de faire la cherche de 'doublon' sur les salariés du compte sur lequel on est
	*				On peut donc mettre existingRecordsWhereClause = 'WHERE compteId__c = \'unIdDeCompte\''
	*/
	protected String existingRecordsWhereClause;
	
	
	/**
	*	La page vers laquelle on va rediriger après qu'un import se soit correctement déroulé
	*	On passera à cette page le nombre de lignes correctement importées sous le paramètre 'importSucceedCount' afin d'y ajouter par exemple un message 'X salariés ont été correctements importés'
	*/
	public PageReference retPage;
	
	
	
	/**
	*	ON PEUT EGALEMENT SURCHARGER LES METHODES:
	*	getHeaders()
	* 	checkImportHeader()
	* 	checkImportRow()
	* 	rollbackImport()
	*/
	
	/****************************************************************************************************/
	/*																									*/
	/*									FIN DES PARAMETRES SURCHARGEABLES								*/
	/*																									*/
	/****************************************************************************************************/
	
	
	

	/**
	 * 	Sert de constructeur car on ne peut pas passer de paramètres en instanciant une classe avec Type.forName('XXX').newInstance();
	 */
	public abstract void init(Id parentId);
	
	
	/**
	 * 	Retourne la "clé unique" de la ligne passée en paramètre
	 * 	@param ImportRow row: Wrapper d'ImportRow de la ligne
	 * 	@return String: La clé unique de cette ligne (correspondant au champ this.upsertKeyFieldName)
	 *	@exemple si on importe des users avec les colonnes suivantes:
	 * 			Nom Email Matricule Telephone
	 * 		Et qu'on veut utiliser le couple Email/Matricule comme clé unique
	 * 		Alors la méthode doit retourner : row.cells[1].value + row.cells[2].value;
	 */
	protected abstract String getRowUpsertKeyValue(ImportRow row);
	
	
	/**
	*	On lui passe un ImportRow d'ImportRow correspondant à une ligne du fichier Excel et retourne un sObject pret à être inseré/updaté
	*	Est appelé pour chaque ligne du fichier
	*	DOIT ETRE surchargé pour préparer correctement le record
	*/
	protected abstract sObject getRecord(ImportRow row);
	

	
	
	
	/**
	*	Retourne une liste avec les différents nom de chaque colonne du fichier Excel
	*/
	protected virtual String[] getHeaders(){
		String[] headers = new List<String>();
		
		for(Map<String, String> col : standardColumns){
			headers.add(col.get('Name').substringBeforeLast('('));
		}
			
		return headers;
	}	
	
	
	
	
	/**
	*	Effectue les vérifications sur les cellules d'en-têtes du fichier
	*	@param String headerRow: Première ligne du fichier importé
	* 	@return ImportRow: Wrapper d'ImportRow
	*/
	public virtual ImportRow checkImportHeader(String headerRow){
		
		ImportRow importRow = new ImportRow(null);
		
		if(String.isBlank(headerRow)){
			importRow.nbErrors = 1;
		}
		else{
		
			Integer columnIndex = 0;
			String errorMessage;
			
			List<String> headers = this.getHeaders();
			for(String cellValue : headerRow.split('\t')){
				
				cellValue = cellValue.trim();
				
				if(columnIndex < standardColumns.size()){
					
					if(cellValue != standardColumns.get(columnIndex).get('Name'))
						errorMessage = 'La colonne ' + (columnIndex + 1) + ' (' + cellValue + ') devrait se nommer \'' + standardColumns.get(columnIndex).get('Name') + '\'';
					else
						errorMessage = null;
						
					importRow.addCell(new ImportCell(headers[columnIndex], errorMessage, this.standardColumns.get(columnIndex).get('Required') == 'true'));
				}
				
				columnIndex ++;
			}
		}
		
		return importRow;
	}
	
	
	
	
	/**
	 *	Vérifie plusieurs lignes du fichier
	 *	@param List<String> rows: Liste des lignes sous forme de String
	 * 	@param Integer rowIndexOffset: L'Offset de la première ligne envoyée par rapport à toutes les lignes (Exemple si on importe 70 lignes avec un Batch size de 50: rowIndexOffset sera à 0 pour le premier Chunk puis 50 pour le 2eme)
	 * 	@param ImportRow headerRow: La ligne d'header de l'import telle que retournée par checkImportHeader()
	 *	@return List<ImportRow>: Liste de Wrapper d'ImportRow
	 */
	public List<ImportRow> checkImportRows(List<String> rows, Integer rowIndexOffset, ImportRow headerRow){
		this.initStandardPicklistValues();
		
		List<ImportRow> importRows = new List<ImportRow>();
		
		for(String row : rows){
			if(String.isNotBlank(row)){
				importRows.add(this.checkImportRow(row, rowIndexOffset, headerRow));
				rowIndexOffset ++;
			}
		}
		
		this.checkExistingRecords(importRows);
		
		return importRows;
	}
	
	
	
	
	/**
	 *	Vérifie une ligne du fichier
	 *	@param String row: Ligne à importer sous forme de String
	 * 	@param Integer rowIndex: L'index de la ligne (commence à 0)
	 * 	@param ImportRow headerRow: La ligne d'header de l'import telle que retournée par checkImportHeader()
	 *	@return ImportRow: Le Wrapper d'ImportRow
	 */
	protected virtual ImportRow checkImportRow(String row, Integer rowIndex, ImportRow headerRow){
		
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
			importRow.addCell( new ImportCell(cellValue, this.standardColumns.get(colIndex).get('FieldName'), this.standardColumns.get(colIndex).get('Required') == 'true',  this.standardColumns.get(colIndex).get('Type'), this.picklistValues.get(this.standardColumns.get(colIndex).get('FieldName'))) );

				
			colIndex ++;
		}
		
		return importRow;
		
	}
	
	
	
	
	/**
	 *	Revérifie plusieurs lignes du fichier
	 *	@param List<ImportRow> rows: Liste de Wrapper d'ImportRow retournée lors du premier appel à checkImportRows()
	 *	@return List<ImportRow>: Liste de Wrapper d'ImportRow
	 */
	public List<ImportRow> recheckImportRows(List<ImportRow> rows){
		this.initStandardPicklistValues();
		
		for(ImportRow row : rows){
			row.recheckRow();
		}
		
		this.checkExistingRecords(rows);
		
		return rows;
	}




	/**
	 * 	Vérifie l'existance des lignes à importer en base (pour savoir si on va faire un insert ou un update: on remplira l'attribut existingRecordId du Wrapper d'ImportRow en cas d'update)
	 * 	@param List<ImportRow> rows: Liste de Wrapper d'ImportRow
	 */
	private void checkExistingRecords(List<ImportRow> rows){
		
		List<String> upsertKeys = new List<String>();
		for(ImportRow row : rows){
			row.upsertKey = this.getRowUpsertKeyValue(row);
			upsertKeys.add(row.upsertKey);
		}
		
		
		//Création de la requete de récupération des records existants 
		String req = 'SELECT Id, ' + this.upsertKeyFieldName + ' FROM ' + this.sObjectDescribe.getDescribe().getName() + ' ' + this.existingRecordsWhereClause
					+ (String.isBlank(this.existingRecordsWhereClause) ? 'WHERE ' : ' AND ') + this.upsertKeyFieldName + ' IN :upsertKeys';
		
		
		/**
		 * Création d'une map avec pour chaque record existant :
		 * 	- clé : Valeur du champ d'upsert du record existant
		 *  - valeur: Id du record existant
		 */
		Map<String, Id> existingRecordIdByUpsertKey = new Map<String, Id>();
		
		for(sObject so : Database.query(req)){
			existingRecordIdByUpsertKey.put(String.valueOf(so.get(this.upsertKeyFieldName)), String.valueOf(so.get('Id')));
		}
		
		for(ImportRow row : rows){
			row.existingRecordId = existingRecordIdByUpsertKey.get(row.upsertKey);
		}
	}
	
	
	
	
	/**
	*	Execute l'import des données, ajoute ou update les enregistrements en base
	* 	@param Integer importId: Id de l'import
	* 	@param List<ImportRow> rows: Liste de Wrapper d'ImportRow à importer
	* 	@return ImportResult: Wrapper d'ImportResult
	*/
	public ImportResult importRows(Integer importId, List<ImportRow> rows){
		

		if(importId == null){
			//Récupère l'id d'import
			importId = 0;
			List<sObject> lastImport = Database.query('SELECT Id, ' + this.importIdField + ' FROM ' + this.sObjectDescribe.getDescribe().getName() + ' WHERE ' + this.importIdField + ' != null ORDER BY ' + this.importIdField + ' DESC LIMIT 1');
			if(lastImport.size() > 0)
				importId = Integer.valueOf(lastImport[0].get(this.importIdField)) + 1;
		}
		
		ImportResult result = new ImportResult(importId);
		
		this.beforeLoadRecords(rows);

		/**
		*	On ne peut pas faire d'upsert sur des sObject générique, donc on sépare les inserts des updates
		*/
		List<sObject> insertRecords = new List<sObject>();
		List<sObject> updateRecords = new List<sObject>();
		List<Integer> insertRowIndexes = new List<Integer>();
		List<Integer> updateRowIndexes = new List<Integer>();
		
		sObject record;
		for(ImportRow row : rows){
			record = this.getRecord(row);
			
			if(record.get('Id') == null){
				record.put(this.importIdField, importId);
				insertRecords.add(record);
				insertRowIndexes.add(row.rowIndex);
			}
			else{
				updateRecords.add(record);
				updateRowIndexes.add(row.rowIndex);
			}
			
		}
		
		this.afterLoadRecords();
		
		try{
			result.addResults(Database.update(updateRecords, false), updateRowIndexes);
			result.addResults(Database.insert(insertRecords, false), insertRowIndexes);
		}
		catch(Exception e){
			result.exceptionMessage = e.getMessage();
		}
		
		this.afterExecuteImport(result, insertRecords, updateRecords);
		
		return result;
		
	}
	



	/**
	 * 	Annule un import
	 * 	@param Integer importId: Id de l'import à annuler
	 */
	public virtual PageReference rollbackImport(Integer importId){
		delete Database.query('SELECT Id FROM ' + this.sObjectDescribe.getDescribe().getName() + ' WHERE ' + this.importIdField + ' = ' + importId + ' AND CreatedById = \'' + UserInfo.getUserId() + '\'');
		return this.retPage;
	}	
	
	
	
	
	/**
	*	Initialise les valeurs possibles des picklist pour les différents champs 'Picklist' de this.standardColumns
	*/
	private void initStandardPicklistValues(){
		
		
		Map<String, Schema.SObjectField> fieldDescribe = this.sObjectDescribe.getDescribe().fields.getMap();
		
		List<SelectOption> tempPicklistValues;
		
		for(Map<String, String> fieldInfos : this.standardColumns){
			if( ! this.picklistValues.containsKey(fieldInfos.get('FieldName')) && fieldInfos.get('Type') == 'Picklist'){
				
				tempPicklistValues = new List<SelectOption>();
				if( fieldInfos.get('Required') == 'false' )
					tempPicklistValues.add(new SelectOption('', '-Aucun-'));
						
				for(Schema.PicklistEntry picklistEntry : fieldDescribe.get(fieldInfos.get('FieldName')).getDescribe().getPicklistValues()) {
					tempPicklistValues.add(new SelectOption(picklistEntry.getValue(), picklistEntry.getLabel()));
				}
				
				this.picklistValues.put(fieldInfos.get('FieldName'), tempPicklistValues);
			}
		}
	}
	
	

	
	/**
	*	Permet de faire d'éventuels traitements AVANT de lancer les appels à this.getRecord() sur chaque ligne du fichier
	*/
	protected virtual void beforeLoadRecords(List<ImportRow> rows){}
	
	
	
	
	/**
	*	Permet de faire d'éventuels traitements APRES avoir lancé les appels à this.getRecord() sur chaque ligne du fichier
	*/
	protected virtual void afterLoadRecords(){}
	
	
	
	
	/**
	*	Permet de faire d'éventuels traitements APRES inséré/updaté les records du fichier Excel
	*/
	protected virtual void afterExecuteImport(ImportResult importResult, List<sObject> insertRecords, List<sObject> updateRecords){}

	
	

	


	/****************************************************************************************************/
	/*																									*/
	/*											WRAPPER CLASSES											*/
	/*																									*/
	/****************************************************************************************************/
	
	
	
	/**
	 * Ligne du fichier
	 * 
	 */
	public class ImportRow{
		
		public Integer rowIndex {get; set;}
		
		public List<ImportCell> cells {get; set;}
		
		public Integer nbErrors {get; set;}
		
		public String upsertKey {get; set;}
		
		public Id existingRecordId {get; set;}
		
		
		public ImportRow(Integer rowIndex){
			this.rowIndex = rowIndex;
			this.cells = new List<ImportCell>();
			this.nbErrors = 0;
		}
		
		public void addCell(ImportCell cell){
			
			this.cells.add(cell);
			if(cell.hasError)
				this.nbErrors ++;
		}
		
		public void addError(Integer cellIndex, String errorMsg){
			if(String.isNotBlank(errorMsg)){
				this.cells[cellIndex].addError(errorMsg);
				this.nbErrors ++;
			}
		}
		
		public void recheckRow(){
			
			for(ImportCell cell : this.cells){
				if(cell.hasError){
					cell.checkCell();
					if(!cell.hasError)
						this.nbErrors --;
				}
			}
		}
		
	}
	
	
	
	
	
	
	
	/**
	 * Cellule d'une ligne du fichier
	 * 
	 */
	public class ImportCell{
		
		//Le nom du champ correspondant
		public String fieldName {get;set;}
		
		//La valeur contenue dans la cellule à enregistrer en base
		public String value {get;set;}
		
		//La valeur contenue dans la cellule à afficher à l'écran
		public String printValue {get;set;}
		
		//Si il y a une erreur dans la cellule
		public Boolean hasError {get;set;}
		
		//Le message d'erreur si il y a une erreur
		public String errorMessage {get; set;}
		
		//Si il y a une erreur sur un champ picklist, on y met les valeurs de la picklist possibles
		public List<ImportCellPicklistValue> picklistValues {get; set;}
		
		//Le type de donnée de la cellule
		public String datatype;
		
		//Est ce que la cellule doit obligatoirement contenir une valeur
		private Boolean required;
		

		//Constructeur
		public ImportCell(String val, String fieldName, Boolean required, String dataType, SelectOption[] picklistValues){
			this.fieldName = fieldName;
			this.value = val;
			this.required = required;
			this.datatype = datatype;
			
			if(picklistValues != null){
				this.picklistValues = new List<ImportCellPicklistValue>();
				for(SelectOption opt : picklistValues){
					if(!opt.getDisabled())
						this.picklistValues.add(new ImportCellPicklistValue(opt.getValue(), opt.getLabel()));
				}
			}
			
			//Vérification de la valeur de la cellule
			this.checkCell();
			
		}
		
		//Constructeur pour les cellules du header
		public ImportCell(String val, String errorMessage, Boolean required){
			this.value = val;
			this.errorMessage = errorMessage;
			this.hasError = String.isNotBlank(errorMessage);
			this.required = required;
		}
		
		
		public void addError(String errorMsg){
			this.errorMessage = (String.isBlank(this.errorMessage) ? errorMsg : this.errorMessage + '<br />' + errorMsg);
			this.hasError = true;
		}
		
		
		/**
		*	Vérifie le contenu d'une cellule:
		*	Check qu'il y a une valeur dans les colonne required
		*	Check le type de la valeur de la cellule (Date, nombre, boolean, etc.)
		*	Met a jour les propriétés de la cellule selon les vérification précédante (hasError, message, picklistValues)
		*/
		public void checkCell(){
			//Pour savoir si la methode est appelé suite à un re-check ou pas
			Boolean isReCheck = (this.hasError == true);
			
			this.hasError = false;
			this.errorMessage = '';

			if(String.isBlank(this.value))
				this.value = null;
			//String
			else if(this.datatype == 'String'){
				
			}
			//Boolean
			else if(this.datatype == 'Boolean'){
				this.value = this.value.toLowerCase();
				
				if(this.value != 'oui' && this.value != 'non'){
					//this.value = null;
					this.hasError = true;
					this.errorMessage += 'Valeurs autorisées: "oui" ou "non" ';
					this.picklistValues = new List<ImportCellPicklistValue>();
					//On ajoute la valeur '-Aucun-' que si le champ n'est pas obligatoire
					if( ! this.required ){
						this.picklistValues.add(new ImportCellPicklistValue('', '-Aucun-'));
						this.value = this.printValue = null;
					}
					else{
						this.value = 'oui';
						this.printValue = 'oui';
					}
					this.picklistValues.add(new ImportCellPicklistValue('oui', 'oui'));
					this.picklistValues.add(new ImportCellPicklistValue('non', 'non'));
				}
			}
			//Currency
			else if(this.datatype == 'Currency'){
				this.value = this.value.replace('€', '');
				this.datatype = 'Number';
				this.checkCell();
			}
			//Percent
			else if(this.datatype == 'Percent'){
				this.value = this.value.replace('%', '').trim();
				this.datatype = 'Number';
				this.checkCell();
				
				//On vérifie en plus que le nombre et entre à et 100
				if(!this.hasError && (decimal.valueOf(this.value) < 0 || decimal.valueOf(this.value) > 100) ){
					this.hasError = true;
					this.errorMessage += 'La valeur doit être comprise entre 0 et 100 ';
				}
			}
			//Number	
			else if(this.datatype == 'Number'){
				this.value = this.value.replace(' ', '').replace(',', '.');
				try{
					this.value = String.valueOf(decimal.valueOf(this.value));
				}catch (System.TypeException e){
					this.hasError = true;
					this.errorMessage += 'Valeur incorrecte ';
				}
			}
			//Date
			else if(this.datatype == 'date'){
				
				try{
					date.parse(this.value);
				}catch (System.TypeException e){
					this.hasError = true;
					this.errorMessage += 'Le format doit être jj/mm/aaaa ';
				}
			}
			//Picklists
			else if(this.datatype == 'Picklist'){
				
					
				Boolean valueInPicklist = false;
				for( ImportCellPicklistValue opt : this.picklistValues){
					if( opt.checkValue(this.value, isReCheck)){
						this.value = opt.value;
						this.printValue = opt.label;
						valueInPicklist = true;
					}
				}
						
				if( ! valueInPicklist ){
					this.hasError = true;
					this.errorMessage += 'La valeur "' + this.value + '" n\'est pas autorisée ';
					//this.value = null;
					if(this.required){
						this.value = this.picklistValues[0].value;
						this.printValue = this.picklistValues[0].label;
					}
					else{
						this.value = this.printValue = null;
					}
				}
				
				
			}
			
			if(required && this.value == null){
				this.hasError = true;
				this.errorMessage = 'Valeur obligatoire';
				
				if(this.datatype == 'Picklist'){
					this.value = this.picklistValues[0].value;
					this.printValue = this.picklistValues[0].label;
				}
				else if(this.datatype == 'Boolean'){
					this.value = 'oui';
					this.printValue = 'oui';
				}
			}
		}
	}
	
	
	
	
	
	
	/**
	 * Valeur de picklist
	 * 
	 */
	public class ImportCellPicklistValue{
		public String value {get; set;}
		public String label {get; set;}
		
		public ImportCellPicklistValue(String value, String label){
			this.value = value;
			this.label = label;
		}
		
		public Boolean checkValue(String value, Boolean isRecheck){
			return (isRecheck ? this.value == value : this.label == value);
		}
	}
	
	
	
	
	
	
	/**
	 * Résultat d'import de plusieurs lignes du tableau
	 * 
	 */
	public class ImportResult{
		public Integer importId {get; set;}
		public List<DmlResult> results {get; set;}
		public String exceptionMessage {get; set;}
		
		public ImportResult(Integer importId){
			this.importId = importId;
			this.results = new List<DmlResult>();
		}
		
		public void addResults(List<Database.Saveresult> results, List<Integer> rowIndexes){
			Integer i = 0;
			for(Database.Saveresult result : results){
				this.results.add(new DmlResult(result, rowIndexes[i]));
				i++;
			}
		}
		
		public void addError(Id recordId, List<Database.Error> errors){
			for(DmlResult result : this.results){
				if(result.recordId == recordId){
					result.success = false;
					for(Database.Error err : errors){
						result.errors += err.getMessage() + '\n';
					}
				}
			}
		}
		
	}
	
	
	
	
	
	
	/**
	 * Résultat d'import d'une ligne
	 * 
	 */
	public class DmlResult{
		public Id recordId {get; set;}
		public Integer rowIndex {get; set;}
		public Boolean success {get; set;}
		public String errors {get; set;}
		
		
		public DmlResult(Database.Saveresult result, Integer rowIndex){
			this.recordId = result.getId();
			this.rowIndex = rowIndex;
			this.success = result.isSuccess();
			this.errors = '';
			for(Database.Error err : result.getErrors()){
				this.errors += err.getMessage() + '\n';
			} 
		}
		
	}
}