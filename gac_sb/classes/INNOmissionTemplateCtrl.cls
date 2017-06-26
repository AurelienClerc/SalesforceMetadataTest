public class INNOmissionTemplateCtrl extends INNOmissionBaseCtrl{

	public List<INNOvalo__c> getValos(){
		return [SELECT Id, Name, RecordType.DeveloperName, Entite__r.Name FROM INNOvalo__c WHERE MissionCIR__c = :this.mission.Id ORDER BY CreatedDate];
	}
	
}