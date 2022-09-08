public without sharing class Manager {
    public static List<Account> getAccountsByLeadPhone(Set<String> leadPhones) {
        return [SELECT Id, Phone, Name FROM Account WHERE Phone IN: leadPhones];
    }
}