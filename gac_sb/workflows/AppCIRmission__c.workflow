<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AppCIRmissionApprouvee</fullName>
        <description>AppCIR Mission CIR approuvée</description>
        <protected>false</protected>
        <recipients>
            <field>Soumetteur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>AppCIRmodelesMessages/AppCIR_mission_approuvee</template>
    </alerts>
    <fieldUpdates>
        <fullName>AppCIR_MAJ_Montant_total_depenses_retenu</fullName>
        <description>Description	APPLICATION CIR - Calcul le Montant total des dépenses retenu, on ne peux pas utiliser une formule car formule compilée trop volumineuse</description>
        <field>Montant_total_depenses_optionFinale__c</field>
        <formula>Total_salarie_optionFinale__c + 
Total_miseDisposition_optionFinale__c + 
Total_jeuneDocteur_optionFinale__c + 
Total_amortissement_optionFinale__c + 
Total_frais_fonctionnement_optionFinale__c + 
Total_brevetPM_optionFinale__c + 
Total_brevetDef_optionFinale__c + 
Total_amortissementBrevet_optionFinale__c + 
Total_brevetAssu_optionFinale__c + 
Total_normalisation_optionFinale__c + 
Total_veille_optionFinale__c + 
Total_prestataire_optionFinale__c + 
Total_remboursementAvance_optionFinale__c - 
Total_subvention_optionFinale__c - 
Total_avanceRemboursable_optionFinale__c - 
Honoraires_N1_a_deduire_optionFinale__c</formula>
        <name>AppCIR MAJ Montant total des dépenses re</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppCIR MAJ Montant total des dépenses retenu</fullName>
        <actions>
            <name>AppCIR_MAJ_Montant_total_depenses_retenu</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>APPLICATION CIR - Calcul le Montant total des dépenses retenu, on ne peut pas utiliser une formule car formule compilée trop volumineuse
Mise à jour de champ (MAJ)</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppCIR mission approuvée</fullName>
        <actions>
            <name>AppCIRmissionApprouvee</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AppCIRmission__c.Statut_approbation__c</field>
            <operation>equals</operation>
            <value>Validée</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
