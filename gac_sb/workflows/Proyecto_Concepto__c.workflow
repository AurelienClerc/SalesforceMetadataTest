<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Proyecto_Concepto</fullName>
        <field>Name</field>
        <formula>TEXT( ANO__c )  &amp; &quot; &quot; &amp; &quot;-&quot; &amp; &quot; &quot; &amp;  Mission__r.Compte__r.Name  &amp; &quot; &quot; &amp; &quot;-&quot; &amp; &quot; &quot; &amp;  Type_of_Proyecto_Concepto__c</formula>
        <name>Proyecto / Concepto</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Proyecto %2F Concepto</fullName>
        <actions>
            <name>Proyecto_Concepto</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISNEW() || ISCHANGED(Type_of_Proyecto_Concepto__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
