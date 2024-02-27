/**
 * An apex page controller that exposes the site forgot password functionality
 */
@IsTest public with sharing class ForgotPasswordControllerTest {

	static {
		getData();
	}

  	 @IsTest(SeeAllData=true) public static void testForgotPasswordController() {
    	// Instantiate a new controller with all parameters in the page
    	ForgotPasswordController controller = new ForgotPasswordController();
    	controller.username = 'test@salesforce.com';     	
    
    	System.assertEquals(controller.forgotPassword(),null); 
    }

	public static String getData(){
        try {
            System.debug('!!!getData');
            return 'Response from Apex!';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}