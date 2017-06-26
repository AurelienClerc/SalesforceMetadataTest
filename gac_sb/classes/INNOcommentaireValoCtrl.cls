/**
*	Controleur du composant VF affichant le champ commentaire en haut de chaque page de liste des différents onglets
*/
public with sharing class INNOcommentaireValoCtrl extends INNOmissionBaseCtrl{

	public INNOvalo__c valo {get; set;}
	
	public String fieldName {get; set;}

	public Boolean isEditMode {get; set;}
	

	public INNOcommentaireValoCtrl(){
		
		this.isEditMode = false;
		
		if(valoId != null){
		
			this.fieldName = ApexPages.currentPage().getParameters().get('tab');
			
			if(this.fieldName != null){	
				this.fieldName = String.escapeSingleQuotes( this.fieldName );
				this.valo = Database.query('SELECT Id, Commentaires_' + this.fieldName + '__c, Dossier_serveur_' + this.fieldName + '__c FROM INNOvalo__c WHERE Id = \'' + valoId + '\' LIMIT 1');
			}
			
		}
	}
	
	public void saveComment(){
		update this.valo;
		this.isEditMode = false;
	}
	
	
	
}