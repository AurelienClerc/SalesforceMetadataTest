<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alerte_date_envoi_criture_avocat_vide</fullName>
        <description>Alerte date envoi écriture avocat vide</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/AppAT_Recours_Alerte_date_envoi_ecriture_avocat_vide</template>
    </alerts>
    <alerts>
        <fullName>AppATAlertedate_envoi_modele_vide</fullName>
        <description>Alerte date rec copie vide</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/AppAT_Alerte_date_mod_le_vide</template>
    </alerts>
    <alerts>
        <fullName>AppAT_Alerte_recours_fin_delai_appel_Accord</fullName>
        <description>AppAT Alerte recours fin délai appel Accord</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/AppAT_Alerte_1j_delai_dappel_recours</template>
    </alerts>
    <alerts>
        <fullName>AppAT_Alerte_recours_fin_delai_appel_rejet</fullName>
        <description>AppAT Alerte recours fin délai appel rejet</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/AppAT_Alerte_7j_delai_dappel_recours</template>
    </alerts>
    <alerts>
        <fullName>AppAT_alerte_recours_date_audience_15j</fullName>
        <description>AppAT alerte recours date audience -15j</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>rsetrakian@global-approach-consulting.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>GAC_France/AT_alerte_date_audience_15j</template>
    </alerts>
    <fieldUpdates>
        <fullName>AppATMAJRecoursDelaiPassage</fullName>
        <field>DelaiPassage__c</field>
        <formula>OrganismeJuridiction__r.DelaiPassage__c</formula>
        <name>AppAT MAJ Recours délai passage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_Recours_tx_succ_s</fullName>
        <field>TauxSucces__c</field>
        <formula>OrganismeJuridiction__r.TauxSuccesTheorique__c</formula>
        <name>AppAT MAJ Recours tx succès</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_recours_fin_delai_appel</fullName>
        <field>FinDelaiAppel__c</field>
        <formula>NotificationDecision__c + VALUE(CASE( TEXT(OrganismeJuridiction__r.TypeOrganisme__c), 
&apos;CRA&apos;,&apos;60&apos;,
&apos;TASS&apos;,&apos;30&apos;,
&apos;CA&apos;,&apos;60&apos;,
&apos;TCI&apos;,&apos;30&apos;,
&apos;CNITAAT&apos;,&apos;60&apos;,
&apos;CARSAT&apos;,&apos;60&apos;,
&apos;60&apos;))</formula>
        <name>AppAT MAJ recours fin délai appel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_recours_principal_FALSE</fullName>
        <field>RecoursPrincipal__c</field>
        <literalValue>0</literalValue>
        <name>AppAT MAJ recours principal FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_recours_principal_via_type</fullName>
        <field>RecoursPrincipal__c</field>
        <literalValue>1</literalValue>
        <name>AppAT MAJ recours principal via type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_Recours_nom</fullName>
        <field>Name</field>
        <formula>RecordType.Name +&apos; - &apos;+ DossierSalarie__r.Nom__c</formula>
        <name>AppAT_Recours_nom</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>AppAT Alerte Date rec Ecri avocat vide</fullName>
        <active>true</active>
        <description>Alerte e-mail</description>
        <formula>NOT(ISBLANK(  DateEnvoiEcritureAvocat__c )) &amp;&amp;
ISBLANK( DateReceptionCopieEcritureAvocat__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Alerte_date_envoi_criture_avocat_vide</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AppATrecours__c.DateEnvoiEcritureAvocat__c</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT Alerte Date rec copie vide</fullName>
        <active>true</active>
        <description>Alerte e-mail</description>
        <formula>NOT(ISBLANK( DateEnvoieModeleClient__c ))&amp;&amp;
ISBLANK(  DateReceptionCopie__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppATAlertedate_envoi_modele_vide</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AppATrecours__c.DateEnvoieModeleClient__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT MAJ Recours Notif 15 jours avant audience</fullName>
        <active>false</active>
        <criteriaItems>
            <field>AppATrecours__c.DateAudiencePassageReelle__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Alerte e-mail</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>AppATrecours__c.DateAudiencePassagePresumee__c</offsetFromField>
            <timeLength>-15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT MAJ Recours Notif 15 jours avant audience Reel</fullName>
        <active>true</active>
        <criteriaItems>
            <field>AppATrecours__c.DateAudiencePassageReelle__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Alerte e-mail</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppAT_alerte_recours_date_audience_15j</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AppATrecours__c.DateAudiencePassageReelle__c</offsetFromField>
            <timeLength>-15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT MAJ Recours stats organisme</fullName>
        <actions>
            <name>AppATMAJRecoursDelaiPassage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_Recours_tx_succ_s</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISCHANGED( OrganismeJuridiction__c ) || ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ alerte recours Accord</fullName>
        <active>true</active>
        <description>Alerte e-mail</description>
        <formula>ISPICKVAL( Statut__c,&apos;Accord&apos;) &amp;&amp;
NOT(ISBLANK( NotificationDecision__c ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppAT_Alerte_recours_fin_delai_appel_Accord</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AppATrecours__c.FinDelaiAppel__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT MAJ alerte recours rejet</fullName>
        <active>true</active>
        <description>Alerte e-mail</description>
        <formula>ISPICKVAL( Statut__c,&apos;Rejet&apos;) &amp;&amp;
NOT(ISBLANK( NotificationDecision__c )) &amp;&amp;
ISPICKVAL(Consequence__c,&apos;&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppAT_Alerte_recours_fin_delai_appel_rejet</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AppATrecours__c.FinDelaiAppel__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppAT MAJ recours fin de délai d%27appel</fullName>
        <actions>
            <name>AppAT_MAJ_recours_fin_delai_appel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>NOT(ISBLANK( NotificationDecision__c ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ recours principal false</fullName>
        <actions>
            <name>AppAT_MAJ_recours_principal_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>TypeContentieuxPrincipal__c=FALSE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ recours principal via type</fullName>
        <actions>
            <name>AppAT_MAJ_recours_principal_via_type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>TypeContentieuxPrincipal__c=TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AppAT_Recours_nom</fullName>
        <actions>
            <name>AppAT_Recours_nom</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
