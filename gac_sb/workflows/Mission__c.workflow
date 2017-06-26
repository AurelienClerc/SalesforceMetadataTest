<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_compte_rendu_mission_TAT</fullName>
        <description>Notification compte-rendu mission (TAT)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>jcostanzo@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_compte_rendu_mission_TAT</template>
    </alerts>
    <fieldUpdates>
        <fullName>IdProprietaire</fullName>
        <field>OwnerId</field>
        <lookupValue>sgubitoso@group-gac.com.br</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>IdProprietaire</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Mission_Name</fullName>
        <field>Name</field>
        <formula>If((($RecordType.DeveloperName  = &apos;TAT&apos;) &amp;&amp; (N_Mission_force__c &lt;&gt; &apos;&apos;)),
N_Mission_force__c + &apos; - &apos; + Compte__r.Name + &apos; &apos; + Filiale_concernee__c,
(If(((($RecordType.DeveloperName  = &apos;LDB&apos;) || ($RecordType.DeveloperName  = &apos;FND&apos;) || ($RecordType.DeveloperName  = &apos;CSL&apos;)) &amp;&amp; (Subsidiaria_no_ambito_do_contrato__c &lt;&gt; &apos;&apos;)),
RecordType.Name   + &apos; - &apos; + TEXT(Annee_concernee__c) + &apos; - &apos; +  Subsidiaria_no_ambito_do_contrato__r.Name ,
CASE( $RecordType.DeveloperName ,
&apos;TAT&apos;, N_Mission__c  + &apos; - &apos; + Compte__r.Name + &apos; &apos; + Filiale_concernee__c,
&apos;AYUDAS&apos;, TEXT(Annee_concernee__c) + &apos; - &apos; + Contrat__r.Account.Name+&apos; - &apos;+ RecordType.Name +&apos; - &apos;+ text(Service__c) ,
&apos;DED&apos;,    TEXT(Annee_concernee__c) + &apos; - &apos; + Contrat__r.Account.Name+&apos; - &apos;+ RecordType.Name +&apos; - &apos;+ text(Service__c) ,
&apos;Consulting&apos;,    text(Annee_concernee__c) + &apos; - &apos; + Contrat__r.Account.Name+&apos; - &apos;+ RecordType.DeveloperName +&apos; - &apos;+ text(Service__c) ,
&apos;CIR&apos;,  TEXT(Annee_concernee__c) + &apos; - &apos; + Contrat__r.Account.Name,
&apos;VEILLE&apos;, TEXT(Annee_concernee__c) + &apos; - &apos; + Contrat__r.Account.Name, 
&apos;LDB&apos;, RecordType.Name   + &apos; - &apos; + TEXT(Annee_concernee__c) + &apos; - &apos; +  Contrat__r.Account.Name  ,
&apos;FND&apos;, RecordType.Name   + &apos; - &apos; + TEXT(Annee_concernee__c) + &apos; - &apos; +  Contrat__r.Account.Name  ,
&apos;CSL&apos;, RecordType.Name   + &apos; - &apos; + TEXT(Annee_concernee__c) + &apos; - &apos; +  Contrat__r.Account.Name  ,
&apos;IL&apos;, N_Mission__c  + &apos; - &apos; + Contrat__r.Account.Name,
&apos;CFI&apos;, RecordType.Name   + N_Mission__c  + &apos; - &apos; + Contrat__r.Account.Name,
&apos;ACS&apos;, N_Mission__c  + &apos; - &apos; + Contrat__r.Account.Name + IF( NOT(ISNULL(Date_d_audit__c)),&apos; - &apos; + TEXT(MONTH(Date_d_audit__c))+&apos;/&apos;+TEXT(YEAR(Date_d_audit__c)),&apos;&apos;),
&apos;CRH&apos;, N_Mission__c  + &apos; - &apos; + Contrat__r.Account.Name + IF( NOT(ISNULL(Date_d_audit__c)),&apos; - &apos; + TEXT(MONTH(Date_d_audit__c))+&apos;/&apos;+TEXT(YEAR(Date_d_audit__c)),&apos;&apos;),
&apos;FI&apos;,  RecordType.Name   + &apos; - &apos; + Contrat__r.Account.Name,
&apos;CIN&apos;, RecordType.Name   + &apos; - &apos; + Contrat__r.Account.Name,
&apos;DI&apos;,  LEFT(TEXT(Type_de_mission__c),FIND(&apos; &apos;,TEXT(Type_de_mission__c),0)) + &apos; - &apos; + Contrat__r.Account.Name,
&apos;CIR_CANADA&apos;, TEXT(Annee_concernee__c)+ &apos; - &apos; + Contrat__r.Account.Name,
&apos;SGP_PIC&apos;, TEXT(Type_de_mission__c) + &apos; - &apos; + TEXT(Annee_concernee__c)+ &apos; - &apos; + IF(!isblank(N_Mission_force__c),N_Mission_force__c + &apos; - &apos;,&apos;&apos;) +  Contrat__r.Account.Name +   IF(INCLUDES(Quarter__c,&apos;Q1&apos;),&apos; /Q1&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q2&apos;),&apos; /Q2&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q3&apos;),&apos; /Q3&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q4&apos;),&apos; /Q4&apos;,&apos;&apos;) ,
&apos;CF&apos;, TEXT(Type_de_mission__c) + &apos; - &apos; + TEXT(Annee_concernee__c)+ &apos; - &apos; + IF(!isblank(N_Mission_force__c),N_Mission_force__c + &apos; - &apos;,&apos;&apos;) +  Contrat__r.Account.Name +   IF(INCLUDES(Quarter__c,&apos;Q1&apos;),&apos; /Q1&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q2&apos;),&apos; /Q2&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q3&apos;),&apos; /Q3&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q4&apos;),&apos; /Q4&apos;,&apos;&apos;) ,
&apos;PF&apos;, TEXT(Type_de_mission__c) + &apos; - &apos; + TEXT(Annee_concernee__c)+ &apos; - &apos; + IF(!isblank(N_Mission_force__c),N_Mission_force__c + &apos; - &apos;,&apos;&apos;) +  Contrat__r.Account.Name +   IF(INCLUDES(Quarter__c,&apos;Q1&apos;),&apos; /Q1&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q2&apos;),&apos; /Q2&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q3&apos;),&apos; /Q3&apos;,&apos;&apos;)+  IF(INCLUDES(Quarter__c,&apos;Q4&apos;),&apos; /Q4&apos;,&apos;&apos;), 
&apos;#&apos;))))</formula>
        <name>MAJ Mission Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>MAJ Mission Name BR</fullName>
        <actions>
            <name>MAJ_Mission_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>MAJ le nom de la mission suite à sa création</description>
        <formula>Compte__r.RecordType.DeveloperName == &apos;BRASIL_ACCOUNT&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Mission Name FR SGP ES</fullName>
        <actions>
            <name>MAJ_Mission_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>MAJ le nom de la mission suite à sa création</description>
        <formula>Compte__r.RecordType.DeveloperName != &apos;BRASIL_ACCOUNT&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Proprietaire par defaut Mission de Type LDB BRESIL</fullName>
        <actions>
            <name>IdProprietaire</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Mission__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>FND,CSL,LDB</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Lors de l’affectation des missions par défaut lors de leurs créations, mettre comme propriétaire Stella GUBITOSO : sgubitoso@group-gac.com.br</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
