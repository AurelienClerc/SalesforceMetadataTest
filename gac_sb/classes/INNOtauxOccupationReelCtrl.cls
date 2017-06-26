public without sharing class INNOtauxOccupationReelCtrl extends INNOtauxOccupationBase{ 
    
    
    //CONFIGURATION
    private static final Integer nbWeeksToDisplay = 15;         //Nombre de semaines à afficher dans le planning
    
    
    public transient List<UserOccupancyRates> usersOccupancyRates {get; set;}
    
    
    
    /**
	 * Créer une liste avec les noms des mois utilisés dans le planning dans l'ordre
	 * Utilisé directement et uniquement par la page VF: <apex:repeat value="{!usedMonthsNames}" var="monthName">
	 * 
	 * @return List<String> la liste des noms de mois
	 */
	public override List<String> getHeaderValues(){
	    List<String> weeksNames = new List<String>();
		Integer planningStartWeek = Integer.valueOf(System.now().format('w')) + 1;
		
		for(Integer week = planningStartWeek; week < planningStartWeek + nbWeeksToDisplay; week ++){
			weeksNames.add('S ' + (week > 52 ? week - 52 : week));
		}

		return weeksNames;
	}
	
    
    
    /**
     * Initialise les taux d'occupation
     * 
     * @param Set<Id> usersRestriction: la liste des Ids d'utilisateur dont il faut calculer le taux d'occupation
     */
    protected override void initUsersOccupancyRates(Set<Id> usersRestriction){

        
        Date planningStartDate = System.today().toStartOfWeek();                    //Le 1er jour du planning, ex 01/01/2015
        Date planningEndDate = planningStartDate.addDays(nbWeeksToDisplay * 7);     //Le lendemin du dernier jour du planning, ex 01/01/2016
        
        Integer planningStartWeek = Integer.valueOf(System.now().format('w')) + 1;
        
        
        /**
         * Construction d'une liste de congés pour chaques utilisateurs de usersRestriction
         */
        //Map<Id, List<AppCIRtimeSheet__c>> congesByUserId = getCongesByUserId(usersRestriction, planningStartDate, planningEndDate);
        
        List<AggregateResult> durees = [SELECT SUM(Duree__c) duree, Semaine__c, Utilisateur__c FROM INNOtimeSheet__c WHERE Utilisateur__c IN :usersRestriction AND Date__c >= :planningStartDate AND Date__c < :planningEndDate GROUP BY Utilisateur__c, Semaine__c];

        //Initialise this.usersOccupancyRates
        this.usersOccupancyRates = new List<UserOccupancyRates>();
        for(User u : [SELECT Id, Name FROM User WHERE Id IN :usersRestriction ORDER BY Name]){
            this.usersOccupancyRates.add( new UserOccupancyRates(u, planningStartWeek, durees));
        }
        
        
    }

    
    /**
     * Wrapper class représentant un utilisateur dont il faut calculer le taux d'occupation
     * 
     */
    public class UserOccupancyRates{
        public User collaborateur {get; set;}                   //L'utilisateur
        public List<Decimal> occupancyRates {get; set;}         //La liste des taux d'occupation par mois
        
        
        /**
         * Constructeur
         */
        public UserOccupancyRates(User collaborateur, Integer planningStartWeek, List<AggregateResult> durees){
            this.collaborateur = collaborateur;
            
            this.occupancyRates = new List<Decimal>();
            for(Integer week = planningStartWeek; week < planningStartWeek + nbWeeksToDisplay; week ++){
            	
                this.occupancyRates.add(0);
            }
            
            Integer week;
            for(AggregateResult duree : durees){
                if(duree.get('Utilisateur__c') == this.collaborateur.Id){
                    week = Integer.valueOf(duree.get('Semaine__c'));
                    this.occupancyRates[ ( week < planningStartWeek ? 52 + week : week) - planningStartWeek] = Math.round((Decimal) duree.get('duree') / 5 * 100);
                }
            }
        }
        
    }
}