public without sharing class INNOequipeConsultingReassignCtrl{

    public INNOequipeConsulting__c dummyEquipe {get; set;}
    
    public List<TeamMember> results {get; set;}
    
    
    public INNOequipeConsultingReassignCtrl(){
        
        this.dummyEquipe = new INNOequipeConsulting__c();
        
    }
    
    
    
    public void searchEquipes(){
        
        this.results = new List<TeamMember>();
        
        for(INNOequipeConsulting__c eq : [SELECT Id, 
                                                MissionCIR__c,
                                                MissionCIR__r.Name,
                                                Role__c, 
                                                Nombre_jours_programmes_Audit__c, 
                                                Nombre_jours_programmes_Controle__c, 
                                                Nombre_jours_programmes_Justification__c, 
                                                Nombre_jours_programmes_Valorisation__c, 
                                                Nombre_jours_theoriques_Audit__c, 
                                                Nombre_jours_theoriques_Controle__c, 
                                                Nombre_jours_theoriques_Justification__c, 
                                                Nombre_jours_theoriques_Valorisation__c, 
                                                Nombre_jours_travailles_Audit__c, 
                                                Nombre_jours_travailles_Controle__c, 
                                                Nombre_jours_travailles_Justification__c, 
                                                Nombre_jours_travailles_Valorisation__c,
                                                Nombre_jours_restants_Audit__c,
                                                Nombre_jours_restants_Valorisation__c, 
                                                Nombre_jours_restants_Justification__c,
                                                Nombre_jours_restants_Controle__c 
                                            FROM INNOequipeConsulting__c
                                            WHERE MissionCIR__r.Statut__c IN ('Inactive', 'Active')
                                                AND Utilisateur__c = :this.dummyEquipe.Utilisateur__c
                                                AND Actif__c = true
                                                AND (Nombre_jours_restants_Audit__c > 0
                                                    OR Nombre_jours_restants_Valorisation__c > 0
                                                    OR Nombre_jours_restants_Justification__c > 0
                                                    OR Nombre_jours_restants_Controle__c > 0
                                                    )
                                            ORDER BY MissionCIR__r.Name]){
            
            this.results.add(new TeamMember(eq));
                
        }
    }
    
    public void saveMembers(){
        
        List<INNOequipeConsulting__c> membersToUpsert = new List<INNOequipeConsulting__c>();
        
        
        /**
         * Initisalitation de dupeMembersByMissionIdUserId avec:
         *  - clé: IdMissionCIR-IdUser
         *  - valeur: objet equipe consulting pour cet mission/utilisateur s'il existe
         */
        Map<String, INNOequipeConsulting__c> dupeMembersByMissionIdUserId = new Map<String ,INNOequipeConsulting__c>();
        for(TeamMember member : this.results){
            dupeMembersByMissionIdUserId.put(member.newMember.MissionCIR__c + '-' + member.newMember.Utilisateur__c, null);
        }
        for(INNOequipeConsulting__c eq : [SELECT Id, Mission_Utilisateur__c, Nombre_jours_theoriques_Audit__c, Nombre_jours_theoriques_Valorisation__c, Nombre_jours_theoriques_Justification__c, Nombre_jours_theoriques_Controle__c FROM INNOequipeConsulting__c WHERE Mission_Utilisateur__c IN :dupeMembersByMissionIdUserId.keySet()]){
            dupeMembersByMissionIdUserId.put(eq.Mission_Utilisateur__c, eq);
        }
        
        System.debug(dupeMembersByMissionIdUserId);
        List<Id> reaffectedMissionIds = new List<Id> ();
        
        INNOequipeConsulting__c tempDupeMember;
        for(TeamMember member : this.results){
            
            if(member.newMember.Utilisateur__c != null && member.newMember.Utilisateur__c != this.dummyEquipe.Utilisateur__c){
                
                //Désactivation et décrémentation des temps théorique de l'ancien utilisateur
                member.oldMember.Actif__c = false;
                member.oldMember.Nombre_jours_theoriques_Audit__c           = Math.min(member.oldMember.Nombre_jours_travailles_Audit__c, member.oldMember.Nombre_jours_theoriques_Audit__c);
                member.oldMember.Nombre_jours_theoriques_Valorisation__c    = Math.min(member.oldMember.Nombre_jours_travailles_Valorisation__c, member.oldMember.Nombre_jours_theoriques_Valorisation__c);
                member.oldMember.Nombre_jours_theoriques_Justification__c   = Math.min(member.oldMember.Nombre_jours_travailles_Justification__c, member.oldMember.Nombre_jours_theoriques_Justification__c);
                member.oldMember.Nombre_jours_theoriques_Controle__c        = Math.min(member.oldMember.Nombre_jours_travailles_Controle__c, member.oldMember.Nombre_jours_theoriques_Controle__c);
                membersToUpsert.add(member.oldMember);
                
                
                tempDupeMember = dupeMembersByMissionIdUserId.get(member.newMember.MissionCIR__c + '-' + member.newMember.Utilisateur__c);
                
                //Si le nouvel utilisateur est déjà dans l'equipe consulting de la mission, on modifie ses temps theoriques
                if(tempDupeMember != null){
                    tempDupeMember.Actif__c = true;
                    tempDupeMember.Role__c = member.newMember.Role__c;
    
                    tempDupeMember.Nombre_jours_theoriques_Audit__c += member.newMember.Nombre_jours_theoriques_Audit__c;
                    tempDupeMember.Nombre_jours_theoriques_Valorisation__c += member.newMember.Nombre_jours_theoriques_Valorisation__c;
                    tempDupeMember.Nombre_jours_theoriques_Justification__c += member.newMember.Nombre_jours_theoriques_Justification__c;
                    tempDupeMember.Nombre_jours_theoriques_Controle__c += member.newMember.Nombre_jours_theoriques_Controle__c;
                    membersToUpsert.add(tempDupeMember);
                }
                //Sinon ajout du nouveau utilisateur dans l'equipe consulting
                else
                    membersToUpsert.add(member.newMember);
                    
                reaffectedMissionIds.add(member.newMember.MissionCIR__c);  
            }
        }
        
        upsert membersToUpsert;
        
        delete [SELECT Id FROM INNOtimeSheet__c WHERE Utilisateur__c = :this.dummyEquipe.Utilisateur__c AND Passee__c = false AND Mission_CIR__c IN :reaffectedMissionIds];
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, reaffectedMissionIds.size() + ' missions réaffectées'));
        
        this.searchEquipes();
    }
    
    
    
    /**
     * Wrapper class correspondant à une equipe consulting à réattribuer
     */
    public class TeamMember{
        
        public INNOequipeConsulting__c oldMember {get; set;}
        
        public INNOequipeConsulting__c newMember {get; set;}
        
        
        
        public TeamMember(INNOequipeConsulting__c oldMember){
            this.oldMember = oldMember;
            
            this.newMember = new INNOequipeConsulting__c(MissionCIR__c                               = oldMember.MissionCIR__c, 
                                                            Role__c                                     = oldMember.Role__c,
                                                            Nombre_jours_theoriques_Audit__c            = Math.max(0, oldMember.Nombre_jours_restants_Audit__c),
                                                            Nombre_jours_theoriques_Valorisation__c     = Math.max(0, oldMember.Nombre_jours_restants_Valorisation__c),
                                                            Nombre_jours_theoriques_Justification__c    = Math.max(0, oldMember.Nombre_jours_restants_Justification__c),
                                                            Nombre_jours_theoriques_Controle__c         = Math.max(0, oldMember.Nombre_jours_restants_Controle__c)
                                                            );
            
        }
        
    }
}