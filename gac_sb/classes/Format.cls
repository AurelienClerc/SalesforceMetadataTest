public with sharing class Format {

  //La valeur à formater
  public Decimal value {get;set;}
  
  //True si on doit arrondir le résultat, false sinon
  public Boolean round {
      get{
        if(round == null){
          round = false;
        }
        return round;  
      }
      set;}
  
  public Boolean isEnglishLocale{get{return userInfo.getLocale().startsWith('en_');}set;}
  
  //La valeur formaté
  public String formattedValue {
      get{
        if(formattedValue == null){
					
					//Pour rajouter ",00" ou ".00" (en fonction du format) aux nombres sans decimales, car le .format() les supprime
					Boolean add00Decimals = this.value != null && !this.round && this.value.round() == this.value;
					if(add00Decimals)
						this.value += (this.value < 0 ? -0.99 : 0.99);
					
					//Arrondi éventuel et formatage selon la 'locale' de l'utilisateur
					formattedValue = this.value == null ? '' : (this.round ? Math.round(this.value) : this.value).format();
					//Si on a qu'un chiffre après la virgule, on rajoute un 0 pour avoir '123 456,70' au lieu de '123 456,7'
					if(formattedValue.substringAfterLast(',').length() == 1)
						formattedValue += '0';
					
					if(add00Decimals)
						formattedValue = formattedValue.removeEnd('99') + '00';
				}
        return formattedValue;
      }
      set;}
      
      
      
  public static testMethod void testFormat(){
    
    //Pour bien faire il faudrait créer un nouveau user...
    List<User> users = [SELECT Id FROM User WHERE IsActive = true AND UserType = 'Standard' AND LocaleSidKey = 'fr_FR' LIMIT 1];
    
    Format f;
    
    if(!users.isEmpty()){
      system.runAs(users[0]){
        f = new Format();
        f.value = 123456.7;
    
        system.assertEquals('123 456,70', f.formattedValue);  //ATTENTION l'espace entre 123 et 456 est un espace insécable (ALT + 255)
        
        f.formattedValue = null;
        f.round = true;
        system.assert(!f.IsEnglishLocale);
        system.assertEquals('123 457', f.formattedValue);  //ATTENTION l'espace entre 123 et 456 est un espace insécable (ALT + 255)
      }
      
    }
    
  }
  
}