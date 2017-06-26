/*
* Classe d'envoi des mail de rappel aux clients pour qu'ils envoient leur compte employeur au client tout les mois
* Mis en prod le 14/02/2014 
* Classe lancée par le Scheduler ContactMailTATScheduler
*/
public without sharing class ContactMailTAT {
  
  public static id mailModel;
  
  public static Map<String, OrgWideEmailAddress> emailAdresses;
  
  public static boolean IgnoreTaskTrigger=false;
  
  public list<string> lReport;
  
  public String ExceptionOnUpdate;
  
  public string sStatus;
  
  public ContactMailTAT(List<Contact> cs,boolean isRelance){
    /*Initialisation de la récupération du modèle de message*/
    lReport = new list<String>();
    String MailModelDevName = isRelance ?  Label.MailModelTATRel  : Label.MailModelTAT; 
    DateTime dernier_Mail_TAT = DateTime.now();
    if(mailModel == null ){
      EmailTemplate[] em = [SELECT id FROM EmailTemplate WHERE developerName = : MailModelDevName LIMIT 1];
      if(!em.isEmpty())
        mailModel = em.get(0).id;
    }
    
    //Récupération de la liste des OrgWideAdresses
    emailAdresses = new Map<String,OrgWideEmailAddress>();
    for(OrgWideEmailAddress o : [select id,Address from OrgWideEmailAddress]){
      emailAdresses.put(o.Address,o);
    }
    
    List<Id> AccountId = new List<Id>();
    List<Contact> ContactsToUp = new List<Contact>();
    List<String> consultantMails = new List<String>();
    List<String> reportTmp = new list<String>();
    if(!cs.isEmpty()){
      List<Messaging.Email> mails = new List<Messaging.Email>();
          system.debug('##CREATING MAIL');
      for(Contact c : cs){
        if( (isRelance && !c.Account.Comptes_employeurs_recus_ce_mois__c) || !isRelance ){
          mails.add(CreateMail(c.id,c.Account.Consultant_mission_T_A_T__r.Name,c.Account.Consultant_mission_T_A_T__r.Email));
          c.Date_dernier_email_TAT__c = dernier_Mail_TAT;
          ContactsToUp.add(c);
          //'Mail;Contact;Compte;Expediteur;Statut génération;Statut envoi'
          reportTmp.add(c.Email+';'+c.id+';'+c.LastName+';'+c.Account.Name+';'+c.Account.Consultant_mission_T_A_T__r.Email+';'+sStatus);
        }
        AccountId.add(c.AccountId);
      }
      system.debug('Done CreateMail ');
      system.debug(lReport);
      if(!mails.isEmpty()){
          system.debug('##SENDING MAIL' + mails.size() + ' to send');
        integer i = 0;
        for(Messaging.Sendemailresult res :  Messaging.sendEmail(mails)){
            string repTmp = reportTmp.get(i);
            String toAppend = ';'+(res.isSuccess() ? 'OK' : 'ERROR: ');
            if(!res.isSuccess()){
                for(Messaging.SendEmailError err : res.getErrors()){
                    toAppend += ' '+ err.getMessage();
                }
            }
            lReport.add(repTmp+toAppend);
            i++;
        }
        
      }
    }
    ExceptionOnUpdate = 'OK';
    try{
        if(!isRelance){
          List<Account> accToUp = new List<Account>();
          for(Account a: [select id,Comptes_employeurs_recus_ce_mois__c from account where id in : accountId and Comptes_employeurs_recus_ce_mois__c = true]){
            a.Comptes_employeurs_recus_ce_mois__c = false;
            acctoup.add(a);
          }
          update accToUp;
        }
        if(!ContactsToUp.isEmpty())
          update ContactsToUp;
        }catch(Exception e){
            ExceptionOnUpdate = e.getMessage();
    }
  }
  
  private Messaging.SingleEmailMessage CreateMail(Id c,String sendFromName,String sendFromMail){
     Messaging.SingleEmailMessage mail;
     sStatus = 'OK';
     if(mailModel == null)
       return null;
     try{
                 Messaging.reserveSingleEmailCapacity(1);
                 mail = new Messaging.SingleEmailMessage();
                 mail.setTargetObjectId(c);
                 mail.setTemplateId(mailModel);
                 
                 mail.setSaveAsActivity(false); //NE PAS UTILISER : enregistre une task par une task = CPU time limit a cause du trigger des task
          
           if(emailAdresses.containskey(sendFromMail)){
                   mail.setOrgWideEmailAddressId(emailAdresses.get(sendFromMail).id);
           }else if (emailAdresses.containsKey('mrocheteau@group-gac.com')){
              mail.setOrgWideEmailAddressId(emailAdresses.get('mrocheteau@group-gac.com').id);
           }else{
             mail.setSenderDisplayName(sendFromName);
           }
           mail.setUseSignature(false);
                 mail.setReplyTo(sendFromMail);
            }catch(System.LimitException e){
              sStatus = '###EXCEPTION : Maximum mail size reached ' + e.getMessage();
              system.debug('#Maximum Mail size reached');
            }catch(Exception e){
                sStatus = '###EXCEPTION : ' + e.getMessage();
              system.debug('#No model found');
            }
            return mail;
  }
}