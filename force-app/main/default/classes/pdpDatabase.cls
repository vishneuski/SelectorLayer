public with sharing class pdpDatabase {

    public static void databaseExecute() {
        Account a = new Account(name = 'Acme1');
        Database.SaveResult[] saveResults = Database.insert(new Account[]{
                a, new Account()
        }, false);

        for (Database.SaveResult sr : saveResults) {
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Account ID: ' + sr.getId());
            } else {
                // Operation failed, so get all errors
                for (Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
    }
}