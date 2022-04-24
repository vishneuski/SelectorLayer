global with sharing class ScheduleBatch implements Schedulable {
    global void execute(SchedulableContext sc) {
        OverdueTaskBatch taskBatch = new OverdueTaskBatch();
        Database.executeBatch(taskBatch);
    }

    global static String runBatch() {
        ScheduleBatch scheduleBatch = new ScheduleBatch();
        String schedule = '0 00 22 * * ?';
        return System.schedule('Batch Job', schedule, scheduleBatch);
    }
}