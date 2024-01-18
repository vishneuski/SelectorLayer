public with sharing class ScheduleJobsTestBatch implements Database.Batchable<sObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext BC) {
	    return Database.getQueryLocator(
            [SELECT Id FROM Lead LIMIT 1]
        );
    }

    public void execute(Database.BatchableContext BC, List<Lead> leads) {
        System.debug('!!!EXECUTE chunk size - ' + leads.size());
    }

    public void finish(Database.BatchableContext BC) {
        ScheduleJobsTestBatch sch = new ScheduleJobsTestBatch();
        Datetime dt = Datetime.now().addSeconds(10);  
        String schCronExp = dt.format('s m H d M \'?\' yyyy');
        Id schedId = System.Schedule('JobName' + dt, schCronExp, sch);

    } 

    public void execute(SchedulableContext ctx) {
        System.debug('!!! SCHEDULE EXECUTE : ');
        Database.executeBatch(new ScheduleJobsTestBatch(), 200);
    }   
}