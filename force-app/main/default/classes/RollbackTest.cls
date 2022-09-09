public with sharing class RollbackTest {
    public static void testRollback() {
        Contact contact = new Contact(FirstName = 'xxx', LastName='yyy');
        insert contact;
        Savepoint sp = Database.setSavepoint();

        try {
            contact.Id = '12345';
            update contact;
        } catch(Exception e) {
            Database.rollback(sp);
        }
    }
}
