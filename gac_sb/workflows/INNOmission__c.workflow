<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>INNOnomMission</fullName>
        <field>Name</field>
        <formula>Contrat__r.Account.Name + &apos; - &apos; + 
Contrat__r.RecordType.Name + &apos; - &apos; + 
TrigrammeTypeMission__c + 
IF(RecordType.DeveloperName == &apos;CIR&apos;, &apos; - &apos; + Annee_CIR__c, &apos;&apos;)</formula>
        <name>INNO Nom mission</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>INNO création mission</fullName>
        <actions>
            <name>INNOnomMission</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>INNOmission__c.TypeMission__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
