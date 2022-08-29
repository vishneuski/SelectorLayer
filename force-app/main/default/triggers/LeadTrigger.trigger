trigger LeadTrigger on Lead (after insert, after update) {
    //****************TRIGGERS*********************
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            LeadTriggerHandler.updateAccountWhenLeadInserted(Trigger.new);
        } else if (Trigger.isUpdate) {
            LeadTriggerHandler.updateAccountWhenLeadUpdated(Trigger.newMap, Trigger.oldMap);
        }
    }
}