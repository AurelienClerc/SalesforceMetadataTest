public class INNOvalorisationChecker {
    
    public Id valoId {get;set;}
    public List<Erreur> erreurs {get; set;}
    public Map<String,List<String>> erreursByType {get; set;}
    public List<Info> infos {get; set;}
    
    public INNOvalorisationChecker(){
        this.valoId = Apexpages.currentPage().getParameters().get('valoId');
        this.erreurs = new List<Erreur>();
        this.erreursByType = new Map<String,List<String>>();
        this.infos = new List<Info>();
        
        INNOvalo__c valo = [ SELECT Id,
                                    Entite__c,
                                    Name,
                                    MissionCIR__r.Annee_CIR__c,
                                    Total_prestataire_public_option1__c,Total_prestataire_public_option2__c,Total_prestataire_public_option3__c,
                                    Total_prestataire_agree_option1__c,Total_prestataire_agree_option2__c,Total_prestataire_agree_option3__c,
                                    Total_salarie_option1__c,Total_salarie_option2__c,Total_salarie_option3__c,
                                    Total_amortissement_option1__c,Total_amortissement_option2__c,Total_amortissement_option3__c,
                                    Total_brevetAssu_option1__c,Total_brevetAssu_option2__c,Total_brevetAssu_option3__c,
                                    Total_brevetDef_option1__c,Total_brevetDef_option2__c,Total_brevetDef_option3__c,
                                    Total_brevetPM_option1__c,Total_brevetPM_option2__c,Total_brevetPM_option3__c,
                                    Total_jeuneDocteur_option1__c,Total_jeuneDocteur_option2__c,Total_jeuneDocteur_option3__c,
                                    Total_miseDisposition_option1__c,Total_miseDisposition_option2__c,Total_miseDisposition_option3__c,
                                    Total_normalisation_option1__c,Total_normalisation_option2__c,Total_normalisation_option3__c,
                                    Total_veille_option1__c,Total_veille_option2__c,Total_veille_option3__c,
                                    Total_heures_RD_option1__c, Total_heures_RD_option2__c, Total_heures_RD_option3__c,
                                    (SELECT Id, Salaire_charge_option1__c,Salaire_charge_option2__c,Salaire_charge_option3__c FROM Depenses_de_personnel__r),
                                    (SELECT Id FROM Projets__r),
                                    (SELECT Id, Name, Projet__c, Organisme__c FROM subventions__r WHERE RecordType.DeveloperName = 'subvention'),
                                    (SELECT Id, Name, Projet__c, Prestataire__c FROM Depenses_de_prestation__r WHERE recordtype.DeveloperName = 'prestataire'),
                                    (SELECT Id, Name, Projet__c FROM Amortissements__r WHERE recordtype.DeveloperName = 'amortissement')
                            FROM INNOvalo__c WHERE Id = :this.valoId];
                            
        List<INNOvalo__c> valosN1 = [SELECT Name,
                                            MissionCIR__r.Annee_CIR__c,
                                            Total_salarie_option1__c,Total_salarie_option2__c,Total_salarie_option3__c,
                                            Total_amortissement_option1__c,Total_amortissement_option2__c,Total_amortissement_option3__c,
                                            Total_prestataire_agree_option1__c,Total_prestataire_agree_option2__c,Total_prestataire_agree_option3__c,
                                            Total_prestataire_public_option1__c,Total_prestataire_public_option2__c,Total_prestataire_public_option3__c,
                                            Total_heures_RD_option1__c, Total_heures_RD_option2__c, Total_heures_RD_option3__c,
                                            (SELECT Id FROM Projets__r),
                                            (Select Id, Salaire_charge_option1__c,Salaire_charge_option2__c,Salaire_charge_option3__c FROM Depenses_de_personnel__r),
                                            (SELECT Id, Projet__c FROM subventions__r WHERE RecordType.DeveloperName = 'subvention') 
                                            FROM INNOvalo__c
                                            WHERE Entite__c = :valo.Entite__c and MissionCIR__r.Annee_CIR__c = :(String.valueOf(Integer.valueOf(valo.MissionCIR__r.Annee_CIR__c) - 1)) 
                                            LIMIT 1];
        INNOvalo__c valoN1 = valosN1.isEmpty() ? null : valosN1[0];
        
        List<INNOprojet__c> projets = [SELECT   Id,
                                                Name, 
                                                (SELECT Id, Depense_de_personnel__r.ingenieur_docteur__c, Heures_RD_option1__c, Heures_RD_option2__c, Heures_RD_option3__c FROM Depenses_de_personnel_to_projets__r ) 
                                                FROM INNOprojet__c 
                                                WHERE Id in :valo.projets__r and type__c = 'projet'];
        
        List<INNOdepensePersonnel__c> salaries = [  SELECT  Id,
                                                            Date_entree__c,
                                                            Date_sortie__c,
                                                            Heures_brevetPM_option1__c,Heures_brevetPM_option2__c,Heures_brevetPM_option3__c,
                                                            Heures_normalisation_option1__c,Heures_normalisation_option2__c,Heures_normalisation_option3__c,
                                                            Heures_RD_option1__c,Heures_RD_option2__c,Heures_RD_option3__c,
                                                            Heures_veille_option1__c,Heures_veille_option2__c,Heures_veille_option3__c,
                                                            Name,
                                                            Statut__c,
                                                            Salaire_charge_option1__c,Salaire_charge_option2__c,Salaire_charge_option3__c,
                                                            Taux_RD_option1__c,Taux_RD_option2__c,Taux_RD_option3__c,
                                                            Total_heures_travaillees_option1__c,Total_heures_travaillees_option2__c,Total_heures_travaillees_option3__c,
                                                            (SELECT Id FROM subventions__r WHERE RecordType.DeveloperName = 'subvention')
                                                    FROM INNOdepensePersonnel__c 
                                                    WHERE Id in :valo.Depenses_de_personnel__r AND Actif__c = true];
                                                    
        Map<String, INNOdepensePersonnel__c> salariesN1 = new Map<String, INNOdepensePersonnel__c>();
        AggregateResult[] groupedResults = new AggregateResult[]{};
        if(valoN1 != null){
            for(INNOdepensePersonnel__c salarieN1 : [  SELECT  Id,
                                                            Date_entree__c,
                                                            Date_sortie__c,
                                                            Heures_brevetPM_option1__c,Heures_brevetPM_option2__c,Heures_brevetPM_option3__c,
                                                            Heures_normalisation_option1__c,Heures_normalisation_option2__c,Heures_normalisation_option3__c,
                                                            Heures_RD_option1__c,Heures_RD_option2__c,Heures_RD_option3__c,
                                                            Heures_veille_option1__c,Heures_veille_option2__c,Heures_veille_option3__c,
                                                            Name,
                                                            Statut__c,
                                                            Salaire_charge_option1__c,Salaire_charge_option2__c,Salaire_charge_option3__c,
                                                            Taux_RD_option1__c,Taux_RD_option2__c,Taux_RD_option3__c,
                                                            Total_heures_travaillees_option1__c,Total_heures_travaillees_option2__c,Total_heures_travaillees_option3__c,
                                                            (SELECT Id FROM subventions__r WHERE RecordType.DeveloperName = 'subvention')
                                                            FROM INNOdepensePersonnel__c 
                                                            WHERE Id in :valoN1.Depenses_de_personnel__r AND Actif__c = true]){
                salariesN1.put(salarieN1.Name,salarieN1);
            }
            
            groupedResults = [ SELECT 
                                sum(Total_heures_travaillees_option1__c),   //expr0
                                sum(Total_heures_travaillees_option2__c),   //expr1
                                sum(Total_heures_travaillees_option3__c),   //expr2
                                count (Id),                                 //expr3
                                sum(Salaire_charge_option1__c),             //expr4
                                sum(Salaire_charge_option2__c),             //expr5
                                sum(Salaire_charge_option3__c)              //expr6
                                FROM INNOdepensePersonnel__c 
                                WHERE (Valorisation__c = :valo.Id OR Valorisation__c = :valoN1.Id) AND Actif__c = true 
                                GROUP BY Valorisation__r.MissionCIR__r.Annee_CIR__c 
                                ORDER BY Valorisation__r.MissionCIR__r.Annee_CIR__c DESC];
        }
            
        //erreurs salaries                                            
        for(INNOdepensePersonnel__c s : salaries){
            
            if(s.Taux_RD_option1__c > 100)
                this.erreurs.add(new Erreur('IsValidTauxRD1',s.Name));
            if(s.Taux_RD_option2__c > 100)
                this.erreurs.add(new Erreur('IsValidTauxRD2',s.Name));
            if(s.Taux_RD_option3__c > 100)
                this.erreurs.add(new Erreur('IsValidTauxRD3',s.Name));
            if(s.Statut__c == 'Thésard' && s.subventions__r.size() == 0)    
                this.erreurs.add(new Erreur('ThesardHasSubvention',s.Name));
            
            Date DateDebut = Date.valueOf(valo.MissionCIR__r.Annee_CIR__c + '-01-01') > s.Date_entree__c || s.Date_entree__c == null ?  Date.valueOf(valo.MissionCIR__r.Annee_CIR__c + '-01-01') : s.Date_entree__c ;
            Date DateFin   = Date.valueOf(valo.MissionCIR__r.Annee_CIR__c + '-12-31') < s.Date_sortie__c || s.Date_sortie__c == null ?  Date.valueOf(valo.MissionCIR__r.Annee_CIR__c + '-12-31') : s.Date_sortie__c ;
            Double NbHeuresAnnees  = (DateDebut.daysBetween(DateFin) / 30.42) * 151.67;
            
            if(NbHeuresAnnees <= s.Total_heures_travaillees_option1__c)
                this.erreurs.add(new Erreur('CoherenceHeuresTravaillees1',s.Name));
            if(NbHeuresAnnees <= s.Total_heures_travaillees_option2__c)
                this.erreurs.add(new Erreur('CoherenceHeuresTravaillees2',s.Name));
            if(NbHeuresAnnees <= s.Total_heures_travaillees_option3__c)
                this.erreurs.add(new Erreur('CoherenceHeuresTravaillees3',s.Name));
                
            if(s.Heures_veille_option1__c + s.Heures_normalisation_option1__c + s.Heures_brevetPM_option1__c + s.Heures_RD_option1__c > s.Total_heures_travaillees_option1__c)
                this.erreurs.add(new Erreur('IsValidHeuresValorisees1',s.Name));    
            if(s.Heures_veille_option2__c + s.Heures_normalisation_option2__c + s.Heures_brevetPM_option2__c + s.Heures_RD_option2__c > s.Total_heures_travaillees_option2__c)
                this.erreurs.add(new Erreur('IsValidHeuresValorisees2',s.Name));
            if(s.Heures_veille_option3__c + s.Heures_normalisation_option3__c + s.Heures_brevetPM_option3__c + s.Heures_RD_option3__c > s.Total_heures_travaillees_option3__c)
                this.erreurs.add(new Erreur('IsValidHeuresValorisees3',s.Name));
            
            if(salariesN1.containsKey(s.Name)){
                if( s.Salaire_charge_option1__c > 0 && salariesN1.get(s.Name).Salaire_charge_option1__c > 0)
                    if(Math.abs((s.Salaire_charge_option1__c - salariesN1.get(s.Name).Salaire_charge_option1__c )/ s.Salaire_charge_option1__c) >= 0.1)
                        this.erreurs.add(new Erreur('CoherenceSalaireSalarie1',s.Name));
                if( s.Salaire_charge_option2__c > 0 && salariesN1.get(s.Name).Salaire_charge_option2__c > 0)
                    if(Math.abs((s.Salaire_charge_option2__c - salariesN1.get(s.Name).Salaire_charge_option2__c )/ s.Salaire_charge_option2__c) >= 0.1)
                        this.erreurs.add(new Erreur('CoherenceSalaireSalarie2',s.Name));
                if( s.Salaire_charge_option3__c > 0 && salariesN1.get(s.Name).Salaire_charge_option3__c > 0)
                    if(Math.abs((s.Salaire_charge_option3__c - salariesN1.get(s.Name).Salaire_charge_option3__c )/ s.Salaire_charge_option3__c) >= 0.1)
                        this.erreurs.add(new Erreur('CoherenceSalaireSalarie3',s.Name));
            }
        }   
        
        //erreurs projets
        for(INNOprojet__c p : projets){
            
            Boolean hasIngenieurDocteur = false;
            for(INNOpersonnelToProjet__c depense : p.Depenses_de_personnel_to_projets__r){
                //On vérifie qu'il y a un ingenieur/docteur qui a travaillé sur le projet
                if(!hasIngenieurDocteur){
                    Decimal heures = 0;
                    heures += depense.Heures_RD_option1__c != null ? depense.Heures_RD_option1__c : 0;
                    heures += depense.Heures_RD_option2__c != null ? depense.Heures_RD_option2__c : 0;
                    heures += depense.Heures_RD_option3__c != null ? depense.Heures_RD_option3__c : 0;
                    hasIngenieurDocteur = (depense.Depense_de_personnel__r.ingenieur_docteur__c && heures > 0);
                }
            }
            if(!hasIngenieurDocteur)
                this.erreurs.add(new Erreur('IsValidInge_Docteur',p.Name));
        }
        
        //erreurs valo
        List<string> SumProperties = new String[]{'Total_prestataire_public','Total_salarie','Total_amortissement','Total_brevetAssu','Total_brevetDef','Total_brevetPM','Total_jeuneDocteur','Total_miseDisposition','Total_normalisation','Total_veille'};
        Decimal Sum = 0;
        for(Integer i=1; i<=3;i++){
            sum = 0;
            for(String prop : SumProperties){
                sum += (Decimal) valo.get(prop + '_option'+i+'__c');
            }
            if((Decimal) valo.get('Total_prestataire_agree_option'+i+'__c') >= (sum * 3) && (Decimal) valo.get('Total_prestataire_agree_option'+i+'__c') > 12000000){
                this.erreurs.add(new Erreur('CoherencePlafondPresta'+i,'Le montant des prestataires est supérieur à 12 000 000€. Ce plafond a été pris en compte dans la synthèse ci-dessous mais PAS dans l\'export Excel de valorisation ni dans le CERFA!'));    
                break;
            }
        }
        
        //erreurs amortissements
        for(INNOamortissement__c am : valo.amortissements__r){
            if(am.projet__c == null)
                this.erreurs.add(new Erreur('CoherenceAmortissement',am.Name));
        }
        
        //erreurs prestations
        for(INNOdepensePrestation__c presta : valo.Depenses_de_prestation__r){
            if(presta.projet__c == null)
                this.erreurs.add(new Erreur('CoherencePrestation',presta.Prestataire__c));
        }
        
        //erreurs subventions
        for(INNOsubvention__c subvention : valo.subventions__r){
            if(subvention.projet__c == null)
                this.erreurs.add(new Erreur('CoherenceSubvention',subvention.Organisme__c));
        }
        
        for(Erreur err : this.erreurs){
            if(!this.erreursByType.containsKey(err.erreurType))
                this.erreursByType.put(err.erreurType,new List<String>());
            
            if(this.erreursByType.get(err.erreurType).size() < 1000)
                this.erreursByType.get(err.erreurType).add(err.value);  
        }
        
        //infos
        if(valoN1 != null){
            
            this.infos.add(new Info('CoherenceSalaire1',  Math.round(valo.Total_salarie_option1__c), Math.round(valoN1.Total_salarie_option1__c)));
            this.infos.add(new Info('CoherenceSalaire2',  Math.round(valo.Total_salarie_option2__c), Math.round(valoN1.Total_salarie_option2__c)));
            this.infos.add(new Info('CoherenceSalaire3',  Math.round(valo.Total_salarie_option3__c), Math.round(valoN1.Total_salarie_option3__c)));
            
            this.infos.add(new Info('MontantTotalDA1',  Math.round(valo.Total_amortissement_option1__c), Math.round(valoN1.Total_amortissement_option1__c)));
            this.infos.add(new Info('MontantTotalDA2',  Math.round(valo.Total_amortissement_option2__c), Math.round(valoN1.Total_amortissement_option2__c)));
            this.infos.add(new Info('MontantTotalDA3',  Math.round(valo.Total_amortissement_option3__c), Math.round(valoN1.Total_amortissement_option3__c)));
    
            this.infos.add(new Info('MontantTotalPresta1',  Math.round(valo.Total_prestataire_agree_option1__c + valo.Total_prestataire_public_option1__c), Math.round(valoN1.Total_prestataire_agree_option1__c + valoN1.Total_prestataire_public_option1__c)));
            this.infos.add(new Info('MontantTotalPresta2',  Math.round(valo.Total_prestataire_agree_option2__c + valo.Total_prestataire_public_option2__c), Math.round(valoN1.Total_prestataire_agree_option2__c + valoN1.Total_prestataire_public_option2__c)));
            this.infos.add(new Info('MontantTotalPresta3',  Math.round(valo.Total_prestataire_agree_option3__c + valo.Total_prestataire_public_option3__c), Math.round(valoN1.Total_prestataire_agree_option3__c + valoN1.Total_prestataire_public_option3__c)));
            
            if(groupedResults.size() == 2){
                
                //ErrDivide by 0
                if((Decimal) groupedResults[0].get('expr0') > 0 &&  (Decimal) groupedResults[1].get('expr0') > 0)
                    this.infos.add(new Info('tauxRD1',  valo.Total_heures_RD_option1__c / (Decimal) groupedResults[0].get('expr0'), valoN1.Total_heures_RD_option1__c / (Decimal) groupedResults[1].get('expr0')));
                if((Decimal) groupedResults[0].get('expr1') > 0 &&  (Decimal) groupedResults[1].get('expr1') > 0)
                    this.infos.add(new Info('tauxRD2',  valo.Total_heures_RD_option2__c / (Decimal) groupedResults[0].get('expr1'), valoN1.Total_heures_RD_option2__c / (Decimal) groupedResults[1].get('expr1')));
                if((Decimal) groupedResults[0].get('expr2') > 0 &&  (Decimal) groupedResults[1].get('expr2') > 0)
                    this.infos.add(new Info('tauxRD3',  valo.Total_heures_RD_option3__c / (Decimal) groupedResults[0].get('expr2'), valoN1.Total_heures_RD_option3__c / (Decimal) groupedResults[1].get('expr2')));
                 
                if((Decimal) groupedResults[0].get('expr0') > 0 &&  (Decimal) groupedResults[1].get('expr0') > 0)
                    this.infos.add(new Info('tauxhoraire1',  (Decimal) groupedResults[0].get('expr4') / (Decimal) groupedResults[0].get('expr0'), (Decimal) groupedResults[1].get('expr4') / (Decimal) groupedResults[1].get('expr0')));
                if((Decimal) groupedResults[0].get('expr1') > 0 &&  (Decimal) groupedResults[1].get('expr1') > 0)
                    this.infos.add(new Info('tauxhoraire2',  (Decimal) groupedResults[0].get('expr5') / (Decimal) groupedResults[0].get('expr1'), (Decimal) groupedResults[1].get('expr5') / (Decimal) groupedResults[1].get('expr1')));
                if((Decimal) groupedResults[0].get('expr2') > 0 &&  (Decimal) groupedResults[1].get('expr2') > 0)
                    this.infos.add(new Info('tauxhoraire3',  (Decimal) groupedResults[0].get('expr6') / (Decimal) groupedResults[0].get('expr2'), (Decimal) groupedResults[1].get('expr6') / (Decimal) groupedResults[1].get('expr2')));
                
                this.infos.add(new Info('totalheures1', Math.Round((Decimal) (groupedResults[0].get('expr0') == null ? 0 : groupedResults[0].get('expr0'))), Math.Round((Decimal) (groupedResults[1].get('expr0') == null ? 0 : groupedResults[1].get('expr0')))));
                this.infos.add(new Info('totalheures2', Math.Round((Decimal) (groupedResults[0].get('expr1') == null ? 0 : groupedResults[0].get('expr1'))), Math.Round((Decimal) (groupedResults[1].get('expr1') == null ? 0 : groupedResults[1].get('expr1')))));
                this.infos.add(new Info('totalheures3', Math.Round((Decimal) (groupedResults[0].get('expr2') == null ? 0 : groupedResults[0].get('expr2'))), Math.Round((Decimal) (groupedResults[1].get('expr2') == null ? 0 : groupedResults[1].get('expr2')))));
            }
            
            this.infos.add(new Info('totalheuresRD1',  Math.round(valo.Total_heures_RD_option1__c), Math.round(valoN1.Total_heures_RD_option1__c)));
            this.infos.add(new Info('totalheuresRD2',  Math.round(valo.Total_heures_RD_option2__c), Math.round(valoN1.Total_heures_RD_option2__c)));
            this.infos.add(new Info('totalheuresRD3',  Math.round(valo.Total_heures_RD_option3__c), Math.round(valoN1.Total_heures_RD_option3__c)));
            
            if(groupedResults.size() == 2){
                this.infos.add(new Info('totalsalarie', Math.Round((Decimal) (groupedResults[0].get('expr3') == null ? 0 : groupedResults[0].get('expr3'))), Math.Round((Decimal) (groupedResults[1].get('expr3') == null ? 0 : groupedResults[1].get('expr3')))));
            }
        }
    }
    
    public class Erreur{
        
        public String erreurType {get;set;}         //IsValidInge_Docteur
        public String value {get;set;}              //Projet__c.Name
        
        public Erreur(String erreurType, String value){
            this.erreurType = erreurType;
            this.value = value;
        }
    }
    
    public class Info{
        
        public String infoType {get;set;}           //CoherenceSalaire1
        public String valueN {get;set;}
        public String valueN1 {get;set;}
        public Boolean alert {get;set;}
        
        public Info(String infoType, Integer valueN, Integer valueN1){
            this.infoType = infoType;
            this.valueN = String.valueOf(valueN);
            this.valueN1 = String.valueOf(valueN1);
            
            if(this.infoType.startsWith('CoherenceSalaire') && valueN > 0){
                if(Math.abs(valueN1-valueN / valueN) > 0.1)
                    this.alert = true;
            }
            
            if(this.infoType.startsWith('MontantTotalDA')){
                if(Math.abs(valueN1-valueN) > 2)
                    this.alert = true;
            }
        }
        
        public Info(String infoType, Decimal valueN, Decimal valueN1){
            
            this.infoType = infoType;
            
            if(this.infoType.startsWith('tauxRD')){
                this.valueN = String.valueOf((valueN * 100).setScale(2)) + ' %';
                this.valueN1 = String.valueOf((valueN1 * 100).setScale(2)) + ' %';
            }
            else if(this.infoType.startsWith('tauxhoraire')){
                this.valueN = String.valueOf(valueN.setScale(2)) + ' €';
                this.valueN1 = String.valueOf(valueN1.setScale(2)) + ' €';
            }
            else{
                this.valueN = String.valueOf(valueN.setScale(2));
                this.valueN1 = String.valueOf(valueN1.setScale(2));
            }
            
            if(this.infoType.startsWith('CoherenceSalaire') && valueN > 0){
                if(Math.abs(valueN1-valueN / valueN) > 0.1)
                    this.alert = true;
            }
        }
    }
}