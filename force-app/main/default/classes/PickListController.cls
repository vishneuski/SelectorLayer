public with sharing class PickListController {
    @AuraEnabled (Cacheable=true)
    public static List<SObjectQueryResult> retrieveRecords(String objectName,
            String fieldAPINames,
            String filterFieldAPIName,
            String strInput) {
        System.debug(objectName);
        System.debug(fieldAPINames);
        System.debug(filterFieldAPIName);
        System.debug(strInput);
        List<SObjectQueryResult> resultOfRequest = new List<SObjectQueryResult>();
        try {
            resultOfRequest = PickListService.getPickListValues(objectName, fieldAPINames, filterFieldAPIName, strInput);
        } catch (Exception e) {
            throw e;
        }
        return resultOfRequest;
    }


    @AuraEnabled (Cacheable=true)
    public static List<Account> getAccount() {
        return [SELECT Id, Name FROM Account WHERE Name='TestLWCAccount' LIMIT 1];
    }

    @AuraEnabled (Cacheable=true)
    public static List<Contact> getContact() {
        return [SELECT Id, Name FROM Contact WHERE LastName='Barr' LIMIT 1];
    }

    @AuraEnabled (Cacheable=true)
    public static List<SObject> getRecordList(String objectType) {
        System.debug(objectType);
        return PickListService.getRecordList(objectType);
    }


    @AuraEnabled
    public static List<Contact> validateInput(String strForValidation) {
        System.debug(strForValidation);
        List<Contact> con = [SELECT Id, LastName FROM Contact WHERE LastName = :strForValidation];
        List<Contact> contacts;
        if (con.size() == 0 || String.isBlank(strForValidation) || strForValidation.startsWith(' ') || strForValidation == null) {
            throw new AuraHandledException('Something wrong');
        } else {
            contacts = [SELECT Id, LastName FROM Contact WHERE LastName = :strForValidation];
        }
        return contacts;
    }

    @AuraEnabled (Cacheable=true)
    public static List<Contact> getContacts() {
        return PickListService.getContacts();
    }

    @AuraEnabled (Cacheable=true)
    public static List<Account> getAccounts() {
        return PickListService.getAccounts();
    }
}