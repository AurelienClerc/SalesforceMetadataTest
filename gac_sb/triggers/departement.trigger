trigger departement on Account (before insert, before update) {
/*  String code, codeDeptRegion;
  Integer codeInt;
  String RecordTypeIdFrance = '012D0000000i8ar';
  //String RecordTypeIdFrance = '012L000000008h2';
  String Pays = 'france';
    
    Set<String> codesDepts = new Set<String>();
    for (Account a : Trigger.new){
      if( 
      		(a.BillingPostalCode != NULL) && 
      		(a.RecordTypeId == RecordTypeIdFrance) &&
      		(a.BillingCountry != NULL) &&
      		(a.BillingCountry.equalsIgnoreCase(Pays)) 
      	){
        codeDeptRegion = getCodeDeptFromPostalCode(a.BillingPostalCode);
        if(!codesDepts.contains(codeDeptRegion)){
            codesDepts.add(codeDeptRegion);
        }
      }
    }
*/      
    /**
     * Création d'un Map conenant les codes des dept avec leur ID SF
     *
    Map<String, Id> departementsRegions = new Map<String, Id>();
    for( Departements_regions__c codeDept :[
      Select
        Code_d_partement__c,
        Id
      from Departements_regions__c
      Where 
        Code_d_partement__c in :codesDepts
    ]
  ){
    departementsRegions.put(codeDept.Code_d_partement__c, codeDept.Id);
  }
    
    for (Account a : Trigger.new){
      if( 
      		(a.BillingPostalCode != NULL) &&
      		(a.RecordTypeId == RecordTypeIdFrance) &&
      		(a.BillingCountry != NULL) &&
      		(a.BillingCountry.equalsIgnoreCase(Pays))  
      ){
        a.D_partement_r_gion__c = departementsRegions.get(getCodeDeptFromPostalCode(a.BillingPostalCode));
      }else{
        a.D_partement_r_gion__c = NULL;
      }
    }
    
    private String getCodeDeptFromPostalCode ( String postalCode ){
      postalCode = postalCode.trim();
      
    if(postalCode.length() < 5){
        postalCode = '0'+postalCode;
      }
      code = postalCode.substring(0, 2);
      codeInt = Integer.valueOf(code);
      
      if(codeInt >= 97){
        /**
         * DOM - TOM :
         * si les 2 premier chiffres sont '97', il faut prendre les 3 premiers chiffres
         * pour le code du département
         *
         
        code = postalCode.substring(0, 3);
      }else if(codeInt == 20){
        /**
         * Exception pour la corse : 
         * si le code postal < 20200 --> corse du sud (2A), sinon haute corse (2B)
         * SAUF : 20223, et 20900 --> corse du sud
         *
        
        codeInt = Integer.valueOf(postalCode.substring(0, 3));
        set<string> exceptionsCorseSud = new Set<String>{'20223', '20900'};
        
        if( 
          (codeInt < 202) ||
          exceptionsCorseSud.contains(postalCode)
        ){
          code = '2A';
        }else{
          code = '2B';
        }
      }
      
      return code;
    }
    */
}