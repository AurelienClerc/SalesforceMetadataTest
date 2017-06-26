<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AppAT_alerte_dossier_salari_forclusion_7j</fullName>
        <description>AppAT alerte dossier salarié forclusion -7j</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>rsetrakian@global-approach-consulting.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>GAC_France/AT_alerte_forclusion_7j</template>
    </alerts>
    <alerts>
        <fullName>AppAT_alerte_dossier_salari_forclusion_rente_7j</fullName>
        <description>AppAT alerte dossier salarié forclusion rente -7j</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>jcostanzo@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>rsetrakian@global-approach-consulting.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>GAC_France/AT_alerte_forclusion_rente_7j</template>
    </alerts>
    <fieldUpdates>
        <fullName>AppAT_DossierSalarieOrigineDossier</fullName>
        <field>OrigineDossierConseil__c</field>
        <literalValue>1</literalValue>
        <name>AppAT Dossier salarié Origine dossier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_Dossier_salari_MAJ_Num_Secu</fullName>
        <field>NumeroSecuriteSociale__c</field>
        <formula>LEFT( SUBSTITUTE(NumeroSecuriteSociale__c,&apos; &apos;,&apos;&apos;),1)+&apos; &apos;+
Right(left(SUBSTITUTE(NumeroSecuriteSociale__c,&apos; &apos;,&apos;&apos;),3),2)+&apos; &apos;+
Right(left(SUBSTITUTE(NumeroSecuriteSociale__c,&apos; &apos;,&apos;&apos;),5),2)+&apos; &apos;+
Right(left(SUBSTITUTE(NumeroSecuriteSociale__c,&apos; &apos;,&apos;&apos;),7),2)+&apos; &apos;+
Right(left(SUBSTITUTE(NumeroSecuriteSociale__c,&apos; &apos;,&apos;&apos;),10),3)+&apos; &apos;+
Right(left(SUBSTITUTE(NumeroSecuriteSociale__c,&apos; &apos;,&apos;&apos;),13),3)+&apos; &apos;+
Right(SUBSTITUTE(NumeroSecuriteSociale__c,&apos; &apos;,&apos;&apos;),2)</formula>
        <name>AppAT Dossier salarié MAJ Num Secu</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_Dossier_salari_MAJ_date_forclusio</fullName>
        <field>Date_de_forclusion__c</field>
        <formula>DatePriseCharge__c + 60
/*
IF(NOT(ISBLANK(Date_de_forclusion__c)),Date_de_forclusion__c,
   IF(ISBLANK( DateAttributionTauxIPP__c), 
    DatePriseCharge__c+60 ,
    DateAttributionTauxIPP__c+60
      )
   ) 
*/</formula>
        <name>AppAT MAJ date forclusion</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_Dossier_salari_MAJ_name</fullName>
        <field>Name</field>
        <formula>UPPER(Nom__c)+&apos; &apos;+ 
