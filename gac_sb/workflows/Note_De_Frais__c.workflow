<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_suppression_depense_recap_approbateur</fullName>
        <description>Notification en cas de suppression de dépense sur un récap par un approbateur</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>rsetrakian@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Notification_suppression_depense_recap_approbateur</template>
    </alerts>
    <alerts>
        <fullName>Notification_suppression_depense_recap_approbateur_BR</fullName>
        <description>Notification en cas de suppression de dépense sur un récap par un approbateur BR</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>rsetrakian@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_BRASIL/Notification_suppression_depense_recap_approbateur_BR</template>
    </alerts>
    <rules>
        <fullName>Suppression d%27une dépense</fullName>
        <actions>
            <name>Notification_suppression_depense_recap_approbateur</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerte e-mail</description>
        <formula>((LastModifiedById = &quot;005D0000002cp2A&quot;) &amp;&amp; 
 (PRIORVALUE(Nombre_De_Depenses__c) &gt; Nombre_De_Depenses__c))
&amp;&amp; ! ISPiCKVAL(Pays__c, &apos;BR&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Suppression d%27une dépense BR</fullName>
        <actions>
            <name>Notification_suppression_depense_recap_approbateur_BR</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerte e-mail</description>
        <formula>((LastModifiedById = &quot;005D0000002cp2A&quot;) &amp;&amp; 
 (PRIORVALUE(Nombre_De_Depenses__c) &gt; Nombre_De_Depenses__c))
&amp;&amp; ISPiCKVAL(Pays__c, &apos;BR&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
