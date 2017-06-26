<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_Facture_ACS_avec_Creance_douteuse</fullName>
        <description>Notification Facture ACS ou CRH avec Créance douteuse</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_si_Facture_avec_cr_ance_douteuse_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_ACS_avec_Creance_irrecouvrable</fullName>
        <description>Notification Facture ACS/CRH avec créance irrécouvrable</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_si_Facture_avec_creance_irrecouvrable_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_avec_Cr_ance_douteuse_INNO</fullName>
        <description>Notification Facture avec Créance douteuse INNO</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>llagarde@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhornez@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mlacombe@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_si_Facture_avec_creance_douteuse_INNO</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_avec_Cr_ance_douteuse_OPTI</fullName>
        <description>Notification Facture avec Créance douteuse OPTI</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>llagarde@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhornez@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sbelhaddad@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_si_Facture_avec_cr_ance_douteuse_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_avec_Creance_douteuse_OPTI</fullName>
        <description>Notification Facture avec Créance douteuse OPTI</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>llagarde@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhornez@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sbelhaddad@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_si_Facture_avec_cr_ance_douteuse_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_avec_Creance_irrecouvrable</fullName>
        <description>Notification Facture avec Créance irrécouvrable INNO</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>llagarde@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhornez@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mlacombe@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_si_Facture_avec_creance_irrecouvrable_INNO</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_avec_Creance_irrecouvrable_OPTI</fullName>
        <description>Notification Facture avec Créance irrécouvrable OPTI</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>llagarde@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhornez@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sbelhaddad@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_si_Facture_avec_creance_irrecouvrable_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_validee_ACS</fullName>
        <description>Notification Facture validée (ACS ou CRH)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>sbelhaddad@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Facture_Validee_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_validee_IL</fullName>
        <description>Notification Facture validée (Perf RH + Perf FI)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mflauraud@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Facture_Validee_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_validee_INNO</fullName>
        <description>Notification Facture validée (INNO)</description>
        <protected>false</protected>
        <recipients>
            <recipient>mflauraud@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rbrunet@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Facture_Validee_INNO</template>
    </alerts>
    <alerts>
        <fullName>Notification_Facture_validee_TAT</fullName>
        <description>Notification Facture validée (TAT)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>sbelhaddad@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Facture_Validee_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Rejet_approbation_Facture_SGP</fullName>
        <description>Notification Rejet approbation Facture (SGP)</description>
        <protected>false</protected>
        <recipients>
            <recipient>SINGAPOUR_PIC</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Rejet_approbation_Facture_SGP</template>
    </alerts>
    <alerts>
        <fullName>Notification_cr_ance</fullName>
        <description>Notification typologie créance INNO</description>
        <protected>false</protected>
        <recipients>
            <recipient>DCR - Inno ETI/PME</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Directeur BU ETI/PME - Inno ETI/PME</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Directeur BU GC – Inno GC</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>ghermosilla@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msebban@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Typologie_cr_ance</template>
    </alerts>
    <alerts>
        <fullName>Notification_cr_ance_opti</fullName>
        <description>Notification typologie créance OPTI</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Typologie_cr_ance</template>
    </alerts>
    <alerts>
        <fullName>Notification_facture_validee_SGP</fullName>
        <description>Notification facture validée (SGP)</description>
        <protected>false</protected>
        <recipients>
            <recipient>GAC_SINGAPOUR</recipient>
            <type>roleSubordinates</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_SINGAPOUR/Notification_Facture_Validee_SGP</template>
    </alerts>
    <alerts>
        <fullName>Notification_modification_pourcentage_provisionner_sur_Facture</fullName>
        <description>Notification si modification % à provisionner sur une Facture</description>
        <protected>false</protected>
        <recipients>
            <recipient>cplissier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>llagarde@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhornez@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_si_modification_pourcentage_provisionner_sur_une_Facture</template>
    </alerts>
    <fieldUpdates>
        <fullName>BR_Factu_MAJ_RecordType_Avoir_non_valid</fullName>
        <field>RecordTypeId</field>
        <lookupValue>BR_Avoir_non_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>BR Factu MAJ RecordType Avoir non validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BR_Factu_MAJ_RecordType_Avoir_valid</fullName>
        <field>RecordTypeId</field>
        <lookupValue>BR_Avoir_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>BR Factu MAJ RecordType Avoir validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BR_Factu_MAJ_RecordType_Facture_non_vali</fullName>
        <field>RecordTypeId</field>
        <lookupValue>BR_Facture_non_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>BR Factu MAJ RecordType Facture non vali</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BR_Factu_MAJ_RecordType_Facture_valid_e</fullName>
        <field>RecordTypeId</field>
        <lookupValue>BR_Facture_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>BR Factu MAJ RecordType Facture validée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BR_Factu_MAJ_date_envoie</fullName>
        <field>Date_envoi__c</field>
        <formula>Today()</formula>
        <name>BR Factu MAJ date envoie</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CA_Factu_MAJ_RecordType_Avoir_non_valid</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Canada_avoir_non_valid</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>CA Factu MAJ RecordType Avoir non validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CA_Factu_MAJ_RecordType_Avoir_valide</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Canada_Avoir_valid</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>CA Factu MAJ RecordType Avoir validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CA_Factu_MAJ_RecordType_Facture_non_vali</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Canada_Facture_non_valid_e</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>CA Factu MAJ RecordType Facture non vali</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CA_Factu_MAJ_RecordType_facture_valid_e</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Canada_Facture_valid_e</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>CA Factu MAJ RecordType facture validée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Creance_irrecouvrable</fullName>
        <field>Creance_douteuse__c</field>
        <literalValue>0</literalValue>
        <name>Créance irrécouvrable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_CA_BR_SGP_Date_facture_internationnal</fullName>
        <description>Met a jour la date de la facture si la date renseignée avant la validation est inférieure a la date du 1er du mois en cours</description>
        <field>Date__c</field>
        <formula>IF(Date__c  &lt; Date(YEAR(TODAY()),MONTH(TODAY()),1),
Date(YEAR(TODAY()),MONTH(TODAY()),1)
,Date__c )</formula>
        <name>ES CA BR SGP Date facture internationnal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_Factu_MAJ_RecordType_Avoir_non_valid</fullName>
        <field>RecordTypeId</field>
        <lookupValue>ES_Avoir_non_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>ES Factu MAJ RecordType Avoir non validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_Factu_MAJ_RecordType_Avoir_valid</fullName>
        <field>RecordTypeId</field>
        <lookupValue>ES_Avoir_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>ES Factu MAJ RecordType Avoir validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_Factu_MAJ_RecordType_Facture_non_vali</fullName>
        <field>RecordTypeId</field>
        <lookupValue>ES_Facture_non_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>ES Factu MAJ RecordType Facture non vali</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_Factu_MAJ_RecordType_Facture_valid_e</fullName>
        <field>RecordTypeId</field>
        <lookupValue>ES_Facture_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>ES Factu MAJ RecordType Facture validée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_BR_MAJ_Montant_HT_avec_CA_Brut</fullName>
        <description>Met à jour le montant HT des factures Brésil avec le CA Brut</description>
        <field>Montant_HT__c</field>
        <formula>BR_CA_Brut__c</formula>
        <name>Factu BR - MAJ Montant HT avec CA Brut</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_BR_MAJ_Montant_HT_avec_CA_Enc</fullName>
        <description>Met à jour le montant HT des factures Brésil avec le CA à encaisser</description>
        <field>Montant_HT__c</field>
        <formula>BR_CA_Brut__c</formula>
        <name>Factu BR - MAJ Montant HT avec CA à Enc.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_BR_Met_jour_le_taux_TVA_1</fullName>
        <description>Met à jour le taux de tva à 1 pour les factures Brésil</description>
        <field>Taux_TVA__c</field>
        <formula>0</formula>
        <name>Factu BR - Met à jour le taux TVA à 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_Date_validation_null</fullName>
        <field>Date_validation__c</field>
        <name>Factu MAJ Date validation null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_Date_validation_today</fullName>
        <field>Date_validation__c</field>
        <formula>TODAY()</formula>
        <name>Factu MAJ Date validation today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_RecordType_Avoir_non_valid</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Avoir_non_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Factu MAJ RecordType Avoir non validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_RecordType_Avoir_valide</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Avoir_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Factu MAJ RecordType Avoir validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_RecordType_Facture_non_validee</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Facture_non_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Factu MAJ RecordType Facture non validée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_RecordType_Facture_validee</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Facture_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Factu MAJ RecordType Facture validée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_Statut_envoyee</fullName>
        <field>Statut__c</field>
        <literalValue>Envoyée</literalValue>
        <name>Factu MAJ Statut envoyée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_Statut_facture_en_attente</fullName>
        <description>CONSULTING SF - MAJ le champ Statut de la facture en &apos;En attente&apos;</description>
        <field>Statut__c</field>
        <literalValue>En attente</literalValue>
        <name>Factu MAJ Statut facture en attente</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_Statut_facture_validee</fullName>
        <description>CONSULTING SF - MAJ le champ Statut de la facture en validée</description>
        <field>Statut__c</field>
        <literalValue>Validée</literalValue>
        <name>Factu MAJ Statut facture validée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Factu_MAJ_Statut_soldee</fullName>
        <field>Statut__c</field>
        <literalValue>Soldée</literalValue>
        <name>Factu MAJ Statut soldée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_DateFactureCompta</fullName>
        <description>Si la date de facture est dans le mauvais mois
