@IsTest
private class CustomerRequestControllerTest {
    @IsTest
    static void newClientTest() {
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        String testUserInfo = '{"companyName":"TestCompanyName","companyEmail":"test@test.com","companyPhone":"+7-000-0000000","companyType":"Individual","contactFirstName":"TestFirstName","contactLastName":"TestLastName","contactEmail":"test1@test.com","contactMobilePhone":"+7-999-9999999","shippingName":"Plain","cargoWeight":"5000","cargoType":"Animals","fromCity":"Minsk","toCity":"Vitebsk","shippingDate":"2021-07-30","customerComments":"Some comment"}';

        System.Test.startTest();
        CustomerRequestController.getContacts(testUserInfo);
        System.Test.stopTest();
    }

    @IsTest
    static void existingContactTest() {
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        Contact contact = new Contact(FirstName = 'TestFirstName', LastName = 'TestLastName', Email = 'test1@test.com', Phone = '+7-111-1001100');
        insert contact;
        String testUserInfo = '{"companyName":"TestCompanyName","companyEmail":"test@test.com","companyPhone":"+7-000-0000000","companyType":"Individual","contactFirstName":"TestFirstName","contactLastName":"TestLastName","contactEmail":"test1@test.com","contactMobilePhone":"+7-111-1001100","shippingName":"Plain","cargoWeight":"5000","cargoType":"Animals","fromCity":"Minsk","toCity":"Vitebsk","shippingDate":"2021-07-30","customerComments":"Some comment"}';

        System.Test.startTest();
        CustomerRequestController.getContacts(testUserInfo);
        System.Test.stopTest();
    }

    @IsTest
    static void existingLeadTest() {
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        Lead lead = new Lead(Company = 'TestCompany', FirstName = 'TestFirstName', LastName = 'TestLastName', Email = 'test1@test.com', Phone = '+7-111-1001100');
        insert lead;
        String testUserInfo = '{"companyName":"TestCompanyName","companyEmail":"test@test.com","companyPhone":"+7-000-0000000","companyType":"Individual","contactFirstName":"TestFirstName","contactLastName":"TestLastName","contactEmail":"test1@test.com","contactMobilePhone":"+7-111-1001100","shippingName":"Plain","cargoWeight":"5000","cargoType":"Animals","fromCity":"Minsk","toCity":"Vitebsk","shippingDate":"2021-07-30","customerComments":"Some comment"}';

        System.Test.startTest();
        CustomerRequestController.getContacts(testUserInfo);
        System.Test.stopTest();
    }

    @IsTest
    static void existingLeadAndContactTest() {
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        Contact contact = new Contact(FirstName = 'TestFirstName', LastName = 'TestLastName', Email = 'test1@test.com', Phone = '+7-111-1001100');
        insert contact;
        Lead lead = new Lead(Company = 'TestCompany', FirstName = 'TestFirstName', LastName = 'TestLastName', Email = 'test1@test.com', Phone = '+7-111-1001100');
        insert lead;
        String testUserInfo = '{"companyName":"TestCompanyName","companyEmail":"test@test.com","companyPhone":"+7-000-0000000","companyType":"Individual","contactFirstName":"TestFirstName","contactLastName":"TestLastName","contactEmail":"test1@test.com","contactMobilePhone":"+7-111-1001100","shippingName":"Plain","cargoWeight":"5000","cargoType":"Animals","fromCity":"Minsk","toCity":"Vitebsk","shippingDate":"2021-07-30","customerComments":"Some comment"}';

        System.Test.startTest();
        CustomerRequestController.getContacts(testUserInfo);
        System.Test.stopTest();
    }

    @IsTest
    static void existingAccountTest() {
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        Account account = new Account(Name = 'TestCompanyAccount', Email__c = 'test@test.com');
        insert account;
        String testUserInfo = '{"companyName":"TestCompanyName","companyEmail":"test@test.com","companyPhone":"+7-000-0000000","companyType":"Individual","contactFirstName":"TestFirstName","contactLastName":"TestLastName","contactEmail":"test1@test.com","contactMobilePhone":"+7-999-9999999","shippingName":"Plain","cargoWeight":"5000","cargoType":"Animals","fromCity":"Minsk","toCity":"Vitebsk","shippingDate":"2021-07-30","customerComments":"Some comment"}';

        System.Test.startTest();
        CustomerRequestController.getContacts(testUserInfo);
        System.Test.stopTest();
    }
}