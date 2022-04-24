public with sharing class LWCBatch implements Database.Batchable<SObject>, Database.RaisesPlatformEvents {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name, Phone FROM Account WHERE Name=\'TestLWCAccount\' LIMIT 1');
    }

    public void execute(Database.BatchableContext bc, List<Account> accounts) {
        System.debug('Accounts : ' + accounts);
        List<Account> newAccounts = new List<Account>();
        for (Account account : accounts) {
            account.Phone = '444';
            newAccounts.add(account);
        }
        update newAccounts;
    }

    public void finish(Database.BatchableContext bc) {
        LWCPlatformEvent__e lwcPlatformEvents = new LWCPlatformEvent__e();
        System.debug('lwcPlatformEvents : ' + lwcPlatformEvents);
        Database.SaveResult sr = EventBus.publish(lwcPlatformEvents);

        if (sr.isSuccess()) {
            System.debug('Successfully Publish Event');
        } else {
            System.debug('Error!');
        }
    }
}