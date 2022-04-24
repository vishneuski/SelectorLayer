@IsTest
private class ManagerTest {
    @IsTest
    static void getSObjectListTest() {
        String sObjectType = 'Contact';
        List<Contact> contacts = new List<Contact>();
        for (Integer i =0; i < 20; i++) {
            Contact contact = new Contact(LastName = 'ManagerTest'+ i, FirstName = 'TestManagerClass');
            contacts.add(contact);
        }
        insert contacts;
        List<Contact> insertedContacts = [SELECT Id FROM Contact WHERE FirstName = 'TestManagerClass'];
        List<Id> ids = new List<Id>();
        for(Contact cont: insertedContacts) {
            ids.add(cont.Id);
        }

        System.Test.startTest();
        List<SObject> sObjectsList = Manager.getSObjectsList(ids, sObjectType);
        System.Test.stopTest();

        System.assertEquals(20, sObjectsList.size());
    }
}