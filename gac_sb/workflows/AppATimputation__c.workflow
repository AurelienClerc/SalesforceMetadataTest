<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>MAJ_DossierSalarieAnneeCCMIP</fullName>
        <field>AnneeCCMIP__c</field>
        <formula>Name</formula>
        <name>MAJ dossier salarié Année CCM IP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>DossierSalarie__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_DossierSalarieAnneeCCMIT</fullName>
        <field>AnneeCCMIT__c</field>
        <formula>Name</formula>
        <name>MAJ dossier salarié Année CCM IT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>DossierSalarie__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>MAJ imputation Année CCM IP</fullName>
        <actions>
            <name>MAJ_DossierSalarieAnneeCCMIP</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>(
  ISPICKVAL( ImputationsContestees__c ,&quot;IP&quot;) ||
  ISPICKVAL( ImputationsContestees__c ,&quot;IT &amp; IP&quot;)
)&amp;&amp;
(
  ISNEW() ||
  ISCHANGED( Name )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ imputation Année CCM IT</fullName>
        <actions>
            <name>MAJ_DossierSalarieAnneeCCMIT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>(
  ISPICKVAL( ImputationsContestees__c ,&quot;IT&quot;) ||
  ISPICKVAL( ImputationsContestees__c ,&quot;IT &amp; IP&quot;)
)&amp;&amp;
(
  ISNEW() ||
  ISCHANGED( Name )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
