<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppCIR_MAJ_Type_enregistrement</fullName>
        <description>APPLICATION CIR - Remonte le type d&apos;enregistrement des dépenses de personnels dans un champ &apos;Type d&apos;enregistrement&apos;
Utile pour pouvoir remonter ce champ dans l&apos;objet dépense de personnel to projet</description>
        <field>Type_enregistrement__c</field>
        <formula>$RecordType.DeveloperName</formula>
        <name>AppCIR MAJ Type d&apos;enregistrement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppCIR MAJ Type d%27enregistrement</fullName>
        <actions>
            <name>AppCIR_MAJ_Type_enregistrement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>APPLICATION CIR - Remonte le type d&apos;enregistrement des dépenses de personnels dans un champ &apos;Type d&apos;enregistrement&apos;
Utile pour pouvoir remonter ce champ dans l&apos;objet dépense de personnel to projet
Mise à jour de champ (MAJ)</description>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
