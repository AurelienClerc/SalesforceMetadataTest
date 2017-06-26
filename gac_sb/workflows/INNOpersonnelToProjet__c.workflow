<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>INNOmajTypeProjet</fullName>
        <field>Type_projet__c</field>
        <formula>TEXT(Projet__r.Type__c)</formula>
        <name>INNO MAJ Type du projet</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UniteDeTemps</fullName>
        <field>UniteTempsDepensesPersonnel2__c</field>
        <formula>text(Depense_de_personnel__r.UniteTempsDepensesPersonnel__c )</formula>
        <name>Unité de temps</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>INNO MAJ Type du projet</fullName>
        <actions>
            <name>INNOmajTypeProjet</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Unité de temps</fullName>
        <actions>
            <name>UniteDeTemps</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
