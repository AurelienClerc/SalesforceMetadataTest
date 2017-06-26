<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppAt_MAJ_Lieu</fullName>
        <field>Lieu__c</field>
        <formula>RueFormation__c &amp;BR()&amp;
VilleFormation__c&amp;&quot; &quot;&amp;CodePostalFormation__c&amp;BR()&amp;
PaysFormation__c</formula>
        <name>AppAt MAJ Lieu</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppAT Lieu portail</fullName>
        <actions>
            <name>AppAt_MAJ_Lieu</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AppATdateFormationPortail__c.Lieu__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
