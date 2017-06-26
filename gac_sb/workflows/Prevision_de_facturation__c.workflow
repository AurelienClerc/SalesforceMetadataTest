<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Date_Saisie_du_TA</fullName>
        <description>Renseigne la date de saisie du TA automatiquement lorsque la case &quot;Saisie du TA&quot; est cochée</description>
        <field>Date_de_saisie_du_TA__c</field>
        <formula>TODAY()</formula>
        <name>Date Saisie du TA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FR_MAJ_ACS_modif_date_prev_encaissement</fullName>
        <field>Date_prevision_encaissement__c</field>
        <formula>Date_prevue__c + 120</formula>
        <name>FR MAJ ACS modif date prév encaissement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FR_MAJ_modif_date_pr_v_encaiss</fullName>
        <description>La date de prévision d&apos;encaissement de décale d&apos;autant que la date prévue lorsque celle-ci est modifiée.</description>
        <field>Date_prevision_encaissement__c</field>
        <formula>Date_prevue__c + 60</formula>
        <name>FR MAJ modif date prév encaissement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FR_TAT_MAJ_dossier_salari</fullName>
        <field>Dossier_salarie__c</field>
        <formula>text(Produit_tat__c)</formula>
        <name>FR TAT MAJ dossier salarié</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Planif_CIR_date_estimee_Technique</fullName>
        <field>Date_estime_technique__c</field>
        <formula>TODAY()</formula>
        <name>Planif_CIR_date_estimée_Technique</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Planif_motif_attente_Canada</fullName>
        <description>lorsque la planification passe en statut facturé, le motif prendra la même valeur</description>
        <field>Motif_attente_facturation__c</field>
        <literalValue>Facturé</literalValue>
        <name>Planif_motif_attente_Canada</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Probabilite_SPAIN_100_Planif_Facture</fullName>
        <field>Fiabilit__c</field>
        <formula>1</formula>
        <name>Probabilité SPAIN 100% Planif Facturé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Date Saisie du TA</fullName>
        <actions>
            <name>Date_Saisie_du_TA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Prevision_de_facturation__c.Saisie_du_TA__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Resneigne automatiquement la date de saisie du TA lorsque la case &quot; Saisie du TA &quot; est cochée.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>FR ACS %2F CRH MAJ modif date prévision encaissement</fullName>
        <actions>
            <name>FR_MAJ_ACS_modif_date_prev_encaissement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Si la date prévue de facturation est décalée d&apos;un certain nombre de jours, la date de prévision d&apos;encaissement doit être décalée d&apos;autant. Mise à jour de champ (MAJ)</description>
        <formula>((RecordType.DeveloperName  =&quot;ACS&quot;  || RecordType.DeveloperName  =&quot;CRH&quot;)  &amp;&amp; Prevision_HT__c &gt; 0 &amp;&amp;
((ISBLANK(Date_prevision_encaissement__c)|| (NOT(ISCHANGED(Date_prevision_encaissement__c))&amp;&amp; ISCHANGED(Date_prevue__c)))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FR MAJ modif date prévision encaissement</fullName>
        <actions>
            <name>FR_MAJ_modif_date_pr_v_encaiss</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Si la date prévue de facturation est décalée d&apos;un certain nombre de jours, la date de prévision d&apos;encaissement doit être décalée d&apos;autant. Mise à jour de champ (MAJ)</description>
        <formula>(RecordType.DeveloperName =&quot;TAT&quot; || RecordType.DeveloperName =&quot;IL&quot;  || RecordType.DeveloperName =&quot;AT_Advance_Risk_Pro&quot; ) &amp;&amp; Prevision_HT__c &gt; 0 &amp;&amp;
((ISBLANK(Date_prevision_encaissement__c)|| (NOT(ISCHANGED(Date_prevision_encaissement__c))&amp;&amp; ISCHANGED(Date_prevue__c))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FR TAT MAJ dossier salarié</fullName>
        <actions>
            <name>FR_TAT_MAJ_dossier_salari</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Met à jour le champ dossier Salariés avec la valeur du champ produit TAT. Mise à jour de champ (MAJ)</description>
        <formula>RecordType.DeveloperName =&apos;AT_Advance_Risk_Pro&apos; &amp;&amp; (ISCHANGED( Produit_tat__c )  ||  ISNEW() )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Planif_CIR_date_estimee_Technique</fullName>
        <actions>
            <name>Planif_CIR_date_estimee_Technique</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Prevision_de_facturation__c.Date_estime_technique__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Prevision_de_facturation__c.Categorie_estimation__c</field>
            <operation>equals</operation>
            <value>CIR N-1,Définitif (après CERFA),Définitif (forfait),Estimé (technique)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Prevision_de_facturation__c.Categorie_estimation__c</field>
            <operation>notEqual</operation>
            <value>Estimation commerce</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Probabilité SPAIN 100%25 Planif Facturé</fullName>
        <actions>
            <name>Probabilite_SPAIN_100_Planif_Facture</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Prevision_de_facturation__c.Statut__c</field>
            <operation>equals</operation>
            <value>Facturée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Prevision_de_facturation__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Consulting,R&amp;D Funding,R&amp;D Tax Credit</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
