trigger validationTechnique on Validation_technique__c (after insert, before update) {
	Opportunity opportunity;
	Account account;
	User ca, cc, currentUser, validTechOwner;
	List<User> usersRoleDC;
	EmailTemplate tpl;
	BrandTemplate brdTpl;
	String msgBody, msgSubject, brdTplValue, tplDevName, avis_technique;
	
	for(Validation_technique__c validTech : Trigger.new){
		if(validTech.Opportunit__c != NULL){
			currentUser = [
				select
					FirstName,
					LastName
				from User
				where Id =: UserInfo.getUserId()
			];
			
			opportunity = [
				select
					Id,
					Name,
					RDV_a_effectuer_par__c,
					Origine_du_RDV__c,
					Enjeux_opportunite__c,
					StageName,
					AccountId
				from Opportunity
				where Id =: validTech.Opportunit__c
			];
			
			validTechOwner = [
				select
					FirstName,
					LastName
				from User
				where Id =: validTech.OwnerId
			];
			
			usersRoleDC = [
				select
					email
				from User
				where USERROLEID =: '00ED0000001NvN7' // rôle DC FRFI
			];
			
			account = [
				select
					Name
				from Account
				where
					Id =: opportunity.AccountId
			];
			
			if(opportunity.RDV_a_effectuer_par__c != NULL){
				cc = [
					select
						Id,
						FirstName,
						LastName,
						email
					from User
					where Id =: opportunity.RDV_a_effectuer_par__c
				];
			}
			
			if(opportunity.Origine_du_RDV__c != NULL){
				ca = [
					select
						Id,
						FirstName,
						LastName,
						email
					from User
					where Id =: opportunity.Origine_du_RDV__c
				];
			}

			tpl = [
				select 
					id,
					body,
					htmlvalue,
					subject,
					brandTemplateId
				from EmailTemplate
				where developerName =: 'Request_approval_response_CIR'
			];
			
			brdTpl = [
				select 
					id,
					value			
				from BrandTemplate
				where
					Id =: tpl.brandTemplateId
			];

			brdTplValue = convertStyle(brdTpl.value);

			List<Map<String,String>> tplValues = new List<Map<String,String>>{
				new Map<String, String>{'start' => ' src="', 'end' => '">'},
				new Map<String, String>{'start' => '', 'end' => ''},
				new Map<String, String>{'start' => '>' + parseTemplate(tpl.htmlvalue, validTech), 'end' => ''},
				new Map<String, String>{'start' => '', 'end' => ''},
				new Map<String, String>{'start' => '', 'end' => ''},
				new Map<String, String>{'start' => '', 'end' => ''}				
			};
			
			for( Map<String, String> i: tplValues){
				brdTplValue = brdTplValue.replaceFirst('>\n<!\\[CDATA\\[', i.get('start'));
				brdTplValue = brdTplValue.replaceFirst(']]>', i.get('end'));
			}
			
			brdTplValue = brdTplValue.replace('</img>', '');

			msgBody = brdTplValue;
			
			msgSubject = tpl.Subject.replace(
				'{!Opportunity.Name}', 
				opportunity.Name
			);
			
			Messaging.reserveSingleEmailCapacity(1);
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[] {};
			
//			validTech.test_trigger__c = '-';
			
			if(ca != NULL){
				toAddresses.add(ca.email);
//				validTech.test_trigger__c += 'CA : '+ ca.email+'\n';
			}
			if(cc != null){
				toAddresses.add(cc.email);
//				validTech.test_trigger__c +='CC : '+ cc.email+'\n';
			}
			
			for(User user: usersRoleDC){
				toAddresses.add(user.email);
//				validTech.test_trigger__c += 'DC : '+user.email+'\n';
			}
			
			mail.setToAddresses(toAddresses);
			mail.setUseSignature(false);
			mail.setSubject(msgSubject);
			mail.setHtmlBody(msgBody);
			//Edit Synefo 2606 fait en sorte que les tests n'envoie pas le mail
			if(validTech.Envoi_email__c && !Test.isRunningTest())
				Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
	}
	
	private String parseTemplate( String tplStr, Validation_technique__c validTech ){
		String str, enjeux_CIR;
		str = tplStr;
		
		enjeux_CIR = opportunity.Enjeux_opportunite__c;
		if(enjeux_CIR == null)
			enjeux_CIR = '';
		
		avis_technique = validTech.Avis_technique__c;
		if(validTech.Avis_technique__c == null)
			avis_technique = '';
		
		str = str.replace('<![CDATA[', '');
		str = str.replace(']]>', '');
		str = str.replace(
			'{!Opportunity.Name}', 
			'<a href="https://eu1.salesforce.com/' + opportunity.Id + '" title="' + opportunity.Name + '">' + opportunity.Name + '</a>'
		).replace(
			'{!Opportunity.StageName}',
			opportunity.StageName
		).replace(
			'{!Opportunity.Account}',
			account.Name
		).replace(
			'{!Opportunity.Enjeux_opportunite__c}',
			enjeux_CIR
		).replace(
			'{!Opportunity.Id}',
			opportunity.Id
		).replace(
			'{!Validation_technique__c.Avis_technique__c}',
			avis_technique
		).replace(
			'{!Validation_technique__c.OwnerFullName}',
			validTechOwner.FirstName + ' ' + validTechOwner.LastName
		).replace(
			'{!Validation_technique__c.Id}',
			validTech.Id
		).replaceAll(
			'\\{!ApprovalRequest\\.[a-zA-Z_]*\\}',
			''
		);
		
		return str;
	}
	
	private String convertStyle( String str ){
		String strTmp;
		String regex = '>\n<style(.*)>\n</style>';
		pattern myPattern = Pattern.compile(regex);
		matcher myMatcher = myPattern.matcher(str);
		
		strTmp = myMatcher.replaceAll('!-----!!is_style!$1!-----!');
		
		String[] tab = strTmp.split('!-----!');
		
		strTmp = '';
		for(String i: tab){
			if(i.substring(0, 10) == '!is_style!'){
				strTmp += 'style="' + i.substring(10).replace('="', ':').replace('"', ';') + '">';
			}else{
				strTmp += i;
			}
		}
		
		return strTmp;
	}
}