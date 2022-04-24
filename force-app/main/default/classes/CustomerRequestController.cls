public without sharing class CustomerRequestController {

    @AuraEnabled
    public static Boolean getUserInfo() {
        System.debug('GUEST USER INFORMATION' + System.UserInfo.getUserType());
        return System.UserInfo.getUserType() == 'Guest';
    }

    @AuraEnabled
    public static void getContacts(String customerInfo) {
        CustomerInfo info = (CustomerInfo) JSON.deserialize(customerInfo, CustomerInfo.class);
        System.debug('Customer INFO' +info);
        if (System.UserInfo.getUserType() != 'Guest') {
            System.debug('USER ID' +System.UserInfo.getUserId());
//            System.debug('USER NAME' +System.UserInfo.getName());
//            createOpportunity(info, Manager.getAccountByUserId(System.UserInfo.getUserId()), System.UserInfo.getUserId(), System.UserInfo.getName());
//            System.debug(System.UserInfo.getUserId());
        }
        List<Contact> contacts = Manager.getContacts(info.contactMobilePhone, info.contactEmail);
        List<Lead> leads = Manager.getLeads(info.contactMobilePhone, info.contactEmail);

        if (contacts.isEmpty() && leads.isEmpty()) {
            addClient(info);
        } else {
            updateClientInfo(contacts, leads);
        }
    }

    private static void addClient(CustomerInfo info) {
        List<Account> accounts = Manager.getAccount(info.companyEmail);
        Id accountId;
        Id accountOwnerId;
        String accountOwnerName = 'New Opportunity';
        if (accounts.isEmpty()) {
            Account account = createAccount(info);
            Manager.addsObject(account);
            accountOwnerId = account.OwnerId;
            accountOwnerName = account.Name;
            accountId = account.Id;
            createContact(accountId, info);
        } else {
            accountId = accounts[0].Id;
            accountOwnerId = accounts[0].OwnerId;
            createContact(accountId, info);
        }
        createOpportunity(info, accountId, accountOwnerId, accountOwnerName);
    }

    private static void updateClientInfo(List<Contact> contacts, List<Lead> leads) {
        if (leads.isEmpty() && !contacts.isEmpty()) {
            createNewTask(contacts);
        } else if (!leads.isEmpty() && contacts.isEmpty()) {
            convertLead(leads);
        } else {
            createNewTask(contacts);
            convertLead(leads);
        }
    }

    private static void createOpportunity(CustomerInfo customerInfo, Id accountId, Id accountOwnerId, String accountOwnerName) {
        Opportunity opportunity = new Opportunity(
                AccountId = accountId,
                Amount = 0,
                StageName = 'New',
                OwnerId = accountOwnerId,
                Name = accountOwnerName,
                CloseDate = Date.today().addMonths(1).toStartOfMonth().addDays(-1),
                Probability = 10,
                Shipping_Name__c = customerInfo.shippingName,
                Cargo_weight__c = customerInfo.cargoWeight,
                Cargo_type__c = customerInfo.cargoType,
                From_City__c = customerInfo.fromCity,
                To_City__c = customerInfo.toCity
        );
        Manager.addsObject(opportunity);
    }

    private static void createContact(Id id, CustomerInfo customerInfo) {
        Contact contact = new Contact(
                AccountId = id,
                Email = customerInfo.contactEmail,
                Phone = customerInfo.contactMobilePhone,
                Language__c = 'EN',
                FirstName = customerInfo.contactFirstName,
                LastName = customerInfo.contactLastName
        );
        Manager.addsObject(contact);
    }

    private static Account createAccount(CustomerInfo customerInfo) {
        return new Account(Name = customerInfo.companyName,
                OwnerId = Manager.getOwnerId(),
                Email__c = customerInfo.companyEmail,
                Phone = customerInfo.companyPhone,
                Type = customerInfo.companyType);
    }

    private static void createNewTask(List<Contact> contacts) {
        List<Task> tasks = new List<Task>();
        for (Contact contact : contacts) {
            Task task = new Task(WhoId = contact.Id);
            tasks.add(task);
        }
        Manager.addTasks(tasks);
    }

    private static void convertLead(List<Lead> leads) {
        for (Lead lead : leads) {
            Database.LeadConvert lc = new database.LeadConvert();
            lc.setLeadId(lead.Id);
            LeadStatus convertStatus = Manager.getLeadStatus();
            lc.setConvertedStatus(convertStatus.MasterLabel);
            Database.LeadConvertResult lcr = Database.convertLead(lc);
        }
    }
}