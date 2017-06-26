<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_nouvelle_reclamation</fullName>
        <description>Notification nouvelle réclamation</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hrolfocazes@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Nouvelle_Reclamation</template>
    </alerts>
    <alerts>
        <fullName>Notification_nouvelle_reclamation_enfant</fullName>
        <description>Notification nouvelle réclamation enfant</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hrolfocazes@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Nouvelle_Reclamation_Enfant</template>
    </alerts>
    <alerts>
        <fullName>Notification_reclamation_fermee</fullName>
        <description>Notification réclamation fermée</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hrolfocazes@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Fermeture_de_Reclamation</template>
    </alerts>
    <alerts>
        <fullName>Support_Gde_Arm_e_Envoi_du_mail_d_affectation_de_requete</fullName>
        <description>Support Gde Armée: Envoi du mail d&apos;affectation de requete</description>
        <protected>false</protected>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Interlocuteur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Support_Grde_Arm_e_Affectation_de_requ_te</template>
    </alerts>
    <alerts>
        <fullName>Support_Global_Appr_Envoi_du_mail_de_fermetre_de_requ_te</fullName>
        <description>Support Global Approach: Envoi du mail de fermeture de requête</description>
        <protected>false</protected>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Interlocuteur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Support_Global_appr_Mail_de_fermeture_de_requete</template>
    </alerts>
    <alerts>
        <fullName>Support_Global_Approach_Envoi_du_mail_d_affectation_de_requete</fullName>
        <description>Support Global Approach: Envoi du mail d&apos;affectation de requete</description>
        <protected>false</protected>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Interlocuteur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Support_Global_appr_Affectation_de_requ_te</template>
    </alerts>
    <alerts>
        <fullName>Support_Global_Approach_Envoi_du_mail_de_sondage</fullName>
        <description>Support Global Approach: Envoi du mail de sondage</description>
        <protected>false</protected>
        <recipients>
            <field>Interlocuteur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Support_Global_appr_Mail_de_rappel_de_sondage</template>
    </alerts>
    <alerts>
        <fullName>Support_Global_Approach_Envoi_du_mail_de_sondage_EN</fullName>
        <description>Support Global Approach: Envoi du mail de sondage EN</description>
        <protected>false</protected>
        <recipients>
            <field>Interlocuteur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Support_Global_appr_Mail_de_rappel_de_sondage_EN</template>
    </alerts>
    <alerts>
        <fullName>Support_GrdAC_Envoi_du_mail_de_fermetre_de_requ_te</fullName>
        <description>Support Gde Armée: Envoi du mail de fermeture de requête</description>
        <protected>false</protected>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Interlocuteur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Support_Grde_Arm_e_Fermeture_de_requ_te</template>
    </alerts>
    <fieldUpdates>
        <fullName>CASE_MAJ_lien_enquete</fullName>
        <field>Lien_enquete__c</field>
        <formula>CASE(RecordType.DeveloperName, 
&apos;Helpdesk_SF&apos;, 
IF(RIGHT(Interlocuteur__r.Email,13) != &apos;group-gac.com&apos;,
  $Setup.SurveySFEn__c.URL__c ,
  $Setup.SurveySF__c.URL__c 
 )
     &amp; &apos;&amp;caId=&apos; &amp; Id, 
&apos;Helpdesk_SG&apos;,
   IF(RIGHT(Interlocuteur__r.Email,13) != &apos;group-gac.com&apos;,
    $Setup.SurveySGEn__c.URL__c ,
    $Setup.SurveySG__c.URL__c 
  )
  &amp; &apos;&amp;caId=&apos; &amp; Id, 
&apos;Helpdesk_IT&apos;,
   IF(RIGHT(Interlocuteur__r.Email,13) != &apos;group-gac.com&apos;,
    $Setup.SurveyIT__c.URL__c ,
    $Setup.SurveyIT__c.URL__c 
  )
  &amp; &apos;&amp;caId=&apos; &amp; Id, 

$Setup.SurveySF__c.URL__c &amp; &apos;&amp;caId=&apos; &amp; Id)</formula>
        <name>CASE - MAJ lien enquete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Email1</fullName>
        <field>Email_suivi_1__c</field>
        <formula>IF((Manager_Reclamation__r.Id = &apos;005D0000002AgGk&apos; || Manager_Reclamation__r.Id = &apos;005D0000002a08c&apos;) , 
IF(ISPICKVAL(Produit__c,&apos;CIR&apos;),&apos;jalieu@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c, &apos;AS&apos;),&apos;jalieu@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CIN&apos;),&apos;jalieu@group-gac.com&apos; ,&apos;&apos;))), 
IF(ISPICKVAL(Produit__c, &apos;IL&apos;),&apos;jfcolle@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CFI&apos;),&apos;jfcolle@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CRH&apos;),&apos;jberche@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;ACS&apos;),&apos;jberche@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;TAT&apos;),&apos;mrocheteau@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CIR&apos;),&apos;lhauseux@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c, &apos;AS&apos;),&apos;lhauseux@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CIN&apos;),&apos;lhauseux@group-gac.com&apos; ,&apos;&apos;)))))))))</formula>
        <name>MAJ Email1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Email2</fullName>
        <field>Email_suivi_2__c</field>
        <formula>IF((Manager_Reclamation__r.Id = &apos;005D0000002AgGk&apos; || Manager_Reclamation__r.Id = &apos;005D0000002a08c&apos;) , 
IF(ISPICKVAL(Produit__c,&apos;CIR&apos;),&apos;&apos; , 
IF(ISPICKVAL(Produit__c, &apos;AS&apos;),&apos;&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CIN&apos;),&apos;&apos; ,&apos;&apos;))), 
IF(ISPICKVAL(Produit__c, &apos;IL&apos;),&apos;&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CFI&apos;),&apos;&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CRH&apos;),&apos;mrocheteau@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;ACS&apos;),&apos;mrocheteau@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;TAT&apos;),&apos;jberche@group-gac.com&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CIR&apos;),&apos;&apos; , 
IF(ISPICKVAL(Produit__c, &apos;AS&apos;),&apos;&apos; , 
IF(ISPICKVAL(Produit__c,&apos;CIN&apos;),&apos;&apos; ,&apos;&apos;)))))))))</formula>
        <name>MAJ Email2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_a_jour_du_statut</fullName>
        <field>Status</field>
        <literalValue>En attente</literalValue>
        <name>Mise a jour du statut</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_jour_de_champ_Source_de_la_demande1</fullName>
        <description>Met à jour le champ &quot; Source de la demande &quot; si AT Advance</description>
        <field>Source_de_la_demande__c</field>
        <literalValue>AT-Advance</literalValue>
        <name>Mise à jour de champ : Source de la dema</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_jour_de_champ_Source_de_la_demande2</fullName>
        <description>Met à jour le champ &quot; Source de la demande &quot; si O2T</description>
        <field>Source_de_la_demande__c</field>
        <literalValue>O2T</literalValue>
        <name>Mise à jour de champ : Source de la dema</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_jour_de_champ_Source_de_la_demande3</fullName>
        <description>Met à jour le champ &quot; Source de la demande &quot; si Inno Advance</description>
        <field>Source_de_la_demande__c</field>
        <literalValue>InnoAdvance</literalValue>
        <name>Mise à jour de champ : Source de la dema</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_jour_de_champ_Source_de_la_demande4</fullName>
        <description>Réclamation</description>
        <field>Source_de_la_demande__c</field>
        <literalValue>Réclamation</literalValue>
        <name>Mise à jour de champ : Source de la dema</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requete_MAJ_date_Affectation</fullName>
        <description>La date d&apos;affectation Synéfo de la requête est mise a jour avec la date du jour</description>
        <field>Date_affectation__c</field>
        <formula>NOW()</formula>
        <name>Requête: MAJ date Affectation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requete_MAJ_date_escalade</fullName>
        <description>Mise a jour du champ date d&apos;escalade Synéfo</description>
        <field>Date_d_escalade_Synefo__c</field>
        <formula>NOW()</formula>
        <name>Requête: MAJ date escalade Synéfo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requete_MAJ_date_escalade_mode_projet</fullName>
        <description>Mise a jour du champ date d&apos;escalade en mode projet</description>
        <field>Date_d_escalade_Mode_projet__c</field>
        <formula>NOW()</formula>
        <name>Requête: MAJ date escalade mode projet</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requete_MAJ_date_escalade_prestataire</fullName>
        <description>Mise a jour du champ date d&apos;escalade au prestataire</description>
        <field>Date_d_escalade_au_prestataire__c</field>
        <formula>NOW()</formula>
        <name>Requête: MAJ date escalade prestataire</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Support_Coche_mise_a_jour_envoyee</fullName>
        <field>Mail_prise_en_charge_envoye__c</field>
        <literalValue>1</literalValue>
        <name>Support: Coche mise a jour envoyee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MAJ E-mail associés</fullName>
        <actions>
            <name>MAJ_Email1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Email2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Requete traitée</fullName>
        <active>true</active>
        <description>MAJ Requete traitée (Envoi le mail de sondage 5 min après</description>
        <formula>ISPICKVAL(Status, &apos;Traité&apos;) &amp;&amp; Interlocuteur__r.IsActive &amp;&amp; !Interlocuteur__r.Ne_recoit_pas_de_survey__c &amp;&amp;RIGHT(Interlocuteur__r.Email,13) == &apos;group-gac.com&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Support_Global_Approach_Envoi_du_mail_de_sondage</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.X55_Minutes_avant__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>MAJ Requete traitée EN</fullName>
        <active>true</active>
        <description>MAJ Requete traitée (Envoi le mail de sondage 5 min après</description>
        <formula>ISPICKVAL(Status, &apos;Traité&apos;) &amp;&amp; Interlocuteur__r.IsActive &amp;&amp; !Interlocuteur__r.Ne_recoit_pas_de_survey__c &amp;&amp; RIGHT(Interlocuteur__r.Email,13) != &apos;group-gac.com&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Support_Global_Approach_Envoi_du_mail_de_sondage_EN</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.X55_Minutes_avant__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>MAJ lien enquete</fullName>
        <actions>
            <name>CASE_MAJ_lien_enquete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Helpdesk SF,Helpdesk IT,Helpdesk SG</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Met à jour le lien vers l&apos;enquête de satisfaction en fonction du recordType</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Mise à jour de champ %3A Source de la demande AT advance</fullName>
        <actions>
            <name>Mise_jour_de_champ_Source_de_la_demande1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Email (helpdesk At Advance)</value>
        </criteriaItems>
        <description>Met à jour le champ &quot; Source de la demande &quot; si AT Advance</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Mise à jour de champ %3A Source de la demande Inno Advance</fullName>
        <actions>
            <name>Mise_jour_de_champ_Source_de_la_demande3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Email (helpdesk InnoAdvance)</value>
        </criteriaItems>
        <description>Met à jour le champ &quot; Source de la demande &quot; si Inno Advance</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Mise à jour de champ %3A Source de la demande O2T</fullName>
        <actions>
            <name>Mise_jour_de_champ_Source_de_la_demande2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Email (helpdesk O2T)</value>
        </criteriaItems>
        <description>Met à jour le champ &quot; Source de la demande &quot; si O2T</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Mise à jour de champ %3A Source de la demande Réclamation</fullName>
        <actions>
            <name>Mise_jour_de_champ_Source_de_la_demande4</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Phone,Web,Email (réclamation),Autres (courrier...)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Réclamation</value>
        </criteriaItems>
        <description>Met à jour le champ &quot; Source de la demande &quot; si Réclamation</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification nouvelle réclamation</fullName>
        <actions>
            <name>Notification_nouvelle_reclamation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>En Cours</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Réclamation</value>
        </criteriaItems>
        <description>Alerte e-mail - création d&apos;une réclamation validée par l&apos;ADV</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification nouvelle réclamation enfant</fullName>
        <actions>
            <name>Notification_nouvelle_reclamation_enfant</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>En Cours</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.ParentId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Réclamation</value>
        </criteriaItems>
        <description>Alerte e-mail - création d&apos;une réclamation enfant validée par l&apos;ADV</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification réclamation fermée</fullName>
        <actions>
            <name>Notification_reclamation_fermee</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Réclamation clôturée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Réclamation</value>
        </criteriaItems>
        <description>Alerte e-mail - fermeture d&apos;une réclamation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Support gde armée %3A Prise en charge</fullName>
        <actions>
            <name>Support_Gde_Arm_e_Envoi_du_mail_d_affectation_de_requete</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Support_Coche_mise_a_jour_envoyee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>En Cours</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Interlocuteur__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Entite__c</field>
            <operation>equals</operation>
            <value>Grande armée conseil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Mail_prise_en_charge_envoye__c</field>
            <operation>equals</operation>
            <value>Faux</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) - alerte e-mail Envoi du mail d&apos;affectation de requête lorsque la requête passe de en attente a en cours de traitement</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Support gde armée%3A fermeture de requête</fullName>
        <actions>
            <name>Support_GrdAC_Envoi_du_mail_de_fermetre_de_requ_te</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Interlocuteur__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Traité</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Entite__c</field>
            <operation>equals</operation>
            <value>Grande armée conseil</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Envoi du mail de fermeture Grande Armée</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Support global appr %3A Prise en charge</fullName>
        <actions>
            <name>Support_Global_Approach_Envoi_du_mail_d_affectation_de_requete</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Support_Coche_mise_a_jour_envoyee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>En Cours</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Interlocuteur__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Entite__c</field>
            <operation>equals</operation>
            <value>Global approach consulting</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Mail_prise_en_charge_envoye__c</field>
            <operation>equals</operation>
            <value>Faux</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) - Alerte e-mail Envoi du mail d&apos;affectation de requête lorsque la requête passe de en attente a en cours de traitement</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Support global appr%3A fermeture de requête</fullName>
        <actions>
            <name>Support_Global_Appr_Envoi_du_mail_de_fermetre_de_requ_te</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Interlocuteur__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Traité</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Entite__c</field>
            <operation>equals</operation>
            <value>Global approach consulting,Grande armée conseil,GAI,EFE,Locataire 3ème,Locataire 4ème,GAC GROUP,BRESIL,CANADA,ESPAGNE,SINGAPOUR</value>
        </criteriaItems>
        <description>Alerte e-mail Envoi du mail de fermeture Global approach</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Support%3A Affectation de requete</fullName>
        <actions>
            <name>Mise_a_jour_du_statut</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Requete_MAJ_date_Affectation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Support</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Actions effectuées lors de l&apos;affectation d&apos;une requete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Support%3A Escalader a syenfo</fullName>
        <actions>
            <name>Requete_MAJ_date_escalade</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Escaladee_Synefo__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Actions lors de l&apos;affection d&apos;une requête a l&apos;utilisateur synefo</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Support%3A Escalader en mode projet</fullName>
        <actions>
            <name>Requete_MAJ_date_escalade_mode_projet</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Escaladee_en_mode_projet__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Actions lorsque la case &quot; escaladée en mode projet &quot; est cochée</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Support%3A Escaladé au prestataire</fullName>
        <actions>
            <name>Requete_MAJ_date_escalade_prestataire</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Escalade_au_prestataire__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Actions lors de l&apos;affection d&apos;une requête à un prestataire</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
