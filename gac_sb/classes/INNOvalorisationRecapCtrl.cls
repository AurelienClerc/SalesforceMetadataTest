public class INNOvalorisationRecapCtrl {
    
    private ApexPages.Standardcontroller stdCtrl;
    public Boolean option1 {get; set;}
    public Boolean option2 {get; set;}
    public Boolean option3 {get; set;}
    public Boolean optionR {get; set;}
    
    public INNOvalorisationRecapCtrl(ApexPages.standardController stdCtrl){
        this.stdCtrl = stdCtrl;
        if(!Test.isRunningTest())
        	this.stdCtrl.addFields(new List<String>{'MissionCIR__r.Annee_CIR__c'});
        this.stdCtrl.getRecord();
        
        this.option1 = ApexPages.currentPage().getParameters().get('option1') != null && ApexPages.currentPage().getParameters().get('option1') == 'true' ? true : false;
        this.option2 = ApexPages.currentPage().getParameters().get('option2') != null && ApexPages.currentPage().getParameters().get('option2') == 'true' ? true : false;
        this.option3 = ApexPages.currentPage().getParameters().get('option3') != null && ApexPages.currentPage().getParameters().get('option3') == 'true' ? true : false;
        this.optionR = ApexPages.currentPage().getParameters().get('optionR') != null && ApexPages.currentPage().getParameters().get('optionR') == 'true' ? true : false;
    }
    
    public PageReference printPDF(){
        
        INNOvalo__c valo = (INNOvalo__c) this.stdCtrl.getRecord();
        
        PageReference retPage = new Pagereference('/apex/INNOvalorisationRecapPDF');
        retPage.getParameters().put('id', valo.Id);
        retPage.getParameters().put('core.apexpages.devmode.url','0');
        retPage.getParameters().put('option1',this.option1 ? 'true' : 'false');
        retPage.getParameters().put('option2',this.option2 ? 'true' : 'false');
        retPage.getParameters().put('option3',this.option3 ? 'true' : 'false');
        retPage.getParameters().put('optionR',this.optionR ? 'true' : 'false');
        retPage.setRedirect(true);
	    return retPage;
    }
    
    /**
    *   Sauvegarde les options fiscales retenues
    */
    public PageReference saveOptionsFiscales(){
        
        INNOvalo__c valo = (INNOvalo__c) this.stdCtrl.getRecord();

        Map<String, String> params = ApexPages.currentPage().getParameters();
            
        for(String key : params.keySet()){
            if(key.startsWith('Option_retenue_')){
                valo.put(key, Integer.valueOf(params.get(key)));
            }
        }
        update valo;
        
         //Hard redirect pour que les formules se mettent à jour (montant total des dépenses option finale)
        PageReference retPage = new Pagereference('/apex/INNOvalorisationRecap');
        retPage.getParameters().put('id', valo.Id);
        retPage.getParameters().put('valoId', valo.Id);
        retPage.setRedirect(true);
        return retPage;
    }

}