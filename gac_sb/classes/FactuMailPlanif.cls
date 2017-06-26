global class FactuMailPlanif {
    
    public Integer MailsSent;
    
    public Map<Id,List<String>> MailToSuperieurMail = new Map<Id,List<String>>();
    
    public List<String> SelectedRecordType = new List<String>{'ACS','TAT','IL','CIR','DI','FI'};
    
    /*********
    Constructeur appelé lors de l'execution de scheduled Apex tous les 1ers lundis du mois.
    Ce constructeur envoie automatiquement tous les mails de retard de planification
    **********/
    public FactuMailPlanif(){
        //Récupération des planifs en retard
      Map<Id,List<prevision_de_facturation__c>> consultantsToPlanifs = new Map<Id,List<prevision_de_facturation__c>> ();
      
      for (prevision_de_facturation__c planif : [select id,name,mission__c,Date_prevue__c,Prevision_HT__c,
                                                        mission__r.name,mission__r.RecordType.Name,
                                                        mission__r.ownerId,mission__r.owner.FirstName,mission__r.owner.Name,mission__r.owner.Email from prevision_de_facturation__c where statut__c = 'Prévue' and Date_prevue__c < : Date.today() AND mission__r.RecordType.Name in:this.SelectedRecordType])
        {
            if(!consultantsToPlanifs.containsKey(planif.mission__r.ownerId))
                consultantsToPlanifs.put(planif.mission__r.ownerId,new List<Prevision_de_facturation__c>());
            consultantsToPlanifs.get(planif.mission__r.ownerId).add(planif);                                                
        }
      
      for (User u : [select Id,Email, Manager.Email from user where Id in : consultantsToPlanifs.keyset()]){
        List<String> destinataires = new List<String>{u.email};
        if(u.Manager != null)
            destinataires.add(u.manager.email);
        this.mailToSuperieurMail.put(u.Id,destinataires);
      }
      
      List<Messaging.Email> mails = new List<Messaging.Email>();
      //system.debug(this.MailToSuperieurMail);
      for(Id consultantId : consultantsToPlanifs.keyset()){
            FactuPlanifMailer mailer = new FactuPlanifMailer(this.mailToSuperieurMail.get(consultantId), consultantsToPlanifs.get(consultantId));
            Messaging.SingleEmailMessage mail = mailer.getMail();
            if( mail != null)
                mails.add(mail);
      }
      this.MailsSent = mails.size();
      if(!mails.isEmpty()){
        if(!Test.isRunningTest())
            Messaging.Sendemailresult[] ret = Messaging.sendEmail(mails);
        system.debug('#Envoi mails planifs : '+mails.size()+' mails sent');
      }else
        system.debug('#no mail to send');
    }
    
    public class MailContent{
            public String BodyHtml = '';
            public String BodyText = '';
            public String Subject = 'Prévisions de facturation en retard';
            
    }
    
    class FactuPlanifMailer{
    
        protected List<Prevision_de_facturation__c> planifs;
        
        protected List<String> consultantMail;
        
        public FactuPlanifMailer(List<String> emails , List<Prevision_de_facturation__c> planifs){
            this.consultantMail = emails;
            this.planifs = planifs;
        }
        
        
        
        public Messaging.SingleEmailMessage getMail(){
            List<String> Bcc = new List<String>{'cdg@global-approah-consulting.com'};
            system.debug('ConsultantMail');
            system.debug(this.consultantMail);
            if(!this.planifs.isEmpty()){
                //Génération des mails
                try{
                    List<String> adresses = this.getAdresses(this.planifs.get(0).mission__r.recordType.Name);
                    Messaging.reserveSingleEmailCapacity(adresses.size());
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    MailContent dataToSend = this.getMailContent();
                    mail.setOrgWideEmailAddressId('0D2D000000002QG');
                    mail.setHtmlBody(dataToSend.bodyHtml);
                    mail.setPlainTextBody(dataToSend.bodyText);
                    mail.setSubject(dataToSend.subject);
                    mail.setSaveAsActivity(false);
                    mail.setToAddresses(adresses);
                    mail.setBccAddresses(Bcc);
                    return mail;
                }catch(System.LimitException e){
                    system.debug('#Maximum Mail size reached');
                    
                }
            }else{
                system.debug('Mail non envoyé sur la prévision des facturations');
            }
            return null;
        }
        
        private List<String> getAdresses(String Type){
                        //String Type = this.planifs.get(0).mission__r.recordType.Name;
            
            List<String> adresses = new List<String>();
            /*
                         
            OPTI :
             
            -      TAT >>>  Joris + Consultants (propriétaire de la mission) + Sandrine SAMABI (recouvrement OPTI)
             
            -      ACS >>>  Consultants (propriétaire de la mission)
             
            -      IL >>>     Consultants (propriétaire de la mission)
             
             
             
            INNO :
             
            -      CIR FI >>> Manager (propriétaire de la mission) + Rainald et Marc (recouvrement)
             
            -      DI >>> Consultants (propriétaire de la mission)
             
 
            */
            
            if(Type == 'CIR' || Type == 'FI'){
                adresses.addAll(new List<String>{
                                        this.consultantMail.get(0), //Manager (=proprietaire de la mission)
                                        'rbrunet@global-approach-consulting.com',
                                        'mflauraud@global-approach-consulting.com'
                                        });
            }
            else if(Type == 'DI' || Type == 'ACS' || Type == 'IL'){
                adresses.add(this.consultantMail.get(0)); //Juste le owner
            }else if(Type == 'TAT'){
                adresses.addAll(this.consultantMail //owner + Manager
                                );
                adresses.add('sbelhaddad@group-gac.com');
            }else{
                adresses.addAll(this.consultantMail );
            }
            
            return adresses;
            
        }
        
        
        
        public MailContent getMailContent(){
            MailContent ret = new MailContent();
            
            ret.BodyHtml = '<style type="text/css">body{font-family: Arial, Helvetica, sans-serif;}td{border:1px solid black;border-width:0px 1px 1px 0;}th{border:1px solid black;border-width:1px 1px 1px 0;        text-align:center;        background-color:#e0eef2;         padding : 10px 0;        color:#007b77;}tr > td:first-child, tr > th:first-child{        border-left-width:1px;}table > tr:first-child td,thead  th{border-top-width:1px;}</style>';
            
            String name = planifs.get(0).mission__r.owner.FirstName != null ? planifs.get(0).mission__r.owner.FirstName : planifs.get(0).mission__r.owner.Name;
            
            ret.BodyHtml += '<p>Bonjour '+name+',</p>';
            ret.BodyHtml += '<p>Pour information, voici la liste de vos planifications de facturation en retard</p>';
            ret.BodyHtml += '<table cellpadding="4" cellspacing="0" style="width:600px"><tr><th>Mission</th><th>Type</th><th>Planification Associée</th><th>Date prévue</th><th>Prévision HT</th></tr>';
            
            for(Prevision_de_facturation__c planif : planifs){
                ret.BodyHtml += '<tr>';
                ret.BodyHtml += '<td><a href="https://eu1.salesforce.com/'+planif.mission__c+'">'+planif.mission__r.name+'</a></td>';
                ret.BodyHtml += '<td>' + planif.mission__r.recordType.name + '</td>';
                ret.BodyHtml += '<td><a href="https://eu1.salesforce.com/'+planif.id+'">'+planif.name+'</a></td>';
                ret.BodyHtml += '<td>'+ planif.Date_prevue__c.format() + '</td>';
                ret.BodyHtml += '<td style="text-align:right">'+planif.Prevision_HT__c.format()+' €</td>';
                ret.BodyHtml += '</tr>';
            }
            
            ret.BodyHtml += '</table>';
            ret.bodyHtml += '<p>Bonne journée</p>';
            return ret;
        }
    }
    
    public static testmethod void FactuMailPlanif(){
     FactuTestBase.Init(); //Crée 5 planifs a 1 seul consultant
     FactuMailPlanif mailPlanif = new FactuMailPlanif();
     System.assertEquals(1, mailPlanif.mailsSent);
   }
    
    
}