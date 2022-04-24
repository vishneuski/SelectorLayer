@IsTest
private class CountryAbbreviationTest {
    @IsTest
    static void correctPhoneTest() {
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        Lead lead = new Lead(LastName = 'Test CA', Phone = '+375-11-1234561', Company = 'Test CA', Status = 'Open');
        insert lead;
        List<Lead> leads = [SELECT Id, Phone FROM Lead WHERE Phone = '+375-11-1234561' LIMIT 1];
        List<Id> leadsId = new List<Id>();
        for (Lead leadItem : leads) {
            leadsId.add(leadItem.Id);
        }
        String sObjType = 'Lead';

        System.Test.startTest();
        CountryAbbreviation.setCountryCodeByPhone(leadsId, sObjType);
        System.Test.stopTest();

        List<Lead> leadList = [SELECT Id FROM Lead WHERE Phone = '+375-11-1234561' AND Country_from_Phone__c = 'BLR'];
        System.assertEquals(leadList.size(), 1);
    }

    @IsTest
    static void invalidPhoneTest() {
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        Lead lead = new Lead(LastName = 'Test2 CA', Phone = '+qwe-qweqeqwedq1', Company = 'Test2 CA', Status = 'Open');
        insert lead;
        List<Lead> leads = [SELECT Id, Phone FROM Lead WHERE Phone = '+qwe-qweqeqwedq1' LIMIT 1];
        List<Id> leadsId = new List<Id>();
        for (Lead leadItem : leads) {
            leadsId.add(leadItem.Id);
        }
        String sObjType = 'Lead';

        System.Test.startTest();
        CountryAbbreviation.setCountryCodeByPhone(leadsId, sObjType);
        System.Test.stopTest();

        List<Lead> leadList = [SELECT Id, Country_from_Phone__c FROM Lead WHERE Phone = '+qwe-qweqeqwedq1'];
        System.assertEquals(leadList.size(), 1);
        System.assertEquals(leadList[0].Country_from_Phone__c, null);
    }

    @IsTest
    static void bulkInsertPhonesTest() {
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        List<Lead> newLeads = new List<Lead>();
        for (Integer i = 0; i < 300; i++) {
            Lead lead = new Lead(LastName = 'Test2 CA' + i, Phone = '+375-99-1234561', Company = 'Test2 CA' + i, Status = 'Open');
            newLeads.add(lead);
        }
        insert newLeads;
        List<Lead> leads = [SELECT Id, Phone FROM Lead WHERE Phone = '+375-99-1234561' LIMIT 300];
        List<Id> leadsId = new List<Id>();
        for (Lead leadItem : leads) {
            leadsId.add(leadItem.Id);
        }
        String sObjType = 'Lead';

        System.Test.startTest();
        CountryAbbreviation.setCountryCodeByPhone(leadsId, sObjType);
        System.Test.stopTest();

        List<Lead> leadList = [SELECT Id FROM Lead WHERE Phone = '+375-99-1234561' AND Country_from_Phone__c = 'BLR'];
        System.assertEquals(leadList.size(), 300);
    }
}