<?php

$test_prod;
$properties = fopen('build.properties', 'r+');

// Check des arguments, sont-ils au bon format ?
if(isset($argv[1]) == true) {
	if(!filter_var($argv[1], FILTER_VALIDATE_EMAIL)) {
		echo "Error First argument : Format invalide pour le username !\n";
	}

	if(isset($argv[2]) == false) {
		echo "Error Missing Second Argument : php script.php [login Salesforce] [mdp Salesforce] [test/prod]\n";
	}

	if(isset($argv[3]) == true) {
		if(strcasecmp($argv[3], "test") == 0) {
			$test_prod = true;
			buildProperties($argv[1], $argv[2], $test_prod);
		}
		elseif(strcasecmp($argv[3], "prod") == 0) {
			$test_prod = false;
			buildProperties($argv[1], $argv[2], $test_prod);
		}
		else {
			echo "Error : test ou prod, c'est pas dur, si ?\n";
		}
	}
	else {
		echo "Error Missing Third Argument : php script.php [login Salesforce] [mdp Salesforce] [test/prod]\n";
	}
}
else {
	echo "Souhaitez-vous vous connecter avec ce login : ".fgets($properties, 4096)." [y/n] ? ";
	$stdin = fgets(STDIN);
}

// Set du Username, Password et TEST/PROD pour le fichier properties en fonction des arguments passés en paramètre
function buildProperties($login, $password, $test_prod)
{
	$serverUrl;
	if($test_prod == true) {
		$serverUrl = "https://test.salesforce.com";
	}
	else {
		$serverUrl = "https://login.salesforce.com";
	}

	$current = "sf.username = ".$login."\n"."sf.password = ".$password."\n"."sf.serverurl = ".$serverUrl."\n"."sf.maxPoll = 20"."\n";
	$properties = fopen('build.properties', 'r+');
	$propertiesDeleteLines = new SplFileObject('build.properties', 'r+');
	$propertiesDeleteLines->ftruncate($propertiesDeleteLines->ftell());
	fwrite($properties, $current);
	fclose($properties);


	// if($properties) {
	// 	while(($buffer = fgets($properties, 4096)) !== false) {
	// 		echo $buffer;
	// 	}

	// 	if(!feof($properties)) {
	// 		echo "Error : fgets() failed\n";
	// 	}

	// 	fclose($properties);
	// }
}

?>
