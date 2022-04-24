@IsTest
private class OverdueTaskBatchTest {
    @IsTest
    static void testBehavior() {
        List<RecordType> recordTypes = [SELECT Id FROM RecordType WHERE DeveloperName = 'Requested_Call'];
        List<Task> tasks = new List<Task>();
        for (Integer i = 0; i < 10; i++) {
            Task task = new Task(Mobile_Phone__c = '333', Status = 'New', RecordTypeId = recordTypes[0].Id);
            tasks.add(task);
        }
        insert tasks;

        System.Test.startTest();
        OverdueTaskBatch taskBatch = new OverdueTaskBatch();
        Id batchId = Database.executeBatch(taskBatch);
        System.Test.stopTest();
        List<Task> insertedTasks = [SELECT Id FROM Task WHERE Mobile_Phone__c = '333'];
        System.assertEquals(10, insertedTasks.size());
    }
}