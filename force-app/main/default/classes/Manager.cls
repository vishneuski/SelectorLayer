public without sharing class Manager {
    public static List<Account> getAccountsByLeadPhone(Set<String> leadPhones) {
        return [SELECT Id, Phone, Name FROM Account WHERE Phone IN: leadPhones];
    }

    public static List<Contact> getContacts(String phone, String email) {
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Phone = :phone OR Email = :email];
        return contacts;
    }

    public static List<Lead> getLeads(String phone, String mail) {
        List<Lead> leads = [SELECT Id FROM Lead WHERE Phone = :phone OR Email = :mail];
        return leads;
    }

    public static LeadStatus getLeadStatus() {
        LeadStatus leadStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = TRUE LIMIT 1];
        return leadStatus;
    }

    public static List<Account> getAccount(String email) {
        List<Account> accounts = [SELECT Id, OwnerId, Name FROM Account WHERE Email__c = :email LIMIT 1];
        return accounts;
    }

    public static void addsObject(SObject sobj) {
        insert sobj;
    }

    public static void addTasks(List<Task> tasks) {
        insert tasks;
    }

    public static Id getOwnerId() {
        List<Profile> profileId = [SELECT Id FROM Profile WHERE Name = 'Sales Manager'];
        System.debug(profileId);
        User user = [SELECT Id FROM User WHERE ProfileId = :profileId[0].Id];
        return user.Id;
    }

    public static List<SObject> getSObjectsList(List<Id> IdList, String sObjectType) {
        return Database.query('SELECT Id, Phone FROM ' + sObjectType + ' WHERE Id IN:IdList');
    }

    public static void updateSObjects(List<SObject> sObj) {
        update sObj;
    }

    public static List<RecordType> getRecordType(String option) {
        return [SELECT Id FROM RecordType WHERE DeveloperName = :option];
    }

    public static Database.QueryLocator getTasks(Id id) {
        return Database.getQueryLocator(
        [
                SELECT Id, OwnerId
                FROM Task
                WHERE Status = 'New'
                AND ActivityDate < TODAY
                AND RecordTypeId = :id
        ]);
    }

    public static CustomNotificationType getNotification() {
        return [
                SELECT Id, DeveloperName
                FROM CustomNotificationType
                WHERE DeveloperName = 'Batch_Custom_Notification'
        ];
    }

    public static List<Order> getOrdersByClientId(Id clientId) {
        return [
                SELECT
                        Id,EffectiveDate,EndDate, Status,
                        SLA_Offers_Date__c, Cargo_weight__c,
                        Cargo_type__c,To_City__c, From_City__c
                FROM Order
                WHERE (AccountId = :clientId OR BillToContactId = :clientId) AND Status != 'Finished' AND Status != 'Cancelled'
        ];
    }

    public static List<Offer__c> getOffers(Id orderId) {
        return [SELECT Name, Max_Price__c, Min_Price__c, Closed_Date__c, Shipping_Company_Owner__c, Special_Terms__c FROM Offer__c WHERE Status__c = 'New' AND Order__c = :orderId];
    }

    public static List<Offer__c> getLooseOffers(Id orderId) {
        return [SELECT Status__c FROM Offer__c WHERE Status__c = 'New' AND Status__c != 'Winner' AND Order__c = :orderId];
    }

    public static Order getOrder(Id recordId) {
        List<Order> orders = [SELECT AccountId, ShipToContactId, OpportunityId FROM Order WHERE Id = :recordId];
        return orders[0];
    }

    public static User getUser(Order order) {
        List<User> users = [SELECT Id FROM User WHERE ContactId = :order.ShipToContactId];
        return users[0];
    }

    public static Opportunity getOpportunity(Order order) {
        List<Opportunity> opportunities = [SELECT Id, StageName FROM Opportunity WHERE Id = :order.OpportunityId];
        return opportunities[0];
    }

    public static Id getAccountByUserId(Id ownerId) {
        List<Account> accounts = [SELECT Id FROM Account WHERE OwnerId =: ownerId];
        return accounts[0].Id;
    }
}