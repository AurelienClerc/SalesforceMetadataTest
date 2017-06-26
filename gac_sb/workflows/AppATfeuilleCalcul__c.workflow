<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppAT_MAJ_FdC_Name</fullName>
        <field>Name</field>
        <formula>AnneeFeuilleCalcul__c &amp; &apos; - &apos; &amp; text( Type_de_feuille_de_calcul__c) &amp; IF(ISBLANK(DateNotification__c), &apos;&apos;, &apos; - &apos; &amp; IF(LEN(TEXT(DAY(DateNotification__c)))=1,&apos;0&apos;+
TEXT(DAY(DateNotification__c)),TEXT(DAY(DateNotification__c))) +&apos;/&apos;+
IF(LEN(TEXT(MONTH(DateNotification__c)))=1,&apos;0&apos;+
text(MONTH(DateNotification__c)),TEXT(MONTH(DateNotification__c)))+&apos;/&apos;+
TEXT(YEAR(DateNotification__c))
)</formula>
        <name>AppAT MAJ FdC Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_Txt_expli_cpt_triennal</fullName>
        <field>TxtExplicatifCompteTriennal__c</field>
        <formula>BLANKVALUE( TxtExplicatifCompteTriennal__c, 
&quot;Valeur du risque = somme du nombre de sinistres par CCM x tarif du CCM correspondant&quot;)</formula>
        <name>AppAT MAJ Txt expli. cpt triennal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_ctrl_calcul2_FALSE</fullName>
        <field>Controler_Calcul2__c</field>
        <literalValue>0</literalValue>
        <name>AppAT MAJ ctrl calcul2 FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_ctrl_calcul2_TRUE</fullName>
        <field>Controler_Calcul2__c</field>
        <literalValue>1</literalValue>
        <name>AppAT MAJ ctrl calcul2 TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_ctrl_calcul_tx_indiv_FALSE</fullName>
        <field>ControlerTauxIndividuel__c</field>
        <literalValue>0</literalValue>
        <name>AppAT MAJ ctrl calcul tx indiv FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_ctrl_calcul_tx_indiv_TRUE</fullName>
        <field>ControlerTauxIndividuel__c</field>
        <literalValue>1</literalValue>
        <name>AppAT MAJ ctrl calcul tx indiv TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_lieu_du_risque</fullName>
        <field>LieuRisque__c</field>
        <formula>IF(ISBLANK(LieuRisque__c), 
 EtablissementConcerne__r.Rue__c +BR()+
 EtablissementConcerne__r.Code_postal__c +&apos; &apos;+
 EtablissementConcerne__r.Ville__c,
LieuRisque__c)</formula>
        <name>AppAT MAJ lieu du risque</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_taux_indiv_reel</fullName>
        <field>TauxIndividuel__c</field>
        <formula>IF(Effectif__c&gt;=150,IF(IF(AND(TauxNet__c&gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),TauxNet__c&lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1)),TauxNet__c,0)=0,0.01*FLOOR(100*(IF(TauxNet__c&lt;IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),0)+IF(TauxNet__c&gt;IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1),IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1)
,0)+IF(AND(TauxNet__c&gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),TauxNet__c&lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1)),TauxNet__c,0))),IF(AND(TauxNet__c&gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),TauxNet__c&lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1)),TauxNet__c,0)),IF(IF(AND(TauxNet__c&gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),TauxNet__c&lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1)),TauxNet__c,0)
=0,0.01*FLOOR(100*(IF(TauxNet__c&lt;IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),0)+IF(TauxNet__c&gt;IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1),IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1)
,0)+IF(AND(TauxNet__c&gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),TauxNet__c&lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1)),TauxNet__c,0))),IF(AND(TauxNet__c&gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c-(TauxExerciceAnterieur__c*0.2),TauxExerciceAnterieur__c-0.8),TauxNet__c&lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c+(TauxExerciceAnterieur__c*0.25),TauxExerciceAnterieur__c+1)),TauxNet__c,0)))</formula>
        <name>AppAT MAJ taux indiv réel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_taux_mixte</fullName>
        <field>TauxMixte__c</field>
        <formula>IF( 
  LEN(TEXT(TauxNet__c*FractionTauxNet__c+TauxCollectif__c*FractionTauxCollectif__c))&lt;7,
  TauxNet__c*FractionTauxNet__c+TauxCollectif__c*FractionTauxCollectif__c,
  Value(LEFT(TEXT(TauxNet__c*FractionTauxNet__c+TauxCollectif__c*FractionTauxCollectif__c),6)))</formula>
        <name>AppAT MAJ taux mixte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_total_val_risque</fullName>
        <field>TotalValeurRisque__c</field>
        <formula>ValeurRisque_N_2__c +ValeurRisque_N_3__c +ValeurRisque_N_4__c</formula>
        <name>AppAT MAJ total val risque</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AppAT_MAJ_tx_indiv_mixte</fullName>
        <field>TauxIndividuel__c</field>
        <formula>IF(IF(AND( TauxMixteArrondi__c &gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *0.8,TauxExerciceAnterieur__c -0.8),TauxMixteArrondi__c &lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *1.25,TauxExerciceAnterieur__c +1)),TauxMixteArrondi__c,0)
=0,0.01*FLOOR(100*(IF( TauxMixteArrondi__c &lt;IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *0.8,TauxExerciceAnterieur__c -0.8),IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *0.8,TauxExerciceAnterieur__c -0.8),0)+IF( TauxMixteArrondi__c &gt;IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *1.25,TauxExerciceAnterieur__c +1),
IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *1.25,TauxExerciceAnterieur__c +1),0)+IF(AND( TauxMixteArrondi__c &gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *0.8,TauxExerciceAnterieur__c -0.8),TauxMixteArrondi__c &lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *1.25,TauxExerciceAnterieur__c +1)),TauxMixteArrondi__c,0)
)),IF(AND( TauxMixteArrondi__c &gt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *0.8,TauxExerciceAnterieur__c -0.8),TauxMixteArrondi__c &lt;=IF( TauxExerciceAnterieur__c &gt;4,TauxExerciceAnterieur__c *1.25,TauxExerciceAnterieur__c +1)),TauxMixteArrondi__c,0)
)</formula>
        <name>AppAT MAJ tx indiv mixte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>AppAT MAJ FdC Name</fullName>
        <actions>
            <name>AppAT_MAJ_FdC_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISNEW()|| LEN(Name)&lt;4</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ FdC calcul</fullName>
        <actions>
            <name>AppAT_MAJ_Txt_expli_cpt_triennal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_ctrl_calcul2_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_lieu_du_risque</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_total_val_risque</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ FdC calcul2</fullName>
        <actions>
            <name>AppAT_MAJ_ctrl_calcul2_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_ctrl_calcul_tx_indiv_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_taux_mixte</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>Controler_Calcul2__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ Tx Individuel  mixte</fullName>
        <actions>
            <name>AppAT_MAJ_ctrl_calcul_tx_indiv_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_tx_indiv_mixte</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>RecordType.DeveloperName =&apos;TauxMixte&apos; &amp;&amp;
 ControlerTauxIndividuel__c = TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>AppAT MAJ Tx Individuel réel</fullName>
        <actions>
            <name>AppAT_MAJ_ctrl_calcul_tx_indiv_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>AppAT_MAJ_taux_indiv_reel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>RecordType.DeveloperName=&apos;TauxReel&apos;&amp;&amp;
 ControlerTauxIndividuel__c  = TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
