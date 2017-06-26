public without sharing class INNOequipeConsultingWithoutSharingCtrl extends INNOmissionBaseCtrl{

	private INNOequipeConsulting__c membre;
	
	
	public Boolean isNew {get; set;}
	
	// public AppCIRmission__c mission {get; set;}
	
	//Le role qu'avait le membre avant la modification (dans le cas d'un update uniquement)
	private String previousRole = null;
	// private String previousUser = null;
	
	public Boolean erreurTempsTheorique {get; set;}
	
	
	
	public INNOequipeConsultingWithoutSharingCtrl(ApexPages.standardController stdCtrl){
		
		this.membre = (INNOequipeConsulting__c) stdCtrl.getRecord();
		
		this.isNew = (this.membre.Id == null);
		
		this.erreurTempsTheorique = false;
		
		if(this.isNew)
			this.membre.MissionCIR__c = ApexPages.currentPage().getParameters().get('missionId');
		else{
			this.previousRole = this.membre.Role__c;
		}
		
		this.mission = [SELECT Id, OwnerId, recordType.DeveloperName, TempsTheoriquePlafond__c FROM INNOmission__c WHERE Id = :this.membre.MissionCIR__c LIMIT 1][0];
	}
	
	
	
	public pageReference saveAndRedirect(){
		
		
		
		//Si le role d'avant était superviseur/manager et qu'il ne l'est plus, il faut vérifier qu'il reste encore au moins 1 superviseur/manager sur la mission
		if( !this.isNew && (this.previousRole == 'Superviseur' || this.previousRole == 'Superviseur/Consultant' || this.previousRole == 'Manager') && (this.membre.Role__c != 'Superviseur' && this.membre.Role__c != 'Superviseur/Consultant' && this.membre.Role__c != 'Manager')){
			//si il n'y a pas d'autres superviseur/manager sur la mission => erreur
			if([SELECT Id FROM INNOequipeConsulting__c WHERE MissionCIR__c = :this.mission.Id
														AND (Role__c = 'Superviseur' OR Role__c = 'Superviseur/Consultant' OR Role__c = 'Manager')
														AND Id != :this.membre.Id].size() == 0){
				this.membre.Role__c.addError('Il doit rester au moins 1 superviseur ou manager sur la mission');
				return null;
			}
		}
		
		//Si on essai d'inserer un membre qui est deja membre de l'equipe consulting de la mission => erreur
		if(this.isNew && [SELECT Id FROM INNOequipeConsulting__c WHERE MissionCIR__c = :this.mission.Id
																	AND Utilisateur__c = :this.membre.Utilisateur__c].size() > 0){
			
			this.membre.Utilisateur__c.addError('Cet utilisateur fait déjà parti de l\'équipe consulting de la mission');
			return null;
		}
		
		
		//Vérification que la somme des temps théoriques de l'équipe ne dépasse pas le temps théorique de la mission
		Decimal sommeTemps = 0;
		//somme de tous les autres membres
		for(AggregateResult aggr : [SELECT SUM(Nombre_jours_theoriques_Audit__c) audit, 
											SUM(Nombre_jours_theoriques_Valorisation__c) valo, 
											SUM(Nombre_jours_theoriques_Justification__c) justif, 
											SUM(Nombre_jours_theoriques_Controle__c) ctrl
									FROM INNOequipeConsulting__c 
									WHERE MissionCIR__c = :this.mission.Id
										AND Utilisateur__c != :this.membre.Utilisateur__c
									GROUP BY MissionCIR__c]){
										
			sommeTemps += this.getNotNullValue((Decimal) aggr.get('audit')) + this.getNotNullValue((Decimal) aggr.get('valo')) + this.getNotNullValue((Decimal) aggr.get('justif')) + this.getNotNullValue((Decimal) aggr.get('ctrl'));
        }
        //+ somme du membre courant
        sommeTemps += this.getNotNullValue(this.membre.Nombre_jours_theoriques_Audit__c) + this.getNotNullValue(this.membre.Nombre_jours_theoriques_Valorisation__c) + this.getNotNullValue(this.membre.Nombre_jours_theoriques_Justification__c) + this.getNotNullValue(this.membre.Nombre_jours_theoriques_Controle__c);

        if((sommeTemps > this.mission.TempsTheoriquePlafond__c || this.mission.TempsTheoriquePlafond__c == null) && !this.erreurTempsTheorique){
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Le nombre de jours théoriques de l\'ensemble de l\'équipe (' + sommeTemps + ') est supérieur à celui estimé sur l\'opportunité (' + this.mission.TempsTheoriquePlafond__c + ').<br /><strong>Vous pouvez forcer ce blocage en recliquant sur le bouton enregistrer.</strong>'));
            this.erreurTempsTheorique  = true;
    		return null;  
        }
        
		upsert this.membre;
		
		

		PageReference retPage;
		retPage = new PageReference('/apex/INNOmissionView');
		retPage.getParameters().put('id', this.mission.Id);
		retPage.getParameters().put('missionId', this.mission.Id);
		retPage.getParameters().put('sharingRecalc', '1');
		retPage.setRedirect(true);
		
		return retPage;
	}
	
	
	private Decimal getNotNullValue(Decimal value){
		return value == null ? 0 : value;
	}
	
	
}