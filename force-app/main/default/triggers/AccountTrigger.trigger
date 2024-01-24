trigger AccountTrigger on Account (after update) {
    
    System.debug('!!! AFTER UPDATE ACCOUNT TRIGGER');

    Contact contact = [SELECT Id, Phone FROM Contact WHERE Fax = '56789' LIMIT 1];

    contact.OtherPhone = '12345';
    update contact;
}