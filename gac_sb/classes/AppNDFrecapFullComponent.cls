public without sharing class AppNDFrecapFullComponent {

  private Boolean bInit = false;
  //public Id idNDF { get; set; }
    public Note_De_Frais_Recap__c oNDFrecap = new Note_De_Frais_Recap__c();
    
    public Map<String, List<Note_De_Frais_Depense__c>> mpNDFdepense {
    get{
      if(!bInit && this.oNDFrecap != null)
        this.initVar();
        
      return this.mpNDFdepense;
    }
    set;
  }
  public List<Note_De_Frais_Depense__History> lsNDFdepenseHistory {
    get{
      if(!bInit && this.oNDFrecap != null)
        this.initVar();
        
      return this.lsNDFdepenseHistory;
    }
    set;
  }
  public List<Note_De_Frais__c> lsNDFevent {
    get{
      if(!bInit && this.oNDFrecap != null)
        this.initVar();
        
      return this.lsNDFevent;
    }
    set;
  }
    public List<Note_De_Frais__c> lsNDFlibre {
    get{
      if(!bInit && this.oNDFrecap != null)
        this.initVar();
        
      return this.lsNDFlibre;
    }
    set;
  }
    public Map<Id, String> mpEvent {
    get{
      if(!bInit && this.oNDFrecap != null)
        this.initVar();
        
      return this.mpEvent;
    }
    set;
  }
    public Integer iLsDepenseSize {
    get{
      return this.mpNDFdepense.get('Autre_Frais').size();
    }
    set;
  }
  public Integer iLsFraisKiloSize {
    get{
      return this.mpNDFdepense.get('Frais_Kilometrique').size();
    }
    set;
  }
  
  public AppNDFrecapFullComponent(){}
  
  public void initVar(){

    this.bInit = true;

    this.mpNDFdepense = new Map<String, List<Note_De_Frais_Depense__c>>{
      'Autre_Frais' => new List<Note_De_Frais_Depense__c>(),
      'Frais_Kilometrique' => new List<Note_De_Frais_Depense__c>()};
    
    this.mpEvent = new Map<Id, String>();
    Map<Id, Event> mpTemp = new Map<Id, Event>();
    Set<Id> setId = new Set<Id>();
    
    List<Note_De_Frais_Depense__c> lsNDFdepense = [
        Select
            
          	n.Total__c, 
			n.RecordTypeId,
			n.RecordType.DeveloperName,
			n.RecordType.Name,
			n.Num_PJ__c,
			n.Note_De_Frais__c,

			n.Note_De_Frais__r.Name,
			n.Note_De_Frais__r.Description__c,
			n.Note_De_Frais__r.Evenement_Id__c,
			n.Note_De_Frais__r.CreatedDate,
			n.Note_De_Frais__r.RecordType.DeveloperName,
			n.Note_De_Frais__r.Date_Des_Frais__c,
			n.Note_De_Frais__r.Mission__c,
			n.Note_De_Frais__r.Opportunite__c,
			n.Note_De_Frais__r.Compte__c,
			n.Note_De_Frais__r.Contrat__c,
			n.Note_De_Frais__r.Objet_attache_type__c,
			n.Note_De_Frais__r.Objet_attache_libelle__c,
			n.Nombre_De_Kilometres__c,
			n.Nature_Depense__c,
			n.Nature_Depense__r.Type__c,
			n.Nature_Depense__r.Name,
			n.Nature_Depense_Categorie__c, 
			n.Name,
			n.Montant_TVA__c,
			n.Montant_TTC__c,
			n.Montant_HT__c, 
			n.Indemnites_Kilometriques__c,
			n.Taux_Indemnites__c,
			n.Id,
        	n.StatutClientBR__c,
			n.Description__c
        From Note_De_Frais_Depense__c n
        Where n.Note_De_Frais__r.Recap_Note_De_Frais__c =: this.oNDFrecap.Id
        order by n.Note_De_Frais__r.CreatedDate];
        
    for(Note_De_Frais_Depense__c oNDFdepense : lsNDFdepense){
      if(oNDFdepense.Note_De_Frais__r.Evenement_Id__c != null && !setId.contains(oNDFdepense.Note_De_Frais__r.Evenement_Id__c)){
        setId.add(oNDFdepense.Note_De_Frais__r.Evenement_Id__c);
    //    mpTemp.put(oNDFdepense.Note_De_Frais__r.Evenement_Id__c, new Event());
      }
    }
    
    for(Event e : [
                        Select
                            e.WhatId,
                            e.What.Name,
                            e.Subject,
                            e.Id,
                            e.IsDeleted,
                            e.ActivityDate,
                            e.AccountId
                        From Event e
                        Where e.Id in : setId]){
            mpTemp.put(e.Id, e);       
        }
        
    DateTime dt;
        String sEv;
    for(Note_De_Frais_Depense__c oNDFdepense : lsNDFdepense){
      
      if(oNDFdepense.RecordType.DeveloperName == 'Frais_Kilometrique')
        this.mpNDFdepense.get('Frais_Kilometrique').add(oNDFdepense);
      
      if(oNDFdepense.RecordType.DeveloperName == 'Autre_Frais')
        this.mpNDFdepense.get('Autre_Frais').add(oNDFdepense);
      
      if(oNDFdepense.Note_De_Frais__r.RecordType.DeveloperName == 'Libre'){
        dt = Datetime.newInstance(oNDFdepense.Note_De_Frais__r.Date_Des_Frais__c.year(),oNDFdepense.Note_De_Frais__r.Date_Des_Frais__c.month(),oNDFdepense.Note_De_Frais__r.Date_Des_Frais__c.day(),0,0,0);
        this.mpEvent.put(oNDFdepense.Id, System.Label.Libre_Frais_en_date_du_date.replace( '__date__',  dt.format('dd/MM/yyyy') ) );
      }
      
      if(oNDFdepense.Note_De_Frais__r.RecordType.DeveloperName == 'Evenement'){
        if(mpTemp.get(oNDFdepense.Note_De_Frais__r.Evenement_Id__c) != null){
          sEv = mpTemp.get(oNDFdepense.Note_De_Frais__r.Evenement_Id__c).Subject + ' - ';
          if(mpTemp.get(oNDFdepense.Note_De_Frais__r.Evenement_Id__c).WhatId != null)
            sEv += mpTemp.get(oNDFdepense.Note_De_Frais__r.Evenement_Id__c).What.Name + ' - ';
                  dt = Datetime.newInstance(mpTemp.get(oNDFdepense.Note_De_Frais__r.Evenement_Id__c).ActivityDate.year(),mpTemp.get(oNDFdepense.Note_De_Frais__r.Evenement_Id__c).ActivityDate.month(),mpTemp.get(oNDFdepense.Note_De_Frais__r.Evenement_Id__c).ActivityDate.day(),0,0,0);
                  sEv += dt.format('dd/MM/yyyy');
          this.mpEvent.put(oNDFdepense.Id,sEv);
        }else{
          this.mpEvent.put(oNDFdepense.Id,'évènement introuvable');
        }
      }
    }
    
    
    // on récupère les histories
    set<Id> setIdDepense = new set<Id>();
    for(Note_De_Frais_Depense__c d : this.mpNDFdepense.get('Autre_Frais')){
      setIdDepense.add(d.Id);
    }
    
    this.lsNDFdepenseHistory = new List<Note_De_Frais_Depense__History>();
    List<Note_De_Frais_Depense__c> lsNDF = [Select (Select Id, Division, IsDeleted, ParentId, Parent.Name, Parent.Nature_Depense__r.Name, CreatedBy.Name, CreatedById, CreatedDate, Field, OldValue, NewValue From Histories where Field != 'created' order by CreatedDate) From Note_De_Frais_Depense__c n where n.Id in : setIdDepense];
         
        for(Note_De_Frais_Depense__c nd : lsNDF){
          for(Note_De_Frais_Depense__History ndh : nd.Histories){
            if(ndh.CreatedById != this.oNDFrecap.Collaborateur__c)
              this.lsNDFdepenseHistory.add(ndh);
          }
        }
  }
  

  // ---------------------------------//
  // --------- getter setter ---------//
  // ---------------------------------//
  
  public Note_De_Frais_Recap__c getONDFrecap(){
      return this.oNDFrecap;
    }
    
    public void setONDFrecap(Note_De_Frais_Recap__c oRec){
      this.bInit = false;
      this.oNDFrecap = oRec;
    }
    
  
}