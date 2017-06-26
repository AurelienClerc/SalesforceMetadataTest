<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_Encaissement_saisi_Inno</fullName>
        <description>Notification Encaissement saisi (Inno)</description>
        <protected>false</protected>
        <recipients>
            <recipient>mflauraud@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mlacombe@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rbrunet@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_Encaissement_Inno</template>
    </alerts>
    <alerts>
        <fullName>Notification_Encaissement_saisi_OPTI</fullName>
        <description>Notification Encaissement saisi (OPTI)</description>
        <protected>false</protected>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mflauraud@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mlacombe@group-gac.com</recipient>
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
        <template>GAC_France/Notification_Encaissement_OPTI</template>
    </alerts>
    <alerts>
        <fullName>Notification_Encaissement_saisi_SGP</fullName>
        <description>Notification Encaissement saisi (SGP)</description>
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
            <recipient>snazrin@group-gac.sg</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>rsetrakian@global-approach-consulting.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>GAC_SINGAPOUR/Notification_SGP_Encaissement</template>
    </alerts>
    <rules>
        <fullName>Notification Encaissement saisie %28Inno%29</fullName>
        <actions>
            <name>Notification_Encaissement_saisi_Inno</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Pole__c</field>
            <operation>equals</operation>
            <value>Inno</value>
        </criteriaItems>
        <description>Alerte e-mail -</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification Encaissement saisie %28OPTI%29</fullName>
        <actions>
            <name>Notification_Encaissement_saisi_OPTI</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Facture__c.Pole__c</field>
            <operation>equals</operation>
            <value>Perf RH,Perf Financière</value>
        </criteriaItems>
        <description>Alerte e-mail -</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification SGP Encaissement</fullName>
        <actions>
            <name>Notification_Encaissement_saisi_SGP</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Encaissement__c.Division</field>
            <operation>equals</operation>
            <value>SINGAPORE</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.DefaultDivision</field>
            <operation>equals</operation>
            <value>SINGAPORE</value>
        </criteriaItems>
        <description>Alerte e-mail - Notification SGP Encaissement</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
