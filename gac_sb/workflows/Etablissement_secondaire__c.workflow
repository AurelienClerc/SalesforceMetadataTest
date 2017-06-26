<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>MaJ_du_Champ_SIREN_sur_les_ES</fullName>
        <field>SIREN__c</field>
        <formula>LEFT(SIRET__c, 9)</formula>
        <name>MàJ du Champ SIREN sur les ES</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MàJ du Champ SIREN sur les ES</fullName>
        <actions>
            <name>MaJ_du_Champ_SIREN_sur_les_ES</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Etablissement_secondaire__c.Pays__c</field>
            <operation>equals</operation>
            <value>FRANCE</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Mise à jour du champs SIREN avec les 9 premiers chiffres du SIREN de l&apos;ES</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
