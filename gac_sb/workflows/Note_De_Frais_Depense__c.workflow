<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppNDF_FU_nature_depense_categorie</fullName>
        <field>Nature_Depense_Categorie__c</field>
        <formula>TEXT( Nature_Depense__r.Categorie__c )</formula>
        <name>AppNDF : FU nature dépense catégorie</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppNDF %3A MAJ depense NDF</fullName>
        <actions>
            <name>AppNDF_FU_nature_depense_categorie</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
