public with sharing class AppNDFrecapListCtrl {
	
	public String sPeriodeLabel {get; set;}
	public Map<String, List<Note_De_Frais_Recap__c>> mpRecapsParEtape {get; set;}
	public Map<Id, String> mpApprobateurCourant {get;set;} // Map<Id du recap, Nom du user approbateur Courant>
	public Map<Id, Boolean> mpIsApprobateur {get;set;}
	public List<selectOption> lsMoisOption;
	public List<selectOption> lsAnneeOption;
	public List<selectOption> lsUserOption;
	private static final List<String> lsEtapes = new List<String>{'En cours', 'Soumis pour approbation', 'Refusé', 'Validé'};
	public Opportunity oppFake {get;set;} // juste pour récupérer des champs date...
	
	public List<String> lsEtapesNonVides {get{
		lsEtapesNonVides = new List<String>();
		for(String etape : lsEtapes){
			if(!this.mpRecapsParEtape.get(etape).isEmpty())
			lsEtapesNonVides.add(etape);
		}
		return lsEtapesNonVides;
	}set;}
	
	
	public String sRejectComment {get;set;}
	
	public AppNDFrecapListCtrl(){
		
		Opportunity oppFake = new Opportunity();
		
		this.initLsSelectOption();
		this.viewRecapList();
	}
	
    public String getPays(){
        String ret =AppNdfSetting__c.getInstance().pays__c == null ? 'FR' : AppNdfSetting__c.getInstance().pays__c.left(2);
        return ret;
    }
    
	public void initLsSelectOption(){
		
		// PERIODE
		this.lsMoisOption = new List<selectOption>();
		this.lsMoisOption.add(new selectOption('', '- None -'));
		
		// on montre 2 années dans le treeview: année et année+1 si on est avant juin (ou en 2013)
		List<String> lsAnnee = new List<String>();
		if(Date.today().month() <= 6){
			lsAnnee.add(string.valueof(Date.today().year()-2));
		}
		lsAnnee.add(string.valueof(Date.today().year()-1));
		lsAnnee.add(string.valueof(Date.today().year()));
		if(Date.today().month() > 6){
			lsAnnee.add(string.valueof(Date.today().year()+1));
		}
		
		for(String s: lsAnnee){
			this.lsMoisOption.add(new selectOption(s + '-01',system.Label.Mois_Janvier + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-02',system.Label.Mois_Fevrier + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-03',system.Label.Mois_Mars + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-04',system.Label.Mois_Avril + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-05',system.Label.Mois_Mai + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-06',system.Label.Mois_Juin + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-07',system.Label.Mois_Juillet + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-08',system.Label.Mois_Aout + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-09',system.Label.Mois_Septembre + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-10',system.Label.Mois_Octobre + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-11',system.Label.Mois_Novembre + ' ' + s));
			this.lsMoisOption.add(new selectOption(s + '-12',system.Label.Mois_Decembre + ' ' + s));
		}
		
        String pays = this.getPays() == 'FR' ? '%' : 'BR%';
        
        
		// USER
		this.lsUserOption = new List<selectOption>();
		this.lsUserOption.add(new selectOption('tous', '- '+system.Label.APPNDF_tous+' -'));
		for(User u : [Select
                    		u.Name,
                    		u.LastName,
                    		u.FirstName,
                    		u.IsActive
                		From User u
                		Where u.IsActive = true
                        AND profile.Name like :pays
                		Order by LastName,FirstName]){
			this.lsUserOption.add(new selectOption(u.Id,u.LastName + ' ' + u.FirstName));
		}
	}
	
	public List<selectOption> getLsMoisOption(){
		return this.lsMoisOption;
	}
	
	public List<selectOption> getLsAnneeOption(){
		return this.lsAnneeOption;
	}
	
	public List<selectOption> getLsUserOption(){
		return this.lsUserOption;
	}
	
	public void viewRecapList(){
		String periode = ApexPages.currentPage().getParameters().get('periode');
		String sUser = ApexPages.currentPage().getParameters().get('user');
		
		this.initMpRecapsParEtape();
		
		if(periode != null){
			this.sRejectComment = '';
			
			List<Note_De_Frais_Recap__c> recapsTemp;
			
			Set<Id> sId = new Set<Id>();
			
			// soql différente si on a un user ou pas
			String soqlQuery = 'SELECT Date_De_Validation__c, Id, Name, Etape__c, Periode_label__c, Collaborateur__c, Collaborateur__r.Name, Total__c ';
			soqlQuery += ' FROM Note_De_Frais_Recap__c WHERE Periode__c = \'' + periode + '\'';
			if(sUser != 'tous')
			soqlQuery += ' And Collaborateur__c = \'' + sUser + '\'';
			soqlQuery += ' ORDER BY Collaborateur__r.LastName';
			system.debug(soqlQuery);
			List<Note_De_Frais_Recap__c> lsNDFrecap = Database.query(soqlQuery);
			
			for(Note_De_Frais_Recap__c r : lsNDFrecap){
				// on récupère le période label d'un des récap
				if(this.sPeriodeLabel == '')
				this.sPeriodeLabel = r.Periode_label__c;
				
				if(r.Etape__c == 'Soumis pour approbation')
				sId.add(r.Id);
				
				recapsTemp = this.mpRecapsParEtape.get(r.Etape__c);
				recapsTemp.add(r);
				this.mpRecapsParEtape.put(r.Etape__c, recapsTemp);
			}
			// on récupère le nom de l'approbateur courant
			// et si l'utilisateur connecté est approbateur en cour pour certains recap
			this.mpApprobateurCourant = new Map<Id,String>();
			this.mpIsApprobateur = new Map<Id, Boolean>();
			for(ProcessInstance PI : [
            			Select
                			p.TargetObjectId,
                			p.Status,
                			p.Id,
                			(Select
                    			Id,
                    			ActorId,
                    			Actor.Name
                			From Workitems)
            			From ProcessInstance p
            			Where p.TargetObjectId in :sId]){
				if(PI.Workitems.size() == 1){
					this.mpApprobateurCourant.put(PI.TargetObjectId, PI.Workitems[0].Actor.Name);
					this.mpIsApprobateur.put(PI.TargetObjectId,PI.Workitems[0].ActorId == UserInfo.getUserId() ? true : false);
				}
			}
		}
	}
	
	/**
	*  Initialise this.mpRecapsParEtape avec des listes vides de recap pour chaque étape
	*/
	private void initMpRecapsParEtape(){
		this.mpRecapsParEtape = new Map<String, List<Note_De_Frais_Recap__c>>();
		
		for(String etape : lsEtapes)
		this.mpRecapsParEtape.put(etape, new List<Note_De_Frais_Recap__c>());
	}
	
	
	
	public void approve(){
		
		String recapId = ApexPages.currentPage().getParameters().get('recapId');
		String action = ApexPages.currentPage().getParameters().get('action');
		
		if(recapId != null && (action == 'Approve' || action == 'Reject')){
			List<ProcessInstanceWorkitem> workItems = [SELECT Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :recapId LIMIT 1];
			if(!workItems.isEmpty()){
				Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
				req.setAction(action);
				req.setComments(this.sRejectComment);
				req.setWorkitemId(workItems[0].Id);
				Approval.ProcessResult result =  Approval.process(req);
				if(result.isSuccess()){
					if(action == 'Reject' && this.sRejectComment != '' ){
						FeedItem chatterFeed = new FeedItem(ParentId = recapId, Body = this.sRejectComment);
						insert chatterFeed;
					}
					this.viewRecapList();
				}
			}
		}
	}
}