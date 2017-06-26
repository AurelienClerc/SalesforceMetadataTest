<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CONTACT_Decocher_Cible_Email_TAT</fullName>
        <description>Décoche Cible Email TAT si compte n&apos;est plus client</description>
        <field>Cible_e_mail_T_A_T__c</field>
        <literalValue>0</literalValue>
        <name>CONTACT Décocher Cible Email TAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CONTACT_Formatage_nom</fullName>
        <description>Met toutes les lettres du nom en majuscule</description>
        <field>LastName</field>
        <formula>UPPER(LastName)</formula>
        <name>CONTACT Formatage nom</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CONTACT_formatage_prenom</fullName>
        <description>Met la premiere lettre du prénom en majuscule et les autres en minuscule</description>
        <field>FirstName</field>
        <formula>IF(
FIND(&quot; &quot;, FirstName ,1)=0,
UPPER(LEFT(FirstName ,1))&amp;MID(FirstName ,2,100),
IF(
FIND(&quot; &quot;,MID(FirstName ,FIND(&quot; &quot;,FirstName ,1)+1,LEN(FirstName )-FIND(&quot; &quot;,FirstName ,1)))=0,
UPPER(LEFT(FirstName ,1))&amp;
MID(FirstName ,2,FIND(&quot; &quot;,FirstName ,1)-1)&amp;&quot; &quot;&amp;
UPPER(MID(FirstName ,FIND(&quot; &quot;,FirstName ,1)+1,1))&amp;
MID(FirstName ,FIND(&quot; &quot;,FirstName ,1)+2,100),
UPPER(LEFT(FirstName ,1))&amp;
MID(FirstName ,2,FIND(&quot; &quot;,FirstName ,1)-1)&amp;&quot; &quot;&amp;
UPPER(MID(FirstName ,FIND(&quot; &quot;,FirstName ,1)+1,1))&amp;
MID(FirstName ,FIND(&quot; &quot;,FirstName ,1)+2,FIND(&quot; &quot;,MID(FirstName ,FIND(&quot; &quot;,FirstName ,1)+1,LEN(FirstName )-FIND(&quot; &quot;,FirstName ,1)))-1)&amp;
UPPER(MID(FirstName ,FIND(&quot; &quot;,MID(FirstName ,FIND(&quot; &quot;,FirstName ,1)+1,LEN(FirstName )-FIND(&quot; &quot;,FirstName ,1)))+FIND(&quot; &quot;,FirstName ,1)+1,1))&amp;
MID(FirstName ,FIND(&quot; &quot;,MID(FirstName ,FIND(&quot; &quot;,FirstName ,1)+1,LEN(FirstName )-FIND(&quot; &quot;,FirstName ,1)))+FIND(&quot; &quot;,FirstName ,1)+2,100)))</formula>
        <name>CONTACT Formatage prenom</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_MAJ_CONTACT_OWNER</fullName>
        <field>OwnerId</field>
        <lookupValue>synefo@gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>ES_MAJ_CONTACT_OWNER</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Codepostal_from_ES</fullName>
        <field>MailingPostalCode</field>
        <formula>Etablissement__r.Code_postal__c</formula>
        <name>MAJ Codepostal from ES</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Pays_from_ES</fullName>
        <field>MailingCountry</field>
        <formula>Etablissement__r.Pays__c</formula>
        <name>MAJ Pays from ES</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Rue_from_ES</fullName>
        <field>MailingStreet</field>
        <formula>Etablissement__r.Rue__c</formula>
        <name>MAJ Rue from ES</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Ville_from_ES</fullName>
        <field>MailingCity</field>
        <formula>Etablissement__r.Ville__c</formula>
        <name>MAJ Ville from ES</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CONTACT Changement Nom</fullName>
        <actions>
            <name>CONTACT_Formatage_nom</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CONTACT_formatage_prenom</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Contact.LastName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.FirstName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Actions effectuées lorsqu&apos;un contact change de nom</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Décocher Cible Email TAT</fullName>
        <actions>
            <name>CONTACT_Decocher_Cible_Email_TAT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Cible_e_mail_T_A_T__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Etat_du_compte_TAT__c</field>
            <operation>notEqual</operation>
            <value>client actif</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Décoche si le compte n&apos;est plus client</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Décocher Cible Newsletter TAT</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Cible_e_mail_T_A_T__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Etat_du_compte_TAT__c</field>
            <operation>notEqual</operation>
            <value>client actif</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Décoche si le compte n&apos;est plus client</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ES_MAJ_CONTACT_OWNER</fullName>
        <actions>
            <name>ES_MAJ_CONTACT_OWNER</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Division</field>
            <operation>equals</operation>
            <value>SPAIN</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Adresse from ES</fullName>
        <actions>
            <name>MAJ_Codepostal_from_ES</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Pays_from_ES</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Rue_from_ES</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Ville_from_ES</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Mettre_jour_avec_l_adresse_de_l_ES__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Permet de mettre à jour l&apos;adresse du contact avec celle de son ES d&apos;attache si la case &quot;Mettre à jour avec l&apos;adresse de l&apos;ES&quot; est cochée</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
