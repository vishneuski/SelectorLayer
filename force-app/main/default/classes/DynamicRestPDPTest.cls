@isTest
private class DynamicRestPDPTest {

    @isTest
    static void myUnitTest() {
        RestRequest request = new RestRequest();
        request.requestUri = 'https://AP24.salesforce.com/services/apexrest/Objects/insert';
        request.httpMethod = 'POST';

        ObjectRestService.DMLRequestWrapper wrapper = new ObjectRestService.DMLRequestWrapper();
        wrapper.objectApiName = 'Account';

        List<ObjectRestService.Field> fields = new List<ObjectRestService.Field>();
        ObjectRestService.Field field = new ObjectRestService.Field();
        field.fieldApiName = 'Name';
        field.fieldValue = 'TestAccountTest';
        fields.add(field);
        wrapper.fields =  fields;

        Blob k = Blob.valueOf(JSON.serialize(wrapper));
        request.requestBody = k;

        RestContext.request = request;
        DynamicRestPDP.doPost();

        System.debug('!!!Account : ' + [SELECT ID, Name from Account]);
    }
}