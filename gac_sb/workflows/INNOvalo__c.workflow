<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>INNOdateClotureValorisation</fullName>
        <description>Met à jour le champ &apos;Date de clôture&apos; en fonction du champ &apos;Jour et mois de clôture fiscale&apos;, l&apos;année choisie est l&apos;année courante</description>
        <field>Date_de_cloture__c</field>
        <formula>DATEVALUE(
	TEXT(YEAR(TODAY())) + &apos;-&apos; + 
	IF(
		ISPICKVAL(Jour_mois_de_cloture_fiscale__c, &apos;&apos;) , 
		&apos;12-31&apos;,
	
		CASE(
			RIGHT(TEXT(Jour_mois_de_cloture_fiscale__c), LEN(TEXT(Jour_mois_de_cloture_fiscale__c)) - 3),
			&apos;Janvier&apos;, &apos;01&apos;,
			&apos;Février&apos;, &apos;02&apos;,
			&apos;Mars&apos;, &apos;03&apos;,
			&apos;Avril&apos;, &apos;04&apos;,
			&apos;Mai&apos;, &apos;05&apos;,
			&apos;Juin&apos;, &apos;06&apos;,
			&apos;Juillet&apos;, &apos;07&apos;,
			&apos;Août&apos;, &apos;08&apos;,
			&apos;Septembre&apos;, &apos;09&apos;,
			&apos;Octobre&apos;, &apos;10&apos;,
			&apos;Novembre&apos;, &apos;11&apos;,
			&apos;Décembre&apos;, &apos;12&apos;,&apos;12&apos;) + &apos;-&apos; + 
			LEFT(TEXT(Jour_mois_de_cloture_fiscale__c), 2)
	)
)</formula>
        <name>INNO date de clôture valorisation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>InnoMajTaux</fullName>
        <field>Taux__c</field>
        <formula>IF(RecordType.DeveloperName = &apos;CIR&apos;, MissionCIR__r.Taux_CIR__c, MissionCIR__r.TauxCII__c)</formula>
        <name>Inno - Maj Taux</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inno_Maj_apres_dedu</fullName>
        <field>TECH_CIR_apres_dedu__c</field>
        <formula>Montant_total_dep_apres_dedu_optionFinal__c * Taux__c</formula>
        <name>Inno - Maj après dédu</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inno_Maj_avant_dedu</fullName>
        <field>TECH_CIR_avantDedu__c</field>
        <formula>MontantTotaDepensesOptionFinalePlafonne__c * Taux__c</formula>
        <name>Inno - Maj avant dédu</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PlafondOption1</fullName>
        <field>MontantTotalDepensesOption1Plafonne__c</field>
        <formula>IF( RecordType.DeveloperName  == &apos;CII&apos;,
  MIN(Montant_total_depenses_option1__c, 400000),
  Montant_total_depenses_option1__c
)</formula>
        <name>Plafond Option 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PlafondOption2</fullName>
        <field>MontantTotalDepensesOption2Plafonne__c</field>
        <formula>IF( RecordType.DeveloperName == &apos;CII&apos;, 
MIN(Montant_total_depenses_option2__c, 400000), 
Montant_total_depenses_option2__c)</formula>
        <name>Plafond Option 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PlafondOption3</fullName>
        <field>MontantTotalDepensesOption3Plafonne__c</field>
        <formula>IF( RecordType.DeveloperName == &apos;CII&apos;, 
MIN(Montant_total_depenses_option3__c, 400000), 
Montant_total_depenses_option3__c )</formula>
        <name>Plafond Option 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PlafondOptionRetenue</fullName>
        <field>MontantTotaDepensesOptionFinalePlafonne__c</field>
        <formula>IF( RecordType.DeveloperName == &apos;CII&apos;, 
MIN(Montant_total_depenses_optionFinale__c, 400000), 
Montant_total_depenses_optionFinale__c)</formula>
        <name>Plafond Option retenue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>INNO MAJ date de clôture valorisation</fullName>
        <actions>
            <name>INNOdateClotureValorisation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISCHANGED(Jour_mois_de_cloture_fiscale__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>INNO Valo %3A Montant total plafonné</fullName>
        <actions>
            <name>InnoMajTaux</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Inno_Maj_apres_dedu</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Inno_Maj_avant_dedu</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PlafondOption1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PlafondOption2</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PlafondOption3</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PlafondOptionRetenue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
