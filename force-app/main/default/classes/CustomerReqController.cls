public with sharing class CustomerReqController {
    @AuraEnabled
    public static List<Contact> getContacts(String phone, String email) {
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE Phone =:phone OR Email =:email ];
        return contacts;
    }
}