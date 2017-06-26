<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppAT_MAJ_MS_Name</fullName>
        <field>Name</field>
        <formula>EtablissementConcerne__r.Name &amp;&apos; - &apos;&amp;Annee__c</formula>
        <name>AppAT MAJ MS Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppAT MAJ MS Name</fullName>
        <actions>
            <name>AppAT_MAJ_MS_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
