public with sharing class DueDateTaskCustomNotification {
    public static void notifyManager(List<Task> taskList) {
        String language = UserInfo.getLanguage();
        Map<String, String> notificationTranslate = new Map<String, String>();
        notificationTranslate.put('en_US', 'Attention: you have an unclosed task');
        notificationTranslate.put('ru', 'Внимание: у Вас есть незакрытая задача');

        for (Task task : taskList) {
            CustomNotificationType notificationType = Manager.getNotification();
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            notification.setTitle('Custom Notification');
            notification.setBody(notificationTranslate.get(language));
            notification.setNotificationTypeId(notificationType.Id);
            notification.setTargetPageRef('{"type": "standard__objectPage","attributes": {"objectApiName": "Task","actionName": "list"},"state":{"filterName":"Recent"}}');
            try {
                sendNotification(notification, task.OwnerId);
            } catch (Exception e) {
                System.debug('Problem sending notification: ' + e.getMessage());
            }
        }
    }

    private static void sendNotification(Messaging.CustomNotification notification, Id ownerId) {
        notification.send(new Set<String>{ownerId});
    }
}