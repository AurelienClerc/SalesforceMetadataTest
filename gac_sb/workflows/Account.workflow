<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ACC_BR_MAJ_DPT</fullName>
        <description>Mise a jour du champ département du compte en fonction de l&apos;état pour le brésil</description>
        <field>Departement__c</field>
        <formula>Case(UPPER(BillingState),
&quot;AC&quot;,&quot;Acre&quot;,
&quot;AL&quot;,&quot;Alagoas&quot;,
&quot;AP&quot;,&quot;Amapá&quot;,
&quot;AM&quot;,&quot;Amazonas&quot;,
&quot;BA&quot;,&quot;Bahia&quot;,
&quot;CE&quot;,&quot;Ceará&quot;,
&quot;ES&quot;,&quot;Espírito Santo&quot;,
&quot;GO&quot;,&quot;Goiás&quot;,
&quot;MA&quot;,&quot;Maranhão&quot;,
&quot;MT&quot;,&quot;Mato Grosso&quot;,
&quot;MS&quot;,&quot;Mato Grosso do Sul&quot;,
&quot;MG&quot;,&quot;Minas Gerais&quot;,
&quot;PA&quot;,&quot;Pará&quot;,
&quot;PB&quot;,&quot;Paraíba&quot;,
&quot;PR&quot;,&quot;Paraná&quot;,
&quot;PE&quot;,&quot;Pernambuco&quot;,
&quot;PI&quot;,&quot;Piauí&quot;,
&quot;RJ&quot;,&quot;Rio de Janeiro&quot;,
&quot;RN&quot;,&quot;Rio Grande do Norte&quot;,
&quot;RS&quot;,&quot;Rio Grande do Sul&quot;,
&quot;RO&quot;,&quot;Rondônia&quot;,
&quot;RR&quot;,&quot;Roraima&quot;,
&quot;SC&quot;,&quot;Santa Catarina&quot;,
&quot;SP&quot;,&quot;São Paulo&quot;,
&quot;SE&quot;,&quot;Sergipe&quot;,
&quot;TO&quot;,&quot;Tocantins&quot;,
&quot;DF&quot;,&quot;Distrito Federal&quot;,
&quot;&quot;
)</formula>
        <name>ACC BR MAJ DPT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_BR_MAJ_REG</fullName>
        <field>Region__c</field>
        <formula>Case(UPPER(BillingState),
&quot;DF&quot;,&quot;Centro-oeste&quot;,
&quot;GO&quot;,&quot;Centro-oeste&quot;,
&quot;MT&quot;,&quot;Centro-oeste&quot;,
&quot;MS&quot;,&quot;Centro-oeste&quot;,
&quot;AL&quot;,&quot;Nordeste&quot;,
&quot;BA&quot;,&quot;Nordeste&quot;,
&quot;CE&quot;,&quot;Nordeste&quot;,
&quot;MA&quot;,&quot;Nordeste&quot;,
&quot;PB&quot;,&quot;Nordeste&quot;,
&quot;PE&quot;,&quot;Nordeste&quot;,
&quot;PI&quot;,&quot;Nordeste&quot;,
&quot;RN&quot;,&quot;Nordeste&quot;,
&quot;SE&quot;,&quot;Nordeste&quot;,
&quot;AC&quot;,&quot;Norte&quot;,
&quot;AP&quot;,&quot;Norte&quot;,
&quot;AM&quot;,&quot;Norte&quot;,
&quot;PA&quot;,&quot;Norte&quot;,
&quot;RO&quot;,&quot;Norte&quot;,
&quot;RR&quot;,&quot;Norte&quot;,
&quot;TO&quot;,&quot;Norte&quot;,
&quot;ES&quot;,&quot;Sudeste&quot;,
&quot;MG&quot;,&quot;Sudeste&quot;,
&quot;RJ&quot;,&quot;Sudeste&quot;,
&quot;SP&quot;,&quot;Sudeste&quot;,
&quot;PR&quot;,&quot;Sul&quot;,
&quot;RS&quot;,&quot;Sul&quot;,
&quot;SC&quot;,&quot;Sul&quot;,
&quot;&quot;
)</formula>
        <name>ACC BR MAJ REG</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_BR_MAJ_REG_COM</fullName>
        <description>Mise a jour du champ région commerciale en fonction de l&apos;état de facturation</description>
        <field>R_gion_commerciale__c</field>
        <formula>CASE(UPPER(BillingState),
&quot;DF&quot;,&quot;Outros&quot;,
&quot;GO&quot;,&quot;Outros&quot;,
&quot;MT&quot;,&quot;Outros&quot;,
&quot;MS&quot;,&quot;Outros&quot;,
&quot;AL&quot;,&quot;Outros&quot;,
&quot;BA&quot;,&quot;Outros&quot;,
&quot;CE&quot;,&quot;Outros&quot;,
&quot;MA&quot;,&quot;Outros&quot;,
&quot;PB&quot;,&quot;Outros&quot;,
&quot;PE&quot;,&quot;Outros&quot;,
&quot;PI&quot;,&quot;Outros&quot;,
&quot;RN&quot;,&quot;Outros&quot;,
&quot;SE&quot;,&quot;Outros&quot;,
&quot;AC&quot;,&quot;Outros&quot;,
&quot;AP&quot;,&quot;Outros&quot;,
&quot;AM&quot;,&quot;Outros&quot;,
&quot;PA&quot;,&quot;Outros&quot;,
&quot;RO&quot;,&quot;Outros&quot;,
&quot;RR&quot;,&quot;Outros&quot;,
&quot;TO&quot;,&quot;Outros&quot;,
&quot;ES&quot;,&quot;Outros&quot;,
&quot;MG&quot;,&quot;Outros&quot;,
&quot;RJ&quot;,&quot;Rio de Janeiro&quot;,
&quot;SP&quot;,&quot;São Paulo&quot;,
&quot;PR&quot;,&quot;Outros&quot;,
&quot;RS&quot;,&quot;Porto Alegre&quot;,
&quot;SC&quot;,&quot;Outros&quot;,
&quot;&quot;
)</formula>
        <name>ACC BR MAJ REG COM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_CA_MAJ_DPT</fullName>
        <field>Departement__c</field>
        <formula>CASE( CA_Num_D_partement__c ,
&quot;1&quot;,&quot;Bas-Saint-Laurent&quot;,
&quot;2&quot;,&quot;Saguenay-Lac-Saint-Jean&quot;,
&quot;3&quot;,&quot;Région de Québec&quot;,
&quot;4&quot;,&quot;Mauricie&quot;,
&quot;5&quot;,&quot;Estrie&quot;,
&quot;6&quot;,&quot;Montréal&quot;,
&quot;7&quot;,&quot;Outaouais&quot;,
&quot;8&quot;,&quot;Abitibi-Témiscamingue&quot;,
&quot;9&quot;,&quot;Côte-Nord&quot;,
&quot;10&quot;,&quot;Nord-du-Québec&quot;,
&quot;11&quot;,&quot;Gaspésie-Îles-de-la-Madeleine&quot;,
&quot;12&quot;,&quot;Chaudière-Appalaches&quot;,
&quot;13&quot;,&quot;Laval&quot;,
&quot;14&quot;,&quot;Lanaudière&quot;,
&quot;15&quot;,&quot;Laurentides&quot;,
&quot;16&quot;,&quot;Montérégie&quot;,
&quot;17&quot;,&quot;Centre-du-Québec&quot;,
&quot;18&quot;,&quot;Ontario&quot;,
&quot;19&quot;,&quot;Maritimes&quot;,
&quot;20&quot;,&quot;Ouest du Canada&quot;,
&quot;&quot;)</formula>
        <name>ACC_CA_MAJ_DPT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_CA_MAJ_NUM_DPT</fullName>
        <field>CA_Num_D_partement__c</field>
        <formula>CASE(LEFT(BillingPostalCode,1), 
&quot;A&quot;,&quot;20&quot;, 
&quot;B&quot;,&quot;19&quot;, 
&quot;C&quot;,&quot;19&quot;, 
&quot;E&quot;,&quot;19&quot;, 
&quot;K&quot;,&quot;18&quot;, 
&quot;L&quot;,&quot;18&quot;, 
&quot;M&quot;,&quot;18&quot;, 
&quot;N&quot;,&quot;18&quot;, 
&quot;P&quot;,&quot;18&quot;, 
&quot;R&quot;,&quot;20&quot;, 
&quot;S&quot;,&quot;20&quot;, 
&quot;T&quot;,&quot;20&quot;, 
&quot;V&quot;,&quot;20&quot;, 
&quot;X&quot;,&quot;20&quot;, 
&quot;Y&quot;,&quot;20&quot;, 
CASE(LEFT(BillingPostalCode,2), 
&quot;H0&quot;,&quot;16&quot;, 
&quot;H1&quot;,&quot;6&quot;, 
&quot;H2&quot;,&quot;6&quot;, 
&quot;H3&quot;,&quot;6&quot;, 
&quot;H4&quot;,&quot;6&quot;, 
&quot;H5&quot;,&quot;6&quot;, 
&quot;H7&quot;,&quot;13&quot;, 
&quot;H8&quot;,&quot;6&quot;, 
&quot;H9&quot;,&quot;6&quot;, 
&quot;G1&quot;,&quot;3&quot;, 
&quot;G2&quot;,&quot;3&quot;, 
&quot;G3&quot;,&quot;3&quot;, 
&quot;J4&quot;,&quot;16&quot;, 
CASE(LEFT(BillingPostalCode,3), 
&quot;G0A&quot;,&quot;3&quot;, 
&quot;G0B&quot;,&quot;11&quot;, 
&quot;G0C&quot;,&quot;11&quot;, 
&quot;G0E&quot;,&quot;11&quot;, 
&quot;G0G&quot;,&quot;9&quot;, 
&quot;G0H&quot;,&quot;9&quot;, 
&quot;G0J&quot;,&quot;1&quot;, 
&quot;G0K&quot;,&quot;1&quot;, 
&quot;G0L&quot;,&quot;1&quot;, 
&quot;G0M&quot;,&quot;12&quot;, 
&quot;G0N&quot;,&quot;12&quot;, 
&quot;G0P&quot;,&quot;17&quot;, 
&quot;G0R&quot;,&quot;12&quot;, 
&quot;G0S&quot;,&quot;12&quot;, 
&quot;G0T&quot;,&quot;9&quot;, 
&quot;G0V&quot;,&quot;2&quot;, 
&quot;G0W&quot;,&quot;2&quot;, 
&quot;G0X&quot;,&quot;4&quot;, 
&quot;G0Y&quot;,&quot;12&quot;, 
&quot;G0Z&quot;,&quot;17&quot;, 
&quot;G4A&quot;,&quot;3&quot;, 
&quot;G4R&quot;,&quot;9&quot;, 
&quot;G4S&quot;,&quot;9&quot;, 
&quot;G4V&quot;,&quot;9&quot;, 
&quot;G4W&quot;,&quot;1&quot;, 
&quot;G4X&quot;,&quot;11&quot;, 
&quot;G4Z&quot;,&quot;9&quot;, 
&quot;G5A&quot;,&quot;1&quot;, 
&quot;G5B&quot;,&quot;9&quot;, 
&quot;G5C&quot;,&quot;9&quot;, 
&quot;G5H&quot;,&quot;1&quot;, 
&quot;G5J&quot;,&quot;1&quot;, 
&quot;G5L&quot;,&quot;1&quot;, 
&quot;G5M&quot;,&quot;1&quot;, 
&quot;G5N&quot;,&quot;1&quot;, 
&quot;G5R&quot;,&quot;1&quot;, 
&quot;G5T&quot;,&quot;1&quot;, 
&quot;G5V&quot;,&quot;12&quot;, 
&quot;G5X&quot;,&quot;12&quot;, 
&quot;G5Y&quot;,&quot;12&quot;, 
&quot;G5Z&quot;,&quot;12&quot;, 
&quot;G6A&quot;,&quot;12&quot;, 
&quot;G6B&quot;,&quot;12&quot;, 
&quot;G6C&quot;,&quot;12&quot;, 
&quot;G6E&quot;,&quot;12&quot;, 
&quot;G6G&quot;,&quot;12&quot;, 
&quot;G6H&quot;,&quot;12&quot;, 
&quot;G6J&quot;,&quot;12&quot;, 
&quot;G6K&quot;,&quot;12&quot;, 
&quot;G6L&quot;,&quot;12&quot;, 
&quot;G6P&quot;,&quot;17&quot;, 
&quot;G6R&quot;,&quot;17&quot;, 
&quot;G6S&quot;,&quot;17&quot;, 
&quot;G6T&quot;,&quot;17&quot;, 
&quot;G6V&quot;,&quot;12&quot;, 
&quot;G6W&quot;,&quot;12&quot;, 
&quot;G6X&quot;,&quot;12&quot;, 
&quot;G6Z&quot;,&quot;12&quot;, 
&quot;G7A&quot;,&quot;12&quot;, 
&quot;G7B&quot;,&quot;2&quot;, 
&quot;G7G&quot;,&quot;2&quot;, 
&quot;G7H&quot;,&quot;2&quot;, 
&quot;G7J&quot;,&quot;2&quot;, 
&quot;G7K&quot;,&quot;2&quot;, 
&quot;G7N&quot;,&quot;2&quot;, 
&quot;G7P&quot;,&quot;2&quot;, 
&quot;G7S&quot;,&quot;2&quot;, 
&quot;G7T&quot;,&quot;2&quot;, 
&quot;G7X&quot;,&quot;2&quot;, 
&quot;G7Y&quot;,&quot;2&quot;, 
&quot;G7Z&quot;,&quot;2&quot;, 
&quot;G8A&quot;,&quot;2&quot;, 
&quot;G8B&quot;,&quot;2&quot;, 
&quot;G8C&quot;,&quot;2&quot;, 
&quot;G8E&quot;,&quot;2&quot;, 
&quot;G8G&quot;,&quot;2&quot;, 
&quot;G8H&quot;,&quot;2&quot;, 
&quot;G8J&quot;,&quot;2&quot;, 
&quot;G8K&quot;,&quot;2&quot;, 
&quot;G8L&quot;,&quot;2&quot;, 
&quot;G8M&quot;,&quot;2&quot;, 
&quot;G8N&quot;,&quot;2&quot;, 
&quot;G8P&quot;,&quot;2&quot;, 
&quot;G8T&quot;,&quot;4&quot;, 
&quot;G8V&quot;,&quot;4&quot;, 
&quot;G8W&quot;,&quot;4&quot;, 
&quot;G8Y&quot;,&quot;4&quot;, 
&quot;G8Z&quot;,&quot;4&quot;, 
&quot;G9A&quot;,&quot;4&quot;, 
&quot;G9B&quot;,&quot;4&quot;, 
&quot;G9C&quot;,&quot;4&quot;, 
&quot;G9H&quot;,&quot;17&quot;, 
&quot;G9N&quot;,&quot;4&quot;, 
&quot;G9P&quot;,&quot;4&quot;, 
&quot;G9R&quot;,&quot;4&quot;, 
&quot;G9T&quot;,&quot;4&quot;, 
&quot;G9X&quot;,&quot;4&quot;, 
&quot;J0A&quot;,&quot;5&quot;, 
&quot;J0B&quot;,&quot;5&quot;, 
&quot;J0C&quot;,&quot;17&quot;, 
&quot;J0E&quot;,&quot;5&quot;, 
&quot;J0G&quot;,&quot;17&quot;, 
&quot;J0H&quot;,&quot;5&quot;, 
&quot;J0J&quot;,&quot;16&quot;, 
&quot;J0K&quot;,&quot;14&quot;, 
&quot;J0L&quot;,&quot;16&quot;, 
&quot;J0M&quot;,&quot;10&quot;, 
&quot;J0N&quot;,&quot;15&quot;, 
&quot;J0P&quot;,&quot;7&quot;, 
&quot;J0R&quot;,&quot;15&quot;, 
&quot;J0S&quot;,&quot;16&quot;, 
&quot;J0T&quot;,&quot;15&quot;, 
&quot;J0V&quot;,&quot;7&quot;, 
&quot;J0W&quot;,&quot;15&quot;, 
&quot;J0X&quot;,&quot;7&quot;, 
&quot;J0Y&quot;,&quot;8&quot;, 
&quot;J0Z&quot;,&quot;8&quot;, 
&quot;J1A&quot;,&quot;5&quot;, 
&quot;J1C&quot;,&quot;5&quot;, 
&quot;J1E&quot;,&quot;5&quot;, 
&quot;J1G&quot;,&quot;5&quot;, 
&quot;J1H&quot;,&quot;5&quot;, 
&quot;J1J&quot;,&quot;5&quot;, 
&quot;J1K&quot;,&quot;5&quot;, 
&quot;J1L&quot;,&quot;5&quot;, 
&quot;J1M&quot;,&quot;5&quot;, 
&quot;J1N&quot;,&quot;5&quot;, 
&quot;J1S&quot;,&quot;5&quot;, 
&quot;J1T&quot;,&quot;5&quot;, 
&quot;J1X&quot;,&quot;5&quot;, 
&quot;J1Z&quot;,&quot;17&quot;, 
&quot;J2A&quot;,&quot;17&quot;, 
&quot;J2B&quot;,&quot;17&quot;, 
&quot;J2C&quot;,&quot;17&quot;, 
&quot;J2E&quot;,&quot;17&quot;, 
&quot;J2G&quot;,&quot;5&quot;, 
&quot;J2H&quot;,&quot;5&quot;, 
&quot;J2J&quot;,&quot;5&quot;, 
&quot;J2K&quot;,&quot;5&quot;, 
&quot;J2L&quot;,&quot;5&quot;, 
&quot;J2N&quot;,&quot;16&quot;, 
&quot;J2R&quot;,&quot;16&quot;, 
&quot;J2S&quot;,&quot;16&quot;, 
&quot;J2T&quot;,&quot;16&quot;, 
&quot;J2W&quot;,&quot;16&quot;, 
&quot;J2X&quot;,&quot;16&quot;, 
&quot;J2Y&quot;,&quot;16&quot;, 
&quot;J3A&quot;,&quot;16&quot;, 
&quot;J3B&quot;,&quot;16&quot;, 
&quot;J3E&quot;,&quot;16&quot;, 
&quot;J3G&quot;,&quot;16&quot;, 
&quot;J3H&quot;,&quot;16&quot;, 
&quot;J3L&quot;,&quot;16&quot;, 
&quot;J3M&quot;,&quot;16&quot;, 
&quot;J3N&quot;,&quot;16&quot;, 
&quot;J3P&quot;,&quot;17&quot;, 
&quot;J3R&quot;,&quot;17&quot;, 
&quot;J3T&quot;,&quot;17&quot;, 
&quot;J3V&quot;,&quot;16&quot;, 
&quot;J3X&quot;,&quot;16&quot;, 
&quot;J3Y&quot;,&quot;16&quot;, 
&quot;J3Z&quot;,&quot;16&quot;, 
&quot;J5A&quot;,&quot;16&quot;, 
&quot;J5B&quot;,&quot;16&quot;, 
&quot;J5J&quot;,&quot;16&quot;, 
&quot;J5K&quot;,&quot;16&quot;, 
&quot;J5L&quot;,&quot;16&quot;, 
&quot;J5R&quot;,&quot;16&quot;, 
&quot;J5V&quot;,&quot;14&quot;, 
&quot;J5W&quot;,&quot;14&quot;, 
&quot;J5X&quot;,&quot;14&quot;, 
&quot;J5Y&quot;,&quot;14&quot;, 
&quot;J5Z&quot;,&quot;14&quot;, 
&quot;J6A&quot;,&quot;14&quot;, 
&quot;J6E&quot;,&quot;14&quot;, 
&quot;J6J&quot;,&quot;16&quot;, 
&quot;J6K&quot;,&quot;16&quot;, 
&quot;J6N&quot;,&quot;16&quot;, 
&quot;J6R&quot;,&quot;16&quot;, 
&quot;J6S&quot;,&quot;7&quot;, 
&quot;J6T&quot;,&quot;7&quot;, 
&quot;J6V&quot;,&quot;15&quot;, 
&quot;J6W&quot;,&quot;15&quot;, 
&quot;J6X&quot;,&quot;15&quot;, 
&quot;J6Y&quot;,&quot;15&quot;, 
&quot;J6Z&quot;,&quot;15&quot;, 
&quot;J7A&quot;,&quot;15&quot;, 
&quot;J7B&quot;,&quot;15&quot;, 
&quot;J7C&quot;,&quot;15&quot;, 
&quot;J7E&quot;,&quot;15&quot;, 
&quot;J7G&quot;,&quot;15&quot;, 
&quot;J7H&quot;,&quot;15&quot;, 
&quot;J7J&quot;,&quot;15&quot;, 
&quot;J7K&quot;,&quot;15&quot;, 
&quot;J7L&quot;,&quot;15&quot;, 
&quot;J7M&quot;,&quot;15&quot;, 
&quot;J7N&quot;,&quot;15&quot;, 
&quot;J7P&quot;,&quot;15&quot;, 
&quot;J7R&quot;,&quot;15&quot;, 
&quot;J7T&quot;,&quot;7&quot;, 
&quot;J7V&quot;,&quot;7&quot;, 
&quot;J7X&quot;,&quot;7&quot;, 
&quot;J7Y&quot;,&quot;15&quot;, 
&quot;J7Z&quot;,&quot;15&quot;, 
&quot;J8A&quot;,&quot;15&quot;, 
&quot;J8B&quot;,&quot;15&quot;, 
&quot;J8C&quot;,&quot;15&quot;, 
&quot;J8E&quot;,&quot;15&quot;, 
&quot;J8G&quot;,&quot;7&quot;, 
&quot;J8H&quot;,&quot;7&quot;, 
&quot;J8L&quot;,&quot;7&quot;, 
&quot;J8M&quot;,&quot;7&quot;, 
&quot;J8N&quot;,&quot;7&quot;, 
&quot;J8P&quot;,&quot;7&quot;, 
&quot;J8R&quot;,&quot;7&quot;, 
&quot;J8T&quot;,&quot;7&quot;, 
&quot;J8V&quot;,&quot;7&quot;, 
&quot;J8X&quot;,&quot;7&quot;, 
&quot;J8Y&quot;,&quot;7&quot;, 
&quot;J8Z&quot;,&quot;7&quot;, 
&quot;J9A&quot;,&quot;7&quot;, 
&quot;J9B&quot;,&quot;7&quot;, 
&quot;J9E&quot;,&quot;15&quot;, 
&quot;J9H&quot;,&quot;7&quot;, 
&quot;J9J&quot;,&quot;7&quot;, 
&quot;J9L&quot;,&quot;15&quot;, 
&quot;J9P&quot;,&quot;8&quot;, 
&quot;J9T&quot;,&quot;8&quot;, 
&quot;J9X&quot;,&quot;8&quot;, 
&quot;J9Y&quot;,&quot;8&quot;, 
&quot;J9Z&quot;,&quot;8&quot;, 
&quot;&quot; 
) 
) 
)</formula>
        <name>ACC_CA_MAJ_NUM_DPT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_CA_MAJ_REG</fullName>
        <field>Region__c</field>
        <formula>CASE(LEFT(BillingPostalCode,1),
&quot;A&quot;,&quot;Terre-Neuve-et-Labrador&quot;,
&quot;B&quot;,&quot;Nouvelle-Ecosse&quot;,
&quot;C&quot;,&quot;Ile-du-Prince-Edouard&quot;,
&quot;E&quot;,&quot;Nouveau-Brunswick&quot;,
&quot;G&quot;,&quot;Québec&quot;,
&quot;H&quot;,&quot;Québec&quot;,
&quot;J&quot;,&quot;Québec&quot;,
&quot;K&quot;,&quot;Ontario&quot;,
&quot;L&quot;,&quot;Ontario&quot;,
&quot;M&quot;,&quot;Ontario&quot;,
&quot;N&quot;,&quot;Ontario&quot;,
&quot;P&quot;,&quot;Ontario&quot;,
&quot;R&quot;,&quot;Manitoba&quot;,
&quot;S&quot;,&quot;Saskatchewan&quot;,
&quot;T&quot;,&quot;Alberta&quot;,
&quot;V&quot;,&quot;Colombie Britannique&quot;,
CASE(LEFT(BillingPostalCode,3),
&quot;X0A&quot;,&quot;Nunavut&quot;,
&quot;X0B&quot;,&quot;Nunavut&quot;,
&quot;X0C&quot;,&quot;Nunavut&quot;,
&quot;X0E&quot;,&quot;Territoires du Nord-Ouest&quot;,
&quot;X0G&quot;,&quot;Territoires du Nord-Ouest&quot;,
&quot;X1A&quot;,&quot;Territoires du Nord-Ouest&quot;,
&quot;&quot;
)
)</formula>
        <name>ACC_CA_MAJ_REG</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_CA_MAJ_REG_COM</fullName>
        <field>R_gion_commerciale__c</field>
        <formula>CASE(LEFT(BillingPostalCode,1),
&quot;A&quot;,&quot;Non couverte&quot;,
&quot;B&quot;,&quot;Non couverte&quot;,
&quot;C&quot;,&quot;Non couverte&quot;,
&quot;E&quot;,&quot;Non couverte&quot;,
&quot;H&quot;,&quot;Montréal&quot;,
&quot;K&quot;,&quot;Montréal&quot;,
&quot;L&quot;,&quot;Montréal&quot;,
&quot;M&quot;,&quot;Montréal&quot;,
&quot;N&quot;,&quot;Montréal&quot;,
&quot;P&quot;,&quot;Montréal&quot;,
&quot;R&quot;,&quot;Non couverte&quot;,
&quot;S&quot;,&quot;Non couverte&quot;,
&quot;T&quot;,&quot;Non couverte&quot;,
&quot;V&quot;,&quot;Non couverte&quot;,
&quot;X&quot;,&quot;Non couverte&quot;,
&quot;Y&quot;,&quot;Non couverte&quot;,
CASE(LEFT(BillingPostalCode,2),
&quot;G1&quot;,&quot;Québec&quot;,
&quot;G2&quot;,&quot;Québec&quot;,
&quot;G3&quot;,&quot;Québec&quot;,
&quot;G7&quot;,&quot;Québec&quot;,
&quot;G8&quot;,&quot;Québec&quot;,
&quot;J1&quot;,&quot;Centre Québec&quot;,
&quot;J4&quot;,&quot;Montréal&quot;,
&quot;J5&quot;,&quot;Montréal&quot;,
&quot;J6&quot;,&quot;Montréal&quot;,
&quot;J7&quot;,&quot;Montréal&quot;,
&quot;J8&quot;,&quot;Montréal&quot;,
CASE(LEFT(BillingPostalCode,3),
&quot;G0A&quot;,&quot;Québec&quot;,
&quot;G0B&quot;,&quot;Non couverte&quot;,
&quot;G0C&quot;,&quot;Non couverte&quot;,
&quot;G0E&quot;,&quot;Non couverte&quot;,
&quot;G0G&quot;,&quot;Non couverte&quot;,
&quot;G0H&quot;,&quot;Non couverte&quot;,
&quot;G0J&quot;,&quot;Non couverte&quot;,
&quot;G0K&quot;,&quot;Non couverte&quot;,
&quot;G0L&quot;,&quot;Non couverte&quot;,
&quot;G0M&quot;,&quot;Québec&quot;,
&quot;G0N&quot;,&quot;Québec&quot;,
&quot;G0P&quot;,&quot;Centre Québec&quot;,
&quot;G0R&quot;,&quot;Québec&quot;,
&quot;G0S&quot;,&quot;Québec&quot;,
&quot;G0T&quot;,&quot;Non couverte&quot;,
&quot;G0V&quot;,&quot;Québec&quot;,
&quot;G0W&quot;,&quot;Québec&quot;,
&quot;G0X&quot;,&quot;Québec&quot;,
&quot;G0Y&quot;,&quot;Québec&quot;,
&quot;G0Z&quot;,&quot;Centre Québec&quot;,
&quot;G4A&quot;,&quot;Québec&quot;,
&quot;G4R&quot;,&quot;Non couverte&quot;,
&quot;G4S&quot;,&quot;Non couverte&quot;,
&quot;G4V&quot;,&quot;Non couverte&quot;,
&quot;G4W&quot;,&quot;Non couverte&quot;,
&quot;G4X&quot;,&quot;Non couverte&quot;,
&quot;G4Z&quot;,&quot;Non couverte&quot;,
&quot;G5A&quot;,&quot;Non couverte&quot;,
&quot;G5B&quot;,&quot;Non couverte&quot;,
&quot;G5C&quot;,&quot;Non couverte&quot;,
&quot;G5H&quot;,&quot;Non couverte&quot;,
&quot;G5J&quot;,&quot;Non couverte&quot;,
&quot;G5L&quot;,&quot;Non couverte&quot;,
&quot;G5M&quot;,&quot;Non couverte&quot;,
&quot;G5N&quot;,&quot;Non couverte&quot;,
&quot;G5R&quot;,&quot;Non couverte&quot;,
&quot;G5T&quot;,&quot;Non couverte&quot;,
&quot;G5V&quot;,&quot;Québec&quot;,
&quot;G5X&quot;,&quot;Québec&quot;,
&quot;G5Y&quot;,&quot;Québec&quot;,
&quot;G5Z&quot;,&quot;Québec&quot;,
&quot;G6A&quot;,&quot;Québec&quot;,
&quot;G6B&quot;,&quot;Québec&quot;,
&quot;G6C&quot;,&quot;Québec&quot;,
&quot;G6E&quot;,&quot;Québec&quot;,
&quot;G6G&quot;,&quot;Québec&quot;,
&quot;G6H&quot;,&quot;Québec&quot;,
&quot;G6J&quot;,&quot;Québec&quot;,
&quot;G6K&quot;,&quot;Québec&quot;,
&quot;G6L&quot;,&quot;Québec&quot;,
&quot;G6P&quot;,&quot;Centre Québec&quot;,
&quot;G6R&quot;,&quot;Centre Québec&quot;,
&quot;G6S&quot;,&quot;Centre Québec&quot;,
&quot;G6T&quot;,&quot;Centre Québec&quot;,
&quot;G6V&quot;,&quot;Québec&quot;,
&quot;G6W&quot;,&quot;Québec&quot;,
&quot;G6X&quot;,&quot;Québec&quot;,
&quot;G6Z&quot;,&quot;Québec&quot;,
&quot;G9A&quot;,&quot;Québec&quot;,
&quot;G9B&quot;,&quot;Québec&quot;,
&quot;G9C&quot;,&quot;Québec&quot;,
&quot;G9H&quot;,&quot;Centre Québec&quot;,
&quot;G9N&quot;,&quot;Québec&quot;,
&quot;G9P&quot;,&quot;Québec&quot;,
&quot;G9R&quot;,&quot;Québec&quot;,
&quot;G9T&quot;,&quot;Québec&quot;,
&quot;G9X&quot;,&quot;Québec&quot;,
&quot;J0A&quot;,&quot;Centre Québec&quot;,
&quot;J0B&quot;,&quot;Centre Québec&quot;,
&quot;J0C&quot;,&quot;Centre Québec&quot;,
&quot;J0E&quot;,&quot;Centre Québec&quot;,
&quot;J0G&quot;,&quot;Centre Québec&quot;,
&quot;J0H&quot;,&quot;Centre Québec&quot;,
&quot;J0J&quot;,&quot;Montréal&quot;,
&quot;J0K&quot;,&quot;Montréal&quot;,
&quot;J0L&quot;,&quot;Montréal&quot;,
&quot;J0M&quot;,&quot;Non couverte&quot;,
&quot;J0N&quot;,&quot;Montréal&quot;,
&quot;J0P&quot;,&quot;Montréal&quot;,
&quot;J0R&quot;,&quot;Montréal&quot;,
&quot;J0S&quot;,&quot;Montréal&quot;,
&quot;J0T&quot;,&quot;Montréal&quot;,
&quot;J0V&quot;,&quot;Montréal&quot;,
&quot;J0W&quot;,&quot;Montréal&quot;,
&quot;J0X&quot;,&quot;Montréal&quot;,
&quot;J0Y&quot;,&quot;Non couverte&quot;,
&quot;J0Z&quot;,&quot;Non couverte&quot;,
&quot;J2A&quot;,&quot;Centre Québec&quot;,
&quot;J2B&quot;,&quot;Centre Québec&quot;,
&quot;J2C&quot;,&quot;Centre Québec&quot;,
&quot;J2E&quot;,&quot;Centre Québec&quot;,
&quot;J2G&quot;,&quot;Centre Québec&quot;,
&quot;J2H&quot;,&quot;Centre Québec&quot;,
&quot;J2J&quot;,&quot;Centre Québec&quot;,
&quot;J2K&quot;,&quot;Centre Québec&quot;,
&quot;J2L&quot;,&quot;Centre Québec&quot;,
&quot;J2N&quot;,&quot;Montréal&quot;,
&quot;J2R&quot;,&quot;Montréal&quot;,
&quot;J2S&quot;,&quot;Montréal&quot;,
&quot;J2T&quot;,&quot;Montréal&quot;,
&quot;J2W&quot;,&quot;Montréal&quot;,
&quot;J2X&quot;,&quot;Montréal&quot;,
&quot;J2Y&quot;,&quot;Montréal&quot;,
&quot;J3A&quot;,&quot;Montréal&quot;,
&quot;J3B&quot;,&quot;Montréal&quot;,
&quot;J3E&quot;,&quot;Montréal&quot;,
&quot;J3G&quot;,&quot;Montréal&quot;,
&quot;J3H&quot;,&quot;Montréal&quot;,
&quot;J3L&quot;,&quot;Montréal&quot;,
&quot;J3M&quot;,&quot;Montréal&quot;,
&quot;J3N&quot;,&quot;Montréal&quot;,
&quot;J3P&quot;,&quot;Centre Québec&quot;,
&quot;J3R&quot;,&quot;Centre Québec&quot;,
&quot;J3T&quot;,&quot;Centre Québec&quot;,
&quot;J3V&quot;,&quot;Montréal&quot;,
&quot;J3X&quot;,&quot;Montréal&quot;,
&quot;J3Y&quot;,&quot;Montréal&quot;,
&quot;J3Z&quot;,&quot;Montréal&quot;,
&quot;J9A&quot;,&quot;Montréal&quot;,
&quot;J9B&quot;,&quot;Montréal&quot;,
&quot;J9E&quot;,&quot;Montréal&quot;,
&quot;J9H&quot;,&quot;Montréal&quot;,
&quot;J9J&quot;,&quot;Montréal&quot;,
&quot;J9L&quot;,&quot;Montréal&quot;,
&quot;J9P&quot;,&quot;Non couverte&quot;,
&quot;J9T&quot;,&quot;Non couverte&quot;,
&quot;J9X&quot;,&quot;Non couverte&quot;,
&quot;J9Y&quot;,&quot;Non couverte&quot;,
&quot;J9Z&quot;,&quot;Non couverte&quot;,
&quot;&quot;)))</formula>
        <name>ACC CA MAJ REG COM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_FR_MAJ_DPT</fullName>
        <field>Departement__c</field>
        <formula>CASE( LEFT(BillingPostalCode,2),&quot;01&quot;,
&quot;Ain&quot;,
&quot;02&quot;,
&quot;Aisne&quot;,
&quot;03&quot;,
&quot;Allier&quot;,
&quot;04&quot;,
&quot;Alpes de haute provence&quot;,
&quot;05&quot;,
&quot;Hautes-Alpes&quot;,
&quot;06&quot;,
&quot;Alpes-Maritimes&quot;,
&quot;07&quot;,
&quot;Ardèche&quot;,
&quot;08&quot;,
&quot;Ardennes&quot;,
&quot;09&quot;,
&quot;Ariège&quot;,
&quot;10&quot;,
&quot;Aube&quot;,
&quot;11&quot;,
&quot;Aude&quot;,
&quot;12&quot;,
&quot;Aveyron&quot;,
&quot;13&quot;,
&quot;Bouches-du-Rhône&quot;,
&quot;14&quot;,
&quot;Calvados&quot;,
&quot;15&quot;,
&quot;Cantal&quot;,
&quot;16&quot;,
&quot;Charente&quot;,
&quot;17&quot;,
&quot;Charente-Maritime&quot;,
&quot;18&quot;,
&quot;Cher&quot;,
&quot;19&quot;,
&quot;Corrèze&quot;,
&quot;2A&quot;,
&quot;Corse-du-Sud&quot;,
&quot;2B&quot;,
&quot;Haute-Corse&quot;,
&quot;20&quot;,
&quot;Corse&quot;,
&quot;21&quot;,
&quot;Côte-d&apos;Or&quot;,
&quot;22&quot;,
&quot;Côte-d&apos;Armor&quot;,
&quot;23&quot;,
&quot;Creuse&quot;,
&quot;24&quot;,
&quot;Dordogne&quot;,
&quot;25&quot;,
&quot;Doubs&quot;,
&quot;26&quot;,
&quot;Drôme&quot;,
&quot;27&quot;,
&quot;Eure&quot;,
&quot;28&quot;,
&quot;Eure-et-Loir&quot;,
&quot;29&quot;,
&quot;Finistère&quot;,
&quot;30&quot;,
&quot;Gard&quot;,
&quot;31&quot;,
&quot;Haute-Garonne&quot;,
&quot;32&quot;,
&quot;Gers&quot;,
&quot;33&quot;,
&quot;Gironde&quot;,
&quot;34&quot;,
&quot;Hérault&quot;,
&quot;35&quot;,
&quot;Ille-et-Vilaine&quot;,
&quot;36&quot;,
&quot;Indre&quot;,
&quot;37&quot;,
&quot;Indre-et-Loire&quot;,
&quot;38&quot;,
&quot;Isère&quot;,
&quot;39&quot;,
&quot;Jura&quot;,
&quot;40&quot;,
&quot;Landes&quot;,
&quot;41&quot;,
&quot;Loir-et-Cher&quot;,
&quot;42&quot;,
&quot;Loire&quot;,
&quot;43&quot;,
&quot;Haute-Loire&quot;,
&quot;44&quot;,
&quot;Loire-Atlantique&quot;,
&quot;45&quot;,
&quot;Loiret&quot;,
&quot;46&quot;,
&quot;Lot&quot;,
&quot;47&quot;,
&quot;Lot-et-Garonne&quot;,
&quot;48&quot;,
&quot;Lozère&quot;,
&quot;49&quot;,
&quot;Maine-et-Loire&quot;,
&quot;50&quot;,
&quot;Manche&quot;,
&quot;51&quot;,
&quot;Marne&quot;,
&quot;52&quot;,
&quot;Haute-Marne&quot;,
&quot;53&quot;,
&quot;Mayenne&quot;,
&quot;54&quot;,
&quot;Meurthe-et-Moselle&quot;,
&quot;55&quot;,
&quot;Meuse&quot;,
&quot;56&quot;,
&quot;Morbihan&quot;,
&quot;57&quot;,
&quot;Moselle&quot;,
&quot;58&quot;,
&quot;Nièvre&quot;,
&quot;59&quot;,
&quot;Nord&quot;,
&quot;60&quot;,
&quot;Oise&quot;,
&quot;61&quot;,
&quot;Orne&quot;,
&quot;62&quot;,
&quot;Pas-de-Calais&quot;,
&quot;63&quot;,
&quot;Puy-de-Dôme&quot;,
&quot;64&quot;,
&quot;Pyrénées-Atlantiques&quot;,
&quot;65&quot;,
&quot;Hautes-Pyrénées&quot;,
&quot;66&quot;,
&quot;Pyrénées-Orientales&quot;,
&quot;67&quot;,
&quot;Bas-Rhin&quot;,
&quot;68&quot;,
&quot;Haut-Rhin&quot;,
&quot;69&quot;,
&quot;Rhône&quot;,
&quot;70&quot;,
&quot;Haute-Saône&quot;,
&quot;71&quot;,
&quot;Saône-et-Loire&quot;,
&quot;72&quot;,
&quot;Sarthe&quot;,
&quot;73&quot;,
&quot;Savoie&quot;,
&quot;74&quot;,
&quot;Haute-Savoie&quot;,
&quot;75&quot;,
&quot;Paris&quot;,
&quot;76&quot;,
&quot;Seine-Maritime&quot;,
&quot;77&quot;,
&quot;Seine-et-Marne&quot;,
&quot;78&quot;,
&quot;Yvelines&quot;,
&quot;79&quot;,
&quot;Deux-Sèvres&quot;,
&quot;80&quot;,
&quot;Somme&quot;,
&quot;81&quot;,
&quot;Tarn&quot;,
&quot;82&quot;,
&quot;Tarn-et-Garonne&quot;,
&quot;83&quot;,
&quot;Var&quot;,
&quot;84&quot;,
&quot;Vaucluse&quot;,
&quot;85&quot;,
&quot;Vendée&quot;,
&quot;86&quot;,
&quot;Vienne&quot;,
&quot;87&quot;,
&quot;Haute-Vienne&quot;,
&quot;88&quot;,
&quot;Vosges&quot;,
&quot;89&quot;,
&quot;Yonne&quot;,
&quot;90&quot;,
&quot;Territoire de Belfort&quot;,
&quot;91&quot;,
&quot;Essonne&quot;,
&quot;92&quot;,
&quot;Hauts-de-Seine&quot;,
&quot;93&quot;,
&quot;Seine-St-Denis&quot;,
&quot;94&quot;,
&quot;Val-de-Marne&quot;,
&quot;95&quot;,
&quot;Val-d&apos;Oise&quot;,
&quot;&quot;)</formula>
        <name>ACC_FR_MAJ_DPT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_FR_MAJ_PAYS</fullName>
        <description>Met à jour le champs Facturation Pays à FRANCE</description>
        <field>BillingCountry</field>
        <formula>&apos;FRANCE&apos;</formula>
        <name>ACC_FR_MAJ_PAYS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_FR_MAJ_REG</fullName>
        <field>Region__c</field>
        <formula>CASE( LEFT(BillingPostalCode,2),&quot;01&quot;,
&quot;Rhône-Alpes&quot;,
&quot;02&quot;,
&quot;Picardie&quot;,
&quot;03&quot;,
&quot;Auvergne&quot;,
&quot;04&quot;,
&quot;Provence-Alpes-Côte d&apos;Azur&quot;,
&quot;05&quot;,
&quot;Provence-Alpes-Côte d&apos;Azur&quot;,
&quot;06&quot;,
&quot;Provence-Alpes-Côte d&apos;Azur&quot;,
&quot;07&quot;,
&quot;Rhône-Alpes&quot;,
&quot;08&quot;,
&quot;Champagne-Ardenne&quot;,
&quot;09&quot;,
&quot;Midi-Pyrénées&quot;,
&quot;10&quot;,
&quot;Champagne-Ardenne&quot;,
&quot;11&quot;,
&quot;Languedoc-Roussillon&quot;,
&quot;12&quot;,
&quot;Midi-Pyrénées&quot;,
&quot;13&quot;,
&quot;Provence-Alpes-Côte d&apos;Azur&quot;,
&quot;14&quot;,
&quot;Basse-Normandie&quot;,
&quot;15&quot;,
&quot;Auvergne&quot;,
&quot;16&quot;,
&quot;Poitou-Charentes&quot;,
&quot;17&quot;,
&quot;Poitou-Charentes&quot;,
&quot;18&quot;,
&quot;Centre&quot;,
&quot;19&quot;,
&quot;Limousin&quot;,
&quot;2A&quot;,
&quot;Corse&quot;,
&quot;2B&quot;,
&quot;Corse&quot;,
&quot;20&quot;,
&quot;Corse&quot;,
&quot;21&quot;,
&quot;Bourgogne&quot;,
&quot;22&quot;,
&quot;Bretagne&quot;,
&quot;23&quot;,
&quot;Limousin&quot;,
&quot;24&quot;,
&quot;Aquitaine&quot;,
&quot;25&quot;,
&quot;Franche-Comté&quot;,
&quot;26&quot;,
&quot;Rhône-Alpes&quot;,
&quot;27&quot;,
&quot;Haute-Normandie&quot;,
&quot;28&quot;,
&quot;Centre&quot;,
&quot;29&quot;,
&quot;Bretagne&quot;,
&quot;30&quot;,
&quot;Languedoc-Roussillon&quot;,
&quot;31&quot;,
&quot;Midi-Pyrénées&quot;,
&quot;32&quot;,
&quot;Midi-Pyrénées&quot;,
&quot;33&quot;,
&quot;Aquitaine&quot;,
&quot;34&quot;,
&quot;Languedoc-Roussillon&quot;,
&quot;35&quot;,
&quot;Bretagne&quot;,
&quot;36&quot;,
&quot;Centre&quot;,
&quot;37&quot;,
&quot;Centre&quot;,
&quot;38&quot;,
&quot;Rhône-Alpes&quot;,
&quot;39&quot;,
&quot;Franche-Comté&quot;,
&quot;40&quot;,
&quot;Aquitaine&quot;,
&quot;41&quot;,
&quot;Centre&quot;,
&quot;42&quot;,
&quot;Rhône-Alpes&quot;,
&quot;43&quot;,
&quot;Auvergne&quot;,
&quot;44&quot;,
&quot;Pays de la Loire&quot;,
&quot;45&quot;,
&quot;Centre&quot;,
&quot;46&quot;,
&quot;Midi-Pyrénées&quot;,
&quot;47&quot;,
&quot;Aquitaine&quot;,
&quot;48&quot;,
&quot;Languedoc-Roussillon&quot;,
&quot;49&quot;,
&quot;Pays de la Loire&quot;,
&quot;50&quot;,
&quot;Basse-Normandie&quot;,
&quot;51&quot;,
&quot;Champagne-Ardenne&quot;,
&quot;52&quot;,
&quot;Champagne-Ardenne&quot;,
&quot;53&quot;,
&quot;Pays de la Loire&quot;,
&quot;54&quot;,
&quot;Lorraine&quot;,
&quot;55&quot;,
&quot;Lorraine&quot;,
&quot;56&quot;,
&quot;Bretagne&quot;,
&quot;57&quot;,
&quot;Lorraine&quot;,
&quot;58&quot;,
&quot;Bourgogne&quot;,
&quot;59&quot;,
&quot;Nord-Pas-de-Calais&quot;,
&quot;60&quot;,
&quot;Picardie&quot;,
&quot;61&quot;,
&quot;Basse-Normandie&quot;,
&quot;62&quot;,
&quot;Nord-Pas-de-Calais&quot;,
&quot;63&quot;,
&quot;Auvergne&quot;,
&quot;64&quot;,
&quot;Aquitaine&quot;,
&quot;65&quot;,
&quot;Midi-Pyrénées&quot;,
&quot;66&quot;,
&quot;Languedoc-Roussillon&quot;,
&quot;67&quot;,
&quot;Alsace&quot;,
&quot;68&quot;,
&quot;Alsace&quot;,
&quot;69&quot;,
&quot;Rhône-Alpes&quot;,
&quot;70&quot;,
&quot;Franche-Comté&quot;,
&quot;71&quot;,
&quot;Bourgogne&quot;,
&quot;72&quot;,
&quot;Pays de la Loire&quot;,
&quot;73&quot;,
&quot;Rhône-Alpes&quot;,
&quot;74&quot;,
&quot;Rhône-Alpes&quot;,
&quot;75&quot;,
&quot;Ile-de-France&quot;,
&quot;76&quot;,
&quot;Haute-Normandie&quot;,
&quot;77&quot;,
&quot;Ile-de-France&quot;,
&quot;78&quot;,
&quot;Ile-de-France&quot;,
&quot;79&quot;,
&quot;Poitou-Charentes&quot;,
&quot;80&quot;,
&quot;Picardie&quot;,
&quot;81&quot;,
&quot;Midi-Pyrénées&quot;,
&quot;82&quot;,
&quot;Midi-Pyrénées&quot;,
&quot;83&quot;,
&quot;Provence-Alpes-Côte d&apos;Azur&quot;,
&quot;84&quot;,
&quot;Provence-Alpes-Côte d&apos;Azur&quot;,
&quot;85&quot;,
&quot;Pays de la Loire&quot;,
&quot;86&quot;,
&quot;Poitou-Charentes&quot;,
&quot;87&quot;,
&quot;Limousin&quot;,
&quot;88&quot;,
&quot;Lorraine&quot;,
&quot;89&quot;,
&quot;Bourgogne&quot;,
&quot;90&quot;,
&quot;Franche-Comté&quot;,
&quot;91&quot;,
&quot;Ile-de-France&quot;,
&quot;92&quot;,
&quot;Ile-de-France&quot;,
&quot;93&quot;,
&quot;Ile-de-France&quot;,
&quot;94&quot;,
&quot;Ile-de-France&quot;,
&quot;95&quot;,
&quot;Ile-de-France&quot;,
&quot;&quot;)</formula>
        <name>ACC_FR_MAJ_REG</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_FR_MAJ_REG_COM</fullName>
        <field>R_gion_commerciale__c</field>
        <formula>CASE( LEFT(BillingPostalCode,2),&quot;01&quot;,
&quot;Grand Est&quot;,
&quot;02&quot;,
&quot;Nord&quot;,
&quot;03&quot;,
&quot;Grand Est&quot;,
&quot;04&quot;,
&quot;Grand Est&quot;,
&quot;05&quot;,
&quot;Grand Est&quot;,
&quot;06&quot;,
&quot;Grand Est&quot;,
&quot;07&quot;,
&quot;Grand Est&quot;,
&quot;08&quot;,
&quot;Nord&quot;,
&quot;09&quot;,
&quot;Grand Ouest&quot;,
&quot;10&quot;,
&quot;IDF&quot;,
&quot;11&quot;,
&quot;Grand Ouest&quot;,
&quot;12&quot;,
&quot;Grand Ouest&quot;,
&quot;13&quot;,
&quot;Grand Est&quot;,
&quot;14&quot;,
&quot;Nord&quot;,
&quot;15&quot;,
&quot;Grand Est&quot;,
&quot;16&quot;,
&quot;Grand Ouest&quot;,
&quot;17&quot;,
&quot;Grand Ouest&quot;,
&quot;18&quot;,
&quot;IDF&quot;,
&quot;19&quot;,
&quot;Grand Ouest&quot;,
&quot;20&quot;,
&quot;Grand Est&quot;,
&quot;2A&quot;,
&quot;Grand Est&quot;,
&quot;2B&quot;,
&quot;Grand Est&quot;,
&quot;21&quot;,
&quot;Grand Est&quot;,
&quot;22&quot;,
&quot;Grand Ouest&quot;,
&quot;23&quot;,
&quot;Grand Ouest&quot;,
&quot;24&quot;,
&quot;Grand Ouest&quot;,
&quot;25&quot;,
&quot;Grand Est&quot;,
&quot;26&quot;,
&quot;Grand Est&quot;,
&quot;27&quot;,
&quot;Nord&quot;,
&quot;28&quot;,
&quot;IDF&quot;,
&quot;29&quot;,
&quot;Grand Ouest&quot;,
&quot;30&quot;,
&quot;Grand Ouest&quot;,
&quot;31&quot;,
&quot;Grand Ouest&quot;,
&quot;32&quot;,
&quot;Grand Ouest&quot;,
&quot;33&quot;,
&quot;Grand Ouest&quot;,
&quot;34&quot;,
&quot;Grand Ouest&quot;,
&quot;35&quot;,
&quot;Grand Ouest&quot;,
&quot;36&quot;,
&quot;Grand Ouest&quot;,
&quot;37&quot;,
&quot;Grand Ouest&quot;,
&quot;38&quot;,
&quot;Grand Est&quot;,
&quot;39&quot;,
&quot;Grand Est&quot;,
&quot;40&quot;,
&quot;Grand Ouest&quot;,
&quot;41&quot;,
&quot;IDF&quot;,
&quot;42&quot;,
&quot;Grand Est&quot;,
&quot;43&quot;,
&quot;Grand Est&quot;,
&quot;44&quot;,
&quot;Grand Ouest&quot;,
&quot;45&quot;,
&quot;IDF&quot;,
&quot;46&quot;,
&quot;Grand Ouest&quot;,
&quot;47&quot;,
&quot;Grand Ouest&quot;,
&quot;48&quot;,
&quot;Grand Ouest&quot;,
&quot;49&quot;,
&quot;Grand Ouest&quot;,
&quot;50&quot;,
&quot;Nord&quot;,
&quot;51&quot;,
&quot;Nord&quot;,
&quot;52&quot;,
&quot;Grand Est&quot;,
&quot;53&quot;,
&quot;Grand Ouest&quot;,
&quot;54&quot;,
&quot;Grand Est&quot;,
&quot;55&quot;,
&quot;Grand Est&quot;,
&quot;56&quot;,
&quot;Grand Ouest&quot;,
&quot;57&quot;,
&quot;Grand Est&quot;,
&quot;58&quot;,
&quot;IDF&quot;,
&quot;59&quot;,
&quot;Nord&quot;,
&quot;60&quot;,
&quot;Nord&quot;,
&quot;61&quot;,
&quot;Nord&quot;,
&quot;62&quot;,
&quot;Nord&quot;,
&quot;63&quot;,
&quot;Grand Est&quot;,
&quot;64&quot;,
&quot;Grand Ouest&quot;,
&quot;65&quot;,
&quot;Grand Ouest&quot;,
&quot;66&quot;,
&quot;Grand Ouest&quot;,
&quot;67&quot;,
&quot;Grand Est&quot;,
&quot;68&quot;,
&quot;Grand Est&quot;,
&quot;69&quot;,
&quot;Grand Est&quot;,
&quot;70&quot;,
&quot;Grand Est&quot;,
&quot;71&quot;,
&quot;Grand Est&quot;,
&quot;72&quot;,
&quot;Grand Ouest&quot;,
&quot;73&quot;,
&quot;Grand Est&quot;,
&quot;74&quot;,
&quot;Grand Est&quot;,
&quot;75&quot;,
&quot;IDF&quot;,
&quot;76&quot;,
&quot;Nord&quot;,
&quot;77&quot;,
&quot;IDF&quot;,
&quot;78&quot;,
&quot;IDF&quot;,
&quot;79&quot;,
&quot;Grand Ouest&quot;,
&quot;80&quot;,
&quot;Nord&quot;,
&quot;81&quot;,
&quot;Grand Ouest&quot;,
&quot;82&quot;,
&quot;Grand Ouest&quot;,
&quot;83&quot;,
&quot;Grand Est&quot;,
&quot;84&quot;,
&quot;Grand Est&quot;,
&quot;85&quot;,
&quot;Grand Ouest&quot;,
&quot;86&quot;,
&quot;Grand Ouest&quot;,
&quot;87&quot;,
&quot;Grand Ouest&quot;,
&quot;88&quot;,
&quot;Grand Est&quot;,
&quot;89&quot;,
&quot;IDF&quot;,
&quot;90&quot;,
&quot;Grand Est&quot;,
&quot;91&quot;,
&quot;IDF&quot;,
&quot;92&quot;,
&quot;IDF&quot;,
&quot;93&quot;,
&quot;IDF&quot;,
&quot;94&quot;,
&quot;IDF&quot;,
&quot;95&quot;,
&quot;IDF&quot;,
&quot;&quot;)</formula>
        <name>ACC FR MAJ REG COM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_SP_MAJ_COM</fullName>
        <description>Met a jour la communidad dans le champ région</description>
        <field>Region__c</field>
        <formula>CASE( LEFT(BillingPostalCode,2), 
&quot;01&quot;,&quot;País Vasco&quot;,
&quot;02&quot;,&quot;Castilla-La Mancha&quot;,
&quot;03&quot;,&quot;Comunidad Valenciana&quot;,
&quot;04&quot;,&quot;Andalucía&quot;,
&quot;33&quot;,&quot;Principado de Asturias&quot;,
&quot;05&quot;,&quot;Castilla y León&quot;,
&quot;06&quot;,&quot;Extremadura&quot;,
&quot;07&quot;,&quot;Islas Baleares&quot;,
&quot;08&quot;,&quot;Cataluña&quot;,
&quot;48&quot;,&quot;País Vasco&quot;,
&quot;09&quot;,&quot;Burgos&quot;,
&quot;10&quot;,&quot;Extremadura&quot;,
&quot;11&quot;,&quot;Andalucía&quot;,
&quot;39&quot;,&quot;Cantabria&quot;,
&quot;12&quot;,&quot;Comunidad Valenciana&quot;,
&quot;13&quot;,&quot;Castilla-La Mancha&quot;,
&quot;14&quot;,&quot;Andalucía&quot;,
&quot;15&quot;,&quot;Galicia&quot;,
&quot;16&quot;,&quot;Castilla-La Mancha&quot;,
&quot;17&quot;,&quot;Cataluña&quot;,
&quot;18&quot;,&quot;Andalucía&quot;,
&quot;19&quot;,&quot;Castilla-La Mancha&quot;,
&quot;20&quot;,&quot;País Vasco&quot;,
&quot;21&quot;,&quot;Andalucía&quot;,
&quot;22&quot;,&quot;Aragón&quot;,
&quot;23&quot;,&quot;Andalucía&quot;,
&quot;24&quot;,&quot;Burgos&quot;,
&quot;25&quot;,&quot;Cataluña&quot;,
&quot;27&quot;,&quot;Galicia&quot;,
&quot;28&quot;,&quot;Madrid&quot;,
&quot;29&quot;,&quot;Andalucía&quot;,
&quot;30&quot;,&quot;Región de Murcia&quot;,
&quot;31&quot;,&quot;Comunidad Foral de Navarra&quot;,
&quot;32&quot;,&quot;Galicia&quot;,
&quot;34&quot;,&quot;Burgos&quot;,
&quot;35&quot;,&quot;Canarias&quot;,
&quot;36&quot;,&quot;Galicia&quot;,
&quot;26&quot;,&quot;La Rioja&quot;,
&quot;37&quot;,&quot;Burgos&quot;,
&quot;38&quot;,&quot;Canarias&quot;,
&quot;41&quot;,&quot;Andalucía&quot;,
&quot;50&quot;,&quot;Aragón&quot;,
&quot;40&quot;,&quot;Burgos&quot;,
&quot;42&quot;,&quot;Burgos&quot;,
&quot;43&quot;,&quot;Cataluña&quot;,
&quot;44&quot;,&quot;Aragón&quot;,
&quot;45&quot;,&quot;Castilla-La Mancha&quot;,
&quot;46&quot;,&quot;Comunidad Valenciana&quot;,
&quot;47&quot;,&quot;Burgos&quot;,
&quot;49&quot;,&quot;Burgos&quot;,
&quot;Ciudades autónomas&quot;
)</formula>
        <name>ACC_SP_MAJ_COM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_SP_MAJ_PR</fullName>
        <description>MAJ Province spain</description>
        <field>Departement__c</field>
        <formula>CASE( LEFT(BillingPostalCode,2),
&quot;01&quot;,&quot;Álava&quot;,
&quot;02&quot;,&quot;Albacete&quot;,
&quot;03&quot;,&quot;Alicante&quot;,
&quot;04&quot;,&quot;Almería&quot;,
&quot;33&quot;,&quot;Asturias&quot;,
&quot;05&quot;,&quot;Ávila&quot;,
&quot;06&quot;,&quot;Badajoz&quot;,
&quot;07&quot;,&quot;Islas Baleares&quot;,
&quot;08&quot;,&quot;Barcelona&quot;,
&quot;48&quot;,&quot;Vizcaya&quot;,
&quot;09&quot;,&quot;Burgos&quot;,
&quot;10&quot;,&quot;Cáceres&quot;,
&quot;11&quot;,&quot;Cádiz&quot;,
&quot;39&quot;,&quot;Cantabria&quot;,
&quot;12&quot;,&quot;Castellón&quot;,
&quot;13&quot;,&quot;Ciudad Real&quot;,
&quot;14&quot;,&quot;Córdoba&quot;,
&quot;15&quot;,&quot;La Coruña&quot;,
&quot;16&quot;,&quot;Cuenca&quot;,
&quot;17&quot;,&quot;Gerona&quot;,
&quot;18&quot;,&quot;Granada&quot;,
&quot;19&quot;,&quot;Guadalajara&quot;,
&quot;20&quot;,&quot;Guipúzcoa&quot;,
&quot;21&quot;,&quot;Huelva&quot;,
&quot;22&quot;,&quot;Huesca&quot;,
&quot;23&quot;,&quot;Jaén&quot;,
&quot;24&quot;,&quot;León&quot;,
&quot;25&quot;,&quot;Lérida&quot;,
&quot;27&quot;,&quot;Lugo&quot;,
&quot;28&quot;,&quot;Madrid&quot;,
&quot;29&quot;,&quot;Málaga&quot;,
&quot;30&quot;,&quot;Murcia&quot;,
&quot;31&quot;,&quot;Navarra&quot;,
&quot;32&quot;,&quot;Orense&quot;,
&quot;34&quot;,&quot;Palencia&quot;,
&quot;35&quot;,&quot;Las Palmas&quot;,
&quot;36&quot;,&quot;Pontevedra&quot;,
&quot;26&quot;,&quot;La Rioja&quot;,
&quot;37&quot;,&quot;Salamanca&quot;,
&quot;38&quot;,&quot;Santa Cruz de Tenerife&quot;,
&quot;41&quot;,&quot;Sevilla&quot;,
&quot;50&quot;,&quot;Zaragoza&quot;,
&quot;40&quot;,&quot;Segovia&quot;,
&quot;42&quot;,&quot;Soria&quot;,
&quot;43&quot;,&quot;Tarragona&quot;,
&quot;44&quot;,&quot;Teruel&quot;,
&quot;45&quot;,&quot;Toledo&quot;,
&quot;46&quot;,&quot;Valencia&quot;,
&quot;47&quot;,&quot;Valladolid&quot;,	
&quot;49&quot;,&quot;Zamora&quot;,
&quot;51&quot;,&quot;Ceuta&quot;,
&quot;52&quot;,&quot;Melilla&quot;,
&quot;&quot;
)</formula>
        <name>ACC_SP_MAJ_PR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC_SP_MAJ_REG_COM</fullName>
        <description>Mise a jour de la région commerciale pour l&apos;éspagne</description>
        <field>R_gion_commerciale__c</field>
        <formula>CASE( LEFT(BillingPostalCode,2),
&quot;01&quot;,&quot;País Vasco y Navarra&quot;,
&quot;02&quot;,&quot;Otros&quot;,
&quot;03&quot;,&quot;Otros&quot;,
&quot;04&quot;,&quot;Andalucía&quot;,
&quot;33&quot;,&quot;Otros&quot;,
&quot;05&quot;,&quot;Otros&quot;,
&quot;06&quot;,&quot;Otros&quot;,
&quot;07&quot;,&quot;Otros&quot;,
&quot;08&quot;,&quot;Cataluña&quot;,
&quot;48&quot;,&quot;País Vasco y Navarra&quot;,
&quot;09&quot;,&quot;Otros&quot;,
&quot;10&quot;,&quot;Otros&quot;,
&quot;11&quot;,&quot;Andalucía&quot;,
&quot;39&quot;,&quot;Otros&quot;,
&quot;12&quot;,&quot;Otros&quot;,
&quot;13&quot;,&quot;Otros&quot;,
&quot;14&quot;,&quot;Andalucía&quot;,
&quot;15&quot;,&quot;Otros&quot;,
&quot;16&quot;,&quot;Otros&quot;,
&quot;17&quot;,&quot;Cataluña&quot;,
&quot;18&quot;,&quot;Andalucía&quot;,
&quot;19&quot;,&quot;Otros&quot;,
&quot;20&quot;,&quot;País Vasco y Navarra&quot;,
&quot;21&quot;,&quot;Andalucía&quot;,
&quot;22&quot;,&quot;Otros&quot;,
&quot;23&quot;,&quot;Andalucía&quot;,
&quot;24&quot;,&quot;Otros&quot;,
&quot;25&quot;,&quot;Cataluña&quot;,
&quot;27&quot;,&quot;Otros&quot;,
&quot;28&quot;,&quot;Madrid&quot;,
&quot;29&quot;,&quot;Andalucía&quot;,
&quot;30&quot;,&quot;Otros&quot;,
&quot;31&quot;,&quot;País Vasco y Navarra&quot;,
&quot;32&quot;,&quot;Otros&quot;,
&quot;34&quot;,&quot;Otros&quot;,
&quot;35&quot;,&quot;Otros&quot;,
&quot;36&quot;,&quot;Otros&quot;,
&quot;26&quot;,&quot;Otros&quot;,
&quot;37&quot;,&quot;Otros&quot;,
&quot;38&quot;,&quot;Otros&quot;,
&quot;41&quot;,&quot;Andalucía&quot;,
&quot;50&quot;,&quot;Otros&quot;,
&quot;40&quot;,&quot;Otros&quot;,
&quot;42&quot;,&quot;Otros&quot;,
&quot;43&quot;,&quot;Cataluña&quot;,
&quot;44&quot;,&quot;Otros&quot;,
&quot;45&quot;,&quot;Otros&quot;,
&quot;46&quot;,&quot;Otros&quot;,
&quot;47&quot;,&quot;Otros&quot;,
&quot;49&quot;,&quot;Otros&quot;,
&quot;Otros&quot;
)</formula>
        <name>ACC_SP_MAJ_REG_COM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Acc_FR_MAJ_REG_COM_PerfRH</fullName>
        <field>Region_commerciale_Perf_RH__c</field>
        <formula>CASE(left(BillingPostalCode,2),
&quot;01&quot;,&quot;Sud Est&quot;,
&quot;02&quot;,&quot;Nord Est&quot;,
&quot;03&quot;,&quot;Sud Est&quot;,
&quot;04&quot;,&quot;Sud Est&quot;,
&quot;05&quot;,&quot;Sud Est&quot;,
&quot;06&quot;,&quot;Sud Est&quot;,
&quot;07&quot;,&quot;Sud Est&quot;,
&quot;08&quot;,&quot;Nord Est&quot;,
&quot;09&quot;,&quot;Sud Ouest&quot;,
&quot;10&quot;,&quot;Nord Est&quot;,
&quot;11&quot;,&quot;Sud Est&quot;,
&quot;12&quot;,&quot;Sud Ouest&quot;,
&quot;13&quot;,&quot;Sud Est&quot;,
&quot;14&quot;,&quot;Nord Ouest&quot;,
&quot;15&quot;,&quot;Sud Est&quot;,
&quot;16&quot;,&quot;Nord Ouest&quot;,
&quot;17&quot;,&quot;Nord Ouest&quot;,
&quot;18&quot;,&quot;Nord Ouest&quot;,
&quot;19&quot;,&quot;Sud Ouest&quot;,
&quot;21&quot;,&quot;Nord Est&quot;,
&quot;22&quot;,&quot;Nord Ouest&quot;,
&quot;23&quot;,&quot;Sud Ouest&quot;,
&quot;24&quot;,&quot;Sud Ouest&quot;,
&quot;25&quot;,&quot;Nord Est&quot;,
&quot;26&quot;,&quot;Sud Est&quot;,
&quot;27&quot;,&quot;Nord Ouest&quot;,
&quot;28&quot;,&quot;Nord Ouest&quot;,
&quot;29&quot;,&quot;Nord Ouest&quot;,
&quot;30&quot;,&quot;Sud Est&quot;,
&quot;31&quot;,&quot;Sud Ouest&quot;,
&quot;32&quot;,&quot;Sud Ouest&quot;,
&quot;33&quot;,&quot;Sud Ouest&quot;,
&quot;34&quot;,&quot;Sud Est&quot;,
&quot;35&quot;,&quot;Nord Ouest&quot;,
&quot;36&quot;,&quot;Nord Ouest&quot;,
&quot;37&quot;,&quot;Nord Ouest&quot;,
&quot;38&quot;,&quot;Sud Est&quot;,
&quot;39&quot;,&quot;Nord Est&quot;,
&quot;40&quot;,&quot;Sud Ouest&quot;,
&quot;41&quot;,&quot;Nord Ouest&quot;,
&quot;42&quot;,&quot;Sud Est&quot;,
&quot;43&quot;,&quot;Sud Est&quot;,
&quot;44&quot;,&quot;Nord Ouest&quot;,
&quot;45&quot;,&quot;Nord Ouest&quot;,
&quot;46&quot;,&quot;Sud Ouest&quot;,
&quot;47&quot;,&quot;Sud Ouest&quot;,
&quot;48&quot;,&quot;Sud Est&quot;,
&quot;49&quot;,&quot;Nord Ouest&quot;,
&quot;50&quot;,&quot;Nord Ouest&quot;,
&quot;51&quot;,&quot;Nord Est&quot;,
&quot;52&quot;,&quot;Nord Est&quot;,
&quot;53&quot;,&quot;Nord Ouest&quot;,
&quot;54&quot;,&quot;Nord Est&quot;,
&quot;55&quot;,&quot;Nord Est&quot;,
&quot;56&quot;,&quot;Nord Ouest&quot;,
&quot;57&quot;,&quot;Nord Est&quot;,
&quot;58&quot;,&quot;Nord Est&quot;,
&quot;59&quot;,&quot;Nord Est&quot;,
&quot;60&quot;,&quot;Nord Est&quot;,
&quot;61&quot;,&quot;Nord Ouest&quot;,
&quot;62&quot;,&quot;Nord Est&quot;,
&quot;63&quot;,&quot;Sud Est&quot;,
&quot;64&quot;,&quot;Sud Ouest&quot;,
&quot;65&quot;,&quot;Sud Ouest&quot;,
&quot;66&quot;,&quot;Sud Est&quot;,
&quot;67&quot;,&quot;Nord Est&quot;,
&quot;68&quot;,&quot;Nord Est&quot;,
&quot;69&quot;,&quot;Sud Est&quot;,
&quot;70&quot;,&quot;Nord Est&quot;,
&quot;71&quot;,&quot;Sud Est&quot;,
&quot;72&quot;,&quot;Nord Ouest&quot;,
&quot;73&quot;,&quot;Sud Est&quot;,
&quot;74&quot;,&quot;Sud Est&quot;,
&quot;75&quot;,&quot;Nord Est&quot;,
&quot;76&quot;,&quot;Nord Ouest&quot;,
&quot;77&quot;,&quot;Nord Ouest&quot;,
&quot;78&quot;,&quot;Nord Est&quot;,
&quot;79&quot;,&quot;Nord Ouest&quot;,
&quot;80&quot;,&quot;Nord Est&quot;,
&quot;81&quot;,&quot;Sud Ouest&quot;,
&quot;82&quot;,&quot;Sud Ouest&quot;,
&quot;83&quot;,&quot;Sud Est&quot;,
&quot;84&quot;,&quot;Sud Est&quot;,
&quot;85&quot;,&quot;Nord Ouest&quot;,
&quot;86&quot;,&quot;Nord Ouest&quot;,
&quot;87&quot;,&quot;Sud Ouest&quot;,
&quot;88&quot;,&quot;Nord Est&quot;,
&quot;89&quot;,&quot;Nord Est&quot;,
&quot;90&quot;,&quot;Nord Est&quot;,
&quot;91&quot;,&quot;Nord Est&quot;,
&quot;92&quot;,&quot;Nord Ouest&quot;,
&quot;93&quot;,&quot;Nord Ouest&quot;,
&quot;94&quot;,&quot;Nord Ouest&quot;,
&quot;95&quot;,&quot;Nord Est&quot;,
&quot;Non affecté&quot;
)</formula>
        <name>ACC FR MAJ REG COM Perf RH</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Account_owner</fullName>
        <field>OwnerId</field>
        <lookupValue>synefo@gac.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>MAJ Account owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Declencheur_Canada</fullName>
        <field>declencheur_MAJ_DPT_CA__c</field>
        <literalValue>1</literalValue>
        <name>MAJ Declencheur Canada</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Declencheur_Canada_false</fullName>
        <field>declencheur_MAJ_DPT_CA__c</field>
        <literalValue>0</literalValue>
        <name>MAJ Declencheur Canada false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MaJ_du_Champ_SIREN_sur_les_comptes</fullName>
        <description>Met à jour le champ SIREN avec les 9 premiers chiffre du champ SIRET sur les Comptes.</description>
        <field>SIREN__c</field>
        <formula>LEFT(SIRET__c, 9)</formula>
        <name>MàJ du Champ SIREN sur les comptes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SGP_Billing_City</fullName>
        <field>BillingCity</field>
        <formula>&quot;Singapore&quot;</formula>
        <name>SGP - Billing City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SGP_Billing_Country</fullName>
        <field>BillingCountry</field>
        <formula>&quot;Singapore&quot;</formula>
        <name>SGP - Billing Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ACC_BR_MAJ_DPT_REG</fullName>
        <actions>
            <name>ACC_BR_MAJ_DPT</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC_BR_MAJ_REG</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC_BR_MAJ_REG_COM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour du libellé Département / Région en fonction de l&apos;état. Mise à jour de champ (MAJ)</description>
        <formula>$RecordType.Name =&quot;BRASIL ACCOUNT&quot; &amp;&amp; (lower(BillingCountry) = &quot;brasil&quot;)&amp;&amp; LEN(BillingState) = 2</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ACC_CA_MAJ_DPT_REG</fullName>
        <actions>
            <name>ACC_CA_MAJ_DPT</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC_CA_MAJ_REG</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC_CA_MAJ_REG_COM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Declencheur_Canada_false</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour du libellé Département / Région en fonction du code postal. Mise à jour de champ (MAJ)</description>
        <formula>$RecordType.Name =&quot;CANADA ACCOUNT&quot; &amp;&amp; lower(BillingCountry) = &quot;canada&quot; &amp;&amp; REGEX(BillingPostalCode,&apos;^[ABCEGHJKLMNPRSTVXY]{1}[0-9]{1}[A-Z]{1} *[0-9]{1}[A-Z]{1}[0-9]{1}$&apos;) &amp;&amp;  declencheur_MAJ_DPT_CA__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ACC_CA_MAJ_NUM_DPT</fullName>
        <actions>
            <name>ACC_CA_MAJ_NUM_DPT</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Declencheur_Canada</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mise à jour du libellé Num Département en fonction du code postal
