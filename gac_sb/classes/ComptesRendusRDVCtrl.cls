public with sharing class ComptesRendusRDVCtrl {

	
	public List<Event> comptesRendusRDV {get;set;}
	
	private Id oppId;
	
	private static List<String> comptesRendusRDVfields = new List<String>{'Nature_evenement__c', 'Description', 'Processus_de_decision__c', 'Enjeux__c', 'Timing_Prochaine_tape__c', 'Attente_Besoin__c', 'Objections__c' };
	private static List<String> typesEvent = new List<String>{'RDV commercial','Suivi Proposition Commerciale','Suivi commercial'};
	private static List<String> naturesEvent = new List<String>{'RDV Physique','RDV Téléphonique'};
	
	
	/**
	*	Constructeur
	*/
	public ComptesRendusRDVCtrl(ApexPages.standardController stdCtrl){
		
		this.oppId = stdCtrl.getId();
		
		
		//Recupération des RDV commercial rattachés à l'opport
		comptesRendusRDV = [SELECT Id, Subject, Nature_evenement__c, StartDateTime, Contexte__c, Description, Objections__c, Processus_de_decision__c, Enjeux__c, Timing_Prochaine_tape__c, Attente_Besoin__c
							FROM Event 
							WHERE WhatId =: this.oppId 
								AND RecordType.DeveloperName = 'RDV_Commercial'
								AND Objet_evenement__c IN: typesEvent
								AND Nature_evenement__c IN: naturesEvent
								AND annulation_et_report__c = null
								AND isDeleted = false
								AND isChild = false //Edit didier 28/11 on ne prend que les RDV, pas les invitations
							ORDER BY StartDateTime DESC 
							LIMIT 10 ALL ROWS];	//On prend le All Rows au cas ou le Compte rendu a été fait par un mec inactif
	}
	
	
	
	/**
	*	Création de l'ensemble des onglets des comptes-rendus RDV
	*	On est obligé de le faire avec les dynamicComponents parce qu'on ne peut pas mettre de <apex:tab> dans un <apex:repeat>...
	*/
	public Component.Apex.TabPanel getComptesRendusRDVtabs(){
		
		//Création de l'ensemble d'onglets
		Component.Apex.TabPanel tabs = new Component.Apex.TabPanel(switchType = 'client');
		
		Component.Apex.Tab tab;
		Component.Apex.PageBlock pageBlock;
		Component.Apex.PageBlockSection pageBlockSection;
		Component.Apex.PageBlockSectionItem pageBlockSectionItem;
		Component.Apex.OutputLink link;
		Component.Apex.OutputField field;

		
		//On boucle sur les events
		Integer index = 0;
		String tabTitle = '';
		for(Event e : this.comptesRendusRDV){
			//Création de l'onglet
			tab = new Component.Apex.Tab(name = String.valueOf(e.Id), label = e.StartDateTime.format('dd/MM/yyyy'), styleClass='comptesRendusRDVtab');
			
			//Création d'un pageBlock et pageBlockSection
			pageBlock = new Component.Apex.PageBlock(mode = 'maindetail');
			pageBlockSection = new Component.Apex.PageBlockSection();
			
			//Création d'un pageBlockSectionItem pour le type d'event
			pageBlockSectionItem = new Component.Apex.PageBlockSectionItem();
			pageBlockSectionItem.childComponents.add(new Component.Apex.OutputLabel(value = Event.sObjectType.getDescribe().getLabel()));
			link = new Component.Apex.OutputLink(value = '/' + e.id + '/e?retURL=' + this.oppId , target = '_top');
			link.childComponents.add(new Component.Apex.OutputText(value = (e.Subject != null ? e.Subject : 'Modifier') ));
			pageBlockSectionItem.childComponents.add(link);
			pageBlockSection.childComponents.add(pageBlockSectionItem);
			
			
			/**
			*	Création des 6 champs d'event qu'on ajoute ensuite à la pageBlockSection
			*/
			for(String f : comptesRendusRDVfields){
				field = new Component.Apex.OutputField();
				field.expressions.value = '{!comptesRendusRDV[' + index + '].'+ f +'}';
				pageBlockSection.childComponents.add(field);
			}
			
			//Ajoute la pageBlockSection a la pageBlock
			pageBlock.childComponents.add(pageBlockSection);
			//Ajoute la pageBlock a l'onglet
			tab.childComponents.add(pageBlock);
			//Ajoute l'onglet a l'ensemble d'onglets
			tabs.childComponents.add(tab);
			index ++;
		}
		
		return tabs;
	}
	
	
	static testmethod void TestComptesRendusRDV(){
		
		Map<String,Id> recordTypes = new Map<String,Id>();
		for(RecordType rtype : [SELECT Id, SobjectType, DeveloperName FROM RecordType WHERE SobjectType='Event' OR SobjectType='Opportunity']){
			recordTypes.put(rtype.SobjectType + '_' + rtype.DeveloperName, rtype.Id);
		}
		
		Account ac = new Account(Name = 'testAccount', BillingCountry = 'FRANCE', BillingPostalCode = '12345',Activity__c= 'test',Industry='test');
		insert ac;
		Opportunity o = new Opportunity(AccountId = ac.Id, name = 'test', StageName = 'Test', CloseDate = Date.today(), recordTypeId = recordTypes.get('Opportunity_ACS'));
		insert o;
		Event ev1 = new Event(RecordTypeId = recordTypes.get('Event_RDV_Commercial') , WhatId = o.Id, startDateTime = datetime.now()-5, endDateTime = datetime.now(), Description='test First', objet_evenement__c = 'RDV Commercial', nature_evenement__c = 'RDV Physique');
		Event ev2 = new Event(RecordTypeId = recordTypes.get('Event_RDV_Commercial') , WhatId = o.Id, startDateTime = datetime.now()-5, endDateTime = datetime.now(), Description='test First', objet_evenement__c = 'Suivi client', nature_evenement__c = 'RDV Physique');
		insert new List<Event>{ev1, ev2};
		
		Test.startTest();
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(o);
		ComptesRendusRDVCtrl ctrl = new ComptesRendusRDVCtrl(stdCtrl);
		
		system.assertEquals(o.Id, ctrl.oppId);
		system.assertEquals(1, ctrl.comptesRendusRDV.size());
		
		ctrl.getComptesRendusRDVtabs();
		
		Test.stopTest();
	}
}