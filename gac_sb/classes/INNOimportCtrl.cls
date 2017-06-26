public with sharing class INNOimportCtrl extends INNOmissionBaseCtrl{

	public static Integer IMPORT_BATCH_SIZE {get; set;}
	
	public INNOimport INNOimport {get; set;}
	
	public Id valoId {get; set;}
	public String tab {get; set;}
	public String importType {get; set;}


	public INNOimportCtrl(){
		
		IMPORT_BATCH_SIZE = 50;
		
		this.valoId = (Id) ApexPages.currentPage().getParameters().get('valoId');
		this.tab = ApexPages.currentPage().getParameters().get('tab');
		
		if(this.tab != null)
			this.tab = String.escapeSingleQuotes(tab);

		if(this.tab == 'brevetPM' || this.tab == 'brevetDef')
			this.importType = 'brevetDefPM';
		else if(this.tab == 'subvention' || this.tab == 'avanceRemboursable' || this.tab == 'remboursementAvance')
			this.importType = 'subventionAvance';
		else if(this.tab == 'salarie' || this.tab == 'jeuneDocteur' ||this.tab == 'miseDisposition')
			this.importType = 'depensePersonnel';	
		else
			this.importType = this.tab;
		
		system.debug(this.tab);
		system.debug(this.importType);
		this.INNOimport = (INNOimport) Type.forName('INNOimport_' + this.importType).newInstance();
		this.INNOimport.init(this.valoId);
		
	}
	
	
	public PageReference rollbackImport(){
		String importId = ApexPages.currentPage().getParameters().get('importId');
		
		if(String.isNotBlank(importId)){
			PageReference retPage = this.INNOimport.rollbackImport(Integer.valueOf(importId));
			retPage.getParameters().put('tab', ApexPages.currentPage().getParameters().get('tab'));
			return retPage;
		}
		return null;
	}
	
	
	public PageReference exitImport(){
		this.INNOimport.retPage.getParameters().put('tab', ApexPages.currentPage().getParameters().get('tab'));
		return this.INNOimport.retPage;
	}
	
	
	private static INNOimport getImportInstance(String importType, Id valoId){
		INNOimport importInst = (INNOimport) Type.forName('INNOimport_' + importType).newInstance();
		importInst.init(valoId);
		return importInst;
	}
	
	
	@RemoteAction
	public static INNOimport.ImportRow checkImportHeader(String importType, Id valoId, String headerRow){
		INNOimport importInst = getImportInstance(importType, valoId);
		
		return importInst.checkImportHeader(headerRow);
	}
	
	
	@RemoteAction
	public static List<INNOimport.ImportRow> checkImportRows(String importType, Id valoId, List<String> rows, Integer rowIndexOffset, INNOimport.ImportRow headerRow){
		INNOimport importInst = getImportInstance(importType, valoId);
		
		return importInst.checkImportRows(rows, rowIndexOffset, headerRow);
	}
	
	
	@RemoteAction
	public static List<INNOimport.ImportRow> reCheckImportRows(String importType, Id valoId, List<INNOimport.ImportRow> rows){
		INNOimport importInst = getImportInstance(importType, valoId);
		
		return importInst.recheckImportRows(rows);
	}
	
	
	@RemoteAction
	public static INNOimport.ImportResult importRows(String importType, Id valoId, Integer importId, List<INNOimport.ImportRow> rows){
		INNOimport importInst = getImportInstance(importType, valoId);
		return importInst.importRows(importId, rows);
	}
	
	
	
	

}