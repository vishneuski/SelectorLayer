@RestResource(urlMapping='/Account/UploadFile/*')
global with sharing class AccountFilesUploader {

    @HttpPost
    global static void handlePost() {
        RestRequest request = RestContext.request;
        RestResponse response = Restcontext.response;

        String actionName = request.requestURI.substringAfterLast('/').toLowerCase();
        Id accountId = request.params.get('woId');
        String contentType = request.params.get('contenttype');
        String name = request.params.get('name');
    
        try {
            switch on actionName {
                when 'addbinaryfile' {
                    addBinaryFile(request);
                } when 'addbase64file' {
                    addBase64File(request);
                } when else {
                    System.debug('ERROR');
                }
            }
        } catch (Exception ex) {
            system.debug(LoggingLevel.ERROR, ex.getMessage());
            system.debug(LoggingLevel.ERROR, ex.getStackTraceString());
        }
    }

    public static void addBinaryFile(RestRequest request) {

        Id accountId = request.params.get('accountId');
        String contentType = request.params.get('contenttype');
        String name = request.params.get('name');
    
        ContentVersion cVersion = new ContentVersion();
        cVersion.PathOnClient = name;
        cVersion.Title = name;
        cVersion.VersionData = request.requestBody;
        insert cVersion;
    
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;

        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;
        cDocLink.LinkedEntityId = accountId;
        insert cDocLink;
    }
    
    
    public static void addBase64File(RestRequest request) {
        Id accountId = request.params.get('accountId');
        String contentType = request.params.get('contenttype');
        String name = request.params.get('name');
        String jsonString = request.requestBody.toString();
    
        ContentVersion cVersion = new ContentVersion();
        cVersion.PathOnClient = name;
        cVersion.Title = name;
        cVersion.VersionData = EncodingUtil.base64Decode(jsonString);
        insert cVersion;
    
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
    
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;
        cDocLink.LinkedEntityId = accountId;
        insert cDocLink;
    }
}
