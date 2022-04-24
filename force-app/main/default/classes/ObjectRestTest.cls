@IsTest
private class ObjectRestTest {
    @IsTest
    static void testGet() {
        List<Contact> recordIds = [SELECT Id FROM Contact WHERE Id = '0035g00000DOFSGAA5'];
        List<Id> idList;
        for (Contact con: recordIds) {
            idList.add(con.Id);
        }

        RestRequest request = new RestRequest();
        request.requestURI = 'https://AP24.salesforce.com/services/apexrest/Objects/';
        request.requestBody = Blob.valueOf(idList.toString());
        request.httpMethod = 'GET';
        RestContext.request = request;

        Map<String, List<SObject>> sObjectsMap = ObjectRest.get();

        System.assert(sObjectsMap != null);
    }
}