public with sharing class LeadPlatformEventTriggerHandler {
    public static void getLeadFields(Lead_Platform_Event__e leadEvent ) {
        System.debug(leadEvent.Lead_Fields__c);   
    }
}
