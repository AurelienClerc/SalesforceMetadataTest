<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Maj_objet_activit_s</fullName>
        <field>Subject</field>
        <formula>TEXT( Nature_tache__c )</formula>
        <name>Maj objet activités</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MAJ Date echeance termine</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>MAJ_Objet_Tache</fullName>
        <actions>
            <name>Maj_objet_activit_s</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ) Mise à jour du champ objet sur la page tâche.
Source champs personnalisé &quot;objets&quot;</description>
        <formula>OR ((ISCHANGED( Nature_tache__c )) , ISNEW() )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
