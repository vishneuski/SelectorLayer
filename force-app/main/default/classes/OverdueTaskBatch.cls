global with sharing class OverdueTaskBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        List<RecordType> RecordTypeList = Manager.getRecordType('Requested_Call');
        return Manager.getTasks(RecordTypeList[0].Id);
    }

    global void execute(Database.BatchableContext bc, List<Task> tasks) {
        DueDateTaskCustomNotification.notifyManager(tasks);
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Future: ' + Limits.getLimitFutureCalls());
        System.debug('Queue: ' + Limits.getLimitQueueableJobs());
    }
}