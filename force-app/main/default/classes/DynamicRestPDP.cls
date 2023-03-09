@RestResource(urlMapping='/Objects/*')
global with sharing class DynamicRestPDP {

//    @HttpDelete
//    global static void doDelete() {
//        RestRequest req = RestContext.request;
//        RestResponse res = RestContext.response;
//        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
//        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
//        delete account;
//    }
//
//    @HttpGet
//    global static Account doGet() {
//        RestRequest req = RestContext.request;
//        RestResponse res = RestContext.response;
//        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
//        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
//        return result;
//    }

    @HttpPost
    global static String doPost() {
        System.debug('!!! Post start');
        String jsonStr = RestContext.request.requestBody.toString();
        System.debug('!!! Request Body ' + jsonStr);

        List<SObject> sObjects = ObjectRestService.dataWorker(jsonStr);
        System.debug('!!!sObjects List' + sObjects);
        return 'Yes';
    }
}