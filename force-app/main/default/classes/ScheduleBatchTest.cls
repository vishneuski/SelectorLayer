@IsTest
private class ScheduleBatchTest {
    @IsTest
    static void scheduleTest() {
        String schedule = '0 00 22 * * ?';
        System.Test.startTest();
        String jobId = ScheduleBatch.runBatch();
        CronTrigger cronTrigger = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals(schedule, cronTrigger.CronExpression);
        System.assertEquals(0, cronTrigger.TimesTriggered);
        System.assertEquals('2021-07-30 22:00:00', String.valueOf(cronTrigger.NextFireTime));
        System.Test.stopTest();
    }


}