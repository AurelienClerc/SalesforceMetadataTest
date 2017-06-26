public with sharing class INNOreportLinkCtrl {


	public String repName {get; set{ 
		if(this.repName == null){
			this.repName = value;
			this.initReportIds();
		}
	}}
	
	public List<SelectOption> reports {get; set;}
	
	
	public void initReportIds(){
		
		this.reports = new List<SelectOption>{new SelectOption('', ' - Choisissez votre rapport - ')};
		String likeClause = (this.repName == 'prestataire' || this.repName == 'projet') ? 'INNO_' + this.repName + '%' : 'INNO_' + this.repName + '_option%';
		
		for(Report r : [SELECT Id, Name FROM Report WHERE DeveloperName LIKE :likeClause ORDER BY DeveloperName]){
			this.reports.add(new SelectOption(r.Id, r.Name));
		}
	
	}
	

}