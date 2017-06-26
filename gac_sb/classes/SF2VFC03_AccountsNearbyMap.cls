public class SF2VFC03_AccountsNearbyMap {

	private Account acc;
	
	//Filtres
	public List<SelectOption> filterTypeCyblageValues {get; set;}
	
	public Integer filterSelectedRadius {get; set;}
	public String filterSelectedAccountStatus {get; set;}
	public String filterSelectedCodeNaf {get; set;}
	public String filterSelectedTypeCyblage {get; set;}
	public String filterSelectedValueCyblage {get; set;}
	
	
	public transient List<Account> nearbyAccounts {get; set;}
	public transient String nearbyAccountsJSON {get; set;}
	
	
	public SF2VFC03_AccountsNearbyMap(ApexPages.standardController stdCtrl){
		this.acc = (Account) stdCtrl.getRecord();
		
		
		/**
		 * Initialisation des filtres
		 */
		this.filterSelectedRadius = 10;
		
		this.filterTypeCyblageValues = new List<SelectOption>{new SelectOption('', '-- Aucun --')};
		for(Schema.PicklistEntry ple : Code_NAF_2__c.ACS_defaultCiblage__c.getDescribe().getPicklistValues())
			this.filterTypeCyblageValues.add( new SelectOption(ple.getValue(), ple.getLabel()) );
		
		//Recherche des comptes à proximité
		this.searchNearbyAccounts();
	}
	
	
	/**
	 * Recherche les compte à proximité du compte actuel en appliquant les filtres de recherche
	 * 
	 */
	public void searchNearbyAccounts(){
		
		if(this.acc.BillingCoordinates__latitude__s == null || this.acc.BillingCoordinates__longitude__s == null){
			acc.addError('Ce compte n\'a pas été géolocalisé');
			return;
		}
		
		String query = 'SELECT Id, Name, Etat_du_compte__c, Code_NAF_2__r.Name, BillingCoordinates__latitude__s, BillingCoordinates__longitude__s FROM Account WHERE Id = \'' + this.acc.Id + '\' OR (DISTANCE(BillingCoordinates__c, GEOLOCATION(' + this.acc.BillingCoordinates__latitude__s + ', ' + this.acc.BillingCoordinates__longitude__s + '), \'km\') < ' + this.filterSelectedRadius;
		
		//Filtre Etat du compte
		if(String.isNotBlank(this.filterSelectedAccountStatus))
			query += ' AND Etat_du_compte__c = \'' + this.filterSelectedAccountStatus + '\'';
		
		
		//Filtre Code NAF
		if(String.isNotBlank(this.filterSelectedCodeNaf))
			query += ' AND Code_NAF_2__r.Name LIKE \'%' + this.filterSelectedCodeNaf + '%\'';
		
		//Filtre Cyblage
		if(String.isNotBlank(this.filterSelectedTypeCyblage) && String.isNotBlank(this.filterSelectedValueCyblage)){
			query += ' AND ' + this.filterSelectedTypeCyblage + '_Ciblage_NAF__c = \'' + filterSelectedValueCyblage + '\'';
		}
		
		query += ') ORDER BY Name LIMIT 1000';
			
		this.nearbyAccounts = Database.query(query);
		this.nearbyAccountsJSON = JSON.serialize(this.nearbyAccounts);
	}
}