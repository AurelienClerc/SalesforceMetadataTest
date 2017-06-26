<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppAT_CTN_MAJ_Identifiant</fullName>
        <field>IdentifiantCTN__c</field>
        <formula>TEXT(TypeCTN__c)+&apos; - &apos;+ Annee__c</formula>
        <name>AppAT CTN MAJ Identifiant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppAT CTN MAJ Identifiant</fullName>
        <actions>
            <name>AppAT_CTN_MAJ_Identifiant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
