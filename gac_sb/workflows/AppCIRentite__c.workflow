<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AppCIR_MAJ_date_de_cloture_entite</fullName>
        <description>Met à jour le champ &apos;Date de clôture&apos; en fonction du champ &apos;Jour et mois de clôture fiscale&apos;, l&apos;année choisie est l&apos;année courante</description>
        <field>Date_de_cloture__c</field>
        <formula>DATEVALUE(
	TEXT(YEAR(TODAY())) + &apos;-&apos; + 
	IF( ISPICKVAL(Jour_mois_de_cloture_fiscale__c, &apos;&apos;) , 
		&apos;12-31&apos;,

		CASE( RIGHT( TEXT(Jour_mois_de_cloture_fiscale__c), LEN( TEXT(Jour_mois_de_cloture_fiscale__c)) - 3),
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

		LEFT( TEXT(Jour_mois_de_cloture_fiscale__c), 2)
	)
)</formula>
        <name>AppCIR MAJ date de clôture entité</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AppCIR MAJ date de clôture entité</fullName>
        <actions>
            <name>AppCIR_MAJ_date_de_cloture_entite</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour de champ (MAJ)</description>
        <formula>ISCHANGED(Jour_mois_de_cloture_fiscale__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
