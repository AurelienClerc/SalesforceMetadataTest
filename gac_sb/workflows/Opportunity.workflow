<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CIR_Technical_validation</fullName>
        <ccEmails>vmarillat@global-approach-consulting.com</ccEmails>
        <description>CIR_Technical validation</description>
        <protected>false</protected>
        <recipients>
            <recipient>gware@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/CIR_Technical_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Confirmation_approbation_RDV_BR</fullName>
        <description>Confirmation approbation RDV BR</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Confirmation_approbation_RDV_BR</template>
    </alerts>
    <alerts>
        <fullName>Confirmation_approbation_RDV_Inno</fullName>
        <description>Confirmation approbation RDV (Inno)</description>
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
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Confirmation_approbation_RDV_Inno</template>
    </alerts>
    <alerts>
        <fullName>Confirmation_approbation_RDV_Opti</fullName>
        <description>Confirmation approbation RDV (Opti)</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Confirmation_approbation_RDV_Opti</template>
    </alerts>
    <alerts>
        <fullName>Confirmation_approbation_RDV_PERF_FI</fullName>
        <description>Confirmation approbation RDV (Perf FI)</description>
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
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Confirmation_approbation_RDV_Opti</template>
    </alerts>
    <alerts>
        <fullName>Confirmation_approbation_proposition_BR</fullName>
        <description>Confirmation approbation proposition BR</description>
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
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>ngarcia@group-gac.com.br</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Confirmation_approbation_proposition_BR</template>
    </alerts>
    <alerts>
        <fullName>Confirmation_approbation_proposition_ES</fullName>
        <description>Confirmation approbation proposition ES</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/Confirmation_approbation_proposition_ES</template>
    </alerts>
    <alerts>
        <fullName>Confirmation_approbation_proposition_Inno</fullName>
        <description>Confirmation approbation proposition (Inno)</description>
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
            <recipient>lhauseux@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Confirmation_approbation_proposition_Inno</template>
    </alerts>
    <alerts>
        <fullName>Confirmation_approbation_proposition_Opti</fullName>
        <description>Confirmation approbation proposition (Opti)</description>
        <protected>false</protected>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Confirmation_approbation_proposition_Opti</template>
    </alerts>
    <alerts>
        <fullName>ES_CONFIR_APP_RDV_INN_IBI_rdv_il</fullName>
        <description>ES_CONFIR_APP_RDV_INN_IBI FOR SPAIN</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/ES_Request_approval_validate</template>
    </alerts>
    <alerts>
        <fullName>ES_REJET_APP_RDV_INN_IBI</fullName>
        <description>ES_REJET_APP_RDV_INN_IBI FOR SPAIN</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/ES_Request_approval_reject</template>
    </alerts>
    <alerts>
        <fullName>Notification_Prise_de_RDV_Commercial_Opti</fullName>
        <description>Notification Prise de RDV Commercial (Perf RH) OLD</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Prise_de_RDV_Commercial_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_Prise_de_RDV_Commercial_inno</fullName>
        <description>Notification Prise de RDV Commercial (INNO CII)</description>
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
            <recipient>jdenis@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Prise_de_RDV_Commercial_INNO</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annul_a_reprendre_Perf_FI</fullName>
        <description>Notification RDV Annulé + a reprendre (Perf FI) OLD</description>
        <protected>false</protected>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_Annule_ou_annule_a_reprendre</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annul_a_reprendre_Perf_RH</fullName>
        <description>Notification RDV Annulé + a reprendre (Perf RH) OLD</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_Annule_ou_annule_a_reprendre</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annule_et_a_reprendre_BR</fullName>
        <description>Notification RDV Annulé et à reprendre BR</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Notification_RDV_Annul_et_reprendre_BR</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annule_et_a_reprendre_ES</fullName>
        <description>Notification RDV Annulé et à reprendre ES</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/Notification_RDV_Annul_et_reprendre_ES</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annule_et_a_reprendre_Inno</fullName>
        <description>Notification RDV Annulé et à reprendre (Inno) OLD</description>
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
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_Annul_et_reprendre_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annule_et_a_reprendre_Opti</fullName>
        <description>Notification RDV Annulé et à reprendre (Perf RH) OLD</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_Annule_et_et_reprendre_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annule_et_a_reprendre_Perf_FI</fullName>
        <description>Notification RDV Annulé et à reprendre (Perf FI) OLD</description>
        <protected>false</protected>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_Annule_et_et_reprendre_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annule_reprendreInno</fullName>
        <description>Notification RDV Annulé + a reprendre (Inno) OLD</description>
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
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_Annule_ou_annule_a_reprendre</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_Annule_reprendrefrall</fullName>
        <description>Notification RDV Annulé + a reprendre (FR ALL)</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_Annule_ou_annule_a_reprendre</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_annule_BR</fullName>
        <description>Notification RDV annulé BR</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Notification_RDV_annul_BR</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_annule_ES</fullName>
        <description>Notification RDV annulé ES</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/Notification_RDV_annul_ES</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_annule_Inno</fullName>
        <description>Notification RDV annulé (Inno) OLD</description>
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
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_annul_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_annule_Perf_FI</fullName>
        <description>Notification RDV annulé Perf FI</description>
        <protected>false</protected>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_annule_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_annule_opti</fullName>
        <description>Notification RDV annulé Perf RH OLD</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_annule_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_d_valid_FR_ALL</fullName>
        <description>Notification RDV dévalidé (FR ALL)</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_d_valid_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_d_valid_Inno</fullName>
        <description>Notification RDV dévalidé (Inno) OLD</description>
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
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_d_valid_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_devalid_opti</fullName>
        <description>Notification RDV dévalidé (opti) OLD</description>
        <protected>false</protected>
        <recipients>
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_devalide_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_reporte_BR</fullName>
        <description>Notification RDV reporté BR</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Notification_RDV_report_BR</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_reporte_ES</fullName>
        <description>Notification RDV reporté ES</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/Notification_RDV_report_ES</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_reporte_FR_All</fullName>
        <description>Notification RDV reporté (FR ALL)</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_report_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_reporte_Inno</fullName>
        <description>Notification RDV reporté (Inno) OLD</description>
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
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_report_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_reporte_opti</fullName>
        <description>Notification RDV reporté (opti) OLD</description>
        <protected>false</protected>
        <recipients>
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_reporte_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_sans_compte_rendu_FR_ALL</fullName>
        <description>Notification RDV sans compte rendu FR ALL</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_sans_CR_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_sans_compte_rendu_Inno</fullName>
        <description>Notification RDV sans compte rendu Inno OLD</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_sans_CR_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_RDV_sans_compte_rendu_Opti</fullName>
        <description>Notification RDV sans compte rendu Opti OLD</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_RDV_sans_CR_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_compte_rendu_RDV_BR</fullName>
        <description>Notification compte-rendu RDV BR</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Notification_compte_rendu_RDV_BR</template>
    </alerts>
    <alerts>
        <fullName>Notification_compte_rendu_RDV_ES</fullName>
        <description>Notification compte-rendu RDV ES</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/Notification_compte_rendu_RDV_ES</template>
    </alerts>
    <alerts>
        <fullName>Notification_compte_rendu_RDV_FR_All</fullName>
        <description>Notification compte-rendu RDV (FR All)</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_compte_rendu_RDV_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_compte_rendu_RDV_Inno</fullName>
        <description>Notification compte-rendu RDV (Inno) OLD</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_compte_rendu_RDV_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_compte_rendu_RDV_TAT</fullName>
        <description>Notification compte-rendu RDV (TAT) OLD</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_compte_rendu_RDV_Opti</template>
    </alerts>
    <alerts>
        <fullName>Notification_compte_rendu_RDV_opti</fullName>
        <description>Notification compte-rendu RDV (opti) OLD</description>
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
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_compte_rendu_RDV_Opti</template>
    </alerts>
    <alerts>
        <fullName>PerfFI_Notification_Prise_de_RDV_Commercial</fullName>
        <description>Perf FI Notification Prise de RDV Commercial</description>
        <protected>false</protected>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Prise_de_RDV_Commercial_Opti</template>
    </alerts>
    <alerts>
        <fullName>Perf_RH_Notification_Prise_de_RDV_Commercial</fullName>
        <description>Perf RH Notification Prise de RDV Commercial</description>
        <protected>false</protected>
        <recipients>
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Prise_de_RDV_Commercial_Opti</template>
    </alerts>
    <alerts>
        <fullName>Reco_avec_contrat_sign</fullName>
        <description>Reco avec contrat signé</description>
        <protected>false</protected>
        <recipients>
            <field>Email_du_destinataire_recommandation__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Email_du_proprietaire_recommandation__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>cguillou@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mnantas@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Reco_avec_contrat_signe</template>
    </alerts>
    <alerts>
        <fullName>Reco_avec_opportunite_fermee_perdue</fullName>
        <description>Reco avec opportunité fermée perdue</description>
        <protected>false</protected>
        <recipients>
            <field>Email_du_destinataire_recommandation__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Email_du_proprietaire_recommandation__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mnantas@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Reco_avec_opportunite_fermee_perdue</template>
    </alerts>
    <alerts>
        <fullName>Reco_ayant_permis_de_prendre_un_RDV_etape_RDV_pris</fullName>
        <description>Reco ayant permis de prendre un RDV (étape « RDV pris »)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_du_destinataire_recommandation__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Email_du_proprietaire_recommandation__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Reco_ayant_permis_de_prendre_un_RDV</template>
    </alerts>
    <alerts>
        <fullName>Rejet_approbation_RDV_BR</fullName>
        <description>Rejet approbation RDV BR</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Rejet_approbation_RDV_BR</template>
    </alerts>
    <alerts>
        <fullName>Rejet_approbation_RDV_Inno</fullName>
        <description>Rejet approbation RDV (Inno)</description>
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
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Rejet_approbation_RDV_Inno</template>
    </alerts>
    <alerts>
        <fullName>Rejet_approbation_RDV_Opti</fullName>
        <description>Rejet approbation RDV (Opti)</description>
        <protected>false</protected>
        <recipients>
            <field>EmailRDV1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>EmailRDV2__c</field>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Rejet_approbation_RDV_Opti</template>
    </alerts>
    <alerts>
        <fullName>Rejet_approbation_RDV_Perf_FI</fullName>
        <description>Rejet approbation RDV (Perf FI)</description>
        <protected>false</protected>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Rejet_approbation_RDV_Opti</template>
    </alerts>
    <alerts>
        <fullName>Rejet_approbation_proposition_BR</fullName>
        <description>Rejet approbation proposition BR</description>
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
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>ngarcia@group-gac.com.br</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Rejet_approbation_proposition_BR</template>
    </alerts>
    <alerts>
        <fullName>Rejet_approbation_proposition_ES</fullName>
        <description>Rejet approbation proposition ES</description>
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
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC/Rejet_approbation_proposition_ES</template>
    </alerts>
    <alerts>
        <fullName>Rejet_approbation_proposition_Inno</fullName>
        <description>Rejet approbation proposition (Inno)</description>
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
            <recipient>lhauseux@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Rejet_approbation_proposition_Inno</template>
    </alerts>
    <alerts>
        <fullName>Rejet_approbation_proposition_Opti</fullName>
        <description>Rejet approbation proposition (Opti)</description>
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
            <field>Email_du_suiveur_notification_workflow__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>estyranec@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Origine_du_RDV__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>RDV_a_effectuer_par__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Rejet_approbation_proposition_Opti</template>
    </alerts>
    <fieldUpdates>
        <fullName>CIR_MAJ_GrilleTar</fullName>
        <field>Prix_avec_marge_de_nego__c</field>
        <formula>IF( RecordType.DeveloperName = &apos;CIR&apos; &amp;&amp; nb_annees_intervention__c &gt; 0 &amp;&amp; nb_annees_intervention__c &lt; 3,
IF(  renta2_Montant_cirN__c &gt; 1000000,0,
	IF( renta2_Montant_cirN__c &lt;= 100000,0.17, 
		IF(renta2_Montant_cirN__c &lt;= 200000,0.15,
			IF(renta2_Montant_cirN__c &lt;= 300000,0.13,
				IF(renta2_Montant_cirN__c &lt;= 400000,0.11,
					IF(renta2_Montant_cirN__c &lt;= 500000,0.09,
						IF(renta2_Montant_cirN__c &lt;= 750000,0.08,0.07))))))
	- nb_annees_intervention__c/100)
,IF( RecordType.DeveloperName = &apos;CIR&apos; &amp;&amp; nb_annees_intervention__c &gt; 2,
IF( renta2_Montant_cirN__c &gt; 1000000,0,
	IF( renta2_Montant_cirN__c &lt;= 100000,0.14, 
		IF(renta2_Montant_cirN__c &lt;= 200000,0.11,
			IF(renta2_Montant_cirN__c &lt;= 300000,0.09,
				IF(renta2_Montant_cirN__c &lt;= 400000,0.07,
					IF(renta2_Montant_cirN__c &lt;= 500000,0.06,
						IF(renta2_Montant_cirN__c &lt;= 750000,0.05,0.04))))))
),null))</formula>
        <name>CIR MAJ GrilleTar</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIR_MAJ_renta_jour_estimes</fullName>
        <field>renta_total_jours_estimes__c</field>
        <formula>(renta_jours_production__c * 
( 1 + IF(renta2_Montant_cirN__c &gt;= 300000 , 0.2,0) ) + 
IF(renta2_Montant_cirN__c &lt; 100000 , 1 ,
IF(renta2_Montant_cirN__c &lt; 300000 , 2 , 
IF(renta2_Montant_cirN__c  &lt; 900000 , 3 ,
IF(renta2_Montant_cirN__c &gt;= 900000 , 5 , 0
)))))</formula>
        <name>CIR_MAJ_renta_jour_estimes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Cocher_renta_a_rafraichir</fullName>
        <field>Renta_a_rafraichir__c</field>
        <literalValue>1</literalValue>
        <name>Cocher renta a rafraichir</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Decocher_renta_a_rafraichir</fullName>
        <field>Renta_a_rafraichir__c</field>
        <literalValue>0</literalValue>
        <name>Decocher renta a rafraichir</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FR_MAJ_mail_destinataire_reco</fullName>
        <field>Email_du_destinataire_recommandation__c</field>
        <formula>Recommandation__r.Email_du_destinataire__c</formula>
        <name>FR_MAJ mail destinataire reco</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FR_MAJ_mail_propri_taire_reco</fullName>
        <field>Email_du_proprietaire_recommandation__c</field>
        <formula>Recommandation__r.Email_du_proprietaire__c</formula>
        <name>FR_MAJ mail propriétaire reco</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJAutomatedCloseDateAllStages</fullName>
        <field>AutomatedClosedDate__c</field>
        <formula>TODAY() + 
