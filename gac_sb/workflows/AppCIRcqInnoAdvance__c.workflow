<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>majAvancementGlobal</fullName>
        <field>avancementGlobal__c</field>
        <formula>(((avancementAudit__c * 17) +
 (avancementCIR__c * 65) +
 (avancementDossiers__c * 19))
/101)</formula>
        <name>Maj avancement global</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Calcul avancement global</fullName>
        <actions>
            <name>majAvancementGlobal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
