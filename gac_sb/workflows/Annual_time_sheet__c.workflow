<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AnnualTimeSheet_Calcul_Hourly_Cost</fullName>
        <field>Hourly_cost__c</field>
        <formula>CASE( TEXT(Consultant__c),
&apos;Alberto VERDU&apos;,15,
&apos;Alexis URCELAY&apos;,22,
&apos;Igor GONZALEZ&apos;,27,
&apos;Imanol BERASALUZE&apos;,21,
&apos;Jon Andoni DOCANDO&apos;,19,
&apos;Jon ARRATE&apos;,19,
&apos;Kizkitza AURREKOETXEA&apos;,54,
&apos;Laura GARCIA&apos;,19,
&apos;Miriam CAMARA&apos;,19,
&apos;Raquel VEGA&apos;,20,
&apos;Silvia CASTRO&apos;,19,
&apos;Veronica MEDRANO&apos;,20,
&apos;Ana Julia VECINO&apos;,29,
&apos;Itziar ONAINDIA&apos;,34,
&apos;Aitor LEGORBURU&apos;,35,
&apos;Alicia VALLE&apos;,19,
&apos;Alvaro PALACIOS&apos;,19,
&apos;Aranzazu OLAZABAL&apos;,23,
&apos;Gemma SANCHIZ&apos;,24,
&apos;Iban RUI-WAMBA&apos;,23,
&apos;Marcos RUANO&apos;,30,
&apos;Mikel IBAÑEZ&apos;,26,
&apos;Paula REVUELTA&apos;,17,
&apos;Pilar BURGUEÑO&apos;,30,
&apos;Rosa DE LIMA&apos;,25,
&apos;Silvia DE LUIS&apos;,32,
&apos;Macarena BARENO&apos;,26,
&apos;Kepa LOPEZ&apos;,22,
&apos;Aiora URIEN&apos;,22,
&apos;Asier VALERO&apos;,22,
&apos;Ixone ARRAUSI&apos;,22,
&apos;Nahia ZABALA&apos;,22,
&apos;Jose Maria GOMEZ&apos;,22,
&apos;Luis GUTIERREZ&apos;,27,
&apos;Belen AREITIO&apos;,22,
&apos;Borja ULLIBARRI&apos;,22,
&apos;Shane REILLY&apos;,22,
&apos;Beatriz NAVARRO&apos;,22,
&apos;Isabel PEREZ&apos;,22,
&apos;Xabier MENDINUETA&apos;,22,
&apos;Unai RODO&apos;,22,
&apos;Antonio LEAL&apos;,23,
&apos;Daniel PASCUAL GONZALEZ&apos;,21,
&apos;Tania GONZALEZ LEDESMA&apos;,5,
&apos;Tania SANCHEZ&apos;,5,
&apos;Laura G.GASTAÑAGA&apos;,21,
&apos;New Trainee&apos;,5,
&apos;Roseli Carvalho&apos;,97,
&apos;Fabiane Gorge&apos;,58,
&apos;Richard Medina&apos;,116,
&apos;Marcus Carraschi&apos;,19,
&apos;Camila Donizette&apos;,79,
&apos;Adriano Araujo&apos;,79,
&apos;Débora Beraldo&apos;,79,
&apos;Mariano Lamarca&apos;,79,
&apos;Fernando Schaffer&apos;,79,
&apos;Juliana Alves&apos;,79,
&apos;Danilo Pereira&apos;,79,
&apos;Fernanda Falcheti&apos;,79,
&apos;Edwin Lima&apos;,211,
&apos;Gregory Correa&apos;,110,
&apos;Gilson Kohs&apos;,126,
null)</formula>
        <name>AnnualTimeSheet Calcul Hourly Cost</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>INSERTION Hourly Cost vide par Consultant</fullName>
        <actions>
            <name>AnnualTimeSheet_Calcul_Hourly_Cost</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Annual_time_sheet__c.Hourly_cost__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
