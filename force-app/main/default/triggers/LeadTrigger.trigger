trigger LeadTrigger on Lead (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            LeadTriggerHandler.publishLeadPlatformEvent(Trigger.new);
        }
    }
}