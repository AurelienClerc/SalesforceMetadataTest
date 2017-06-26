/**
 * An apex page controller that exposes the site login functionality
 */
global with sharing class SiteLoginController {
    global String username {get; set;}
    global String password {get; set;}

    global PageReference login() {
        String startUrl = '/PortailATlogin?portalRedirect=1';//System.currentPageReference().getParameters().get('startURL');
        
        PageReference retPage = Site.login(username, password, startUrl);
        //retPage.getParameters().put('retURL', );
        return retPage;
    }
    
    global Boolean getIsLogged(){
    	return UserInfo.getUserType() != 'Guest';
    }
    
    global PageReference forwardToHomePage(){
    	
    	// if(UserInfo.getUserType() != 'Guest'){
    	// 	PageReference homePage = new PageReference('/PortailAThome');
    	// 	homePage.setRedirect(true);
    	// 	return homePage;
    	// }
    	
    	return null;
    }
    
   	global SiteLoginController () {}
    
    @IsTest(SeeAllData=true) global static void testSiteLoginController () {
        // Instantiate a new controller with all parameters in the page
        SiteLoginController controller = new SiteLoginController ();
        controller.username = 'test@salesforce.com';
        controller.password = '123456'; 
                
        System.assertEquals(controller.login(),null);                           
    }    
}