/**
*	Controller de la page INNOprojetView et INNOprojetEdit
*/
public with sharing class INNOprojetCtrl extends INNOmissionBaseCtrl{

	private ApexPages.standardController stdCtrl;

	public Integer nbPrestataires {get; set;}
	public Integer nbSubventions {get; set;}
	public Integer nbAvancesRemboursables {get; set;}
		
		
	/*
	*	On a absolument besoin du parametre valoId (dans l'extension INNOmissionBaseCtrl notamment), donc on l'ajoute si on ne l'a pas
	*/
	public PageReference checkParams(){
		PageReference retPage;
		
        if( this.stdCtrl.getId() != null && ApexPages.currentPage().getParameters().get('valoId') == null){
        	retPage = new PageReference('/apex/INNOprojetView');
	        retPage.getParameters().put('id', this.stdCtrl.getId());
	        retPage.getParameters().put('valoId', this.valoId);
	        retPage.setRedirect(true);
        	return retPage;
        }
        
        //Redirige vers la liste des projets si on veux voir la page d'un "faux projet" (veille, normalisation, brevetPM)
        if(this.stdCtrl.getRecord().get('Type__c') != 'projet'){
        	retPage = new PageReference('/apex/INNOprojetList');
	        retPage.getParameters().put('id', this.valoId);
	        retPage.getParameters().put('valoId', this.valoId);
	        retPage.setRedirect(true);
        	return retPage;
        }
        return null;
    }
		
		
	public INNOprojetCtrl(ApexPages.standardController stdCtrl){
		this.stdCtrl = stdCtrl;
		
		INNOprojet__c projet = (INNOprojet__c) this.stdCtrl.getRecord();
		
		//En edition
		if( ApexPages.currentPage().getUrl().startsWith('/apex/INNOprojetEdit') ){
			
			if(projet.Id == null)
				projet.Valorisation__c = this.valoId;

			
			this.initDepartements();
		}
		
		else{
			//Calcul du nombre de prestataires
			this.nbPrestataires = [SELECT COUNT() FROM INNOdepensePrestation__c WHERE Valorisation__c = :this.valoId AND RecordType.DeveloperName = 'prestataire' AND Projet__c = :projet.Id];
			
			this.nbSubventions = this.nbAvancesRemboursables = 0;
			
			//Calcul du nombre de subventions et d'avances remboursables
			for(AggregateResult aggr : [SELECT COUNT(Id) nb, RecordType.DeveloperName FROM INNOsubvention__c WHERE Valorisation__c = :this.valoId AND (RecordType.DeveloperName = 'subvention' OR RecordType.DeveloperName = 'avanceRemboursable') AND Projet__c = :projet.Id GROUP BY RecordType.DeveloperName]){
				if(aggr.get('DeveloperName') == 'subvention')
					this.nbSubventions = (Integer) aggr.get('nb');
				else if(aggr.get('DeveloperName') == 'avanceRemboursable')
					this.nbAvancesRemboursables = (Integer) aggr.get('nb');
			}
		}
		
		
		
	}
	
	
	public PageReference save(){
	
		this.stdCtrl.save();
		
		PageReference retPage = new PageReference('/apex/INNOprojetView');
		retPage.getParameters().put('id', this.stdCtrl.getId());
		retPage.getParameters().put('valoId', this.valoId);
		retPage.setRedirect(true);
		
		return retPage;
	}
	
	
	
	/**
	*	Supprime un projet et redirige vers la page de liste des projets
	*/
	public PageReference deleteAndRedirect(){
		Database.delete(this.stdCtrl.getId());
		
		PageReference retPage = new pageReference( '/apex/INNOprojetList' );
		retPage.getParameters().put('valoId', this.valoId);
		retPage.setRedirect(true);
		return retPage; 
	}
	
	
	
	
	
	
}