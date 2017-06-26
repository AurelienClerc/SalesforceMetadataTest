public with sharing class INNOhomeCtrl {

	public SelectOption[] anneesCIR {get; set;}
	
	public String[] consultants {get; set;}
	public String[] consultantsFiscalistes {get; set;}
	
	public List<SelectOption> missionRecordTypes {get; set;}
	public Id selectedMissionRecordType {get; set;}
	
	public List<SelectOption> statuts {get; set;}
	public String selectedStatut {get; set;}
	

	public transient INNOmission__c[] missions {get;set;}
	
	public Boolean userHasFullAccess {get; set;}
	
	public Boolean userIsManager {get; set;}
	
	public INNOhomeCtrl(){
		
		this.statuts = new List<SelectOption>{new SelectOption('Active', 'Actives'), new SelectOption('Inactive', 'Inactives'), new SelectOption('Terminée', 'Terminées')};
		
		this.missionRecordTypes = new List<SelectOption>();
		for(RecordType rt : [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'INNOmission__c' ORDER BY Name]){
			this.missionRecordTypes.add(new SelectOption(rt.Id, rt.Name));
			if(rt.DeveloperName == 'CIR')
				this.selectedMissionRecordType = rt.Id;
		}
		
		this.selectedStatut = 'Active';

		this.userHasFullAccess = INNOmissionUtils.userHasFullAccess();
		this.userIsManager = INNOmissionUtils.userIsManager();
		
		//Init les années CIR disponibles
		this.anneesCIR = new List<Selectoption>{ new SelectOption('', 'Toutes')};
		for(Integer y = System.today().addYears(2).year(); y > 2006 ; y--)
			this.anneesCIR.add( new SelectOption(String.valueOf(y), String.valueOf(y)) );
			
			
		//Init les consultant disponibles
		this.consultants = new List<String>();
		for(AggregateResult aggr : [SELECT Utilisateur__r.Name u FROM INNOequipeConsulting__c GROUP BY Utilisateur__r.Name])
			this.consultants.add(String.valueOf(aggr.get('u')));
		
		this.initMissions();
		
	}
	
	
	public void initMissions(){
		/*
		*	Seletionne uniquement les missions auquelles j'ai accès grace aux sharing rules
		*/
		String missionQuery = 'SELECT Id, Name, Annee_CIR__c, Phase__c, Avancement__c, Consultants_scientifiques__c, Consultants_fiscalistes__c, Consultants_exterieurs__c, Managers__c';
		
		//Pour les non admin, on recup aussi l'equipe consulting du user courant pour pouvoir récupérer son avancement
		if(!this.userHasFullAccess)
			missionQuery += ', (SELECT Id, Avancement__c FROM EquipesConsulting__r WHERE Utilisateur__c = \'' + UserInfo.getUserId() + '\')';
		
		missionQuery += ' FROM INNOmission__c WHERE Statut__c = :selectedStatut AND RecordTypeId = :selectedMissionRecordType ORDER BY Annee_CIR__c DESC LIMIT 3000';
		
		this.missions = Database.query(missionQuery);
	
		for(INNOmission__c m : this.missions){
			
			if(!this.userHasFullAccess)
				m.Taux_CIR__c = (m.EquipesConsulting__r.isEmpty() ? null : m.EquipesConsulting__r[0].Avancement__c);
			else
				m.Taux_CIR__c = m.Avancement__c;
			
			m.Consultants_scientifiques__c = (String.isNotBlank(m.Consultants_scientifiques__c) ? m.Consultants_scientifiques__c.replace(' - ', '<br />') : '') + 
												(String.isNotBlank(m.Consultants_fiscalistes__c) ? '<br />' + m.Consultants_fiscalistes__c.replace(' - ', '<br />') : '') + 
												(String.isNotBlank(m.Consultants_exterieurs__c) ? '<br />' + m.Consultants_exterieurs__c.replace(' - ', '<br />') : '');
												
			
			m.Managers__c = (String.isNotBlank(m.Managers__c) ? m.Managers__c.replace(' - ', '<br />') : '');
		}

		
		
	}
	
		
	
}