Permet de retourner une valeur textuelle du champ département. Mise à jour de champ (MAJ)</description>
        <formula>$RecordType.Name =&quot;CANADA ACCOUNT&quot; &amp;&amp; lower(BillingCountry) = &quot;canada&quot; &amp;&amp; REGEX(BillingPostalCode,&apos;^[ABCEGHJKLMNPRSTVXY]{1}[0-9]{1}[A-Z]{1} *[0-9]{1}[A-Z]{1}[0-9]{1}$&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ACC_FR_MAJ_DPT_REG</fullName>
        <actions>
            <name>ACC_FR_MAJ_DPT</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC_FR_MAJ_REG</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC_FR_MAJ_REG_COM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Acc_FR_MAJ_REG_COM_PerfRH</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour du libellé Département / Région en fonction du code postal. Mise à jour de champ (MAJ)</description>
        <formula>$RecordType.Name =&quot;FRANCE ACCOUNT&quot; &amp;&amp; lower(BillingCountry) = &quot;france&quot; &amp;&amp; LEN(BillingPostalCode) = 5 &amp;&amp; BillingPostalCode &lt;&gt; &quot;00000&quot; &amp;&amp; NOT(BEGINS(BillingPostalCode, &quot;96&quot;)) &amp;&amp;
  $User.Id  &lt;&gt; &quot;005D0000002DMkS&quot; &amp;&amp; 
  $User.Id  &lt;&gt; &quot;005D0000002tZBf&quot; &amp;&amp; 
NOT(BEGINS(BillingPostalCode, &quot;99&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ACC_FR_MAJ_PAYS</fullName>
        <actions>
            <name>ACC_FR_MAJ_PAYS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.BillingCountry</field>
            <operation>notEqual</operation>
            <value>FRANCE</value>
        </criteriaItems>
        <description>Met à jour le champ Facturation - Pays en fonction du type d&apos;enregistrement. Mise à jour de champ (MAJ)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ACC_SP_MAJ_DPT_REG</fullName>
        <actions>
            <name>ACC_SP_MAJ_COM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC_SP_MAJ_PR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC_SP_MAJ_REG_COM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour du libellé Département / Région en fonction du code postal. Mise à jour de champ (MAJ)</description>
        <formula>$RecordType.Name =&quot;SPAIN_ACCOUNT&quot; &amp;&amp; (lower(BillingCountry) = &quot;españa&quot; || lower(BillingCountry) = &quot;espana&quot; )&amp;&amp; LEN(BillingPostalCode) = 5 &amp;&amp; BillingPostalCode &lt;&gt; &quot;00000&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MAJ du Champ SIREN</fullName>
        <actions>
            <name>MaJ_du_Champ_SIREN_sur_les_comptes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>FRANCE ACCOUNT</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SGP - Billing Country</fullName>
        <actions>
            <name>SGP_Billing_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SGP_Billing_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>SINGAPORE ACCOUNT</value>
        </criteriaItems>
        <description>Mise à jour de champ (MAJ)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
