<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alerte_Recommandation_cross_selling</fullName>
        <description>Alerte Recommandation cross-selling (Perf Inno)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>lhauseux@group-gac.com</recipient>
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
        <recipients>
            <field>Destinataire__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Nouvelle_Recommandation</template>
    </alerts>
    <alerts>
        <fullName>Alerte_Recommandation_cross_selling_Perf_FI</fullName>
        <description>Alerte Recommandation cross-selling (Perf Financière)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>jfcolle@group-gac.com</recipient>
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
        <recipients>
            <field>Destinataire__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Nouvelle_Recommandation</template>
    </alerts>
    <alerts>
        <fullName>Alerte_Recommandation_cross_selling_Perf_RH</fullName>
        <description>Alerte Recommandation cross-selling (Perf RH)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>jberche@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mnantas@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrocheteau@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shabert@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Destinataire__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Nouvelle_Recommandation</template>
    </alerts>
    <alerts>
        <fullName>Notification_de_modification_de_destinataire_de_la_reco</fullName>
        <description>Notification de modification de destinataire de la reco</description>
        <protected>false</protected>
        <recipients>
            <recipient>mnantas@group-gac.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GAC_France/Modification_du_destinataire_d_une_recommandation</template>
    </alerts>
    <fieldUpdates>
        <fullName>MAJ_E_mail_DCR_reco</fullName>
        <field>E_mail_du_DCR__c</field>
        <formula>Destinataire__r.DCR__r.Email</formula>
        <name>MAJ E-mail DCR reco</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_E_mail_DR_reco</fullName>
        <field>E_mail_du_DR__c</field>
        <formula>Destinataire__r.DCR__r.Email</formula>
        <name>MAJ E-mail DR reco</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_E_mail_Destinataire_recommandation</fullName>
        <field>Email_du_destinataire__c</field>
        <formula>Destinataire__r.Email</formula>
        <name>MAJ E-mail Destinataire recommandation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Email_Proprietaire_recommandation</fullName>
        <field>Email_du_proprietaire__c</field>
        <formula>Owner:User.Email</formula>
        <name>MAJ E-mail Propriétaire recommandation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reco_Profil_Commercial_INNO</fullName>
        <field>Profil_proprietaire__c</field>
        <formula>&quot;Commerce INNO&quot;</formula>
        <name>Reco Profil Commercial INNO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reco_Profil_Commercial_OPTI</fullName>
        <field>Profil_proprietaire__c</field>
        <formula>&quot;Commerce OPTI&quot;</formula>
        <name>Reco Profil Commercial OPTI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reco_Profil_Membre_du_CODIR</fullName>
        <field>Profil_proprietaire__c</field>
        <formula>&quot;Membre du CODIR&quot;</formula>
        <name>Reco Profil Membre du CODIR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reco_Profil_Support</fullName>
        <field>Profil_proprietaire__c</field>
        <formula>&quot;Support&quot;</formula>
        <name>Reco Profil Support</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reco_Profil_Technique_INNO</fullName>
        <field>Profil_proprietaire__c</field>
        <formula>&quot;Technique INNO&quot;</formula>
        <name>Reco Profil Technique INNO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reco_Profil_Technique_OPTI</fullName>
        <field>Profil_proprietaire__c</field>
        <formula>&quot;Technique OPTI&quot;</formula>
        <name>Reco Profil Technique Perf RH</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MAJ E-mail DCR</fullName>
        <actions>
            <name>MAJ_E_mail_DCR_reco</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Met à jour l&apos;email du DCR sur l&apos;objet recommandation en fonction du champs &quot;Destinataire&quot;</description>
        <formula>ISCHANGED( Destinataire__c ) || ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ E-mail DR</fullName>
        <actions>
            <name>MAJ_E_mail_DR_reco</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Met à jour l&apos;email du DR sur l&apos;objet recommandation en fonction du champs &quot;Destinataire&quot;</description>
        <formula>ISCHANGED( Destinataire__c ) || ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ E-mail Destinataire</fullName>
        <actions>
            <name>MAJ_E_mail_Destinataire_recommandation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Met à jour l&apos;email du Destinataire sur l&apos;objet recommandation en fonction du champs &quot;Destinataire&quot;</description>
        <formula>ISCHANGED(Destinataire__c) || ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ E-mail Propriétaire</fullName>
        <actions>
            <name>MAJ_Email_Proprietaire_recommandation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Met à jour l&apos;email du Propriétaire sur l&apos;objet recommandation en fonction du champs &quot;Propriétaire&quot;</description>
        <formula>ISCHANGED(  OwnerId  ) || ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification Modif reco</fullName>
        <actions>
            <name>Notification_de_modification_de_destinataire_de_la_reco</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerte e-mail pour MCN l&apos;informant si un utilisateur a modifié le destinataire de la reco.</description>
        <formula>ISCHANGED( Destinataire__c )  &amp;&amp;  LastModifiedBy.Id &lt;&gt; &quot;005D0000002BvOd&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notification Recommandation Cross-selling %28Inno%29</fullName>
        <actions>
            <name>Alerte_Recommandation_cross_selling</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Recommandation_cross_selling__c.Produits__c</field>
            <operation>equals</operation>
            <value>AS,CIR,CIN</value>
        </criteriaItems>
        <criteriaItems>
            <field>Recommandation_cross_selling__c.Destinataire__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Alerte e-mail - recommandation cross-selling inno</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification Recommandation Cross-selling %28Perf Financière%29</fullName>
        <actions>
            <name>Alerte_Recommandation_cross_selling_Perf_FI</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Recommandation_cross_selling__c.Produits__c</field>
            <operation>equals</operation>
            <value>IL,CFI</value>
        </criteriaItems>
        <criteriaItems>
            <field>Recommandation_cross_selling__c.Destinataire__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Alerte e-mail - recommandation cross-selling IL + CFI</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notification Recommandation Cross-selling %28Perf RH%29</fullName>
        <actions>
            <name>Alerte_Recommandation_cross_selling_Perf_RH</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Recommandation_cross_selling__c.Produits__c</field>
            <operation>equals</operation>
            <value>ACS,TAT,CRH</value>
        </criteriaItems>
        <criteriaItems>
            <field>Recommandation_cross_selling__c.Destinataire__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Alerte e-mail - recommandation cross-selling perf RH</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Reco Profil CODIR</fullName>
        <actions>
            <name>Reco_Profil_Membre_du_CODIR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Membre du CODIR&quot;),TRUE,FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reco Profil Commercial OPTI</fullName>
        <actions>
            <name>Reco_Profil_Commercial_OPTI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle Optimisation Commercial&quot;)  || ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle TAT commerce&quot;) || ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle ACS commerce&quot;),TRUE,FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reco Profil Pôle INNO Commercial</fullName>
        <actions>
            <name>Reco_Profil_Commercial_INNO</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ) Commerce + Manager Technique Inno</description>
        <formula>IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Commercial IDF&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Commercial Ouest&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Commercial Lyon&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Commercial Toulouse&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Commercial Lille&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;BU Grands Comptes&quot;)  &amp;&amp;  (CreatedBy.Profile.Name &lt;&gt; &quot;FR - Tech - Manager - Inno&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;BU Grands Comptes&quot;)  &amp;&amp;  (CreatedBy.Profile.Name &lt;&gt; &quot;FR - Tech - Consultant - Inno&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Manager&quot;) &amp;&amp;  (CreatedBy.Profile.Name &lt;&gt; &quot;FR - Tech - Manager - Inno&quot;),TRUE,FALSE))))))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reco Profil Pôle INNO Technique</fullName>
        <actions>
            <name>Reco_Profil_Technique_INNO</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Technique MERLIN&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Technique NARAINSAMY&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Technique RASSAT&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Technique SEBBAN&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Technique MANCIER&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Technique CHABRILLAT&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle Innovation Fiscaliste&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Technique HUMBERT&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;BU Grands Comptes&quot;) &amp;&amp; (CreatedBy.Profile.Name = &quot;FR - Tech - Manager - Inno&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;BU Grands Comptes&quot;) &amp;&amp; (CreatedBy.Profile.Name = &quot;FR - Tech - Consultant - Inno&quot;),TRUE,
IF(ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle INNO Manager&quot;) &amp;&amp; (CreatedBy.Profile.Name = &quot;FR - Tech - Manager - Inno&quot;),TRUE,FALSE)))))))))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reco Profil Support</fullName>
        <actions>
            <name>Reco_Profil_Support</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>IF((ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Informatique/Finance/SG&quot;) || 
ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Marketing&quot;) || 
ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Ressources Humaines&quot;) || 
ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Informatique/Finance/SG&quot;)),TRUE,FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reco Profil Technique Perf RH</fullName>
        <actions>
            <name>Reco_Profil_Technique_OPTI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>IF((ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle TAT&quot;) || 
ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle IL&quot;) || 
ISPICKVAL(CreatedBy.Type_approbation_NDF__c, &quot;Pôle ACS&quot;)),TRUE,FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
