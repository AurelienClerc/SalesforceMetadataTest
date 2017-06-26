//DIDIER @deprecated 18/02/2014 Ai désactivé le trigger qui était déjà commenté
trigger mintTriggerV2 on Account (before update) {
/*
	// Map contenant les anciennes valeurs des objet du trigger
	Map<Id, Account> oldValuesAccountsMap = getMapOfAccounts(Trigger.old);
	
	Boolean isMintUpdate;
	Boolean isUserUpdate;
	
	List<String> mois = new List<String>{
		'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
	};
	Map<String, Integer> mapMois = new Map<String, Integer>();
	
	// Liste des champs mint à checker pour déterminer si la màj vient de mint
	List<String> fieldsMintToCheck = new List<String>{
		'AnnualRevenue_MINT__c',
		'Code_NAF_2_MINT__c', 
		'Date_de_cloture_fiscale_MINT__c',
		'Effectif_MINT__c',
		'ParentId_MINT__c',
		'Type_d_etablissement_MINT__c' 
	};
	
	// Liste des champs à checker pour déterminer si la màj vient de l'utilisateur
	List<String> fieldsSFToCheck = new List<String>{
		'AnnualRevenue',
		'Code_NAF_2__c', 
		'Date_de_cloture_fiscale__c',
		'Effectif_france__c',
		'Effectif_site__c',
		'ParentId',
		'Type_d_etablissement__c' 
	};
	
	Set<String> parentsAccountsMintBvDIds = new Set<String>();
	Set<String> parentsAccountsIds = new Set<String>();
	Set<String> codesNafMintIds = new Set<String>();
	Set<String> codesNafIds = new Set<String>();
	
	// Initialisation des listes de valeurs qu'on va devoir chercher dans SF
	for(Account a : Trigger.new){
		// Si màj mint
		// Les bvdId du champ ParentId_Mint
		if(!parentsAccountsMintBvDIds.contains(a.ParentId_MINT__c) && (a.ParentId_MINT__c != null)){
			parentsAccountsMintBvDIds.add(a.ParentId_MINT__c);
		}
		
		// Les codes NAF venant de mint
		if(!codesNafMintIds.contains(a.Code_Naf_2_MINT__c) && (a.Code_Naf_2_MINT__c != null)){
			codesNafMintIds.add(a.Code_Naf_2_MINT__c);
		}
		
		// Si màj User
		// Les Id du champ ParentId si principal, et Etablissement_Principal__c si secondaire
		if(isPrincipal(a)){
			if(!parentsAccountsIds.contains(a.ParentId) && (a.ParentId != null)){
				parentsAccountsIds.add(a.ParentId);
			}
		}else{
			if(!parentsAccountsIds.contains(a.Etablissement_Principal__c) && (a.Etablissement_Principal__c != null)){
				parentsAccountsIds.add(a.Etablissement_Principal__c);
			}
		}
		
		// Les codes Naf venant de SF
		if(!codesNafIds.contains(a.Code_Naf_2__c) && (a.Code_Naf_2__c != null)){
			codesNafIds.add(a.Code_Naf_2__c);
		}
		
		Set<String> situationsInactives = new Set<String>{
			// Valeurs provenant de Mint
			'Faillite', 
			'Dissoute', 
			'Dissoute (fusion)', 
			'Dissoute (scission)', 
			'En liquidation', 
			'Inactive (établissement secondaire)', 
			'Inactive (sans précision)',
			
			// Valeurs disponibles dans SF
			'Cessation d\'activité',
			'Inactif',
			'Liquidation',
			'Redressement judiciaire'
		};
		
		if(situationsInactives.contains(a.Situation_juridique__c) && (a.Situation_juridique__c != null)){
			a.Statut_juridique__c = 'Inactif';
		}else{
			a.Statut_juridique__c = 'Actif';
		}
	}
	
	Map<String, String> mapParentsBvdIdsFromMint = getRecordsFromIds( new String[]{'ID_BvD__c', 'Id'}, parentsAccountsMintBvDIds, 'Account', 'ID_BvD__c' );
	Map<String, String> mapParentsIdsFromSF = getRecordsFromIds( new String[]{'Id', 'ID_BvD__c'}, parentsAccountsIds, 'Account', 'Id' );
	Map<String, String> mapCodesNafFromMint = getRecordsFromIds( new String[]{'Code_NAF_2_code__c', 'Id'}, codesNafMintIds, 'Code_Naf_2__c', 'Code_Naf_2_code__c' );
	Map<String, String> mapCodesNafFromSF = getRecordsFromIds( new String[]{'Id', 'Code_NAF_2_code__c'}, codesNafIds, 'Code_Naf_2__c', 'Id' );
		
	for(Account a : Trigger.new){
		isMintUpdate = isUpdate(a, fieldsMintToCheck);
		isUserUpdate = isUpdate(a, fieldsSFToCheck);
				
		if( isUserUpdate ){
			if(a.AnnualRevenue == NULL)
				a.AnnualRevenue_MINT__c = null;
			else
				a.AnnualRevenue_MINT__c = Math.round(a.AnnualRevenue / 1000);
		
			Integer cpt = 0;
			for(String strMois : mois){
				mapMois.put(strMois, cpt);
				cpt = cpt+1;
			}
			
			if(a.Date_de_cloture_fiscale__c == null){
				a.Date_de_cloture_fiscale_MINT__c = null;
			}else{
				List<String> dateTmp = a.Date_de_cloture_fiscale__c.split(' ', 0);
				
				if(dateTmp.size()>1){
					Integer intMois = mapMois.get(dateTmp[1]);
					Integer intJour = integer.valueof(dateTmp[0]);
					if((intMois != null) && (intJour != null)){
						a.Date_de_cloture_fiscale_MINT__c = Date.newInstance(Date.today().year(), intMois+1, intJour);
					}
				}
			}
				
			a.Type_d_etablissement_MINT__c = a.Type_d_etablissement__c;
			
			if(isPrincipal(a)){
				a.ParentId_Mint__c = getValue(mapParentsIdsFromSF, a.ParentId);
				a.Effectif_MINT__c = a.Effectif_France__c;	
			}else{
				a.ParentId_Mint__c = getValue(mapParentsIdsFromSF, a.Etablissement_Principal__c);
				
				if(a.Effectif_site__c == null)
					a.Effectif_MINT__c = null;
				else
					a.Effectif_MINT__c = integer.valueof(a.Effectif_site__c);
			}
			
			a.Code_NAF_2_MINT__c = getValue(mapCodesNafFromSF, a.Code_NAF_2__c);			
		}else{
			if( isMintUpdate ){
				if(a.AnnualRevenue_MINT__c == NULL){
					a.AnnualRevenue = null;
				}else{
					a.AnnualRevenue = Math.round(a.AnnualRevenue_MINT__c) * 1000;				
				}
				
				if(a.Date_de_cloture_fiscale_MINT__c == NULL){
					a.Date_de_cloture_fiscale__c = null;
				}else{
					a.Date_de_cloture_fiscale__c = a.Date_de_cloture_fiscale_MINT__c.day() + ' ' + mois[a.Date_de_cloture_fiscale_MINT__c.month()-1];
				}
				
				
				if(a.Type_d_etablissement_MINT__c == 'Branch location'){
					a.Type_d_etablissement__c = 'Secondaire';
				}else{
					a.Type_d_etablissement__c = 'Principal';
				}
				
				if(isPrincipal(a)){
					a.Etablissement_Principal__c = null;
					a.ParentId = getValue(mapParentsBvdIdsFromMint, a.ParentId_Mint__c);
					a.Effectif_France__c = a.Effectif_MINT__c;
				}else{
					a.Etablissement_Principal__c = getValue(mapParentsBvdIdsFromMint, a.ParentId_Mint__c);
					a.Effectif_site__c = string.valueof(a.Effectif_MINT__c);
				}
				
				if(a.Code_NAF_2_MINT__c == NULL){
					a.Code_NAF_2__c = null;
				}else{
					a.Code_NAF_2__c = getValue(mapCodesNafFromMint, a.Code_NAF_2_MINT__c);
				}
			}
		}
	}
	
	// Methods
	private Map<String, String> getRecordsFromIds ( List<String> fields, Set<String> ids, String objectToMatch, String fieldToMatch){
		Map<String, String> results = new Map<String, String>();
		if(ids.isEmpty()){
			return results;
		}
		
		String soqlquery = 'Select ';
		
		for(String field : fields){
			soqlquery += field + ', ';
		}
		
		soqlquery = soqlquery.substring(0, soqlquery.length()-2);
		soqlquery += ' from ' + objectToMatch;
		soqlquery += ' where ' + fieldToMatch + ' in :ids';
		
		// à améliorer : on doit pouvoir faire du générique ici
		if(objectToMatch == 'Account'){
			List<Account> soqlresults = Database.query(soqlquery);
			for(Account a : soqlresults){
				results.put(String.valueof(a.get(fields[0])), String.valueof(a.get(fields[1])));
			}
		}
			
		if(objectToMatch == 'Code_Naf_2__c'){
			List<Code_Naf_2__c> soqlresults = Database.query(soqlquery);
			for(Code_Naf_2__c a : soqlresults){
				results.put(String.valueof(a.get(fields[0])), String.valueof(a.get(fields[1])));
			}
		}
		
		return results;
	}
*/	
	/**
	 * Indique si le compte est un établissement principal
	 *
	 * Account a : le compte à tester
	 * Retour : true si c'est un EP, false sinon
	 */
	/*private Boolean isPrincipal (Account a){
		return (a.Type_d_etablissement__c == 'Principal');
	}*/
	
	/**
	 * Renvoie la valeur correspondant à une clé dans un Map
	 *
	 * Map<String, String> values : le Map dans lequel rechercher
	 * String key : la clé à chercher
	 * Retour : La valeur associée. si la clé est null ou inexistante dans le Map, alors l valeur renvoyée est null
	 */
	/*private String getValue(Map<String, String> values, String key ){
		if( (key == null) || !values.containsKey(key)){
			return null;
		}
		return values.get(key);
	}*/
	
	/**
	 * Retourne l'ID SF d'un objet à partir de son ID externe
	 * 
	 * Map<String, Id> externalIds : Map contenant les IDs externes associés aux IDs SF
	 * Retour : L'ID SF correspondant à l'ID externe ou null si non trouvé
	 */
	/*private String getIdFromExternalId( Map<String, String> externalIds, String externalIdToSearch ){
		if(!externalIds.containsKey(externalIdToSearch)){
			return null;
		}
		return externalIds.get(externalIdToSearch);
	}*/
	
	/**
	 * Retourne l'ID externe d'un objet à partir de son ID SF
	 * 
	 * Map<Id, String> ids : Map contenant les IDs SF associés aux IDs externes
	 * Retour : L'ID externe correspondant à l'ID SF ou null si non trouvé
	 */
	/*private String getExternalIdFromId( Map<String, String> ids, Id idToSearch ){
		if(!ids.containsKey(idToSearch)){
			return null;
		}
		return ids.get(idToSearch);
	}*/
	
	/**
	 * Détermine si un des champs de la liste a été changé
	 *
	 * Account a : le compte sur lequel on effectue le test de champs
	 * List<String> fields : liste de champs à tester
	 * Retour : Boolean
	 */ 
	/*private Boolean isUpdate ( Account a, List<String> fields ){
		for(String field : fields){
			if(a.get(field) != oldValuesAccountsMap.get(a.Id).get(field)){
				return true;
			}
		}
		return false;
	}*/
	
	/**
	 * Créé un Map Id, Account à partir d'une liste de comptes 
	 * 
	 * List<Account> accountsList : liste de comptes
	 * Retour : Map<Id, Account>
	 */
	/*private Map<Id, Account> getMapOfAccounts( List<Account> accountsList ){
		Map<Id, Account> accountsMap = new Map<Id, Account>();
	
		for(Account account : accountsList) {
			accountsMap.put(account.Id, account);
		}
		
		return accountsMap;
	}*/
}