global class FactuDecalePrevision  implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.stateful {
	
	
	global list<string> lReport;
    
    
    global list<string> errOnUpdate;
	
	global FactuDecalePrevision(){
	   lReport = new list<String>{'id;Facture #;prevision;date prevue;montant TTC;error'};
       errOnUpdate = new list<String>{'Errors shown below'};
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC){
      return database.getQueryLocator( [SELECT Id, Name ,Date_prevue__c, facture__r.Name, Montant_prevu_TTC__c FROM Prevision_encaissement__c WHERE Date_prevue__c != null AND PrevADecaller__c = true] );
    }
    
    global void execute(Database.BatchableContext BC, List<Prevision_encaissement__c> scope){
        Prevision_encaissement__c [] PrevEncaissementToUpdate = new Prevision_encaissement__c[]{};
        string tmpReport = '';
        for ( Prevision_encaissement__c p : scope )
        {
			Date newDate = p.Date_prevue__c.addMonths(p.date_prevue__c.monthsBetween(date.today() + 1));
			//On met la prévision d'encaissement au mois prochain quoiqu'il arrive
            if(newDate != p.Date_prevue__c )
            {
                p.Date_prevue__c = newDate;
    			PrevEncaissementToUpdate.add(p);
            }
		}
		try
		{
		    if(!PrevEncaissementToUpdate.isEmpty())
		    {
    		    Database.saveResult[] res = Database.update(PrevEncaissementToUpdate, false); 
    		    for(integer i=0; i<res.size(); i++)  //updateResult ne renvoie pas les id mais conserve l'order de la liste. On est obligé de passer par une grosse boucle avec des entiers
    		    {
    		        database.saveResult r = res.get(i);
    		        Prevision_encaissement__c record = PrevEncaissementToUpdate.get(i); 
    		        tmpReport = record.id+';'+record.facture__r.Name+';'+ record.Name+';'+record.date_prevue__c.format()+';'+record.Montant_prevu_TTC__c+';';
    		        
    		        if( r.isSuccess() )
    		        {
    		            tmpReport +='OK';
    		        }
    		        else
    		        {
    		            tmpReport += '"';
    		            for( Database.Error err : r.getErrors() )
    		            {
    		                 tmpReport += err.getStatusCode() + ': ' + err.getMessage();
    		                
    		            }
    		            tmpReport +='"';
    		            errOnUpdate.add(r.getErrors().get(0).getMessage());
    		        }
    		        lReport.add(tmpReport);
    		    }
		    }
		}
		catch(Exception e)
		{
		    //Main Exception here
		    tmpReport += e.getMessage() + ' - '+e.getStackTraceString();
		    lReport.add(tmpReport);
		    errOnUpdate.add( e.getMessage() + ' - '+e.getStackTraceString() );
		}
	
        
    }
    
    global void finish(Database.BatchableContext BC){
	  	List<String> Bcc = new List<String>{'dhuguet@synefo.fr'};
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		try
		{
			Messaging.reserveSingleEmailCapacity(Bcc.size());
			//MailContent dataToSend = this.getMailContent();
			mail.setOrgWideEmailAddressId('0D2D000000002QG');
			mail.setTargetObjectId('005D0000001vxx8');
			mail.setCcAddresses(Bcc);
			mail.setSaveAsActivity(false);
			mail.setHtmlBody('<p>Fin Du script Décal prev encaissement à '+datetime.now().format()+', '+(lReport.size() - 1 )+ ' enregistrements mis a jours avec '+(errOnUpdate.size() - 1)+ ' erreurs</p>');
			mail.setPlainTextBody('Fin Du script Décal prev encaissement à '+datetime.now().format()+', '+(lReport.size() - 1 )+ ' enregistrements mis a jours avec '+(errOnUpdate.size() - 1)+ ' erreurs');
			mail.setSubject('Fin du script de décal prev. encaissement');
			
			
			Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            Blob fileBody = Blob.valueOf(String.join(lReport,'\n'));
            efa.setBody(fileBody);
            efa.setFileName('RaportMailEncaissement.csv');
            Messaging.EmailFileAttachment efa2 = new Messaging.EmailFileAttachment();
            Blob fileBody2 = Blob.valueOf(String.join(errOnUpdate,'\n'));
            efa2.setBody(fileBody2);
            efa2.setFileName('ErreurUpdate.csv');
            Messaging.EmailFileAttachment[] efas = new list<Messaging.EmailFileAttachment>{efa,efa2};
            mail.setFileAttachments(efas);
            
        	Messaging.Sendemailresult[] ret = Messaging.sendEmail(new List<Messaging.Email>{mail});
			
		}
		catch(System.LimitException e)
		{
			system.debug('#Maximum Mail size reached');
		}	
	
	    
    }
	

	/*********
	Constructeur appelé lors de l'execution de scheduled Apex tous les 1ers lundis du mois.
	Ce constructeur décale toutes les prévision d'encaissement dépassées par le mois en cours
	********** /
	public FactuDecalePrevision(){
    		List<Prevision_encaissement__c> encaissementsToUpdate = new List<Prevision_encaissement__c>();
    		
    		
    		if(!encaissementsToUpdate.isEmpty())
    			update encaissementsToUpdate;
		}
	}
	*/
	public static testMethod void testDecalePrevision(){
		FactuTestBase.Init();
		FactuTestBase.InitFactures();


		//EDIT DIDIER 18/02=> Bug inexpliqué:trop de soql dans cette methode ~30, obligé de la passé en startTest
		Test.startTest();
		system.debug('Test.StartTest');
		FactuTestBase.InitPrevEncaissement();
		
		
		//On vérifie qu'on a bien des vielles prevs
		system.assertNotEquals(0,[select id from Prevision_encaissement__c where date_prevue__c < : date.today() - 15].size());
		
		FactuDecalePrevision ba = new FactuDecalePrevision();
		database.executeBatch(ba);
		test.stopTest();
		//On vérifie qu'on n'a plus de vieilles prevs
		system.assertEquals(0,[select id from Prevision_encaissement__c where date_prevue__c < : date.today() - 15].size());
		system.debug('Test.StopTest');
		
	}
}