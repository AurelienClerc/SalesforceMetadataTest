public class V2AP02_SegmentationConcurrentManager {
    public static Map<String,Historique_Segmentation__c> refIdExtSegmentation;
    
    public static final boolean boverwritteSegmentation = false;
    
    public static Set<id> setAccountsId;
    
    public static list<string> lBus;
    
    public static final list<string> lConcurrentFields = new list<string>{'concurrent__c','autre_concurrent__c','annees_concernees_concurrent__c'};
    
    public static list<string> lAllConcurrentFields;
    
    static{
        refIdExtSegmentation = new Map<String,Historique_Segmentation__c>();
        setAccountsId = new set<id>();
        lBus = new list<string>();
        lBus.addAll(V2AP01_SegmentationManager.refFieldsByBU.keySet());
        lAllConcurrentFields = new list<string>();
        for(String sBu : lBus){
            for(String c : lConcurrentFields)
                lAllConcurrentFields.add(sBu+'_'+c);
        }
    }
    
    //Remplissage d'une map idExterne => histo
    public static void addItem(Historique_Segmentation__c h){
        String idExt = V2AP01_SegmentationManager.getHistoIdExterne(h.compte__c, Integer.valueOf(h.annee__c));
        if(!setAccountsId.contains(h.compte__c))
            setAccountsId.add(h.compte__c);
        if(!refIdExtSegmentation.containsKey(idExt))
            refIdExtSegmentation.put( idExt, h );
    }
    
    
    //Retourne la liste des histo à upserter en fonction des histo qu'on a déjà mis
    public static List<Historique_Segmentation__c> processCalc(){
        system.debug('###IN V2AP02_SegmentationConcurrentManager.processCalc');
        Map<string,Historique_Segmentation__c> refHistosGeneres = new Map<string,Historique_Segmentation__c>();
        Map<String,Historique_Segmentation__c> refReturnValue   = new Map<String,Historique_Segmentation__c>();
        Set<Id> setTmpAccountId = setAccountsId;      //On recopie setAccountId pour pouvoir l'utilisre dans une requête soql en string (bug apex)


        set<string> sDoneIdsExt = new Set<string>();
        //On va se créer une map des histo qu'on a envie d'upserter
        for( Historique_Segmentation__c h : refIdExtSegmentation.values() )         //Pour toutes les histos dans le trigger
        {    
            for( string sBu : lBus )                                                 //Pour toutes les bus
            {                                                
                string sCurrentField = sBu +'_annees_concernees_concurrent__c';       //On se base sur années concernées concurrent de cette bu
                
                if((String) h.get( sCurrentField ) != null)                         //Si on a renseigné l'année concernée pour cette bu et cet histo, il va falloir générer tous les histos des années concernées :
                {                        
                    
                    String sGestionDuDossier = (String) h.get( sBu + '_concurrent__c');
                    String sAutreConcurrent  = (String) h.get( sBu + '_autre_concurrent__c');
                    List<String> lAnneesConcernees = ((String) h.get(sCurrentField) ).split(';');       //On va splitter sur les années concerntées
                    
                    for(string sAnnee : lAnneesConcernees)                          //Pour chaque année concernée
                    {                 
                        integer iAnnee = integer.valueOf(sAnnee);
                        if(iAnnee != Integer.valueOf(h.annee__c))                   //Si l'année est différente de celle sur laquelle on est
                        {
                            string newKey  = V2AP01_SegmentationManager.getHistoIdExterne(h.compte__c, Integer.valueOf(iAnnee));    //On génere un id externe pour faire un upsert
                            if(refIdExtSegmentation.containsKey(newKey)) //Cas ou l'histo qu'on veut mettre a jour est dans notre map de trigger (dans ce cas la, on rempli cet objet là au lieu de remplir les autres, vu que ce code s'exectue en trigger before, tout sera automatiquement mis a jour)
                            {   
                                if((refIdExtSegmentation.get(newKey).get(sCurrentField) == null  || boverwritteSegmentation ) && !sDoneIdsExt.contains(newKey)){   //On le rempli uniquement si le concurrent n'est pas renseignée (et si on n'est pas déjà passé par cet id).
                                    refIdExtSegmentation.get(newKey).put( sBu +'_concurrent__c', sGestionDuDossier );
                                    refIdExtSegmentation.get(newKey).put( sBu +'_autre_concurrent__c', sAutreConcurrent );
                                    refIdExtSegmentation.get(newKey).put( sCurrentField ,h.get( sCurrentField ));
                                    sDoneIdsExt.add(newKey);        //On se met une map de controle pour ne pas repasser par cet id.
                                }
                            }
                            else  //Cas ou l'histo qu'on veut mettre a jour n'est pas dans notre map de trigger (dans ce cas la, rempli un autre objet qu'on va upserter)
                            {
                                if( !refHistosGeneres.containsKey(newKey) )   //On n'a jamais généré cet histo dans une autre BU
                                {
                                    refHistosGeneres.put(newKey,new Historique_Segmentation__c(id_externe__c = newKey,compte__c=h.compte__c, annee__c = iAnnee));
                                }
                                refHistosGeneres.get(newKey).put(sBu + '_concurrent__c',sGestionDuDossier);
                                refHistosGeneres.get(newKey).put(sBu + '_autre_concurrent__c',sAutreConcurrent);
                                refHistosGeneres.get(newKey).put( sCurrentField , h.get(sCurrentField));
                            }
                        }
                    }
                }
            }
        }
        system.debug('###V2AP02_SegmentationConcurrentManager.processCalcrefHistoGeneres ' + refHistosGeneres);
        set<string> setNePasRafraichir = new Set<string>();
        if(!setTmpAccountId.isEmpty()){
            //On ne va faire une mise a jour des objet qu'on a généré uniquement si les objets existants n'ont pas de données concurrent renseignées        
            for(Historique_Segmentation__c h : database.query('SELECT id_externe__c,compte__c,annee__c,'+string.join(lAllConcurrentFields,',')+' from historique_segmentation__c where compte__c in : setTmpAccountId')){
                if(refHistosGeneres.containsKey(h.id_externe__c) )    //L'histo généré qu'on veut mettre a jour existe
                {   
                    boolean bArafraichir = false;
                    Historique_Segmentation__c oHistoARetourner = new historique_segmentation__c(id_externe__c = h.id_externe__c, compte__c = h.compte__c,annee__c = h.annee__c);
                    historique_segmentation__c oHistoGenere     = refHistosGeneres.get(h.id_externe__c);
                    //On va vérifier qu'on n'écrase rien pour chaque BU
                    for(String sBu : lbus){
                        string sCurrentField = sBu + '_annees_concernees_concurrent__c';
                        if( refHistosGeneres.get( h.id_externe__c ).get( sCurrentField ) != null && (h.get( sCurrentField ) == null || boverwritteSegmentation))
                        {
                            oHistoARetourner.put( sBu + '_concurrent__c', oHistoGenere.get( sBu + '_concurrent__c') );
                            oHistoARetourner.put( sBu + '_autre_concurrent__c'  , oHistoGenere.get( sBu + '_autre_concurrent__c')  );
                            oHistoARetourner.put( sCurrentField , h.get(sCurrentField) );
                            bArafraichir = true;
                        }
                    }
                    if(bArafraichir)
                        refReturnValue.put( oHistoARetourner.id_externe__c, oHistoARetourner );
                    else
                        setNePasRafraichir.add(oHistoARetourner.id_externe__c);
                }
            }
        }
        system.debug('###V2AP02_SegmentationConcurrentManager.processCalc refReturnValue ' + refReturnValue);
        for(historique_segmentation__c hRet : refHistosGeneres.values()){
            if(!refReturnValue.containsKey(hret.id_externe__c) && !setNePasRafraichir.contains(hret.id_externe__c))
                refReturnValue.put( hret.id_externe__c, hret );
        }
        system.debug('###OUT V2AP02_SegmentationConcurrentManager.processCalc refReturnValue apres les générés ' + refReturnValue);
        //On vide nos valeurs de travail : 
        refIdExtSegmentation = new map<String,Historique_Segmentation__c>();
        return refReturnValue.values();
    }
    
    
}