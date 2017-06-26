<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>INNOcqMajAvancementGlobal</fullName>
        <field>avancementGlobal__c</field>
        <formula>(
  IF(AuditNoAudit__c, 0, avancementAudit__c * 17) +
  IF(CIRnoValo__c, 0, avancementCIR__c * 65) +
  IF(CIInoValo__c, 0, avancementCII__c * 38) +
  IF(DJnoDossierJustificatif__c, 0, avancementDossiers__c * 19) 
)
/
( 
  IF(AuditNoAudit__c, 0, 17) +
  IF(CIRnoValo__c, 0, 65) +
  IF(CIInoValo__c, 0, 38) +
  IF(DJnoDossierJustificatif__c, 0, 19)
)</formula>
        <name>INNO CQ Maj avancement global</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>INNO CQ Calcul avancement global</fullName>
        <actions>
            <name>INNOcqMajAvancementGlobal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
