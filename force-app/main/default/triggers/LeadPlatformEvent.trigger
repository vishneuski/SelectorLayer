trigger LeadPlatformEvent on Lead_Platform_Event__e (after insert) {
    LeadPlatformEventTriggerHandler leadTriggerHandler = new LeadPlatformEventTriggerHandler();
    for(Lead_Platform_Event__e leadEvent : Trigger.new) {
        if(Trigger.isInsert) {
            LeadPlatformEventTriggerHandler.getLeadFields(leadEvent);
        }
    }

}