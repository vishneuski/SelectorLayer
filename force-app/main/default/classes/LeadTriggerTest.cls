@IsTest
private class LeadTriggerTest {
    @IsTest
    static void leadTriggerTest() {
        Lead testLead = new Lead(LastName = 'Test Lead', Company = 'TestLead Company', Status = 'Open');
        insert testLead;
        List<Lead> leads = [SELECT Id, Phone FROM Lead WHERE Company = 'TestLead Company'];
        System.Test.startTest();
        LeadTriggerHandler.getIdList(leads);
        System.Test.stopTest();
        System.assertEquals(1, leads.size());
    }
}