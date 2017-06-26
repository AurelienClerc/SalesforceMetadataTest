<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>INNO_MAJ_Montant_RD_retenu_option_1</fullName>
        <field>Montant_RD_retenu_option1__c</field>
        <formula>IF( Actif__c = true, 
  CASE($RecordType.DeveloperName,
    &apos;jeuneDocteur&apos;,
    2 * (BLANKVALUE(Salaire_charge_option1__c, 0) + BLANKVALUE(Interessement_option1__c, 0) + BLANKVALUE(Participation_option1__c, 0)) * BLANKVALUE(Taux_RD_option1__c, 0),
    &apos;miseDisposition&apos;,
    BLANKVALUE(Salaire_charge_option1__c, 0) * BLANKVALUE(Taux_RD_option1__c, 0),
    (BLANKVALUE(Salaire_charge_option1__c, 0) + BLANKVALUE(Interessement_option1__c, 0) + BLANKVALUE(Participation_option1__c, 0)) * BLANKVALUE(Taux_RD_option1__c, 0)
  )
    ,
    0)</formula>
        <name>INNO MAJ Montant R&amp;D retenu option 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>INNO_MAJ_Montant_RD_retenu_option_2</fullName>
        <field>Montant_RD_retenu_option2__c</field>
        <formula>IF( Actif__c = true, 
  CASE($RecordType.DeveloperName,
    &apos;jeuneDocteur&apos;,
    2 * (BLANKVALUE(Salaire_charge_option2__c, 0) + BLANKVALUE(Interessement_option2__c, 0) + BLANKVALUE(Participation_option2__c, 0)) * BLANKVALUE(Taux_RD_option2__c, 0),
    &apos;miseDisposition&apos;,
    BLANKVALUE(Salaire_charge_option2__c, 0) * BLANKVALUE(Taux_RD_option2__c, 0),
    (BLANKVALUE(Salaire_charge_option2__c, 0) + BLANKVALUE(Interessement_option2__c, 0) + BLANKVALUE(Participation_option2__c, 0)) * BLANKVALUE(Taux_RD_option2__c, 0)
  )
    ,
    0)</formula>
        <name>INNO MAJ Montant R&amp;D retenu option 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>INNO_MAJ_Montant_RD_retenu_option_3</fullName>
        <field>Montant_RD_retenu_option3__c</field>
        <formula>IF( Actif__c = true, 
  CASE($RecordType.DeveloperName,
    &apos;jeuneDocteur&apos;,
    2 * (BLANKVALUE(Salaire_charge_option3__c, 0) + BLANKVALUE(Interessement_option3__c, 0) + BLANKVALUE(Participation_option3__c, 0)) * BLANKVALUE(Taux_RD_option3__c, 0),
    &apos;miseDisposition&apos;,
    BLANKVALUE(Salaire_charge_option3__c, 0) * BLANKVALUE(Taux_RD_option3__c, 0),
    (BLANKVALUE(Salaire_charge_option3__c, 0) + BLANKVALUE(Interessement_option3__c, 0) + BLANKVALUE(Participation_option3__c, 0)) * BLANKVALUE(Taux_RD_option3__c, 0)
  )
    ,
    0)</formula>
        <name>INNO MAJ Montant R&amp;D retenu option 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>INNO_MAJ_Type_enregistrement</fullName>
        <field>Type_enregistrement__c</field>
        <formula>$RecordType.DeveloperName</formula>
        <name>INNO MAJ Type d&apos;enregistrement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>INNO Dépense de personnel</fullName>
        <actions>
            <name>INNO_MAJ_Montant_RD_retenu_option_1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>INNO_MAJ_Montant_RD_retenu_option_2</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>INNO_MAJ_Montant_RD_retenu_option_3</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>INNO_MAJ_Type_enregistrement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
