<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ATADVANCE_En_attente_retour_convention_AT_Advance_sign_e</fullName>
        <description>ATADVANCE - En attente retour convention AT Advance signée</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsetrakian@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/En_attente_retour_convention_AT_Advance_signee</template>
    </alerts>
    <alerts>
        <fullName>ATADVANCE_Identifiants_AT_Advance_Transmis_au_client</fullName>
        <description>ATADVANCE - Identifiants AT Advance Transmis au client</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsetrakian@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sbelhaddad@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/ATADVANCE_Identifiants_AT_Advance_Transmis_au_client</template>
    </alerts>
    <alerts>
        <fullName>ATADVANCE_Identifiants_AT_Advance_Transmis_au_client_Gratuit</fullName>
        <description>ATADVANCE - Identifiants AT Advance Transmis au client Gratuit</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsetrakian@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/ATADVANCE_Identifiants_AT_Advance_Transmis_au_client</template>
    </alerts>
    <alerts>
        <fullName>ATADVANCE_Reception_de_la_convention_AT_Advance_signee_par_le_client</fullName>
        <description>ATADVANCE - Réception de la convention AT Advance signée par le client</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsetrakian@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sbelhaddad@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Reception_de_la_convention_AT_Advance_signee_par_le_client</template>
    </alerts>
    <alerts>
        <fullName>ATADVANCE_Reception_de_la_convention_AT_Advance_signee_par_le_client_Gratuit</fullName>
        <description>ATADVANCE - Réception de la convention AT Advance signée par le client Gratuit</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsetrakian@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Reception_de_la_convention_AT_Advance_signee_par_le_client</template>
    </alerts>
    <alerts>
        <fullName>Notification_Contrat_sans_activation_ACS</fullName>
        <description>Notification Contrat sans activation (ACS / CRH)</description>
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
        <template>GAC_France/Notification_Contrat_cree_sans_activation_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_Contrat_sans_activation_Inno</fullName>
        <description>Notification Contrat sans activation (Inno ETI/PME)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lhauseux@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Contrat_cree_sans_activation_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_Contrat_sans_activation_Inno_GC</fullName>
        <description>Notification Contrat sans activation (Inno GC)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jalieu@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Contrat_cree_sans_activation_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_Contrat_sans_activation_Opti</fullName>
        <description>Notification Contrat sans activation (Opti)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_suiveur_notifications_Contrat__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Contrat_cree_sans_activation_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_activation_contrat_ACS</fullName>
        <description>Notification activation contrat (Perf RH)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_suiveur_notifications_Contrat__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_d_activtation_de_contrat_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_activation_contrat_All_BR</fullName>
        <description>Notification activation contrat All BR</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>clebail@group-gac.com.br</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ngarcia@group-gac.com.br</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Notification_activation_contrat_BR</template>
    </alerts>
    <alerts>
        <fullName>Notification_activation_contrat_All_ES</fullName>
        <description>Notification activation contrat All ES</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>jacano@group-gac.es</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/Notification_activation_contrat_ES</template>
    </alerts>
    <alerts>
        <fullName>Notification_activation_contrat_CIR_FI</fullName>
        <description>Notification activation contrat (inno)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gware@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lhauseux@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mflauraud@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rbrunet@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_d_activation_contrat_INNO</template>
    </alerts>
    <alerts>
        <fullName>Notification_activation_contrat_DI</fullName>
        <description>Notification activation contrat (DI)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gware@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mflauraud@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rbrunet@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_d_activation_contrat_INNO</template>
    </alerts>
    <alerts>
        <fullName>Notification_activation_contrat_Opti</fullName>
        <description>Notification activation contrat (Perf Financière)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_suiveur_notifications_Contrat__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mflauraud@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_d_activtation_de_contrat_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_activation_contrat_VEILLE</fullName>
        <description>Notification activation contrat (VEILLE)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>mpeltier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_d_activation_contrat_INNO</template>
    </alerts>
    <alerts>
        <fullName>Notification_cloture_contrat_Inno</fullName>
        <description>Notification clôture contrat (Inno + veille)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gware@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lhauseux@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mflauraud@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rbrunet@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_cloture_d_un_contrat_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_cloture_contrat_Opti</fullName>
        <description>Notification clôture contrat (Opti)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_suiveur_notifications_Contrat__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
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
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_cloture_d_un_contrat_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_cloture_contrat_VEILLE</fullName>
        <description>Notification clôture contrat (VEILLE)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>mpeltier@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_cloture_d_un_contrat_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_avenant_cree_TAT</fullName>
        <description>Notification contrat / avenant créé (TAT)</description>
        <protected>false</protected>
        <recipients>
            <recipient>sbelhaddad@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_creation_de_contrat_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_cree_ACS</fullName>
        <description>Notification contrat créé (ACS / CRH)</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_creation_de_contrat_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_cree_BR</fullName>
        <description>Notification contrat créé BR</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>clebail@group-gac.com.br</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ngarcia@group-gac.com.br</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Notification_de_creation_de_contrat_BR</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_cree_ES</fullName>
        <description>Notification contrat créé ES</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>bportillo@group-gac.es</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jacano@group-gac.es</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/Notification_de_creation_de_contrat_ES</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_cree_IDI</fullName>
        <description>Notification contrat créé (DI)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>aleurent@global-approach-consulting.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_creation_de_contrat_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_cree_IL</fullName>
        <description>Notification contrat créé (Perf Financière)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_suiveur_notifications_Contrat__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>afofana@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mlacombe@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_creation_de_contrat_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_cree_Inno</fullName>
        <description>Notification contrat créé (Inno)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_creation_de_contrat_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_cree_Opti</fullName>
        <description>Notification contrat créé (Opti)</description>
        <protected>false</protected>
        <recipients>
            <field>E_mail_du_DCR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_DR__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>E_mail_du_suiveur_notifications_Contrat__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>acrochet@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cmoussy@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>fgaury@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ActivatedById</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Binome_CC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Consultant_Commercial__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_de_creation_de_contrat_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_contrat_cree_SGP</fullName>
        <description>Notification contrat créé SGP</description>
        <protected>false</protected>
        <recipients>
            <recipient>ademontety@group-gac.sg</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cgervasoni@group-gac.sg</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mboissonot@group-gac.sg</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rtan@group-gac.sg</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>snazrin@group-gac.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_SINGAPOUR/Notification_de_creation_de_contrat_SGP</template>
    </alerts>
    <fieldUpdates>
        <fullName>Cloture_contrat_automatique</fullName>
        <field>Status</field>
        <literalValue>Clos</literalValue>
        <name>Cloture contrat automatique</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contrat_MAJ_Adresse_Fact_CP</fullName>
        <field>BillingPostalCode</field>
        <formula>Contrat_parent__r.BillingPostalCode</formula>
        <name>Contrat MAJ Adresse Fact - CP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contrat_MAJ_Adresse_Fact_Country</fullName>
        <field>BillingCountry</field>
        <formula>Contrat_parent__r.BillingCountry</formula>
        <name>Contrat MAJ Adresse Fact - Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contrat_MAJ_Adresse_Fact_rue</fullName>
        <field>BillingStreet</field>
        <formula>Contrat_parent__r.BillingStreet</formula>
        <name>Contrat MAJ Adresse Fact - rue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contrat_MAJ_Adresse_Fact_state</fullName>
        <field>BillingState</field>
        <formula>Contrat_parent__r.BillingState</formula>
        <name>Contrat MAJ Adresse Fact - state</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contrat_MAJ_Adresse_Fact_ville</fullName>
        <field>BillingCity</field>
        <formula>Contrat_parent__r.BillingCity</formula>
        <name>Contrat MAJ Adresse Fact - ville</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contrat_MAJ_Grille_tarifaire_respectee</fullName>
        <field>Grille_tarifaire_respectee__c</field>
        <literalValue>1</literalValue>
        <name>Contrat MAJ Grille tarifaire respectée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_MAJ_CIF_Contrat</fullName>
        <field>CIF__c</field>
        <formula>Account.SIRET__c</formula>
        <name>ES MAJ CIF Contrat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Date_Levee_tacite</fullName>
        <field>Date_de_levee_de_tacite__c</field>
        <formula>IF( ( RecordType.DeveloperName == &apos;CIR&apos; || RecordType.DeveloperName == &apos;AS&apos; || RecordType.DeveloperName == &apos;DI&apos; ) 
  &amp;&amp; (INCLUDES(Type_de_mission_multi__c , &quot;CIR classique&quot;) || INCLUDES(Type_de_mission_multi__c , &quot;Crédit d&apos;Impôt Métiers d&apos;Art&quot;) || INCLUDES(Type_de_mission_multi__c , &quot;Crédit d&apos;Impôt Innovation&quot;)) 
  &amp;&amp; !ISBLANK(Derniere_annee_de_Tacite__c), 

    IF(ISPICKVAL(Conditions_de_renouvellement__c ,&apos;Tacite&apos;), 
      IF(Account.mois_cloture__c!=12, 
        DATE(VALUE(Derniere_annee_de_Tacite__c ) + 1,1,1)+165, /* Account cloture au 31/12 =&gt; on prend derniere année + 4.5 mois + 2 mois*/ 
        DATE(VALUE(Derniere_annee_de_Tacite__c ) +1,1,1)+195 /* Account cloture différent de 31/12 =&gt; on derniere année + 3.5 mois + 2mois */ 
      ) 
      , null
    ) 
    /*Si on est pas dans le cas inno, on laisse la date de levée de tacite*/ 
    , Date_de_levee_de_tacite__c
)</formula>
        <name>MAJ_Date_Levee_tacite</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Date_de_d_but</fullName>
        <description>Date de début du contrat = date de signature</description>
        <field>StartDate</field>
        <formula>Date_de_reception_du_contrat__c</formula>
        <name>MAJ Date de début</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Date_de_fin_de_contrat</fullName>
        <field>EndDate</field>
        <formula>IF(RecordType.DeveloperName == &apos;TAT&apos;, 
  /*CAS TAT (Ce cas a été désactivé au niveau de la règle de WF DHU 12/10/2015)*/ 
  IF(ISPICKVAL( Conditions_de_renouvellement__c ,&apos;Tacite&apos;),null,  /*SI tacite, on vide*/ 
    IF(Derniere_annee_du_contrat__c != null, 
      DATE(Value(Derniere_annee_du_contrat__c),12,31),  /*SI non tacite, on prend le 31/12 de la derniere année*/ 
      null 
    ) 
  ) /*Fin cas TAT */ 
  , 
  /*CAS Inno*/ 
  IF(RecordType.DeveloperName = &apos;CIR&apos; || RecordType.DeveloperName = &apos;FI&apos; || RecordType.DeveloperName = &apos;DI&apos;, 
    IF(RecordType.DeveloperName = &apos;CIR&apos; &amp;&amp; (INCLUDES(Type_de_mission_multi__c , &quot;classique&quot;) || INCLUDES(Type_de_mission_multi__c , &quot;Crédit d&apos;Impôt Métiers d&apos;Art&quot;) || INCLUDES(Type_de_mission_multi__c , &quot;CIR / CII Classique&quot;) || INCLUDES(Type_de_mission_multi__c , &quot;Crédit d&apos;Impôt Innovation&quot;)), 
      IF(ISPICKVAL( Conditions_de_renouvellement__c ,&apos;Tacite&apos;),
        null, /* on vide le champs si tacite*/ 
        /*Inno sans tacite*/ 
        IF(Derniere_annee_du_contrat__c != null, 
          IF( Account.mois_cloture__c = 12, 
            DATE(VALUE(Derniere_annee_du_contrat__c ) +1,1,1) + 135, /* Account cloture au 31/12 =&gt; on prend derniere année + 4.5 mois */ 
            DATE(VALUE(Derniere_annee_du_contrat__c ) +1, Account.mois_cloture__c + 1,1) + 105  /* Account cloture différent de 31/12 =&gt; on derniere année + 3.5 mois */ 
          ) 
          ,null 
        ) 
      ),
    EndDate
    )
    , 
    /*Fin cas Inno*/ 
    /*Cas par défaut*/ 
    DATE ( 
      /*YEAR*/ 
      YEAR(StartDate) + FLOOR((MONTH(StartDate) + ContractTerm - 1)/12), 
      /*MONTH*/ 
      CASE(MOD(MONTH(StartDate) + ContractTerm, 12 ), 0, 12, MOD(MONTH(StartDate)+ ContractTerm, 12 )), 
      /*DAY*/ 
      MIN(DAY(StartDate), 
        CASE(MOD(MONTH(StartDate) + ContractTerm,12), 9, 30, 4, 30, 6, 30, 11, 30, 2, 
        /* return max days for February dependent on if end date is leap year */ 
        IF(MOD(YEAR(StartDate) + FLOOR((MONTH(StartDate) + ContractTerm)/12), 400) = 0 || (MOD(YEAR(StartDate) + FLOOR((MONTH(StartDate) + ContractTerm)/12), 4) = 0 &amp;&amp; MOD(YEAR(StartDate) + FLOOR((MONTH(StartDate) + ContractTerm)/12), 100) &lt;&gt; 0 
        ), 
        29,28), 
        31)
      ) 
    ) 
  /*Fin cas par défaut*/ 
  ) 
)</formula>
        <name>MAJ Date de fin de contrat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Dur_e_contrat</fullName>
        <field>ContractTerm</field>
        <formula>IF(
AND(
LastModifiedBy.Profile.Id &lt;&gt;&apos;00eD0000001h8r5&apos;,
Nb_ann_es_interventions__c &gt; 0),
Nb_ann_es_interventions__c * 12,
12)</formula>
        <name>MAJ Durée contrat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_E_mail_DCR_contrat</fullName>
        <field>E_mail_du_DCR__c</field>
        <formula>Consultant_Commercial__r.DCR__r.Email</formula>
        <name>MAJ E-mail DCR contrat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_E_mail_DR_contrat</fullName>
        <field>E_mail_du_DR__c</field>
        <formula>Consultant_Commercial__r.DR__r.Email</formula>
        <name>MAJ E-mail DR contrat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_E_mail_du_suiveur_Approbation</fullName>
        <description>Permet de récupérer l&apos;adresse E-mail d&apos;une personne afin qu&apos;elle puisse également recevoir les notifications sur les contrat d&apos;un utilisateur qu&apos;elle suit.</description>
        <field>E_mail_du_suiveur_notifications_Contrat__c</field>
        <formula>Opportunite__r.Email_du_suiveur_notification_workflow__c</formula>
        <name>MAJ E-mail du suiveur Approbation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_N_Compte_client</fullName>
        <field>N_compte_client__c</field>
        <formula>IF( RecordType.DeveloperName =&apos;CIR_CANADA&apos;, 
TEXT(Account.Numero_du_client__c) ,
&quot;411&quot; + LEFT( SUBSTITUTE(Account.Name,&quot; &quot;,&quot;&quot;) , 10))</formula>
        <name>MAJ N° Compte client</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_N_Compte_client_Renouv_avenants</fullName>
        <field>N_compte_client__c</field>
        <formula>Contrat_parent__r.N_compte_client__c</formula>
        <name>MAJ N° Compte client Renouv et avenants</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ATADVANCE - En attente retour convention AT Advance signée</fullName>
        <actions>
            <name>ATADVANCE_En_attente_retour_convention_AT_Advance_sign_e</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Contract.AT_Advance__c</field>
            <operation>equals</operation>
            <value>Gratuit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.AT_Advance__c</field>
            <operation>equals</operation>
            <value>Payant</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Statut_deploiement_AT_Advance__c</field>
            <operation>equals</operation>
            <value>En attente de la convention signée</value>
        </criteriaItems>
        <description>ATADVANCE - En attente retour convention AT Advance signée
