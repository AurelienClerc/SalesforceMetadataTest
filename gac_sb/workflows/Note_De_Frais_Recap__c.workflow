<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AppNDF_EA_approbation_rcap</fullName>
        <description>AppNDF : EA approbation récap</description>
        <protected>false</protected>
        <recipients>
            <field>Collaborateur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Confirmation_approbation_recap_note_de_frais</template>
    </alerts>
    <alerts>
        <fullName>AppNDF_EA_approbation_rcapBR</fullName>
        <description>AppNDF : EA approbation récap BR</description>
        <protected>false</protected>
        <recipients>
            <field>Collaborateur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Confirmation_approbation_recap_note_de_frais_BR</template>
    </alerts>
    <alerts>
        <fullName>AppNDF_EA_rejet_recap</fullName>
        <description>AppNDF : EA rejet récap</description>
        <protected>false</protected>
        <recipients>
            <field>Collaborateur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Rejet_recap_note_de_frais</template>
    </alerts>
    <alerts>
        <fullName>AppNDF_EA_rejet_recap_BR</fullName>
        <description>AppNDF : EA rejet récap - BR</description>
        <protected>false</protected>
        <recipients>
            <field>Collaborateur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Rejet_recap_note_de_frais_BR</template>
    </alerts>
    <alerts>
        <fullName>AppNDF_Notification_de_suppression_d_une_depense</fullName>
        <description>AppNDF : Notification de suppression d&apos;une dépense</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_suppression_d_une_depense</template>
    </alerts>
    <fieldUpdates>
        <fullName>AppNDF_Approbateur_1_Pole_INNO_Manager</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF Approbateur 1 Pôle INNO Manager</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_Approbateur_2_Pole_INNO_Manager</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>lhauseux@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF Approbateur 2 Pôle INNO Manager</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_Approbateur_3_Pole_INNO_Manager</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF Approbateur 3 Pôle INNO Manager</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Appro_1_GAC_Br_sil_Stella</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>clebail@group-gac.com.br</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Appro. 1 - GAC Brésil Stella</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Appro_2_GAC_Br_sil_Stella</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>ngarcia@group-gac.com.br</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Appro. 2 - GAC Brésil Stella</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb2_INNO_Commerce_TOULOUSE</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>cazais@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF:FU Approb2 INNO Commerce TOULOUSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Commerce_IDF</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>sdaikhi@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Commerce IDF</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Commerce_LILLE</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>dlietar@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Commerce LILLE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Commerce_LYON</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>ygoullioud@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Commerce LYON</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Commerce_OUEST</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>lhauseux@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Commerce OUEST</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Tech_CHABRILLAT</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>mchabrillat@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Tech CHABRILLAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Tech_HUMBERT</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>ahumbert@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Tech HUMBERT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Tech_MANCIER</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>mmancier@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Tech MANCIER</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Tech_MERLIN</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>amerlin@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Tech MERLIN</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Tech_NARAINSAMY</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>knarainsamy@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Tech NARAINSAMY</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Tech_RASSAT</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>drassat@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Tech RASSAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approb_2_INNO_Tech_SEBBAN</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>msebban@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approb 2 INNO Tech SEBBAN</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_BU_Gd_Compte</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 BU Gd Compte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_Fiscaliste_Inno</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approbateur 1 Fiscaliste Inno</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_GAC_Br_sil</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>sgubitoso@group-gac.com.br</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 GAC - Brésil</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_GAC_SGP</fullName>
        <description>Mets à jour Approbateur 1,2 à la création en fonction du champ picklist Type d&apos;approbateur du user</description>
        <field>Approbateur_1__c</field>
        <lookupValue>cgervasoni@group-gac.sg</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 GAC SGP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_Info_DAF_SG</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>cplissier@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Info/DAF/SG</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_Marketing</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Marketing</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_Membre_DUP</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Membre DUP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_Membres_CODIR</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>lhauseux@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Membres CODIR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_P_le_INNO_Comm</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Pôle INNO Comm</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_P_le_INNO_Tech</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Pôle INNO Tech</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_Pole_ACS</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Pôle ACS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_Pole_IL</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Pôle IL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_Pole_TAT</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>estyranec@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 Pôle TAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_1_RH</fullName>
        <field>Approbateur_1__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 1 RH</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_BU_Gd_Compte</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>jalieu@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 BU Gd Compte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_Fiscaliste_Inno</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>vmwagala@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approbateur 2 Fiscaliste Inno</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_GAC_Br_sil</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>elima@group-gac.com.br</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 GAC - Brésil</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_GAC_SGP</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 GAC SGP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_Info_DAF_SG</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 Info/DAF/SG</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_Marketing</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>shabert@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 Marketing</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_Membres_CODIR</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 Membres CODIR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_Pole_ACS</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>jberche@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 Pôle ACS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_Pole_IL</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>lhauseux@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 Pôle IL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_Pole_TAT</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>mrocheteau@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 Pôle TAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_2_RH</fullName>
        <field>Approbateur_2__c</field>
        <lookupValue>rrakotomamonjy@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 2 RH</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_BU_Gd_Compte</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 3  BU Gd Compte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_Fiscaliste_Inno</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF: FU Approbateur 3 Fiscaliste Inno</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_GAC_Br_sil</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>ngarcia@group-gac.com.br</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 3 GAC - Brésil</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_Marketing</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 3 Marketing</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_P_le_INNO_Comm</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 3 Pôle INNO Comm</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_P_le_INNO_Tech</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 3 Pôle INNO Tech</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_Pole_ACS</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 3 Pôle ACS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_Pole_IL</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 3 Pôle IL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Approbateur_3_Pole_TAT</fullName>
        <field>Approbateur_3__c</field>
        <lookupValue>mhornez@group-gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AppNDF : FU Approbateur 3 Pôle TAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Date_de_validation</fullName>
        <field>Date_De_Validation__c</field>
        <formula>TODAY()</formula>
        <name>AppNDF : FU Date de validation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Etape_en_cours</fullName>
        <field>Etape__c</field>
        <literalValue>En cours</literalValue>
        <name>AppNDF : FU Etape en cours</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Etape_refuse</fullName>
        <field>Etape__c</field>
        <literalValue>Refusé</literalValue>
        <name>AppNDF : FU Etape refusé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Etape_soumis</fullName>
        <field>Etape__c</field>
        <literalValue>Soumis pour approbation</literalValue>
        <name>AppNDF : FU Etape soumis</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_FU_Etape_valid</fullName>
        <field>Etape__c</field>
        <literalValue>Validé</literalValue>
        <name>AppNDF : FU Etape validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppNDF_MAJ_type_approbation_NDF</fullName>
        <field>Type_approbation_NDF__c</field>
        <formula>TEXT(Collaborateur__r.Type_approbation_NDF__c)</formula>
        <name>AppNDF MAJ type approbation NDF</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A BU Grands Comptes</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_BU_Gd_Compte</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_BU_Gd_Compte</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_BU_Gd_Compte</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>BU Grands Comptes</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 et 3  à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A GAC - Brésil</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_GAC_Br_sil</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_GAC_Br_sil</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_GAC_Br_sil</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>GAC - Brésil</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A GAC - Brésil - Stella</fullName>
        <actions>
            <name>AppNDF_FU_Appro_1_GAC_Br_sil_Stella</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Appro_2_GAC_Br_sil_Stella</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>GAC - Brésil - Stella Gubitoso</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A GAC SGP</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_GAC_SGP</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_GAC_SGP</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>GAC SGP</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Informatique%2FFinance%2FSG</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_Info_DAF_SG</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_Info_DAF_SG</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Informatique/Finance/SG</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Marketing</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_Marketing</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_Marketing</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_Marketing</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Marketing</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Membre de la DUP</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_Membre_DUP</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Membre de la DUP</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1, 2 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Membres du CODIR</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_Membres_CODIR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_Membres_CODIR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Membre du CODIR</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2  à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pole Innovation Fiscaliste</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_Fiscaliste_Inno</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_Fiscaliste_Inno</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_Fiscaliste_Inno</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle Innovation Fiscaliste</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_Pole_ACS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_Pole_ACS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_Pole_ACS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle ACS</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle IL</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_Pole_IL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_Pole_IL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_Pole_IL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle IL</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Commercial</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_P_le_INNO_Comm</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_P_le_INNO_Comm</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>startsWith</operation>
            <value>Pôle INNO Commercial</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Commercial IDF</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Commerce_IDF</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Commercial IDF</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Commercial LILLE</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Commerce_LILLE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Commercial Lille</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Commercial LYON</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Commerce_LYON</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Commercial Lyon</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Commercial NARAINSAMY</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Tech_NARAINSAMY</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Technique NARAINSAMY</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Commercial OUEST</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Commerce_OUEST</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Commercial Ouest</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Commercial TOULOUSE</fullName>
        <actions>
            <name>AppNDF_FU_Approb2_INNO_Commerce_TOULOUSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Commercial Toulouse</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Manager</fullName>
        <actions>
            <name>AppNDF_Approbateur_1_Pole_INNO_Manager</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_Approbateur_2_Pole_INNO_Manager</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_Approbateur_3_Pole_INNO_Manager</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Manager</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2  à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Technique</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_P_le_INNO_Tech</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_P_le_INNO_Tech</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>startsWith</operation>
            <value>Pôle INNO Technique</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Technique CHABRILLAT</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Tech_CHABRILLAT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Technique CHABRILLAT</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Technique HUMBERT</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Tech_HUMBERT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Technique HUMBERT</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Technique MANCIER</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Tech_MANCIER</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Technique MANCIER</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Technique MERLIN</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Tech_MERLIN</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Technique MERLIN</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Technique NARAINSAMY</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Tech_NARAINSAMY</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Technique NARAINSAMY</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Technique RASSAT</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Tech_RASSAT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Technique RASSAT</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle INNO Technique SEBBAN</fullName>
        <actions>
            <name>AppNDF_FU_Approb_2_INNO_Tech_SEBBAN</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle INNO Technique SEBBAN</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Mets à jour Approbateur 2 à la création en fonction du champ picklist Type d&apos;approbateur du user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Pôle TAT</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_Pole_TAT</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_Pole_TAT</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_3_Pole_TAT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Pôle TAT</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user
Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ Approbateurs %3A Ressources Humaines</fullName>
        <actions>
            <name>AppNDF_FU_Approbateur_1_RH</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppNDF_FU_Approbateur_2_RH</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Type_approbation_NDF__c</field>
            <operation>equals</operation>
            <value>Ressources Humaines</value>
        </criteriaItems>
        <description>Mets à jour Approbateur 1,2 et 3 à la création en fonction du champ picklist Type d&apos;approbateur du user Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AppNDF MAJ type approbation NDF</fullName>
        <actions>
            <name>AppNDF_MAJ_type_approbation_NDF</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Note_De_Frais_Recap__c.Collaborateur__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
