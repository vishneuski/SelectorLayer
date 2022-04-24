public with sharing class ScheduleBatch2 implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name, Phone FROM Account WHERE Name=\'TestLWCAccount\' LIMIT 1');
    }

    public void execute(Database.BatchableContext bc, List<Account> accounts) {
        System.debug('Accounts : ' + accounts);
        List<Account> newAccounts = new List<Account>();
        for (Account account : accounts) {
            account.Phone = '555';
            newAccounts.add(account);
        }
        update newAccounts;
    }

    public void finish(Database.BatchableContext bc) {

    }
}