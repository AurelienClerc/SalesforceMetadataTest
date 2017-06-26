<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppCIRmajTypeProjet</fullName>
        <description>APPLICATION CIR - MAJ le champ &apos;Type du projet&apos; des dépenses de personnel to projet en fonction du champ &apos;Type&apos; du projet
Le champ &apos;Type du projet&apos; ne peut pas être une formule car utile dans les critères des champs &apos;Heures R&amp;D option1,2,3&apos; sur le projet</description>
        <field>Type_projet__c</field>
        <formula>TEXT(Projet__r.Type__c)</formula>
        <name>AppCIR MAJ Type du projet</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppCIR MAJ Type du projet</fullName>
        <actions>
            <name>AppCIRmajTypeProjet</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>APPCIR - Mise à jour de champ (MAJ)  &apos;Type du projet&apos; des dép personnel to projet en fonction du champ &apos;Type&apos; du projet
Le champ &apos;Type du projet&apos; ne peut pas être une formule car utile dans les critères des champs &apos;Heures R&amp;D option1,2,3&apos; sur le projet</description>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
