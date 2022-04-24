trigger ContractSharingTrigger on Contract (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ContractSharingHandler.executeSharing(Trigger.New);
        }
    }
}