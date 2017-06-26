<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppAT_Dossier_salari_MAJ_Num_SIRET</fullName>
        <field>SIRET__c</field>
        <formula>LEFT( SUBSTITUTE(SIRET__c,&apos; &apos;,&apos;&apos;),3)+&apos; &apos;+ 
Right(left(SUBSTITUTE(SIRET__c,&apos; &apos;,&apos;&apos;),6),3)+&apos; &apos;+ 
Right(left(SUBSTITUTE(SIRET__c,&apos; &apos;,&apos;&apos;),9),3)+&apos; &apos;+ 
Right(SUBSTITUTE(SIRET__c,&apos; &apos;,&apos;&apos;),5)</formula>
        <name>AppAT Dossier salarié MAJ Num SIRET</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_Etablissement_name</fullName>
        <field>Name</field>
        <formula>LEFT(Mission__r.Name,40)&amp;&apos; - &apos;&amp;LEFT(Ville__c,20)&amp;
IF(ISBLANK(Entite__c),&apos;&apos;,&apos; - &apos;&amp;Entite__c)</formula>
        <name>AppAT MAJ Etablissement name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_etablissement_Code_unique</fullName>
        <field>Code_unique__c</field>
        <formula>IF(Etablissement_principal__c, 
Mission__r.Id &amp; CodeRisque__c,
 Id )</formula>
        <name>AppAT MAJ etablissement Code unique</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppAT Dossier salarié MAJ Num SIRET</fullName>
        <actions>
            <name>AppAT_Dossier_salari_MAJ_Num_SIRET</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ Etablissement</fullName>
        <actions>
            <name>AppAT_MAJ_Etablissement_name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_etablissement_Code_unique</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Met à jour le nom de l&apos;établissement et le code unique
Mise à jour de champ (MAJ)</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