Met a jour la date de la facture à custom setting + 1 si c&apos;est une facture FR ou au 1er jour du mois en cours sinon</description>
        <field>Date__c</field>
        <formula>/*
Didier 31/01/14 Cas facture française : on vas apliquer le max entre la date de la facture et le custom setting 
sinon, on applique le max entre la date et le 1er jours du mois en cours
*/
   if(Date__c  &lt;= $Setup.FacturationSetting__c.Date_blocage__c  +1 ,$Setup.FacturationSetting__c.Date_blocage__c  +1,
Date__c )</formula>
        <name>MAJ DateFactureCompta</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_N_de_facture_unique</fullName>
        <description>Renseigne le N° de facture pour éventuellement déclencher une erreur d&apos;unicité</description>
        <field>N_de_facture_Unique__c</field>
        <formula>Name</formula>
        <name>MAJ N° de facture unique</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Reset_N_de_facture_unique</fullName>
        <field>N_de_facture_Unique__c</field>
        <name>MAJ Reset N° de facture unique</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Typologie_creance</fullName>
        <description>Met à jour la typologie creance en &quot;En Procédure&quot; si la case Creance douteuse est cohée</description>
        <field>Typologie_creance__c</field>
        <literalValue>En procédure</literalValue>
        <name>MAJ Typologie creance</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_taux_TVA_Canada</fullName>
        <field>Taux_TVA__c</field>
        <formula>TPS__c + TVQ__c</formula>
        <name>MAJ taux TVA Canada</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MaJ_CIF_sur_la_facture</fullName>
        <field>SIRET2__c</field>
        <formula>SIRET__c</formula>
        <name>MàJ CIF sur la facture</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SGP_Factu_MAJ_RType_Facture_non_valid_e</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SGP_Facture_non_validee</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SGP -Factu MAJ RType Facture non validée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SGP_Factu_MAJ_RecordType_Avoir_non_val</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SGP_Avoir_non_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SGP - Factu MAJ RecordType Avoir non val</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SGP_Factu_MAJ_RecordType_Avoir_valid</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SGP_Avoir_valide</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SGP - Factu MAJ RecordType Avoir validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SGP_Factu_MAJ_RecordType_Facture_valid</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SGP_Facture_validee</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>SGP - Factu MAJ RecordType Facture valid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>BR - Avoir créé</fullName>
        <actions>
            <name>Factu_BR_MAJ_Montant_HT_avec_CA_Brut</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Factu_BR_Met_jour_le_taux_TVA_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Account_Record_Type__c</field>
            <operation>equals</operation>
            <value>BRASIL_ACCOUNT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.BR_CA_Brut__c</field>
            <operation>lessThan</operation>
            <value>EUR 0</value>
        </criteriaItems>
        <description>Règle permettant de remplir les champs Montant HT et Taux TVA des factures Brésil afin d&apos;utiliser les champ Créance, encaissé, annulé par avoir etc...
Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BR - Factu Avoir dé-validé</fullName>
        <actions>
            <name>BR_Factu_MAJ_RecordType_Avoir_non_valid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>PRIORVALUE( Statut__c ) &lt;&gt; &apos;En attente&apos; &amp;&amp; ISPICKVAL(Statut__c,&apos;En attente&apos;)  &amp;&amp;  $RecordType.DeveloperName =&apos;BR_Avoir_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BR - Factu Avoir validé</fullName>
        <actions>
            <name>BR_Factu_MAJ_RecordType_Avoir_valid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISPICKVAL(PRIORVALUE( Statut__c ), &apos;En attente&apos;) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;En attente&apos;)) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;&apos;)) &amp;&amp;  $RecordType.DeveloperName = &apos;BR_Avoir_non_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BR - Factu Facture dé-validée</fullName>
        <actions>
            <name>BR_Factu_MAJ_RecordType_Facture_non_vali</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>PRIORVALUE( Statut__c ) &lt;&gt; &apos;En attente&apos; &amp;&amp; ISPICKVAL(Statut__c,&apos;En attente&apos;)  &amp;&amp;  $RecordType.DeveloperName = &apos;BR_Facture_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BR - Factu Facture validée</fullName>
        <actions>
            <name>BR_Factu_MAJ_RecordType_Facture_valid_e</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>BR_Factu_MAJ_date_envoie</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ES_CA_BR_SGP_Date_facture_internationnal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISPICKVAL(PRIORVALUE( Statut__c ), &apos;En attente&apos;) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;En attente&apos;)) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;&apos;)) &amp;&amp;  $RecordType.DeveloperName = &apos;BR_Facture_non_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BR - Factu créée</fullName>
        <actions>
            <name>Factu_BR_MAJ_Montant_HT_avec_CA_Enc</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Factu_BR_Met_jour_le_taux_TVA_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Account_Record_Type__c</field>
            <operation>equals</operation>
            <value>BRASIL_ACCOUNT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.BR_CA_Brut__c</field>
            <operation>greaterOrEqual</operation>
            <value>EUR 0</value>
        </criteriaItems>
        <description>Règle permettant de remplir les champs Montant HT et Taux TVA des factures Brésil afin d&apos;utiliser les champ Créance, encaissé, annulé par avoir etc...
Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CIF MàJ</fullName>
        <actions>
            <name>MaJ_CIF_sur_la_facture</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>ES - Avoir non validé,ES - Avoir validé,ES - Facture non validée,ES - Facture validée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.SIRET2__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Màj du CIF du compte sur la facture</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Creance douteuse</fullName>
        <actions>
            <name>MAJ_Typologie_creance</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Facture__c.Creance_douteuse__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Canada Facture non validée,Canada avoir non validé,Canada Facture validée,Canada Avoir validé</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Met à jour la typologie creance en &quot;Procédure&quot; si la case creance douteuse est cochée</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Créance irrécouvrable</fullName>
        <actions>
            <name>Creance_irrecouvrable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Creance_irrecouvrable__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Décoche la case Créance douteuse en dès que que la case créance irrécouvrable est cochée</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ES - Factu Avoir dé-validé</fullName>
        <actions>
            <name>ES_Factu_MAJ_RecordType_Avoir_non_valid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>PRIORVALUE( Statut__c ) &lt;&gt; &apos;En attente&apos; &amp;&amp; ISPICKVAL(Statut__c,&apos;En attente&apos;)  &amp;&amp;  $RecordType.DeveloperName = &apos;ES_Avoir_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ES - Factu Avoir validé</fullName>
        <actions>
            <name>ES_Factu_MAJ_RecordType_Avoir_valid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) ES</description>
        <formula>ISPICKVAL(PRIORVALUE( Statut__c ), &apos;En attente&apos;) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;En attente&apos;)) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;&apos;)) &amp;&amp;  $RecordType.DeveloperName = &apos;ES_Avoir_non_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ES - Factu Facture dé-validée</fullName>
        <actions>
            <name>ES_Factu_MAJ_RecordType_Facture_non_vali</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) ES</description>
        <formula>PRIORVALUE( Statut__c ) &lt;&gt; &apos;En attente&apos; &amp;&amp; ISPICKVAL(Statut__c,&apos;En attente&apos;)  &amp;&amp;  $RecordType.DeveloperName = &apos;ES_Facture_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ES - Factu Facture validée</fullName>
        <actions>
            <name>ES_CA_BR_SGP_Date_facture_internationnal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ES_Factu_MAJ_RecordType_Facture_valid_e</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) ES</description>
        <formula>ISPICKVAL(PRIORVALUE( Statut__c ), &apos;En attente&apos;) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;En attente&apos;)) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;&apos;)) &amp;&amp;  $RecordType.DeveloperName = &apos;ES_Facture_non_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Factu Avoir dé-validé</fullName>
        <actions>
            <name>Factu_MAJ_RecordType_Avoir_non_valid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>PRIORVALUE( Statut__c ) &lt;&gt; &apos;En attente&apos; &amp;&amp; ISPICKVAL(Statut__c,&apos;En attente&apos;)  &amp;&amp;  $RecordType.DeveloperName = &apos;Avoir_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Factu Avoir validé</fullName>
        <actions>
            <name>Factu_MAJ_RecordType_Avoir_valide</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISPICKVAL(PRIORVALUE( Statut__c ), &apos;En attente&apos;) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;En attente&apos;)) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;&apos;)) &amp;&amp;  $RecordType.DeveloperName = &apos;Avoir_non_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Factu Avoir%2FFacture envoyée</fullName>
        <actions>
            <name>Factu_MAJ_Statut_envoyee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Date_envoi__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Statut__c</field>
            <operation>equals</operation>
            <value>Validée</value>
        </criteriaItems>
        <description>Actions lorsque que le date d&apos;envoi de la facture est saisie. Mise à jour de champ (MAJ).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Factu Facture dé-validée</fullName>
        <actions>
            <name>Factu_MAJ_RecordType_Facture_non_validee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>PRIORVALUE( Statut__c ) &lt;&gt; &apos;En attente&apos; &amp;&amp; ISPICKVAL(Statut__c,&apos;En attente&apos;)  &amp;&amp;  $RecordType.DeveloperName = &apos;Facture_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Factu Facture désoldée</fullName>
        <actions>
            <name>Factu_MAJ_Statut_envoyee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Montant_creance_HT__c</field>
            <operation>greaterThan</operation>
            <value>EUR 0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Statut__c</field>
            <operation>equals</operation>
            <value>Soldée</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Factu Facture soldée</fullName>
        <actions>
            <name>Factu_MAJ_Statut_soldee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Montant_creance_HT__c</field>
            <operation>equals</operation>
            <value>EUR 0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Statut__c</field>
            <operation>notEqual</operation>
            <value>En attente</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Factu Facture validée</fullName>
        <actions>
            <name>Factu_MAJ_RecordType_Facture_validee</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_DateFactureCompta</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISPICKVAL(PRIORVALUE( Statut__c ), &apos;En attente&apos;) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;En attente&apos;)) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;&apos;)) &amp;&amp;  $RecordType.DeveloperName = &apos;Facture_non_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Facture validée - disable unicité du numéro</fullName>
        <actions>
            <name>MAJ_Reset_N_de_facture_unique</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Facture validée,BR - Facture validée,ES - Facture validée,Canada Facture validée</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Facture validée - unicité du numéro</fullName>
        <actions>
            <name>MAJ_N_de_facture_unique</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Facture validée,BR - Facture validée,ES - Facture validée,Canada Facture validée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.N_de_facture_Unique__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification Facture Validée %28ACS et CRH%29</fullName>
        <actions>
            <name>Notification_Facture_validee_ACS</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Mission__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,CRH</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Statut__c</field>
            <operation>equals</operation>
            <value>Validée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.CreatedById</field>
            <operation>notContain</operation>
            <value>Synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ByPassValidationRules__c</field>
            <operation>notEqual</operation>
            <value>Vrai</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la validation d&apos;une Facture (ACS ou CRH)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification Facture Validée %28Perf Financière%29</fullName>
        <actions>
            <name>Notification_Facture_validee_IL</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2 AND 3 AND 4) OR (1 AND 2 AND 3 AND 5)</booleanFilter>
        <criteriaItems>
            <field>Mission__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IL,CFI</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Statut__c</field>
            <operation>equals</operation>
            <value>Validée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.CreatedById</field>
            <operation>notContain</operation>
            <value>Synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.LastName</field>
            <operation>contains</operation>
            <value>poncins,plissier</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la validation d&apos;une Facture (Perf Financière)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification Facture Validée %28TAT%29</fullName>
        <actions>
            <name>Notification_Facture_validee_TAT</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Mission__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>TAT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Statut__c</field>
            <operation>equals</operation>
            <value>Validée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.CreatedById</field>
            <operation>notContain</operation>
            <value>Synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la validation d&apos;une Facture (TAT)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification Typologie créance INNO</fullName>
        <actions>
            <name>Notification_cr_ance</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Typologie_creance__c</field>
            <operation>equals</operation>
            <value>En procédure,Contentieux avocat,Problème de trésorerie,Litige mission</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Facture validée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Name</field>
            <operation>startsWith</operation>
            <value>CIR-,FI-,DI-,CIN-,AS-</value>
        </criteriaItems>
        <description>Alerte e-mail -</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification Typologie créance Perf RH %2B Perf Financière</fullName>
        <actions>
            <name>Notification_cr_ance_opti</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Typologie_creance__c</field>
            <operation>equals</operation>
            <value>En procédure,Contentieux avocat,Problème de trésorerie,Litige mission</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Facture validée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Name</field>
            <operation>startsWith</operation>
            <value>TAT-,IL-,ACS-,CRH-,CFI-</value>
        </criteriaItems>
        <description>Alerte e-mail -</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification si Facture ACS avec créance douteuse</fullName>
        <actions>
            <name>Notification_Facture_ACS_avec_Creance_douteuse</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerte e-mail - Envoi d&apos;une notification si la case créance douteuse est cochée sur une facture ACS</description>
        <formula>AND(
(Creance_douteuse__c  = True),
(OR(BEGINS(Name,&apos;ACS&apos;),BEGINS(Name,&apos;CRH&apos;))),
(ISCHANGED(provisionner__c))
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification si Facture ACS ou CRH avec créance irrécouvrable</fullName>
        <actions>
            <name>Notification_Facture_ACS_avec_Creance_irrecouvrable</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Creance_irrecouvrable__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Name</field>
            <operation>startsWith</operation>
            <value>ACS,CRH</value>
        </criteriaItems>
        <description>Alerte e-mail - Envoi d&apos;une notification si la case créance irrécouvrable est cochée sur une facture ACS ou CRH</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification si Facture avec créance douteuse INNO</fullName>
        <actions>
            <name>Notification_Facture_avec_Cr_ance_douteuse_INNO</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerte e-mail - Envoi d&apos;une notification si la case créance douteuse est cochée sur une facture INNO</description>
        <formula>AND(
(Creance_douteuse__c  = True),
(Pole__c = &apos;Inno&apos;),
(ISCHANGED(provisionner__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification si Facture avec créance douteuse Perf Financière</fullName>
        <actions>
            <name>Notification_Facture_avec_Cr_ance_douteuse_OPTI</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerte e-mail - Envoi d&apos;une notification si la case créance douteuse est cochée sur une facture Perf Financière</description>
        <formula>AND(
(Creance_douteuse__c  = True),
(Pole__c = &apos;Perf Financière&apos;),
(ISCHANGED(provisionner__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification si Facture avec créance douteuse Perf RH</fullName>
        <actions>
            <name>Notification_Facture_avec_Creance_douteuse_OPTI</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerte e-mail - Envoi d&apos;une notification si la case créance douteuse est cochée sur une facture Perf RH</description>
        <formula>AND(
(Creance_douteuse__c  = True),
(Pole__c = &apos;Perf RH&apos;),
($User.Code_analytique__c &lt;&gt;&quot;&quot;),
(ISCHANGED(provisionner__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification si Facture avec créance irrécouvrable INNO</fullName>
        <actions>
            <name>Notification_Facture_avec_Creance_irrecouvrable</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Creance_irrecouvrable__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Pole__c</field>
            <operation>equals</operation>
            <value>Inno</value>
        </criteriaItems>
        <description>Alerte e-mail - Envoi d&apos;une notification si la case créance irrécouvrable est cochée sur une facture INNO</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification si Facture avec créance irrécouvrable OPTI</fullName>
        <actions>
            <name>Notification_Facture_avec_Creance_irrecouvrable_OPTI</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Creance_irrecouvrable__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Facture__c.Pole__c</field>
            <operation>notEqual</operation>
            <value>Inno</value>
        </criteriaItems>
        <description>Alerte e-mail - Envoi d&apos;une notification si la case créance irrécouvrable est cochée sur une facture OPTI</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification si modification %25 à provisionner sur une Facture</fullName>
        <actions>
            <name>Notification_modification_pourcentage_provisionner_sur_Facture</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerte e-mail - Notification si modification du champ &quot; % à provisionner &quot; sur une Facture</description>
        <formula>ISCHANGED( provisionner__c )&amp;&amp;
Contrat__r.Account.RecordType.DeveloperName =&apos;FRANCE ACCOUNT&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SGP - Factu Avoir dé-validé</fullName>
        <actions>
            <name>SGP_Factu_MAJ_RecordType_Avoir_non_val</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>PRIORVALUE( Statut__c ) &lt;&gt; &apos;En attente&apos; &amp;&amp; ISPICKVAL(Statut__c,&apos;En attente&apos;)  &amp;&amp;  $RecordType.DeveloperName = &apos;SGP_Avoir_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SGP - Factu Avoir validé</fullName>
        <actions>
            <name>SGP_Factu_MAJ_RecordType_Avoir_valid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISPICKVAL(PRIORVALUE( Statut__c ), &apos;En attente&apos;) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;En attente&apos;)) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;&apos;)) &amp;&amp;  $RecordType.DeveloperName = &apos;SGP_Avoir_non_valide&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SGP - Factu Facture dé-validée</fullName>
        <actions>
            <name>SGP_Factu_MAJ_RType_Facture_non_valid_e</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>PRIORVALUE( Statut__c ) &lt;&gt; &apos;En attente&apos; &amp;&amp; ISPICKVAL(Statut__c,&apos;En attente&apos;)  &amp;&amp;  $RecordType.DeveloperName = &apos;SGP_Facture_validee&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SGP - Factu Facture validée</fullName>
        <actions>
            <name>SGP_Factu_MAJ_RecordType_Facture_valid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISPICKVAL(PRIORVALUE( Statut__c ), &apos;En attente&apos;) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;En attente&apos;)) &amp;&amp; NOT(ISPICKVAL(Statut__c,&apos;&apos;)) &amp;&amp;  $RecordType.DeveloperName = &apos;SGP_Facture_non_validee&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
