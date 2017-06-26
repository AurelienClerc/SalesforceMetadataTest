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
private class TestOutlookTaskTrigger {

/*
 * Synefo 2606, ce test ne sert plus a rien, renommé en testEmptyTask
 *
 */
    static testMethod void testEmptyTask() {
        // TO DO: implement unit test
        
        Task task = new Task();
        //task.WhatId = '006L00000024BAw';
		//task.WhatId = '006D000000J7sRH';
        
        Opportunity opportunity = [select id,description from opportunity limit 1][0];

/*
synefo
        Opportunity opportunity = [
        	select
        		description
        	from Opportunity
        	where Id=: task.WhatId
        ];
*/

        task.WhatId =opportunity.Id;
        insert task;
        
        task = [
        	select
        		body_outlook__c
        	from Task
        	where Id =: task.Id
        ];
        //Synefo 26/06, ce test ne sert a rien??
        System.assertNotEquals(task.body_outlook__c, '');
        
    }
}