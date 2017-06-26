//@CoveredBy ContactMailTAT_Test
global class ContactMailTATBatchContext implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.stateful {

    global list<string> lReport;
    
    
    global list<string> errOnUpdate;
    
    
    global Database.QueryLocator start(Database.BatchableContext BC){
      lReport = new list<String>{'Mail;Id;Contact;Compte;Expediteur;Statut génération;Statut envoi mail'};
      errOnUpdate = new list<String>{'Liste des exceptions levées sur l\'envoi de mail, il va falloir cocher les case manuellement sur ces liste si elles sont différentes de OK'};
      //5 Jour avant
      Date lastMail = date.today() - 6;
      DateTime lastMailDt = Datetime.newInstance(lastMail.year(), lastMail.month(), lastMail.day());
      //On evite les list has no row
      List<String> Bcc = new List<String>{'dhuguet@synefo.fr'};
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    try{
      Messaging.reserveSingleEmailCapacity(Bcc.size());
      //MailContent dataToSend = this.getMailContent();
      mail.setOrgWideEmailAddressId('0D2D000000002QG');
      mail.setTargetObjectId('005D0000001vxx8');
      mail.setCcAddresses(Bcc);
      mail.setSaveAsActivity(false);
      mail.setHtmlBody('<p>Lancement du script à '+datetime.now().format()+'</p>');
      mail.setPlainTextBody('Lancement du script à '+datetime.now().format());
      mail.setSubject('Lancement du script d\'envoi de mail TAT');
    }catch(System.LimitException e){
      system.debug('#Maximum Mail size reached');
    }  
    if(!Test.isRunningTest())
         Messaging.Sendemailresult[] ret = Messaging.sendEmail(new List<Messaging.Email>{mail});
      
        return database.getQueryLocator( [select id,email,Date_dernier_email_TAT__c,AccountId,LastName,Account.Consultant_mission_T_A_T__r.Name,Account.Comptes_employeurs_recus_ce_mois__c,Account.Consultant_mission_T_A_T__r.Email, Account.Name 
                            from Contact where  
                              ( Date_dernier_email_TAT__c = null OR Date_dernier_email_TAT__c < : lastMailDt) 
                                      AND 
                              Envoyer_mail_TAT__c = true //Envoyer mail TAT est un champ formule
                                    //LIMIT 5 // -> Pas de limites ici, on est en batch
                          ]);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> Contacts){
        ContactMailTAT.IgnoreTaskTrigger = true;
        //Récupération du jour
      Boolean isRelance = Date.today().day() > 10;
        if(!Contacts.isEmpty()){
         ContactMailTAT job = new ContactMailTAT(contacts,isRelance);
         system.debug(job);
         lReport.addAll(job.lReport);
         errOnUpdate.add(job.exceptionOnUpdate);
        }
        
        
    }
    
    global void finish(Database.BatchableContext BC){
        //5 Jour avant
      Date lastMail = date.today() - 6;
      DateTime lastMailDt = Datetime.newInstance(lastMail.year(), lastMail.month(), lastMail.day());
      //On evite les list has no row
      List<String> Bcc = new List<String>{'dhuguet@synefo.fr'};
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    try{
      Messaging.reserveSingleEmailCapacity(Bcc.size());
      //MailContent dataToSend = this.getMailContent();
      mail.setOrgWideEmailAddressId('0D2D000000002QG');
      mail.setTargetObjectId('005D0000001vxx8');
      mail.setCcAddresses(Bcc);
      mail.setSaveAsActivity(false);
      mail.setHtmlBody('<h1>Fin du script envoiMailTAT à '+datetime.now().format()+'</h1>');
      mail.setPlainTextBody('Fin du script envoiMailTAT '+datetime.now().format());
      mail.setSubject('Fin du du script d\'envoi de mail TAT');
      
      
      Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            Blob fileBody = Blob.valueOf(String.join(lReport,'\n'));
            efa.setBody(fileBody);
            efa.setFileName('RapportEnvoiMail.csv');
            Messaging.EmailFileAttachment efa2 = new Messaging.EmailFileAttachment();
            Blob fileBody2 = Blob.valueOf(String.join(errOnUpdate,'\n'));
            efa2.setBody(fileBody2);
            efa2.setFileName('ErreurUpdate.csv');
            Messaging.EmailFileAttachment[] efas = new list<Messaging.EmailFileAttachment>{efa,efa2};
            mail.setFileAttachments(efas);
            
            //mail.setToAddresses(new String[] { 'dhuguet@synefo.fr'});
            Messaging.SingleEmailMessage[] messages = new list<Messaging.SingleEmailMessage>{mail};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
      
    }catch(System.LimitException e){
      system.debug('#Maximum Mail size reached');
    }  
    }

}