IF(!IsClosed, 
CASE(Text(StageName), 
&apos;Accord de principe&apos; , 15, 
&apos;Négociation&apos; , 30, 
&apos;Proposition validée&apos;,90, 

365 /*Cas New*/), 
0/* Cas Closed */)</formula>
        <name>MAJ AutomatedCloseDate - All Stages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJCloseDateAllStages</fullName>
        <field>CloseDate</field>
        <formula>TODAY() + 
IF(!IsClosed,
CASE(Text(StageName),
&apos;Accord de principe&apos; , 15,
&apos;Négociation&apos; , 30,
&apos;Proposition validée&apos;,90,

365 /*Cas New*/),
0/* Cas Closed */)</formula>
        <name>MAJ Close Date - All Stages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_AutomatedClosedDate_TODAY_15jours</fullName>
        <description>Met a jour automated closedDate a TODAY + 15 jours</description>
        <field>AutomatedClosedDate__c</field>
        <formula>TODAY() + 15</formula>
        <name>MAJ_AutomatedClosedDate_TODAY+15jours</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_AutomatedClosedDate_TODAY_1MONTHS</fullName>
        <description>Met a jour Automated ClosedDate a today + 1 month</description>
        <field>AutomatedClosedDate__c</field>
        <formula>TODAY() + 30</formula>
        <name>MAJ_AutomatedClosedDate_TODAY+1MONTHS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_AutomatedClosedDate_TODAY_1YEAR</fullName>
        <field>AutomatedClosedDate__c</field>
        <formula>TODAY() + 365</formula>
        <name>MAJ_AutomatedClosedDate_TODAY+1YEAR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_AutomatedClosedDate_TODAY_3MONTHS</fullName>
        <description>Met a jour le champ automated closed date a today+3Months</description>
        <field>AutomatedClosedDate__c</field>
        <formula>TODAY() + 90</formula>
        <name>MAJ_AutomatedClosedDate_TODAY+3MONTHS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_CIR_annee_dernier_cir</fullName>
        <description>MAJ du champ année dernier cir en non concerné</description>
        <field>CIR_Annee_dernier_CIR__c</field>
        <literalValue>Non Concerné</literalValue>
        <name>MAJ_CIR_annee_dernier_cir</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_CIR_gestion_dossier</fullName>
        <field>Concurrent__c</field>
        <literalValue>Non concerné</literalValue>
        <name>MAJ_CIR_gestion_dossier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_ClosedDate_TODAY_15jours</fullName>
        <description>Met a jour closed date a today + 15 jours</description>
        <field>CloseDate</field>
        <formula>TODAY() + 15</formula>
        <name>MAJ_ClosedDate_TODAY+15jours</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_ClosedDate_TODAY_1Month</fullName>
        <description>Met a jour Closed Date avec Today + 1 month</description>
        <field>CloseDate</field>
        <formula>TODAY() + 30</formula>
        <name>MAJ_ClosedDate_TODAY+1Month</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_ClosedDate_TODAY_1YEAR</fullName>
        <description>Met a jour la date de cloture a today + one year</description>
        <field>CloseDate</field>
        <formula>TODAY()+365</formula>
        <name>MAJ_ClosedDate_TODAY+1YEAR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_ClosedDate_TODAY_3MONTHS</fullName>
        <description>Met a jour la date de cloture a TODAY + 3 MONTH</description>
        <field>CloseDate</field>
        <formula>TODAY() + 90</formula>
        <name>MAJ_ClosedDate_TODAY+3MONTHS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Date_Cloture</fullName>
        <description>Mettre date de clôture à date du jour +12 mois</description>
        <field>CloseDate</field>
        <formula>TODAY() +365</formula>
        <name>MAJ Date Clôture</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Date_soumission_Approbation_Propale</fullName>
        <field>Date_soumission_Approbation_Propale__c</field>
        <formula>NOW()</formula>
        <name>MAJ Date soumission Approbation Propale</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Date_soumission_Approbation_RDV</fullName>
        <field>Date_soumission_Approbation_RDV__c</field>
        <formula>NOW()</formula>
        <name>MAJ Date soumission Approbation RDV</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Date_validation_RDV</fullName>
        <field>Date_de_validation_RDV__c</field>
        <formula>TODAY()</formula>
        <name>MAJ Date validation RDV</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Date_validation_propale</fullName>
        <field>Date_validation_propale__c</field>
        <formula>TODAY()</formula>
        <name>MAJ Date validation propale</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_E_mail_DCR_opp</fullName>
        <field>E_mail_du_DCR__c</field>
        <formula>RDV_a_effectuer_par__r.DCR__r.Email</formula>
        <name>MAJ E-mail DCR opp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_E_mail_DR_opp</fullName>
        <field>E_mail_du_DR__c</field>
        <formula>RDV_a_effectuer_par__r.DR__r.Email</formula>
        <name>MAJ E-mail DR opp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_E_mail_du_suiveur_Approbation</fullName>
        <description>Permet de récupérer l&apos;adresse E-mail de la personne devant être notifier des approbations. (En plus des DR et DCR)</description>
        <field>Email_du_suiveur_notification_workflow__c</field>
        <formula>RDV_a_effectuer_par__r.Suiveur_Temporaire__r.Email</formula>
        <name>MAJ E-mail du suiveur Approbation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Etape_RDV_Valide</fullName>
        <description>Fait avancer l&apos;étape de l&apos;opportunité à RDV validé</description>
        <field>StageName</field>
        <literalValue>RDV validé</literalValue>
        <name>MAJ Etape à RDV Validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Etape_a_proposition_valid_e</fullName>
        <field>StageName</field>
        <literalValue>Proposition validée</literalValue>
        <name>MAJ Etape a proposition validée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Nom_Opp</fullName>
        <description>Mettre le nom de l&apos;opportunité en conformité avec règle de nommage type-nom compte- date création ex TAT-NOM-AAMMJJ</description>
        <field>Name</field>
        <formula>IF((!ISNULL( Product_Piste__c) &amp;&amp; Product_Piste__c &lt;&gt; &apos;&apos;)  ,Product_Piste__c,  $RecordType.Name ) &amp; &quot; - &quot;&amp;Account.Name &amp; &quot; - &quot; &amp;TEXT((year( TODAY())-2000 )*10000+month(today())*100+day(today()))</formula>
        <name>MAJ Nom Opp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RDV1</fullName>
        <field>EmailRDV1__c</field>
        <formula>CASE(RecordType.DeveloperName,
&apos;CIR&apos;,IF(ispickval(Type_de_compte__c ,&apos;BU Grands Comptes innovation&apos;),&apos;jalieu@group-gac.com&apos;,&apos;lhauseux@group-gac.com&apos;),
&apos;FI&apos;, IF(ispickval(Type_de_compte__c ,&apos;BU Grands Comptes innovation&apos;),&apos;jalieu@group-gac.com&apos;,&apos;lhauseux@group-gac.com&apos;),
&apos;FIN&apos;,IF(ispickval(Type_de_compte__c ,&apos;BU Grands Comptes innovation&apos;),&apos;jalieu@group-gac.com&apos;,&apos;lhauseux@group-gac.com&apos;),
&apos;IL&apos;,&apos;&apos;,
&apos;CFI&apos;,&apos;&apos;,
&apos;CRH&apos;,&apos;jberche@group-gac.com&apos;,
&apos;ACS&apos;,&apos;jberche@group-gac.com&apos;,
&apos;TAT&apos;,&apos;jberche@group-gac.com&apos;,

&apos;&apos;

)</formula>
        <name>MAJ RDV1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RDV2</fullName>
        <field>EmailRDV2__c</field>
        <formula>CASE(RecordType.DeveloperName, 
&apos;CIR&apos;,&apos;&apos;, 
&apos;FI&apos;, &apos;&apos;, 
&apos;FIN&apos;,&apos;&apos;, 
&apos;IL&apos;,&apos;&apos;, 
&apos;CFI&apos;,&apos;&apos;, 
&apos;CRH&apos;,&apos;mrocheteau@group-gac.com&apos;, 
&apos;ACS&apos;,&apos;mrocheteau@group-gac.com&apos;, 
&apos;TAT&apos;,&apos;mrocheteau@group-gac.com&apos;, 

&apos;&apos; 

)</formula>
        <name>MAJ RDV2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RecordType_ACS</fullName>
        <field>RecordTypeId</field>
        <lookupValue>ACS</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ_RecordType_ACS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RecordType_AS</fullName>
        <field>RecordTypeId</field>
        <lookupValue>FI</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ_RecordType_AS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RecordType_CIR</fullName>
        <field>RecordTypeId</field>
        <lookupValue>CIR</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ_RecordType_CIR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RecordType_IL</fullName>
        <field>RecordTypeId</field>
        <lookupValue>IL</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ_RecordType_IL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RecordType_PARTENAIRE</fullName>
        <field>RecordTypeId</field>
        <lookupValue>PARTENAIRE</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ_RecordType_PARTENAIRE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RecordType_TAT</fullName>
        <field>RecordTypeId</field>
        <lookupValue>TAT</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ_RecordType_TAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Record_Type_CFI</fullName>
        <field>RecordTypeId</field>
        <lookupValue>CFI</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ Record Type CFI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Record_type_CIN</fullName>
        <field>RecordTypeId</field>
        <lookupValue>CIN</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ Record type CIN</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Record_type_CRH</fullName>
        <field>RecordTypeId</field>
        <lookupValue>CRH</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ Record type CRH</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Record_type_name</fullName>
        <field>Record_type_name_old__c</field>
        <formula>$RecordType.Name</formula>
        <name>MAJ Record type name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Total_jours_estime_WF</fullName>
        <field>Total_jours_estimes_WF__c</field>
        <formula>IF(CloseDate &gt; Date(2017,02,15) &amp;&amp; ispickval(Type_de_compte__c,&apos;BU Grands Comptes innovation&apos;), 
(1.3 * ((4 * FLOOR(montant_CIR__c / 3000)) + Renta2_Nb_jours_Total_Audit__c + Renta2_Nb_jours_Total_Valo__c)), 
(1.1 * (Renta2_Nb_jours_Total_Audit__c + Renta2_Nb_jours_Total_Valo__c + Renta2_Nb_jours_Justif_secto_hors_Sante__c + Renta2_Nb_jours_Justif_secto_Sante__c)))</formula>
        <name>MAJ Total jours estimés (WF)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Total_jours_estimes_WF</fullName>
        <field>Total_jours_estimes_WF__c</field>
        <formula>IF(CloseDate &gt; Date(2017,02,15) &amp;&amp; ispickval(Type_de_compte__c,&apos;BU Grands Comptes innovation&apos;),
(1.3 * ((4 * FLOOR(montant_CIR__c / 3000)) + Renta2_Nb_jours_Total_Audit__c  + Renta2_Nb_jours_Total_Valo__c)),
(1.1 * (Renta2_Nb_jours_Total_Audit__c  +  Renta2_Nb_jours_Total_Valo__c  + Renta2_Nb_jours_Justif_secto_hors_Sante__c  + Renta2_Nb_jours_Justif_secto_Sante__c)))</formula>
        <name>MAJ Total jours estimés (WF)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_etat_approbation_non_soumise</fullName>
        <field>Etat_de_l_approbation__c</field>
        <literalValue>Non soumise</literalValue>
        <name>MAJ etat approbation non soumise</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_etat_approbation_soumise</fullName>
        <field>Etat_de_l_approbation__c</field>
        <literalValue>Soumise</literalValue>
        <name>MAJ etat approbation soumise</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_etat_approbation_valid_refus</fullName>
        <field>Etat_de_l_approbation__c</field>
        <literalValue>Validé / refusé</literalValue>
        <name>MAJ etat approbation validé/refusé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maj_CA_Cible_renta_Opportunite</fullName>
        <field>Renta2_CA_cible__c</field>
        <formula>IF(CloseDate &lt; DATE(2016,04,04),
renta_CA_cible__c,
IF(CloseDate &gt;= DATE(2017,04,04),
(Renta2_CA_Cible_New__c * 1335),(Renta2_CA_Cible_New__c * 1360)))</formula>
        <name>Maj CA Cible renta Opportunité</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maj_Nb_jour_Projets_a_Auditer</fullName>
        <field>Renta2_Nb_jours_Projets_a_Auditer__c</field>
        <formula>IF(RecordType.DeveloperName ==&apos;CIR&apos;,
IF(CloseDate &gt; Date(2017,02,15) &amp;&amp; ispickval(Type_de_compte__c,&apos;BU Grands Comptes innovation&apos;),0,
IF((ISBLANK(Nombre_de_projets_auditer__c) || Nombre_de_projets_auditer__c = 0),0,
IF(NOT(ISPICKVAL(Gamme__c,&apos;Offre essentielle&apos;)), 
(IF( renta2_Montant_cirN__c &lt;= 100000 , 
IF(Nombre_de_projets_auditer__c &lt; 4,0.3, 
IF(Nombre_de_projets_auditer__c &lt; 6,0.45, 
IF(Nombre_de_projets_auditer__c &lt; 11,0.6, 
IF(Nombre_de_projets_auditer__c &lt; 21,0.75, 
IF(Nombre_de_projets_auditer__c &gt;= 21,0.9,0))))), 

IF(renta2_Montant_cirN__c &lt;= 300000 , 
IF(Nombre_de_projets_auditer__c &lt; 4,0.4, 
IF(Nombre_de_projets_auditer__c &lt; 6,0.55, 
IF(Nombre_de_projets_auditer__c &lt; 11,0.7, 
IF(Nombre_de_projets_auditer__c &lt; 21,0.85, 
IF(Nombre_de_projets_auditer__c &gt;= 21,1,0))))), 

IF(renta2_Montant_cirN__c &gt; 300000 , 
IF(Nombre_de_projets_auditer__c &lt; 4,0.6, 
IF(Nombre_de_projets_auditer__c &lt; 6,0.8, 
IF(Nombre_de_projets_auditer__c &lt; 11,1, 
IF(Nombre_de_projets_auditer__c &lt; 21,1.2, 
IF(Nombre_de_projets_auditer__c &gt;= 21,(Nombre_de_projets_auditer__c/14),0))))),0)))), 

(IF(renta2_Montant_cirN__c &lt;= 100000 , 
IF(Nombre_de_projets_auditer__c &lt; 4,0.3, 
IF(Nombre_de_projets_auditer__c &lt; 6,0.35, 
IF(Nombre_de_projets_auditer__c &lt; 11,0.5, 
IF(Nombre_de_projets_auditer__c &lt; 21,0.65, 
IF(Nombre_de_projets_auditer__c &gt;= 21,0.8,0))))), 

IF(renta2_Montant_cirN__c &lt;= 300000 , 
IF(Nombre_de_projets_auditer__c &lt; 4,0.4, 
IF(Nombre_de_projets_auditer__c &lt; 6,0.45, 
IF(Nombre_de_projets_auditer__c &lt; 11,0.6, 
IF(Nombre_de_projets_auditer__c &lt; 21,0.75, 
IF(Nombre_de_projets_auditer__c &gt;= 21,0.9,0))))), 

IF(renta2_Montant_cirN__c &gt; 300000 , 
IF(Nombre_de_projets_auditer__c &lt; 4,0.6, 
IF(Nombre_de_projets_auditer__c &lt; 6,0.7, 
IF(Nombre_de_projets_auditer__c &lt; 11,0.9, 
IF(Nombre_de_projets_auditer__c &lt; 21,1.1, 
IF(Nombre_de_projets_auditer__c &gt;= 21,(Nombre_de_projets_auditer__c/15),0))))),0)))))))
,null)</formula>
        <name>Maj Nombre de jour Projets à Auditer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maj_Nombre_de_jour_Justif_non_sante</fullName>
        <field>Renta2_Nb_jours_Justif_secto_hors_Sante__c</field>
        <formula>IF(RecordType.DeveloperName ==&apos;CIR&apos;, 
IF((ISBLANK(Nombre_de_projets_rediger__c) || Nombre_de_projets_rediger__c = 0  || ispickval(Type_de_compte__c,&apos;BU Grands Comptes innovation&apos;)),0,
IF((ISPICKVAL(Account.Activity__c,&apos;Santé&apos;) || ISPICKVAL(Account.Sous_secto_2__c,&apos;Santé&apos;)),0,
(IF(NOT(ISPICKVAL(Gamme__c,&apos;Offre essentielle&apos;)),
(IF(renta2_Montant_cirN__c &lt;= 100000 ,
IF(Nombre_de_projets_rediger__c &lt; 4,1.6,
IF(Nombre_de_projets_rediger__c &lt; 6,2.475,
IF(Nombre_de_projets_rediger__c &lt; 11,4.4,
IF(Nombre_de_projets_rediger__c &lt; 20,6.8, 
IF(Nombre_de_projets_rediger__c &gt;= 20,6.8,0))))),

IF(renta2_Montant_cirN__c &lt;= 300000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,2.05,
IF(Nombre_de_projets_rediger__c &lt; 6,2.925,
IF(Nombre_de_projets_rediger__c &lt; 11,5.2,
IF(Nombre_de_projets_rediger__c &lt; 20,8.3, 
IF(Nombre_de_projets_rediger__c &gt;= 20,13.75,0))))),

IF(renta2_Montant_cirN__c &gt; 300000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,2.4,
IF(Nombre_de_projets_rediger__c &lt; 6,3.6,
IF(Nombre_de_projets_rediger__c &lt; 11,6.4,
IF(Nombre_de_projets_rediger__c &lt; 20,10.5,
 IF(Nombre_de_projets_rediger__c &lt; 25,10.5,
IF(Nombre_de_projets_rediger__c &gt;= 25,(Nombre_de_projets_rediger__c*0.7),0)))))),0)))),

(IF(renta2_Montant_cirN__c &lt;= 100000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,1.3,
IF(Nombre_de_projets_rediger__c &lt; 6,2.025,
IF(Nombre_de_projets_rediger__c &lt; 11,3.6,
IF(Nombre_de_projets_rediger__c &lt; 20,5.3, 
IF(Nombre_de_projets_rediger__c &gt;= 20,5.3,0))))),

IF(renta2_Montant_cirN__c &lt;= 300000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,1.85,
IF(Nombre_de_projets_rediger__c &lt; 6,2.475,
IF(Nombre_de_projets_rediger__c &lt; 11,4.4,
IF(Nombre_de_projets_rediger__c &lt; 20,6.8, 
IF(Nombre_de_projets_rediger__c &gt;= 20,11.25,0))))),

IF(renta2_Montant_cirN__c &gt; 300000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,2.4,
IF(Nombre_de_projets_rediger__c &lt; 6,3.2,
IF(Nombre_de_projets_rediger__c &lt; 11,5.6,
IF(Nombre_de_projets_rediger__c &lt; 20,9,
IF(Nombre_de_projets_rediger__c &lt; 25,9,
IF(Nombre_de_projets_rediger__c &gt;= 25,(Nombre_de_projets_rediger__c*0.6),0)))))),0))))))))

