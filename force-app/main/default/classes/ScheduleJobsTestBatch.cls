public with sharing class ScheduleJobsTestBatch implements Database.Batchable<sObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext BC) {
	    return Database.getQueryLocator(
            [SELECT Id, Phone FROM Lead LIMIT 1]
        );
    }

    public void execute(Database.BatchableContext BC, List<Lead> leads) {
        // System.debug('!!!EXECUTE chunk size - ' + leads.size());

        // Set<Id> ids = new Set<Id>();

        // for (Lead l : leads) {
        //     ids.add(l.Id);
        //     // System.debug('!!! l.phone : ' + l.Phone);
        // }


        // List<Lead> leadsList = [SELECT ID, Phone FROM Lead WHERE Id IN: ids]; 

        // System.debug('SOQL LIST SIZE' + leadsList.size());
      
    }

    public void finish(Database.BatchableContext BC) {

        Set<Id> ids = new Set<Id>();
        List<Lead> leads = [Select Id from Lead];

        for (Lead l : leads) {
            ids.add(l.Id);
        }

        System.debug('!!! IN: Ids');
        String query = 'SELECT Id FROM Lead WHERE Id IN :ids';
       
        List<Lead> leads1 = Database.query(query);
        System.debug('!!!DATABASE QUERY : ' + leads1.size());

        // ScheduleJobsTestBatch sch = new ScheduleJobsTestBatch();
        // Datetime dt = Datetime.now().addSeconds(10);  
        // String schCronExp = dt.format('s m H d M \'?\' yyyy');
        // Id schedId = System.Schedule('JobName' + dt, schCronExp, sch);
    } 

    public void execute(SchedulableContext ctx) {
        System.debug('!!! SCHEDULE EXECUTE : ');
        Database.executeBatch(new ScheduleJobsTestBatch(), 200);
    }   
}