public with sharing class LWC_Controller {
    @AuraEnabled(Cacheable = true)
    public static string methodName(String param){
        try {
            return '!!! param ' + param;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}