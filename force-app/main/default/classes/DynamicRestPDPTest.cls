@isTest
private class DynamicRestPDPTest {

    @isTest
    static void restPostTest() {
        String accountName = 'TestAccountTest';

        String testJson = '[{'+
        '   \"objectApiName\" : \"Account\", ' + 
        '   \"fields\" : [' +
        '       {' +
        '           \"fieldApiName\" : \"Name\", ' + 
        '           \"fieldValue\" :' + '\"' + accountName + '\"' +    
        '       }' +
        '   ]' +
        '}]';
        

        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Objects/insert';
        request.httpMethod = 'POST';
        RestContext.request = request;
        request.requestBody = Blob.valueOf(testJson);

        Test.startTest();
        DynamicRestPDP.doPost();
        Test.stopTest();

        List<Account> accounts = [SELECT Id, Name FROM Account]; 

        Assert.areEqual(1, accounts.size());
        Assert.areEqual(accountName, accounts.get(0).Name);
    }
}