public with sharing class AuraController {
    @AuraEnabled
    public static String getData(){
        try {
            System.debug('!!!getData');
            return 'Response from Apex!';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Lead> getLeads(){
        try {
            System.debug('!!! get Leads');
            return [SELECT Id, Name, Phone, Fax FROM Lead LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Contact createContact(Contact contact){
        upsert contact;
        return contact;
    }
}