Prenom__c  +&apos; - &apos;+
TEXT(Type__c)+&apos; &apos;+
IF(LEN(TEXT(DAY(DateSinistre__c)))=1,&apos;0&apos;+
TEXT(DAY(DateSinistre__c)),TEXT(DAY(DateSinistre__c))) +&apos;/&apos;+
IF(LEN(TEXT(MONTH(DateSinistre__c)))=1,&apos;0&apos;+
text(MONTH(DateSinistre__c)),TEXT(MONTH(DateSinistre__c)))+&apos;/&apos;+
TEXT(YEAR(DateSinistre__c))+
IF(ISBLANK(NDossier__c),&apos;&apos;,
                       &apos; - &apos;+ NDossier__c)</formula>
        <name>AppAT Dossier salarié MAJ name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_Dossier_salari_MAJ_statut_clos</fullName>
        <field>Statut__c</field>
        <literalValue>Terminé</literalValue>
        <name>AppAT Dossier salarié MAJ statut clos</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_Dossier_salari_MAJ_statut_en_cour</fullName>
        <field>Statut__c</field>
        <literalValue>Contestation en cours</literalValue>
        <name>AppAT Dossier salarié MAJ statut en cour</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAt_MAJ_Date_Mail_Forclusion</fullName>
        <field>TECH_Date_mail_forclusion__c</field>
        <formula>Date_de_forclusion__c - 7</formula>
        <name>AppAT MAJ Date Mail Forclusion</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAt_MAJ_Date_mail_forclusion_rente</fullName>
        <field>TECH_Date_envoi_mail_forclusion_rente__c</field>
        <formula>Date_de_forclusion_rente__c - 7</formula>
        <name>AppAT MAJ Date mail forclusion rente</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAt_Vide_Date_forclusion</fullName>
        <field>TECH_Date_mail_forclusion__c</field>
        <name>AppAt Vide Date forclusion</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAt_Vider_date_forclusion_rente</fullName>
        <field>TECH_Date_envoi_mail_forclusion_rente__c</field>
        <name>AppAt Vider date forclusion rente</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAt_maj_Date_forclusion_rente</fullName>
        <field>Date_de_forclusion_rente__c</field>
        <formula>DateAttributionTauxIPP__c + 60</formula>
        <name>AppAT MAJ Date forclusion rente</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>AppAT Dossier salarié MAJ Num Secu</fullName>
        <actions>
            <name>AppAT_Dossier_salari_MAJ_Num_Secu</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Formate le numéro de sécurité sociale avec les espaces. Mise à jour de champ (MAJ)</description>
        <formula>ISchANGED( NumeroSecuriteSociale__c )|| ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT Dossier salarié MAJ date forclusion</fullName>
        <active>true</active>
        <description>Alerte e-mail</description>
        <formula>ISPICKVAL(Statut__c,&apos;Demandé&apos;)&amp;&amp;
NOT(ISBLANK(DatePriseCharge__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppAT_alerte_dossier_salari_forclusion_7j</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AppATdossiersSalaries__c.Date_de_forclusion__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT Dossier salarié MAJ name</fullName>
        <actions>
            <name>AppAT_Dossier_salari_MAJ_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT Dossier salarié MAJ statut clos</fullName>
        <actions>
            <name>AppAT_Dossier_salari_MAJ_statut_clos</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>(NombreRecoursClos__c =  NombreRecours__c)&amp;&amp; NombreRecours__c &lt;&gt;0</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT Dossier salarié MAJ statut en cours</fullName>
        <actions>
            <name>AppAT_Dossier_salari_MAJ_statut_en_cour</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>(NombreRecoursClos__c &lt;&gt; NombreRecours__c)&amp;&amp; 
ISPICKVAL( Statut__c ,&apos;Terminé&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AppAT Dossier salarié NotifForclusion</fullName>
        <active>false</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>NOT(ISBLANK( TECH_Date_mail_forclusion__c ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppAT_alerte_dossier_salari_forclusion_7j</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>AppAt_Vide_Date_forclusion</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>AppATdossiersSalaries__c.TECH_Date_mail_forclusion__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT Dossier salarié NotifForclusionRente</fullName>
        <active>true</active>
        <description>Mise à jour de champ (MAJ). Alerte e-mail.</description>
        <formula>NOT(ISBLANK(  TECH_Date_envoi_mail_forclusion_rente__c  ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppAT_alerte_dossier_salari_forclusion_rente_7j</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>AppAt_Vider_date_forclusion_rente</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>AppATdossiersSalaries__c.TECH_Date_envoi_mail_forclusion_rente__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT Dossier salarié Origine dossier</fullName>
        <actions>
            <name>AppAT_DossierSalarieOrigineDossier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Coche la case origine dossier conseil si le dossier est consiel
Mise à jour de champ (MAJ)</description>
        <formula>RecordType.DeveloperName =&apos;Conseil&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AppAT Forclusion changed</fullName>
        <actions>
            <name>AppAt_MAJ_Date_Mail_Forclusion</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAt_MAJ_Date_mail_forclusion_rente</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISNEW() || 
ISCHANGED(Date_de_forclusion__c) ||  
ISCHANGED( Date_de_forclusion_rente__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ date forclusion</fullName>
        <actions>
            <name>AppAT_Dossier_salari_MAJ_date_forclusio</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISNEW() || ISCHANGED(DatePriseCharge__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ date forclusion rente</fullName>
        <actions>
            <name>AppAt_maj_Date_forclusion_rente</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISNEW() || ISCHANGED( DateAttributionTauxIPP__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
