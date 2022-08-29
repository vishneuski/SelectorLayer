trigger LeadTrigger on Lead (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            LeadTriggerHandler.updateAccount(Trigger.new);
        }
    }
}