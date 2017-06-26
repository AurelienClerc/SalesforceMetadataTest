<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AppCIRMembreDesactive</fullName>
        <description>AppCIR Membre désactivé</description>
        <protected>false</protected>
        <recipients>
            <field>Utilisateur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>AppCIRmodelesMessages/AppCIRMembreDesactive</template>
    </alerts>
    <alerts>
        <fullName>AppCIR_creation_membre_quipe_consulting</fullName>
        <description>AppCIR création membre équipe consulting</description>
        <protected>false</protected>
        <recipients>
            <field>Utilisateur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>AppCIRmodelesMessages/AppCIR_Mission_CIR_lancee</template>
    </alerts>
    <alerts>
        <fullName>AppCIR_creation_membre_quipe_consulting_Manager</fullName>
        <description>AppCIR création membre équipe consulting Manager</description>
        <protected>false</protected>
        <recipients>
            <field>Utilisateur__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>AppCIRmodelesMessages/AppCIR_Mission_CIR_lancee_manager</template>
    </alerts>
    <rules>
        <fullName>AppCIR création membre équipe consulting</fullName>
        <active>true</active>
        <criteriaItems>
            <field>AppCIRequipeConsulting__c.Utilisateur__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>AppCIRequipeConsulting__c.Role__c</field>
            <operation>notEqual</operation>
            <value>Manager</value>
        </criteriaItems>
        <description>Alerte e-mail</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppCIR_creation_membre_quipe_consulting</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppCIR création membre équipe consulting Manager</fullName>
        <active>true</active>
        <criteriaItems>
            <field>AppCIRequipeConsulting__c.Utilisateur__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>AppCIRequipeConsulting__c.Role__c</field>
            <operation>equals</operation>
            <value>Manager</value>
        </criteriaItems>
        <description>Alerte e-mail</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppCIR_creation_membre_quipe_consulting_Manager</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AppCIR désactivation membre équipe consulting</fullName>
        <active>true</active>
        <criteriaItems>
            <field>AppCIRequipeConsulting__c.Actif__c</field>
            <operation>equals</operation>
            <value>Faux</value>
        </criteriaItems>
        <description>Alerte e-mail</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AppCIRMembreDesactive</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