,null)</formula>
        <name>Maj Nombre de jour Justif non santé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maj_Nombre_de_jour_Justif_sante</fullName>
        <field>Renta2_Nb_jours_Justif_secto_Sante__c</field>
        <formula>IF(RecordType.DeveloperName ==&apos;CIR&apos;,
IF((ISBLANK(Nombre_de_projets_rediger__c) || Nombre_de_projets_rediger__c = 0  || ispickval(Type_de_compte__c,&apos;BU Grands Comptes innovation&apos;)),0,
IF((ISPICKVAL(Account.Activity__c,&apos;Santé&apos;) || ISPICKVAL(Account.Sous_secto_2__c,&apos;Santé&apos;)),
IF((NOT(ISPICKVAL(Gamme__c,&apos;Offre essentielle&apos;))),
(IF(renta2_Montant_cirN__c &lt;= 100000 ,
IF(Nombre_de_projets_rediger__c &lt; 4,1.4,
IF(Nombre_de_projets_rediger__c &lt; 6,2,
IF(Nombre_de_projets_rediger__c &lt; 11,3.6,
IF(Nombre_de_projets_rediger__c &lt; 20,5.3, 
IF(Nombre_de_projets_rediger__c &gt;= 20,5.3,0))))),

IF(renta2_Montant_cirN__c &lt;= 300000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,1.6,
IF(Nombre_de_projets_rediger__c &lt; 6,2.5,
IF(Nombre_de_projets_rediger__c &lt; 11,4.4,
IF(Nombre_de_projets_rediger__c &lt; 20,6.8, 
IF(Nombre_de_projets_rediger__c &gt;= 20,11.3,0))))),

IF(renta2_Montant_cirN__c &gt; 300000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,2.4,
IF(Nombre_de_projets_rediger__c &lt; 6,3.2,
IF(Nombre_de_projets_rediger__c &lt; 11,5.6,
IF(Nombre_de_projets_rediger__c &lt; 20,9,
IF(Nombre_de_projets_rediger__c &lt; 25,15,
IF(Nombre_de_projets_rediger__c &gt;= 25,(Nombre_de_projets_rediger__c*0.6),0)))))),0)))),

(IF(renta2_Montant_cirN__c &lt;= 100000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,1.1,
IF(Nombre_de_projets_rediger__c &lt; 6,1.6,
IF(Nombre_de_projets_rediger__c &lt; 11,2.8,
IF(Nombre_de_projets_rediger__c &lt; 20,3.8, 
IF(Nombre_de_projets_rediger__c &gt;= 20,3.8,0))))),

IF(renta2_Montant_cirN__c &lt;= 300000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,1.4,
IF(Nombre_de_projets_rediger__c &lt; 6,2,
IF(Nombre_de_projets_rediger__c &lt; 11,3.6,
IF(Nombre_de_projets_rediger__c &lt; 20,5.3, 
IF(Nombre_de_projets_rediger__c &gt;= 20,8.8,0))))),

IF(renta2_Montant_cirN__c &gt; 300000 , 
IF(Nombre_de_projets_rediger__c &lt; 4,2.2,
IF(Nombre_de_projets_rediger__c &lt; 6,2.7,
IF(Nombre_de_projets_rediger__c &lt; 11,4.8,
IF(Nombre_de_projets_rediger__c &lt; 20,7.5,
IF(Nombre_de_projets_rediger__c &lt; 25,12.5,
IF(Nombre_de_projets_rediger__c &gt;= 25,(Nombre_de_projets_rediger__c*0.5),0)))))),0))))),0))