Alerte e-mail</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ATADVANCE - Identifiants AT Advance Transmis au client</fullName>
        <actions>
            <name>ATADVANCE_Identifiants_AT_Advance_Transmis_au_client</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.AT_Advance__c</field>
            <operation>equals</operation>
            <value>Payant</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Statut_deploiement_AT_Advance__c</field>
            <operation>equals</operation>
            <value>Déploiement terminé / Identifiants transmis au client</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <description>ATADVANCE - Identifiants AT Advance Transmis au client Alerte e-mail</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ATADVANCE - Identifiants AT Advance Transmis au client Gratuit</fullName>
        <actions>
            <name>ATADVANCE_Identifiants_AT_Advance_Transmis_au_client_Gratuit</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.AT_Advance__c</field>
            <operation>equals</operation>
            <value>Gratuit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Statut_deploiement_AT_Advance__c</field>
            <operation>equals</operation>
            <value>Déploiement terminé / Identifiants transmis au client</value>
        </criteriaItems>
        <description>Alerte e-mail ATADVANCE - Identifiants AT Advance Transmis au client Gratuit</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ATADVANCE - Réception de la convention AT Advance signée par le client</fullName>
        <actions>
            <name>ATADVANCE_Reception_de_la_convention_AT_Advance_signee_par_le_client</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Contract.AT_Advance__c</field>
            <operation>equals</operation>
            <value>Gratuit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.AT_Advance__c</field>
            <operation>equals</operation>
            <value>Payant</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Statut_deploiement_AT_Advance__c</field>
            <operation>equals</operation>
            <value>Convention signée reçue / Déploiement à effectuer</value>
        </criteriaItems>
        <description>Alerte e-mail ATADVANCE - Réception de la convention AT Advance signée par le client</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ATADVANCE - Réception de la convention AT Advance signée par le client Gratuit</fullName>
        <actions>
            <name>ATADVANCE_Reception_de_la_convention_AT_Advance_signee_par_le_client_Gratuit</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.AT_Advance__c</field>
            <operation>equals</operation>
            <value>Gratuit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Statut_deploiement_AT_Advance__c</field>
            <operation>equals</operation>
            <value>Convention signée reçue / Déploiement à effectuer</value>
        </criteriaItems>
        <description>Alerte e-mail ATADVANCE - Réception de la convention AT Advance signée par le client Gratuit</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Cloture contrat automatique</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.EndDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>TAT,CIR,DI,FI,CIN,AS</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.EndDate</field>
            <operation>greaterOrEqual</operation>
            <value>4/29/2015</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Cloture_contrat_automatique</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.EndDate</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>E-mail du suiveur notifications Contrat</fullName>
        <actions>
            <name>MAJ_E_mail_du_suiveur_Approbation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Permet de récupérer l&apos;adresse E-mail d&apos;une personne afin qu&apos;elle puisse également recevoir les notifications sur les contrat d&apos;un utilisateur qu&apos;elle suit.</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ES MAJ CIF Contrat</fullName>
        <actions>
            <name>ES_MAJ_CIF_Contrat</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.CIF__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SIRET__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>SPAIN_ACCOUNT</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>INS contrat tat</fullName>
        <actions>
            <name>Contrat_MAJ_Adresse_Fact_CP</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Contrat_MAJ_Adresse_Fact_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Contrat_MAJ_Adresse_Fact_rue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Contrat_MAJ_Adresse_Fact_state</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Contrat_MAJ_Adresse_Fact_ville</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) A l&apos;insertion d&apos;un contrat TAT, on doit mettre l&apos;adresse du contrat avec l&apos;adresse de son contrat parent s&apos;il y en a une</description>
        <formula>ISPICKVAL(Division , &apos;FRANCE&apos;) &amp;&amp; Contrat_parent__c != null &amp;&amp; (ISNEW()|| ISCHANGED(Contrat_parent__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Date de début</fullName>
        <actions>
            <name>MAJ_Date_de_d_but</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) La date de début = date de signature du contrat.</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Date de fin de contrat</fullName>
        <actions>
            <name>MAJ_Date_Levee_tacite</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Date_de_fin_de_contrat</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>(RecordType.DeveloperName &lt;&gt; &apos;TAT&apos; &amp;&amp; 
ISCHANGED( ContractTerm ) || RecordType.DeveloperName &lt;&gt; &apos;TAT&apos; &amp;&amp; ISNEW()) || 
(
/*
EDIT DHU (requete 00012611) 12/10/2015 : on retire le TAT du calcul de la date de fin + règles de validation sur les contrat pour rendre obligatoire la date de fin de contrat
RecordType.DeveloperName = &apos;TAT&apos; || 
*/
(RecordType.DeveloperName = &apos;CIR&apos; || RecordType.DeveloperName = &apos;DI&apos; || RecordType.DeveloperName = &apos;CIN&apos; ||RecordType.DeveloperName = &apos;AS&apos; ) 
&amp;&amp;
(ISCHANGED(Annees_concernees__c) || ISCHANGED( Conditions_de_renouvellement__c)
))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Date fin client actif A supprimer</fullName>
        <actions>
            <name>MAJ_Dur_e_contrat</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Regle qui met à jour le champ natif Durée du contrat qui va mettre à jour automatiquement la date de fin client actif.</description>
        <formula>RecordType.DeveloperName != &apos;TAT&apos; &amp;&amp; 
RecordType.DeveloperName != &apos;IL&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ E-mail DCR</fullName>
        <actions>
            <name>MAJ_E_mail_DCR_contrat</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Met à jour l&apos;email du DCR sur l&apos;objet contrat en fonction du champs &quot;Contrat signé par&quot;</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ E-mail DR</fullName>
        <actions>
            <name>MAJ_E_mail_DR_contrat</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Met à jour l&apos;email du DR sur l&apos;objet contrat en fonction du champs &quot;Contrat signé par&quot;</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Grille tarifaire respectée</fullName>
        <actions>
            <name>Contrat_MAJ_Grille_tarifaire_respectee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>!ISBLANK(Opportunite__c)
&amp;&amp; Opportunite__r.Grille_tarifaire_respectee__c</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ N%C2%B0 Compte client</fullName>
        <actions>
            <name>MAJ_N_Compte_client</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISBLANK(N_compte_client__c) &amp;&amp;  (    (RecordType.DeveloperName != &apos;SGP_PIC&apos;      || RecordType.DeveloperName != &apos;CF&apos;      ||
RecordType.DeveloperName != &apos;PF&apos;      ||
RecordType.DeveloperName != &apos;ACS&apos;      || RecordType.DeveloperName != &apos;TAT&apos;    || RecordType.DeveloperName != &apos;CRH&apos;   )   ||    ((RecordType.DeveloperName == &apos;ACS&apos;         || RecordType.DeveloperName == &apos;TAT&apos; || RecordType.DeveloperName == &apos;CRH&apos;)     &amp;&amp; (ISBLANK(Contrat_parent__c)        || (!ISPICKVAL(Type_de_contrat__c, &apos;Renouvellement / Reconduction de contrat&apos;)            &amp;&amp; !ISPICKVAL(Type_de_contrat__c, &apos;Avenant à contrat en cours&apos;))        )   ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ N%C2%B0 Compte client Renouvellements et Avenants</fullName>
        <actions>
            <name>MAJ_N_Compte_client_Renouv_avenants</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISBLANK(N_compte_client__c) &amp;&amp; (RecordType.DeveloperName == &apos;ACS&apos; || RecordType.DeveloperName == &apos;TAT&apos; || RecordType.DeveloperName == &apos;CRH&apos;) &amp;&amp; (!ISBLANK(Contrat_parent__c)    &amp;&amp; (ISPICKVAL(Type_de_contrat__c, &apos;Renouvellement / Reconduction de contrat&apos;)        || ISPICKVAL(Type_de_contrat__c, &apos;Avenant à contrat en cours&apos;))    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification %C2%AB Reconduction%2FRenouvellement %C2%BB Contrat TAT</fullName>
        <actions>
            <name>Notification_contrat_avenant_cree_TAT</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>TAT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Type_de_contrat__c</field>
            <operation>equals</operation>
            <value>Renouvellement / Reconduction de contrat</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors d&apos;une « Reconduction/Renouvellement » d&apos;un contrat TAT</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat activé %28BR%29</fullName>
        <actions>
            <name>Notification_activation_contrat_All_BR</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>FND,CSL,LDB</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de l&apos;activation d&apos;un contrat (BR)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat activé %28DI%29</fullName>
        <actions>
            <name>Notification_activation_contrat_DI</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>DI</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de l&apos;activation d&apos;un contrat (DI)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat activé %28ES%29</fullName>
        <actions>
            <name>Notification_activation_contrat_All_ES</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Consulting,R&amp;D Funding,R&amp;D Tax Credit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de l&apos;activation d&apos;un contrat (ESP)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat activé %28Perf Financière%29</fullName>
        <actions>
            <name>Notification_activation_contrat_Opti</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>IL,CFI</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de l&apos;activation d&apos;un contrat (IL + CFI)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat activé %28Perf RH%29</fullName>
        <actions>
            <name>Notification_activation_contrat_ACS</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,CRH,TAT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de l&apos;activation d&apos;un contrat (ACS, TAT ou CRH)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat activé %28VEILLE%29</fullName>
        <actions>
            <name>Notification_activation_contrat_VEILLE</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>VEILLE</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de l&apos;activation d&apos;un contrat (VEILLE)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat activé %28inno %2B veille%29</fullName>
        <actions>
            <name>Notification_activation_contrat_CIR_FI</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,FI,AS,CIN,VEILLE</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de l&apos;activation d&apos;un contrat (inno + veille)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat clôturé %28ES%29</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Consulting,R&amp;D Funding,R&amp;D Tax Credit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Clos</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de la clôture d&apos;un contrat (ESP)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat clôturé %28Inno %2B veille%29</fullName>
        <actions>
            <name>Notification_cloture_contrat_Inno</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,DI,FI,AS,CIN,VEILLE</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Clos</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de la clôture d&apos;un contrat (Inno + veille)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat clôturé %28Perf RH %2B Perf Financière%29</fullName>
        <actions>
            <name>Notification_cloture_contrat_Opti</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,IL,TAT,CRH,CFI</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Clos</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de la clôture d&apos;un contrat (Perf RH + Perf Financière)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat clôturé %28VEILLE%29</fullName>
        <actions>
            <name>Notification_cloture_contrat_VEILLE</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>VEILLE</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Clos</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de la clôture d&apos;un contrat (VEILLE)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat créé %28ACS %2F CRH%29</fullName>
        <actions>
            <name>Notification_contrat_cree_ACS</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,CRH</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.LastName</field>
            <operation>notEqual</operation>
            <value>STYRANEC</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la création d&apos;un contrat (ACS / CRH)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat créé %28FI%29</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>FI,AS</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la création d&apos;un contrat (FI)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat créé %28Inno%29</fullName>
        <actions>
            <name>Notification_contrat_cree_Inno</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,DI,FI,AS,CIN</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la création d&apos;un contrat (Inno)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat créé %28Perf Financière%29</fullName>
        <actions>
            <name>Notification_contrat_cree_IL</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>IL,CFI</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.LastName</field>
            <operation>notEqual</operation>
            <value>STYRANEC</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la création d&apos;un contrat (IL + CFI)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat créé %28Perf RH%29</fullName>
        <actions>
            <name>Notification_contrat_cree_Opti</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,TAT,CRH</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.LastName</field>
            <operation>notEqual</operation>
            <value>STYRANEC</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la création d&apos;un contrat (Perf RH)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat créé BR</fullName>
        <actions>
            <name>Notification_contrat_cree_BR</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>FND,CSL,LDB</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de la création d&apos;un contrat BR</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat créé ES</fullName>
        <actions>
            <name>Notification_contrat_cree_ES</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Consulting,R&amp;D Funding,R&amp;D Tax Credit</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail -  E-mail de notification lors de la création d&apos;un contrat ESP</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat créé SGP</fullName>
        <actions>
            <name>Notification_contrat_cree_SGP</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>PF,CF,SGP - PIC</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lors de la création d&apos;un contrat SGP</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification contrat sans activation %28ACS %2F CRH%29</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>notEqual</operation>
            <value>Activé,Clos</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,CRH</value>
        </criteriaItems>
        <description>Alerte envoyée au bout de 5 jours si un contrat créé n&apos;a toujours pas été activé.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_Contrat_sans_activation_ACS</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.CreatedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notification contrat sans activation %28Inno ETI%2FPME%29</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>notEqual</operation>
            <value>Activé,Clos</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,FI,DI,VEILLE,AS,CIN</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Type_de_compte__c</field>
            <operation>notEqual</operation>
            <value>BU Grands Comptes innovation</value>
        </criteriaItems>
        <description>Alerte envoyée au bout de 5 jours si un contrat créé n&apos;a toujours pas été activé. BU Inno ETI/PME</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_Contrat_sans_activation_Inno</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.CreatedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notification contrat sans activation %28Inno GC%29</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>notEqual</operation>
            <value>Activé,Clos</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,FI,DI,VEILLE,AS,CIN</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Type_de_compte__c</field>
            <operation>notEqual</operation>
            <value>BU Grands Comptes innovation</value>
        </criteriaItems>
        <description>Alerte envoyée au bout de 5 jours si un contrat créé n&apos;a toujours pas été activé. BU Inno GC</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_Contrat_sans_activation_Inno_GC</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.CreatedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notification contrat sans activation %28Perf Financière%29</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>notEqual</operation>
            <value>Activé,Clos</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,IL,TAT,CRH,CFI</value>
        </criteriaItems>
        <description>Alerte envoyée au bout de 5 jours si un contrat créé n&apos;a toujours pas été activé.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_Contrat_sans_activation_Opti</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.CreatedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notification création d%27un avenant à contrat en cours TAT</fullName>
        <actions>
            <name>Notification_contrat_avenant_cree_TAT</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>TAT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Type_de_contrat__c</field>
            <operation>equals</operation>
            <value>Avenant à contrat en cours</value>
        </criteriaItems>
        <description>Alerte e-mail - Notification création d&apos;un avenant à contrat en cours TAT</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>OLD Notification contrat activé %28TAT%29</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>TAT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.CreatedById</field>
            <operation>notContain</operation>
            <value>synefo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Administrateur système</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors de l&apos;activation d&apos;un contrat (TAT)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
