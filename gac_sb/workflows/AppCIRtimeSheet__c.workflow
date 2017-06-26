<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppCIR_TimeSheet_passee</fullName>
        <field>Passee__c</field>
        <literalValue>1</literalValue>
        <name>AppCIR TimeSheet passée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppCIR_semaine_TimeSheet</fullName>
        <field>Semaine__c</field>
        <formula>TEXT(MOD(FLOOR( (Date__c-7-DATEVALUE(&quot;2007-01-01&quot; ))/7),52)+1)</formula>
        <name>AppCIR semaine TimeSheet</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppCIR TimeSheet passée</fullName>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>Passee__c == false</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppCIR_TimeSheet_passee</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>AppCIRtimeSheet__c.Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppCIR semaine TimeSheet</fullName>
        <actions>
            <name>AppCIR_semaine_TimeSheet</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AppCIRtimeSheet__c.Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