, null)</formula>
        <name>Maj Nombre de jour Justif santé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maj_Taux_Min_GAC</fullName>
        <field>Renta2_Taux_min_GAC__c</field>
        <formula>IF((ISBLANK(Renta2_Taux_min_reel__c) || Renta2_Taux_min_reel__c = 0  || Renta2_Taux_min_reel__c = 1),0,
IF(NOT(ISPICKVAL(Gamme__c,&apos;Offre essentielle&apos;)),
IF(renta2_Montant_cirN__c &lt;= 100000 ,
IF((Renta2_Taux_min_reel__c + 0.02) &lt; 0.08,0.08,Renta2_Taux_min_reel__c + 0.02),
IF(renta2_Montant_cirN__c &lt;= 300000 ,
IF((Renta2_Taux_min_reel__c + 0.02) &lt; 0.06,0.06,Renta2_Taux_min_reel__c + 0.02),
IF(renta2_Montant_cirN__c &gt; 300000 ,
IF((Renta2_Taux_min_reel__c + 0.02) &lt; 0.04,0.04,Renta2_Taux_min_reel__c + 0.02),Renta2_Taux_min_reel__c + 0.02))),
IF(renta2_Montant_cirN__c &lt;= 100000 ,
IF((Renta2_Taux_min_reel__c + 0.02) &lt; 0.07,0.07,Renta2_Taux_min_reel__c + 0.02),
IF(renta2_Montant_cirN__c &lt;= 300000 ,
IF((Renta2_Taux_min_reel__c + 0.02) &lt; 0.05,0.05,Renta2_Taux_min_reel__c + 0.02),
IF(renta2_Montant_cirN__c &gt; 300000 ,
IF((Renta2_Taux_min_reel__c + 0.02) &lt; 0.03,0.03,Renta2_Taux_min_reel__c + 0.02),Renta2_Taux_min_reel__c + 0.02)))))</formula>
        <name>Maj Taux Min GAC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OPP_MAJ_RecordType_Consulting</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Consulting</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>OPP MAJ RecordType Consulting</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OPP_MAJ_RecordType_FIN</fullName>
        <description>MAJ du recordtype ver FND (BR)</description>
        <field>RecordTypeId</field>
        <lookupValue>FND</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>OPP MAJ RecordType FND</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OPP_MAJ_RecordType_LDB</fullName>
        <description>Mise a jour du recordType vers LDB (BR)</description>
        <field>RecordTypeId</field>
        <lookupValue>LDB</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>OPP MAJ RecordType LDB</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OPP_MAJ_RecordType_R_D_Funding</fullName>
        <field>RecordTypeId</field>
        <lookupValue>AYUDAS</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>OPP MAJ RecordType R&amp;D Funding</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OPP_MAJ_RecordType_R_D_Tax_Credit</fullName>
        <field>RecordTypeId</field>
        <lookupValue>DED</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>OPP MAJ RecordType R&amp;D Tax Credit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>MAJ CloseDate %28Accord de principe%29</fullName>
        <actions>
            <name>MAJ_AutomatedClosedDate_TODAY_15jours</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_ClosedDate_TODAY_15jours</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ) Déclenché lors du passage a l&apos;étape Accord de principe pour mettre à jour la date de cloture</description>
        <formula>OR($RecordType.Name = &apos;ACS&apos;, $RecordType.Name = &apos;CIR&apos;, $RecordType.Name = &apos;FI&apos;, $RecordType.Name = &apos;IL&apos;, $RecordType.Name = &apos;DI&apos;, $RecordType.Name = &apos;CIN&apos;,$RecordType.Name = &apos;TAT&apos;, RecordType.DeveloperName = &apos;CANADA_RSDE&apos;) &amp;&amp; ISPICKVAL( StageName , &apos;Accord de principe&apos; ) &amp;&amp;  (CloseDate ==  AutomatedClosedDate__c || CloseDate &lt;= TODAY())</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>MAJ CloseDate %28Negociation%29</fullName>
        <actions>
            <name>MAJ_AutomatedClosedDate_TODAY_1MONTHS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_ClosedDate_TODAY_1Month</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ) Déclenché lors du passage a l&apos;étape Négociation pour mettre à jour la date de cloture</description>
        <formula>OR($RecordType.Name = &apos;ACS&apos;, $RecordType.Name = &apos;CIR&apos;, $RecordType.Name = &apos;FI&apos;, $RecordType.Name = &apos;IL&apos;, $RecordType.Name = &apos;DI&apos;, $RecordType.Name = &apos;CIN&apos;,
$RecordType.Name = &apos;TAT&apos;, RecordType.DeveloperName  = &apos;CANADA_RSDE&apos;) &amp;&amp; ISPICKVAL( StageName , &apos;Négociation&apos; ) &amp;&amp;  (CloseDate ==  AutomatedClosedDate__c || CloseDate &lt;= TODAY())</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>MAJ CloseDate %28Proposition validee%29</fullName>
        <actions>
            <name>MAJ_AutomatedClosedDate_TODAY_3MONTHS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_ClosedDate_TODAY_3MONTHS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ) Déclenché lors du passage a l&apos;étape proposition envoyée pour mettre à jour la date de cloture</description>
        <formula>OR($RecordType.Name = &apos;ACS&apos;, $RecordType.Name = &apos;CIR&apos;, $RecordType.Name = &apos;FI&apos;, $RecordType.Name = &apos;IL&apos;, $RecordType.Name = &apos;DI&apos;, $RecordType.Name = &apos;CIN&apos;,
$RecordType.Name = &apos;TAT&apos;,  RecordType.DeveloperName = &apos;CANADA_RSDE&apos;) &amp;&amp;  ISPICKVAL( StageName , &apos;Proposition validée&apos; ) &amp;&amp;   (CloseDate ==  AutomatedClosedDate__c ||     CloseDate &lt;= TODAY())</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>MAJ CloseDate %28allStages%29</fullName>
        <actions>
            <name>MAJAutomatedCloseDateAllStages</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJCloseDateAllStages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Déclenché a la création d&apos;une opportunité de type francais pour initialiser la date de cloture</description>
        <formula>AND(
/*Si C&apos;est Nouveau ou qu&apos;on a modifié le stagename */
OR(ISNEW(), 
   ISCHANGED(StageName)
),
/*Et qu&apos;on est dans une étape traquée ou que c&apos;est nouveau*/
OR(
 ISPICKVAL( StageName , &apos;Négociation&apos; ),
 ISPICKVAL( StageName , &apos;Accord de principe&apos; ),
 ISPICKVAL( StageName , &apos;Proposition validée&apos; ),
 ISNEW(),
 IsClosed
),
/*Et qu&apos;on a pas sorti volontairement l&apos;opportunitéde ce process*/
OR(
 ISBLANK(AutomatedClosedDate__c) ,     /*Cas nouvelle opp*/
 CloseDate == AutomatedClosedDate__c , /*L&apos;opportunité est bien dans le process*/
 CloseDate &lt;= TODAY() ,                /*Cas la date de cloture est dans le passé (on fait rerentrer l&apos;opp)*/
 IsClosed                              /*Cas l&apos;opportunité est fermée, dans ce cas la on met la date du jour*/
)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ CloseDate %28creation%29</fullName>
        <actions>
            <name>MAJ_AutomatedClosedDate_TODAY_1YEAR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_ClosedDate_TODAY_1YEAR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIN,FND,CSL,Consulting,TAT,ACS,AS,CIR,IL,PARTENAIRE,DI,R&amp;D Funding,R&amp;D Tax Credit,LDB,VEILLE</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché a la création d&apos;une opportunité de type francais pour initialiser la date de cloture</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Date Total jours estimés %22forcé%22</fullName>
        <active>false</active>
        <formula>ISCHANGED(renta_Total_jours_estimes_force__c) &amp;&amp;
ISBLANK(PRIORVALUE(renta_Total_jours_estimes_force__c)) &amp;&amp;
!ISBLANK(renta_Total_jours_estimes_force__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ E-mail DCR</fullName>
        <actions>
            <name>MAJ_E_mail_DCR_opp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ) Met à jour l&apos;email du DCR sur l&apos;objet opportunité en fonction du champs &quot;RDV a effectue par&quot;</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ E-mail associés</fullName>
        <actions>
            <name>MAJ_E_mail_DCR_opp</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_E_mail_DR_opp</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_E_mail_du_suiveur_Approbation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_RDV1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_RDV2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) - remplissage de tous les emails associés à cette opportunité</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ E-mail du suiveur Approbation</fullName>
        <actions>
            <name>MAJ_E_mail_du_suiveur_Approbation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ) Met à jour l&apos;email du suiveur sur l&apos;objet opportunité en fonction du champs &quot;Notification suiveur&quot;</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ OPP_CIR_Hors_dispositif</fullName>
        <actions>
            <name>MAJ_CIR_annee_dernier_cir</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_CIR_gestion_dossier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.CIR_Dans_le_dispositif__c</field>
            <operation>equals</operation>
            <value>Non</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) workflow sur le champ « Dans le dispositif CIR » pour que, si la réponse est non :
