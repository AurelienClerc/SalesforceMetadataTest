//On étend contractHandler car on veut la même method "andFinally"
//Handler pour mettre a jour les comptes lors de la mise a jour des enregistrement "Sociétés a auditer"
//La majeur partie des cas est traitée par la mise a jour des contrats, mais cette classe s'occupe de gérer les suppressions d'enregistrement
//La classe est testée dans contractGateway_test
public with sharing class Societe_a_auditerHandler extends ContractHandler{


	// Constructor
	public Societe_a_auditerHandler(){
	}

	
	override public void bulkBefore(){
		
	}
	
	override public void bulkAfter(){
		
	}
		
	override public void beforeInsert(SObject so){
	}
	
	override public void beforeUpdate(SObject oldSo, SObject so){
	}
	
	override public void beforeDelete(SObject so){	
	}
	
	override public void afterInsert(SObject so){
		//rien a faire ici, les inserts sont gérés avec le contrat (champs récap de cumul)
	}
	
	override public void afterUpdate(SObject oldSo, SObject so){
		//on met a jour l'ancien compte si jamais l'update a fait changer le compte
		Societe_a_auditer__c s = (Societe_a_auditer__c) oldSo;
		Societe_a_auditer__c s1 = (Societe_a_auditer__c) so;
		if(s.Societe_a_auditer__c != s1.Societe_a_auditer__c){
			this.ContractGateway.addItem(s.Societe_a_auditer__c);
			this.ContractGateway.addItem(s1.Societe_a_auditer__c);
			
		}
	}
	
	override public void afterDelete(SObject so){
		Societe_a_auditer__c s = (Societe_a_auditer__c) so;
		this.ContractGateway.addItem(s.Societe_a_auditer__c);
	}
	
	override public void andFinally(){
		super.andFinally(); //appel de la méthode de contractHandler pour ne pas avoir a recopier le code
	}
}