public with sharing class AppNDFsftreeComponentCtrl {
	public List<TreeModel> lsNodeList {get;set;}
    public String sType {get;set;}
    public List<String> lsMois = new List<String> {system.Label.Mois_Janvier,system.Label.Mois_Fevrier,system.Label.Mois_Mars,system.Label.Mois_Avril,system.Label.Mois_Mai,system.Label.Mois_Juin,system.Label.Mois_Juillet,system.Label.Mois_Aout,system.Label.Mois_Septembre,system.Label.Mois_Octobre,system.Label.Mois_Novembre,system.Label.Mois_Decembre};
    public List<String> lsAnnee {get;set;}
    public List<String> lsMoisAnnee = new List<String>();
    
    public AppNDFsftreeComponentCtrl(){
    	
    	this.initLsAnnee();
    	this.initLsMoisAnnee();
    	lsNodeList = new List<TreeModel>();
        
        List<Note_De_Frais_Recap__c> lsNDFrecap = [
        			Select
        				n.Id,
        				n.Name,
        				n.Periode_Label__c,
        				n.Etape__c,
        				n.Date_Debut_De_Periode__c,
        				n.Collaborateur__c 
        			From Note_De_Frais_Recap__c n
        			Where n.OwnerId =: UserInfo.getUserId()];
        			
        
        for(String s : this.lsMoisAnnee){
            TreeModel tm = new TreeModel();
            tm.sId = tm.sName = s;
            for(Note_De_Frais_Recap__c r : lsNDFrecap){
            	if(r.Periode_Label__c == s){
            		TreeModel tmChild = new TreeModel();
	                tmChild.sId = r.Id;
	                tmChild.sName = r.name;
	                tm.children.add(tmChild);
            	}
            }
            	
            lsNodeList.add(tm);
        }
    }
    
    /*
    * on montre 2 années dans le treeview: année et année+1 si on est avant juin (ou en 2013)
    * ou année-1 et année sinon
    */
    public void initLsAnnee(){
    	this.lsAnnee = new List<String>();
		if(Date.today().month() > 6 || Date.today().year() <= 2013){	
			this.lsAnnee.add(string.valueof(Date.today().year()));
			this.lsAnnee.add(string.valueof(Date.today().year()+1));
		}else{
			this.lsAnnee.add(string.valueof(Date.today().year()-1));
			this.lsAnnee.add(string.valueof(Date.today().year()));
		}
    }
    
    public void initLsMoisAnnee(){
    	for(String a : this.lsAnnee){
    		for(String m : this.lsMois){
    			this.lsMoisAnnee.add(m + ' ' + a);
    		}
    	}
    }
    
    public class TreeModel{
        public String sId {get;set;}
        public String sName {get;set;}
        public List<TreeModel> children {get;set;}
        
        public TreeModel(){
            children  = new List<TreeModel>();
        }
    
    }

}