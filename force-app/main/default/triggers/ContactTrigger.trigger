trigger ContactTrigger on Contact (before update, after update) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        System.debug('!!! BEFORE UPDATE CONTACT TRIGGER : ' + Trigger.new);
    } else if (Trigger.isAfter && Trigger.isUpdate) {
        System.debug('!!! AFTER UPDATE CONTACT TRIGGER : ' + Trigger.new);
    }
}