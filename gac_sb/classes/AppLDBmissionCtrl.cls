public virtual with sharing class AppLDBmissionCtrl{
    
    //Le controller standard de la mission
    private ApexPages.standardController stdCtrl;

    /**
    *   Constructeur
    */
    public AppLDBmissionCtrl(ApexPages.standardController stdCtrl){
        
        //Permet notamment de vérifier automatiquement que l'utilisateur à bien les droits sur la mission
       stdCtrl.getRecord();
       this.stdCtrl = stdCtrl;
      
    }
    
    public PageReference saveAndReturn(){
    
        try{
			update this.stdCtrl.getRecord();
			PageReference retPage;
	        retPage = new PageReference('/apex/AppLDBmissionView');
	        retPage.getParameters().put('id', this.stdCtrl.getId());
	        retPage.setRedirect(true);
	        return retPage;
        }
		catch(DmlException ex){
			ApexPages.addMessages(ex);
			return null;
		}
    }
    
 
    
}