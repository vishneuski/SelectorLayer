@IsTest
private class DueDateTaskCustomNotificationTest {
    @IsTest
    static void testBehavior() {
        List<Task> tasks = new List<Task>();
        for (Integer i = 0; i < 10; i++) {
            Task task = new Task(Description = 'TestDescription' + i);
            tasks.add(task);
        }
        insert tasks;
        System.Test.startTest();
        DueDateTaskCustomNotification.notifyManager(tasks);
        System.Test.stopTest();
    }
}