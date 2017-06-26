<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppAT_MAJ_nom_organisme</fullName>
        <field>Name</field>
        <formula>TEXT(TypeOrganisme__c) +&apos; - &apos;+ Ville__c</formula>
        <name>AppAT MAJ nom organisme</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppAT MAJ nom organisme</fullName>
        <actions>
            <name>AppAT_MAJ_nom_organisme</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
