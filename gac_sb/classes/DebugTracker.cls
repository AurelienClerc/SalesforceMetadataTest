public with sharing class DebugTracker {
	
	public String message {get;set;}
	
	public Log[] logs {get;set;}
	
	public Integer debugMessageCount {get; set;}
	
	
	public DebugTracker(){
		this.logs = new List<Log>();
	}

	public void searchNewLogs(){
		
		
		this.debugMessageCount = 0;
		
		//On recupère les Ids de log qu'on a deja dans this.log pour ne pas aller les rechercher 
		Set<Id> retrievedLogs = new Set<Id>();
		for(Log l : this.logs)
			retrievedLogs.add(l.id);
		
		ApexLog[] ls = [SELECT Id, StartTime, Operation, Status FROM ApexLog WHERE LogUserId = :Userinfo.getUserId() AND Operation != '/apex/DebugTracker' ORDER BY StartTime DESC LIMIT 4];
		Log newLog;
		Boolean logAlreadyRetrieved;
		//Boucle sur les derniers logs du plus vieu au plus récent
		for(Integer i = ls.size() + retrievedLogs.size() - 1; i >= retrievedLogs.size(); i--){
			
			logAlreadyRetrieved = false;
			//ON regarde si on a pas deja ce log dans this.logs
			for(Log l : this.logs){
				if(l.id == ls[i - retrievedLogs.size()].Id){
					logAlreadyRetrieved = true;
					break;
				}
			}
			
			if(!logAlreadyRetrieved){
				newLog = new Log(ls[i - retrievedLogs.size()]);
				if(newLog.debugMessages[0] != '#DEBUGTRACKER#')
					logs.add( newLog );
			}
		}
		
		for(Log l : this.logs)
			if(l.debugMessages[0] != 'Ø')
				this.debugMessageCount ++;	
	}
	
	
	public class Log{
		public Id id {get;set;}
		public String status {get;set;}
		public DateTime startTime {get;set;}
		public String page {get;set;}
		public List<String> debugMessages{get;set;}
		
		public Log(ApexLog l){
			this.id = l.Id;
			this.status = l.Status;
			this.startTime = l.StartTime;
			this.page = l.Operation;
			this.debugMessages = new List<String>();
			
			//Récupère le contenu du fichier de log
			String logs = new Pagereference('/apexdebug/traceDownload.apexp?id=' + this.id).getContent().toString();
			
			//On part a la recherche les lignes de debug du fichier de log
			Integer startSearchIndex = 0, endSearchIndex = 0;
			String message;
			while ( (startSearchIndex = logs.indexOf('|DEBUG|', startSearchIndex)) != -1){
				endSearchIndex = logs.indexOf('\n', startSearchIndex);
				message = logs.substring(startSearchIndex + 7, endSearchIndex);
				
				this.debugMessages.add( message );
				
				if(message == '#DEBUGTRACKER#')
					break;
				
				startSearchIndex = endSearchIndex;
			}
			
			if(this.debugMessages.size() == 0)
				this.debugMessages.add('Ø');
		}
		
	}
	
}