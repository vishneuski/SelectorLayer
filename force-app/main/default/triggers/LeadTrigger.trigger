trigger LeadTrigger on Lead (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            LeadTriggerHandler.publishLeadPlatformEvent(Trigger.new);
            LeadTriggerHandler.updateAccountWhenLeadInserted(Trigger.new);
        } else if (Trigger.isUpdate) {
            LeadTriggerHandler.updateAccountWhenLeadUpdated(Trigger.newMap, Trigger.oldMap);
        }
    }
}