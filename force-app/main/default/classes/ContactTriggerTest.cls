@IsTest
private class ContactTriggerTest {
    @IsTest
    static void contactTriggerTest() {
        Contact testContact = new Contact(LastName = 'Test Contact');
        insert testContact;
        List<Contact> contacts = [SELECT Id, Phone FROM Contact WHERE LastName = 'Test Contact'];
        System.Test.startTest();
        ContactTriggerHandler.getIdList(contacts);
        System.Test.stopTest();
        System.assertEquals(1, contacts.size());
    }
}