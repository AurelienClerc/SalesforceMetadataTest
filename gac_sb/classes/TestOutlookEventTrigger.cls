/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */

@isTest
private class TestOutlookEventTrigger {
 /*synefo, enlevé me sert a rien, ne couvre rien
    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
        Event event = new Event();
        
        /*synefo enlevé
        event.WhatId = '006L00000024BAw';
        event.WhoId = '003L0000002jclk';
        *
        
        event.WhatId = '006D000000J7sRH';
        event.WhoId = '003D000000mReg9';
        
        Datetime sdt = Datetime.newInstance( Date.newInstance(2011, 10, 24), Time.newInstance(1, 15, 18, 0));
        Datetime edt = Datetime.newInstance( Date.newInstance(2011, 10, 24), Time.newInstance(1, 15, 18, 0));

        event.StartDateTime = sdt;
        event.EndDateTime = edt;
        
        /* synefo, enlevé
        Opportunity opportunity = [
        	select
        		description
        	from Opportunity
        	where Id=: event.WhatId
        ];
        *

		insert event;
		
		event = [
			select
				emplacement_outlook__c,
				body_outlook__c,
				categorie_outlook__c
			from Event
			where
				Id =: event.Id
		];
		
		System.assertNotEquals(event.body_outlook__c, '');
	
    }
    */
}