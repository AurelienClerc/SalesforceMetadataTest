<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>INNO_TimeSheet_pass_e</fullName>
        <field>Passee__c</field>
        <literalValue>1</literalValue>
        <name>INNO TimeSheet passée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>INNO_semaine_TimeSheet</fullName>
        <field>Semaine__c</field>
        <formula>TEXT(MOD(FLOOR( (Date__c-7-DATEVALUE(&quot;2007-01-01&quot; ))/7),52)+1)</formula>
        <name>INNO semaine TimeSheet</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>INNO TimeSheet passée</fullName>
        <active>true</active>
        <criteriaItems>
            <field>INNOtimeSheet__c.Passee__c</field>
            <operation>equals</operation>
            <value>Faux</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>INNO_TimeSheet_pass_e</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>INNOtimeSheet__c.Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>INNO semaine TimeSheet</fullName>
        <actions>
            <name>INNO_semaine_TimeSheet</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>INNOtimeSheet__c.Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
