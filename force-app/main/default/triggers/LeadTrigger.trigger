trigger LeadTrigger on Lead (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            LeadTriggerHandler.updateAccount(Trigger.new);
        }
//        if (Trigger.isInsert) {
//            LeadTriggerHandler.updateAccountWhenLeadInserted(Trigger.new);
//        } else if (Trigger.isUpdate) {
//            LeadTriggerHandler.updateAccountWhenLeadUpdated(Trigger.newMap, Trigger.oldMap);
//        }
    }
}