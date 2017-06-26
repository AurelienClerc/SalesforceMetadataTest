<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>EVT_MAJ_Emplacement</fullName>
        <description>Mise à jour du champ Emplacement avec Emplacement Outlook</description>
        <field>Location</field>
        <formula>IF(TEXT(Annulation_et_report__c) &lt;&gt; &apos;&apos;,
CASE(TEXT(Annulation_et_report__c),    /*Traduction */
&apos;Annulé&apos;,$Label.Annule,
&apos;Reporté&apos;,$Label.Reporte,
&apos;Annulé à reprendre&apos;,$Label.Annule_a_reprendre,
TEXT(Annulation_et_report__c)),

CASE(TEXT(Nature_evenement__c),         /*Traduction */
&apos;RDV Physique&apos;, $Label.RDV_Physique,
&apos;RDV Téléphonique&apos;, $Label.RDV_Telephonique,
TEXT(Nature_evenement__c))
) + &apos; - &apos; + emplacement_outlook__c</formula>
        <name>EVT_MAJ_Emplacement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Obj_Eve</fullName>
        <description>Mise à jour du champ objet sur la page evenement</description>
        <field>Subject</field>
        <formula>TEXT(  Nature_evenement__c  )</formula>
        <name>MAJ_Obj_Eve</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>EVT_MAJ_Emplacement</fullName>
        <actions>
            <name>EVT_MAJ_Emplacement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.RecordTypeId</field>
            <operation>equals</operation>
            <value>RDV Commercial</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Règle qui remplie automatiquement le champ &quot;Emplacement&quot; avec les informations du champ &quot;Emplacement outlook&quot; dans le but d&apos;avoir plus d&apos;informations visible sur l&apos;agenda Salesforce</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ_Objet_Eve</fullName>
        <actions>
            <name>MAJ_Obj_Eve</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ) Mise à jour du champ objet sur la page événement.</description>
        <formula>OR ((ISCHANGED( Nature_evenement__c  )) , ISNEW() )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification compte-rendu de RDV mission %28TAT%29</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4 OR 5 OR 6 OR 7 OR 8)</booleanFilter>
        <criteriaItems>
            <field>Event.RecordTypeId</field>
            <operation>equals</operation>
            <value>RDV Consultant</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>Consultant TAT,Manager Consultant TAT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Contexte__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Enjeux__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Timing_Prochaine_tape__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Attente_Besoin__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Processus_de_decision__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Objections__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Alerte e-mail Notification informant qu&apos;un compte-rendu de RDV a été saisi par un consultant TAT.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
