global without sharing class FactuUtils {

    /**
     *  Retourne une adresse formaté avec 'separator' comme séparateur
     *  @exemple si separator = '\n'
     *    Rue
     *    CodePostal Ville
     *    Pays
     *  @exemple si separator = ','
     *    Rue, CodePostal Ville, Pays
     */
    global static String getAddress(sObject obj, String separator, Boolean showCountry){

        String streetField, postalCodeField, cityField, stateField, countryField;
        system.debug('###IN Get adress with '+showCountry);
        system.debug(obj);


        if(obj.getSObjectType() == Etablissement_secondaire__c.sObjectType){
            streetField = 'Rue__c';
            postalCodeField = 'Code_postal__c';
            stateField = 'D_partement_R_gion__c';
            cityField = 'Ville__c';
            countryField = 'Pays__c';
        }
        else{
            streetField = 'BillingStreet';
            postalCodeField = 'BillingPostalCode';
            stateField = 'BillingState';
            cityField = 'BillingCity';
            countryField = 'BillingCountry';
        }

        String address = '';
        address += (obj.get(streetField) == null ? '' : obj.get(streetField) + separator);

        if(showCountry){
            address += (obj.get(postalCodeField) == null ? '' : obj.get(postalCodeField) + ' ') + (obj.get(cityField) == null ? '' : obj.get(cityField)) + (obj.get(postalCodeField) != null && obj.get(cityField) != null ? separator : '');
            address += (obj.get(countryField) == null ? '' : obj.get(countryField));
        }
        else{
            address += (obj.get(cityField) == null ? '' : obj.get(cityField)) + (obj.get(stateField) == null ? '' : (', ' + obj.get(stateField))) + (obj.get(cityField) != null || obj.get(stateField) != null ? separator : '');
            address += (obj.get(postalCodeField) == null ? '' : obj.get(postalCodeField) );

        }

        system.debug('###OUT GetAdresse with '+address);
        return address;
    }


    /**
     *  Retourne une adresse formaté avec 'separator' comme séparateur
     *  @exemple si separator = '\n'
     *    Rue
     *    CodePostal Ville
     *    Pays
     *  @exemple si separator = ','
     *    Rue, CodePostal Ville, Pays
     */
    global static String getAddress(sObject obj, String separator){

        return getAddress(obj, separator, true);
    }


    public static Map<String,set<Integer>> DerniersNumAttribues;

    /**
     *  Retourne un numéro de facture/avoir définitif
     *  @param Facture__c facture: la facture dont on veut avoir le numéro
     *  @param String missionRecordTypeName: le developerName du recordType de la mission à laquelle est rattachée la facture
     *  @return String: le numéro de facture
     */
    global static string getFactureNumber(Facture__c facture, String missionRecordTypeName){
        system.debug('###IN GetFactureNumber with '+facture.Name);


        //EDIT DIDIER 18/02/2014 : 
        /*
         * Bug de l'approbation en masse des factures: Quand on fait approuver plusieurs éléments en même temps, l'appli procède
         * facture par facture et refait une requête a chaque fois alors qu'on est en before update
         * Nescessité de mettre un map String,string en static pour socker le dernier n°Attribué
         */

        if(DerniersNumAttribues == null){
            DerniersNumAttribues = new Map<String,set<Integer>>();
        }

        String entityCompteur = missionRecordTypeName ;
        //Faire attention, l'espagne a des compteurs différents
        if(facture.Account_Record_Type__c == 'SPAIN_ACCOUNT' )
            entityCompteur += '_'+ facture.Entite_GAC__c;

        if(!DerniersNumAttribues.containsKey(entityCompteur)){
            DerniersNumAttribues.put(entityCompteur,new Set<Integer>());
        }



        //FIN EDIT DIDIER

        String factureName;

        //True si c’est un avoir, false sinon
        Boolean isAvoir = (facture.Montant_HT__c < 0) ;

        //Le nombre de chiffre qui compose le numéro de facture: 5 pour le Canada, 4 pour les autres
        Integer numbersLength = (missionRecordTypeName == 'CIR_CANADA' ? 5 : 4);

        //Si la facture n'avait pas déja un nom définif
        if(facture.Name.startsWith('TEMP-')){

            //EDIT DIDER 18/02/14 TODO : Lors d'un mass Approval=> DANGER de trop de soql => faire en sorte de réutiliser les numéros stockés dans DerniersNumAttribues 
            String req = 'SELECT Id, Name, Index_num_facture__c FROM Facture__c WHERE Entite_GAC__c = \'' + facture.Entite_GAC__c + '\' AND (NOT Name LIKE \'TEMP-%\') ';

            //Edit didier 31/01/2014
            if(facture.Account_Record_Type__c == 'SPAIN_ACCOUNT'){
                //Cas de l'espagne, on fait 2 compteurs distinct pour les avoirs et les factures, en plus des compteurs des entités...
                //On va donc rechercher le type de facture et filtrer la requete
                req += isAvoir ? ' AND montant_HT__c < 0 ' : ' AND montant_HT__c >= 0 ';
            }
            //Fin edit didier 31/01/2014


			//Pas avant 82 pour Singapour
			if(missionRecordTypeName == 'SGP_PIC'){
				req += ' AND Index_num_facture__c > 81 ';
			}


            //Pour le CANADA et SINGAPOUR les numéros se suivent quelque soit l'année, pour les autres pays, les numéros sont réinitialisés chaque année
            if(missionRecordTypeName != 'CIR_CANADA' && missionRecordTypeName != 'SGP_PIC')
                req += ' AND CALENDAR_YEAR(Date__c) = ' + facture.Date__c.year();
            
            
           

            req += ' ORDER BY Index_num_facture__c';
            system.debug(req);

            List<Facture__c> factures = database.query(req);


            system.debug('factures : '+factures);

            if(factures.isEmpty()){
                system.debug('1ere facture');

                //On commence à 10001 pour le canada
                if(missionRecordTypeName == 'CIR_CANADA')
                    factureName = '10001';
                
                else 
                    factureName = '0001';
                
            }else{


                Integer factuIndex;
                //Pour le CANADA, on ne cherche pas à combler les "trous" dans les numéros de factures
                if(missionRecordTypeName == 'CIR_CANADA'){
                    factuIndex = Math.max(Integer.valueOf(factures[factures.size() - 1].Index_num_facture__c) + 1, 10001);
                }
                
                //On va chercher à combler les "trous" dans les numéros de factures
                else{
                    
                    //Pas avant 82 pour Singapour
                    if(missionRecordTypeName == 'SGP_PIC'){
						factuIndex = 82;
					}
                    
                    else{
                    	factuIndex = 1; 
                    }
                    
                    for(Facture__c fact : factures){

                        if(fact.Index_num_facture__c > factuIndex 
                                && !DerniersNumAttribues.get(entityCompteur).contains(factuIndex) //EDIT DIDIER 18/02 => On vérifie qu'on l'a pas déjà attribué
                                )
                            break;
                        factuIndex ++;

                    }
				
					

                    //EDIT Didier 18/02
                    //On va maintenant y ajouter tous les numéro qu'on a déjà attribué dans le batch
                    while(DerniersNumAttribues.get(entityCompteur).contains(factuIndex)){
                        system.debug('###FactuGetNumber=>MassApproval, on saute le n°'+String.valueOf( factuIndex ));
                        factuIndex++;
                    }
                    
                    
                    //Et on stocke la valeur du batch;
                    DerniersNumAttribues.get(entityCompteur).add(factuIndex);
                    //Fin Edit Didier

                    
                    
                }

                factureName = String.valueOf( factuIndex );

                //Remplissage du numéro avec les zéros devant
                while(factureName.length() < numbersLength)
                    factureName = '0' + factureName;

                system.debug('Done findingName : '+factureName);
            }
        }

        else{
            if(facture.Account_Record_Type__c == 'SPAIN_ACCOUNT')
                factureName = facture.Name.replace('/'+DateTime.newInstance(facture.Date__c, Time.newInstance(0,0,0,0)).format('yyyy'),'').right(numbersLength);
            else
                factureName = facture.Name.right(numbersLength);
        }

        if(facture.Account_Record_Type__c == 'SPAIN_ACCOUNT'){

			
            factureName = factureName + '/' + DateTime.newInstance(facture.Date__c, Time.newInstance(0,0,0,0)).format('yyyy');

            if(facture.Entite_GAC__c == 'EIDOSTECH' || facture.Entite_GAC__c == 'EIDOSTECH ROMANIA'){
                factureName = (isAvoir ? 'AB ET ' : 'ET ') +  factureName;
            }

            else if(facture.Entite_GAC__c == 'CONSULNOVA'){
                factureName = (isAvoir ? 'AB C ' : 'C ') + factureName ;
            }
            else if(facture.Entite_GAC__c == 'GAC ESPANA'){
                factureName = (isAvoir ? 'AB G ' : 'G ') + factureName ;
            }
            else if(facture.Entite_GAC__c == 'Internacional'){
                factureName = (isAvoir ? 'AB IN ' : 'ET IN ') + factureName ;
            }


        }

        else if(facture.Account_Record_Type__c == 'SINGAPORE_ACCOUNT'){
            factureName = 'PIC - ' + (isAvoir ? 'CN' : 'INV') + ' - ' + DateTime.newInstance(facture.Date__c, Time.newInstance(0,0,0,0)).format('yyMM') +  factureName;

        }
        else if(missionRecordTypeName != 'CIR_CANADA'){

            //Rajoute le 'FA' ou 'AV' - ainsi que l'année et le mois de la facture devant son numéro
            factureName = ( facture.Montant_HT__c < 0 ? 'AV-' : 'FA-') + DateTime.newInstance(facture.Date__c, Time.newInstance(0,0,0,0)).format('yyMM') + factureName;

            //Rajoute l'entité devant le numero de facture
            factureName = missionRecordTypeName + (facture.Entite_GAC__c == 'GAC INNOVATION' ? 'b' : '') + '-' + factureName;

        }

        system.debug('###OUT GetFactureNumber =>Number =  with '+facture.Name + ' => '+factureName);
        return factureName;

    }



    /**
     *  Retourne un numéro de facture temporaire et unique
     *  @return String: le numéro de facture entre TEMP-0000 et TEMP-9999
     */
    global static string getFactureTempNumber(){
        return getFactureTempNumber(null);
    }


    /**
     *  Retourne un numéro de facture temporaire et unique (si possible le numero passé en paramètre)
     *  @param String preferredName: Si aucune facture n'a déjà ce numéro, on retourne ce numéro, sinon on en choisi un autre unique aléatoirement (entre 0000 et 9999)
     *  @return String: le numéro de facture entre TEMP-0000 et TEMP-9999
     */
    global static string getFactureTempNumber(String preferredName){

        String factureTempNumber = preferredName == null ? null : String.valueOf(Integer.valueOf(preferredName.right(4)));

        Set<String> tempFactureNumbers = new Set<String>();

        for(Facture__c f : [SELECT Id, Name, Index_num_facture__c  
                            FROM Facture__c 
                            WHERE Name LIKE 'TEMP-%']){                            
            tempFactureNumbers.add(String.valueOf(f.Index_num_facture__c));

        }

        while(factureTempNumber == null || tempFactureNumbers.contains(factureTempNumber)){
            factureTempNumber = String.valueOf( (Math.random() * 10000).intValue() );
        }

        while(factureTempNumber.length() < 4)
            factureTempNumber = '0' + factureTempNumber;

        return 'TEMP-' + factureTempNumber;
    }
}