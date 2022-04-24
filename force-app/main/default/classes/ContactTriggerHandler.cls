public with sharing class ContactTriggerHandler {
    public static void getIdList(List<Contact> contacts) {
        Account_Selector accSel = new Account_Selector();
        List<Account> accounts = accSel.selectById(new Set<Id>{'0015g00000cN6IYAA0'});
        System.debug('!!!' + accounts);
        List<Id> contactsIdList = new List<Id>();
        String sobjectType = contacts[0].Id.getSobjectType().getDescribe().getName();
        for (Contact contact : contacts) {
            if (contact.Phone != null) {
                contactsIdList.add(contact.Id);
            }
        }
        CountryAbbreviation.setCountryCodeByPhone(contactsIdList, sobjectType);
    }
}