· Le champ « année dernier CIR » se remplisse en « non concerné »
· Le champ « gestion du dossier » se remplisse en « non concerné »</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>MAJ Record type name</fullName>
        <actions>
            <name>CIR_MAJ_GrilleTar</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CIR_MAJ_renta_jour_estimes</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Record_type_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ) Mise à jour du nom du record type pour comparaison avec celui du contrat.</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType ACS %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_RecordType_ACS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>ACS</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType AS %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_RecordType_AS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>AS</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType CFI %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_Record_Type_CFI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>CFI</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType CIN %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_Record_type_CIN</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>CIN</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType CIR %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_RecordType_CIR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>CIR</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType CRH %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_Record_type_CRH</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>CRH</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType Consulting Spain %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>OPP_MAJ_RecordType_Consulting</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>Consulting</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType FND BR %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>OPP_MAJ_RecordType_FIN</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>FND</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType IL %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_RecordType_IL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>IL</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType LDB BR %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>OPP_MAJ_RecordType_LDB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>LDB</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType PARTENAIRE %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_RecordType_PARTENAIRE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>PARTENAIRE</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType R%26D Funding %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>OPP_MAJ_RecordType_R_D_Funding</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>R&amp;D Funding</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType R%26D Tax Credit %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>OPP_MAJ_RecordType_R_D_Tax_Credit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>R&amp;D Tax Credit</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ RecordType TAT %28creation suite LeadConversion%29</fullName>
        <actions>
            <name>MAJ_RecordType_TAT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Product_Piste__c</field>
            <operation>equals</operation>
            <value>TAT</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Déclenché lorsque Product Piste est rempli</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>MAJ_Titre_DateFin Opp</fullName>
        <actions>
            <name>MAJ_Date_Cloture</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Nom_Opp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Mise en conformité du nom d&apos;opportunité  (ex TAT-Nom compte-date création AAMMJJ et mise à jour de la date d&apos;échéance à 12 mois après la date de création.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Maj Renta2</fullName>
        <actions>
            <name>CIR_MAJ_GrilleTar</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CIR_MAJ_renta_jour_estimes</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Cocher_renta_a_rafraichir</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Maj_Nb_jour_Projets_a_Auditer</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Maj_Nombre_de_jour_Justif_non_sante</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Maj_Nombre_de_jour_Justif_sante</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>OR(RecordType.DeveloperName == &apos;CIR&apos; , RecordType.DeveloperName == &apos;FI&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Maj Renta2 CA Cible</fullName>
        <actions>
            <name>Decocher_renta_a_rafraichir</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Total_jours_estime_WF</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Maj_CA_Cible_renta_Opportunite</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) - Cette regle de WF doit se déclencher après la règle Renta2 CA Cible</description>
        <formula>OR(RecordType.DeveloperName == &apos;CIR&apos;,RecordType.DeveloperName == &apos;FI&apos; ) &amp;&amp; Renta_a_rafraichir__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Maj Renta2 Nombre de jour Projets à Auditer</fullName>
        <actions>
            <name>Maj_Nb_jour_Projets_a_Auditer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>RecordType.DeveloperName == &apos;CIR&apos; &amp;&amp;
IF(ISCHANGED(Gamme__c),true,
IF(ISCHANGED(montant_CIR__c),true,
IF(ISCHANGED(Nombre_de_projets_auditer__c),true,
IF(ISCHANGED(Nombre_d_interlocuteurs__c),true,
IF(ISCHANGED(Nb_sites__c),true,
IF(ISCHANGED(Nombre_de_projets_rediger__c),true,
IF(ISCHANGED(Renta2_CA_cible__c),true, 
IF(ISCHANGED(Renta2_Taux_min_GAC__c),true, 
IF(ISCHANGED(Renta2_Nb_jours_Justif_secto_hors_Sante__c),true, 
IF(ISCHANGED(Renta2_Nb_jours_Justif_secto_Sante__c),true,
IF(ISCHANGED(Renta2_Nb_jours_Projets_a_Auditer__c),true,
IF(ISCHANGED(Total_jours_retenus__c),true,
IF(ISCHANGED(Nombre_de_valorisation__c),true,false)))))))))))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Maj Renta2 Taux Min GAC</fullName>
        <actions>
            <name>Maj_Taux_Min_GAC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>RecordType.DeveloperName == &apos;CIR&apos; &amp;&amp;
IF(ISCHANGED(CloseDate),true,
IF(ISCHANGED(Gamme__c),true,
IF(ISCHANGED(Renta2_Nb_jours_Justif_secto_hors_Sante__c),true,
IF(ISCHANGED(Renta2_Nb_jours_Justif_secto_Sante__c),true,
IF(ISCHANGED(Renta2_Nb_jours_Projets_a_Auditer__c),true,
IF(ISCHANGED(Renta2_Nb_jours_Total_Mission__c),true,
IF(ISCHANGED(Nombre_de_projets_auditer__c),true,
IF(ISCHANGED(Nombre_d_interlocuteurs__c),true,
IF(ISCHANGED(Nb_sites__c),true,
IF(ISCHANGED(Nombre_de_projets_rediger__c),true,
IF(ISCHANGED(Nombre_de_valorisation__c),true,
IF(ISCHANGED(renta_cout_total__c),true,
IF(ISCHANGED(Total_jours_retenus__c),true,
IF(ISCHANGED(Renta2_Taux_min_GAC__c),true,
IF(ISCHANGED(Renta2_Taux_min_reel__c),true,
IF(ISCHANGED(montant_CIR__c),true,
IF(ISCHANGED(Renta2_CA_cible__c),true,false)))))))))))))))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification Prise de RDV Commercial %28FI %2B RH%29</fullName>
        <actions>
            <name>Perf_RH_Notification_Prise_de_RDV_Commercial</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Alerte e-mail - Notification Prise de RDV Commercial (Perf FI + PERF RH), on peut le mettre pour l&apos;opti si on modifie le critere de filtre</description>
        <formula>((RecordType.DeveloperName = &quot;IL&quot; || RecordType.DeveloperName = &quot;CFI&quot; || RecordType.DeveloperName = &quot;CRH&quot; || RecordType.DeveloperName = &quot;TAT&quot; || RecordType.DeveloperName = &quot;ACS&quot;) &amp;&amp; NOT ISBLANK(Origine_du_RDV__c) &amp;&amp;  ISCHANGED(Date_de_prise_de_RDV__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification Prise de RDV Commercial %28Perf FI%29</fullName>
        <actions>
            <name>PerfFI_Notification_Prise_de_RDV_Commercial</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Alerte e-mail - Notification Prise de RDV Commercial (Perf FI)</description>
        <formula>((RecordType.DeveloperName = &quot;IL&quot; || RecordType.DeveloperName = &quot;CFI&quot;) &amp;&amp;
ISnew() &amp;&amp; Numero_etape__c = 4 &amp;&amp; PRIORVALUE(RDV_annul__c) = false &amp;&amp; ISBLANK(Opportunite_soeur__c) &amp;&amp; 
RDV_pas_encore_effectue__c = 0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification Prise de RDV Commercial %28Perf RH%29</fullName>
        <actions>
            <name>Notification_Prise_de_RDV_Commercial_Opti</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Alerte e-mail - Notification Prise de RDV Commercial (Perf RH)</description>
        <formula>((RecordType.DeveloperName = &quot;CRH&quot; || RecordType.DeveloperName = &quot;TAT&quot; || RecordType.DeveloperName = &quot;ACS&quot;) &amp;&amp;
ISnew() &amp;&amp; Numero_etape__c = 4 &amp;&amp; PRIORVALUE(RDV_annul__c) = false &amp;&amp; ISBLANK(Opportunite_soeur__c) &amp;&amp; 
RDV_pas_encore_effectue__c = 0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulation rdv %28FR ALL%29 %28annulé %2B a reprendre%29</fullName>
        <actions>
            <name>Notification_RDV_Annule_reprendrefrall</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé ou annulé à reprendre</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulation rdv %28Perf FI%29 %28annulé %2B a reprendre%29</fullName>
        <actions>
            <name>Notification_RDV_Annul_a_reprendre_Perf_FI</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CFI,IL</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé et à reprendre (Perf FI)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulation rdv %28Perf RH%29 %28annulé %2B a reprendre%29</fullName>
        <actions>
            <name>Notification_RDV_Annul_a_reprendre_Perf_RH</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,ACS,CRH</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé ou à reprendre (Perf RH)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulation rdv %28inno%29 %28annulé %2B a reprendre%29</fullName>
        <actions>
            <name>Notification_RDV_Annule_reprendreInno</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,DI,FI,AS,CIN</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé et à reprendre (Inno)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulé et à reprendre %28Inno%29</fullName>
        <actions>
            <name>Notification_RDV_Annule_et_a_reprendre_Inno</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,DI,FI,AS,CIN</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>RDV à repositionner</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé et à reprendre (Inno)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulé et à reprendre %28Perf FI%29</fullName>
        <actions>
            <name>Notification_RDV_Annule_et_a_reprendre_Perf_FI</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CFI,IL</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>RDV à repositionner</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé et à reprendre (Perf FI)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulé et à reprendre %28Perf RH%29</fullName>
        <actions>
            <name>Notification_RDV_Annule_et_a_reprendre_Opti</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,ACS,CRH</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>RDV à repositionner</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé et à reprendre (Perf RH)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulé et à reprendre BR</fullName>
        <actions>
            <name>Notification_RDV_Annule_et_a_reprendre_BR</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>FND,CSL,LDB</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>RDV à prendre</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé et à reprendre BR</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV Annulé et à reprendre ES</fullName>
        <actions>
            <name>Notification_RDV_Annule_et_a_reprendre_ES</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Consulting,R&amp;D Funding,R&amp;D Tax Credit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>RDV à prendre</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est Annulé et à reprendre ESP</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV annulé %28Inno%29</fullName>
        <actions>
            <name>Notification_RDV_annule_Inno</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,DI,FI,AS,CIN</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Fermée: refus du RDV</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est annulé(Inno)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV annulé %28Perf FI%29</fullName>
        <actions>
            <name>Notification_RDV_annule_Perf_FI</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CFI,IL</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>notEqual</operation>
            <value>RDV à repositionner</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est annulé (Perf FI)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV annulé %28Perf RH%29</fullName>
        <actions>
            <name>Notification_RDV_annule_opti</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,TAT,CRH</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Fermée: refus du RDV</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est annulé (Perf RH)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV annulé BR</fullName>
        <actions>
            <name>Notification_RDV_annule_BR</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>FND,CSL,LDB</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Fermée: refus du RDV</value>
        </criteriaItems>
        <description>Alerte e-mail -  E-mail de notification lorsqu&apos;un RDV est annulé BR</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV annulé ES</fullName>
        <actions>
            <name>Notification_RDV_annule_ES</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_annul__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Consulting,R&amp;D Funding,R&amp;D Tax Credit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Fermée: refus du RDV</value>
        </criteriaItems>
        <description>Alerte e-mail -  E-mail de notification lorsqu&apos;un RDV est annulé ESP</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV dévalidé %28FR ALL%29</fullName>
        <actions>
            <name>Notification_RDV_d_valid_FR_ALL</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_d_valid__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est dévalidé ((FR ALL))</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV dévalidé %28Inno%29</fullName>
        <actions>
            <name>Notification_RDV_d_valid_Inno</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_d_valid__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,DI,FI,AS,CIN</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est dévalidé (Inno)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV dévalidé %28Perf RH %2B Perf FI%29</fullName>
        <actions>
            <name>Notification_RDV_devalid_opti</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.RDV_d_valid__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,TAT,IL,CRH,CFI</value>
        </criteriaItems>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est dévalidé (Perf RH + Perf FI)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV reporté %28FR ALL%29</fullName>
        <actions>
            <name>Notification_RDV_reporte_FR_All</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est reporté (FR ALL)</description>
        <formula>AND(ISCHANGED(ACS_Date_de_RDV_report__c ), 
Account.RecordType.DeveloperName = &apos;FRANCE_ACCOUNT&apos;
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV reporté %28Inno%29</fullName>
        <actions>
            <name>Notification_RDV_reporte_Inno</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est reporté (Inno)</description>
        <formula>AND(ISCHANGED(ACS_Date_de_RDV_report__c ), OR($RecordType.DeveloperName =&quot;CIR&quot; ,$RecordType.DeveloperName =&quot;FI&quot;,$RecordType.DeveloperName =&quot;DI&quot;,$RecordType.DeveloperName =&quot;CIN&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV reporté %28Perf RH %2B Perf FI%29</fullName>
        <actions>
            <name>Notification_RDV_reporte_opti</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est reporté(Perf RH + Perf FI)</description>
        <formula>AND(ISCHANGED(ACS_Date_de_RDV_report__c ), $RecordType.Name =&quot;IL&quot;,$RecordType.Name =&quot;CFI&quot;,$RecordType.Name =&quot;ACS&quot;,$RecordType.Name =&quot;CRH&quot;,$RecordType.Name =&quot;TAT&quot;, $Profile.Name &lt;&gt; &apos;Administrateur système&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV reporté BR</fullName>
        <actions>
            <name>Notification_RDV_reporte_BR</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est reporté BR</description>
        <formula>AND(ISCHANGED(ACS_Date_de_RDV_report__c ), OR($RecordType.Name =&quot;FND&quot; ,$RecordType.Name =&quot;LDB&quot; ,$RecordType.Name =&quot;CSL&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification RDV reporté ES</fullName>
        <actions>
            <name>Notification_RDV_reporte_ES</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Alerte e-mail - E-mail de notification lorsqu&apos;un RDV est reporté ESP</description>
        <formula>AND(ISCHANGED(ACS_Date_de_RDV_report__c ), OR($RecordType.DeveloperName =&quot;AYUDAS&quot; ,$RecordType.DeveloperName  =&quot;DED&quot;,$RecordType.DeveloperName  =&quot;Consulting&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification compte-rendu RDV %28FR ALL%29</fullName>
        <actions>
            <name>Notification_compte_rendu_RDV_FR_All</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1  and 7 and  (2 or 3 or 4 or 5 or 6)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Numero_etape__c</field>
            <operation>greaterOrEqual</operation>
            <value>6</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Timing_Prochaine_etape__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Contexte__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Objections__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Attente_Besoin__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Enjeux__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors du remplissage d&apos;un compte-rendu de RDV (Inno)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification compte-rendu RDV %28Inno%29</fullName>
        <actions>
            <name>Notification_compte_rendu_RDV_Inno</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND (3 or 4 or 5 or 6 or 7)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Numero_etape__c</field>
            <operation>greaterOrEqual</operation>
            <value>6</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>CIR,DI,FI,CIN,AS</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Contexte__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Objections__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Attente_Besoin__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Timing_Prochaine_etape__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Enjeux__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors du remplissage d&apos;un compte-rendu de RDV (Inno)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification compte-rendu RDV %28Perf RH %2B Perf FI%29</fullName>
        <actions>
            <name>Notification_compte_rendu_RDV_opti</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Numero_etape__c</field>
            <operation>greaterOrEqual</operation>
            <value>6</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>ACS,IL,CRH,CFI</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors du remplissage d&apos;un compte-rendu de RDV (Perf RH 
+ Perf FI)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification compte-rendu RDV %28TAT%29</fullName>
        <actions>
            <name>Notification_compte_rendu_RDV_TAT</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Numero_etape__c</field>
            <operation>greaterOrEqual</operation>
            <value>6</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>TAT</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors du remplissage d&apos;un compte-rendu de RDV (TAT)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification compte-rendu RDV BR</fullName>
        <actions>
            <name>Notification_compte_rendu_RDV_BR</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Numero_etape__c</field>
            <operation>greaterOrEqual</operation>
            <value>6</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>FND,CSL,LDB</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors du remplissage d&apos;un compte-rendu de RDV BR</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification compte-rendu RDV ES</fullName>
        <actions>
            <name>Notification_compte_rendu_RDV_ES</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Numero_etape__c</field>
            <operation>greaterOrEqual</operation>
            <value>6</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Consulting,R&amp;D Funding,R&amp;D Tax Credit</value>
        </criteriaItems>
        <description>Alerte e-mail E-mail de notification lors du remplissage d&apos;un compte-rendu de RDV ESP</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OPP FR RDV VALIDE SANS CR %28Inno%29</fullName>
        <active>false</active>
        <description>Alerte e-mail si une opportunité est toujours à l&apos;étape RDV validé alors que le rendez-vous a été effectué depuis 7 jours</description>
        <formula>NOT(ISNULL(Date_dernier_RDV__c)) &amp;&amp; 
 opportunite_recente__c = 1 &amp;&amp;
RDV_d_valid__c != true &amp;&amp;
Account.RecordType.DeveloperName == &apos;FRANCE_ACCOUNT&apos; &amp;&amp;
Numero_etape__c &lt;=5 /*RDV VALIDé*/ &amp;&amp;
NOT( IsClosed ) &amp;&amp;
 Pole__c == &apos;Inno&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_RDV_sans_compte_rendu_Inno</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Date_dernier_RDV__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OPP FR RDV VALIDE SANS CR %28Inno%29 2</fullName>
        <active>false</active>
        <description>Alerte e-mail si une opportunité est toujours à l&apos;étape RDV validé alors que le rendez-vous a été effectué depuis 5 jours</description>
        <formula>NOT(ISNULL(Date_dernier_RDV__c)) &amp;&amp; 
 opportunite_recente__c = 1 &amp;&amp;
RDV_d_valid__c != true &amp;&amp;
Account.RecordType.DeveloperName == &apos;FRANCE_ACCOUNT&apos; &amp;&amp;
Numero_etape__c &lt;=5 /*RDV VALIDé*/ &amp;&amp;
NOT( IsClosed ) &amp;&amp;
 Pole__c == &apos;Inno&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_RDV_sans_compte_rendu_Inno</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Date_dernier_RDV__c</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OPP FR RDV VALIDE SANS CR %28Opti%29</fullName>
        <active>false</active>
        <description>Alerte e-mail si une opportunité est toujours à l&apos;étape RDV validé alors que le rendez-vous a été effectué depuis 7 jours</description>
        <formula>NOT(ISNULL( Date_dernier_RDV__c )) &amp;&amp;
opportunite_recente__c = 1 &amp;&amp;
 RDV_d_valid__c != true &amp;&amp;
Account.RecordType.DeveloperName == &apos;FRANCE_ACCOUNT&apos; &amp;&amp;
Numero_etape__c &lt;=5 /*RDV VALIDé*/ &amp;&amp;
NOT( IsClosed ) &amp;&amp;
 Pole__c &lt;&gt; &apos;Inno&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_RDV_sans_compte_rendu_Opti</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Date_dernier_RDV__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OPP FR RDV VALIDE SANS CR %28Opti%29 2</fullName>
        <active>false</active>
        <description>Alerte e-mail si une opportunité est toujours à l&apos;étape RDV validé alors que le rendez-vous a été effectué depuis 5 jours</description>
        <formula>NOT(ISNULL( Date_dernier_RDV__c )) &amp;&amp;
opportunite_recente__c = 1 &amp;&amp;
 RDV_d_valid__c != true &amp;&amp;
Account.RecordType.DeveloperName == &apos;FRANCE_ACCOUNT&apos; &amp;&amp;
Numero_etape__c &lt;=5 /*RDV VALIDé*/ &amp;&amp;
NOT( IsClosed ) &amp;&amp;
 Pole__c &lt;&gt; &apos;Inno&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_RDV_sans_compte_rendu_Opti</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Date_dernier_RDV__c</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OPP FR RDV VALIDE SANS CR FR ALL</fullName>
        <active>true</active>
        <description>Alerte e-mail si une opportunité est toujours à l&apos;étape RDV validé alors que le rendez-vous a été effectué depuis 5 jours</description>
        <formula>NOT(ISNULL( Date_dernier_RDV__c )) &amp;&amp;
opportunite_recente__c = 1 &amp;&amp;
 RDV_d_valid__c != true &amp;&amp;
Account.RecordType.DeveloperName == &apos;FRANCE_ACCOUNT&apos; &amp;&amp;
Numero_etape__c &lt;=5 /*RDV VALIDé*/ &amp;&amp;
NOT( IsClosed )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_RDV_sans_compte_rendu_FR_ALL</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Date_dernier_RDV__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Opportunité avec reco</fullName>
        <actions>
            <name>FR_MAJ_mail_destinataire_reco</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>FR_MAJ_mail_propri_taire_reco</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>Recommandation__c &lt;&gt; null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reco avec contrat signé</fullName>
        <actions>
            <name>Reco_avec_contrat_sign</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Fermée gagnée</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Email_du_destinataire_recommandation__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Email_du_proprietaire_recommandation__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Reco avec opportunité fermée perdue</fullName>
        <actions>
            <name>Reco_avec_opportunite_fermee_perdue</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Fermée: refus du RDV,Fermée: refus de l&apos;offre</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Email_du_proprietaire_recommandation__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Email_du_destinataire_recommandation__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Reco avec opportunité fermée perdue</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Reco ayant permis de prendre un RDV %28étape %C2%AB RDV pris %C2%BB%29</fullName>
        <actions>
            <name>Reco_ayant_permis_de_prendre_un_RDV_etape_RDV_pris</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>RDV pris</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Email_du_proprietaire_recommandation__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Email_du_destinataire_recommandation__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ) Reco ayant permis de prendre un RDV (étape « RDV pris »)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
