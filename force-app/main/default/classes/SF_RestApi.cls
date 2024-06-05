public with sharing class SF_RestApi {
    public static void getListViews( String sObjectName ) {

        Http http = new Http();

        HttpRequest httpReq = new  HttpRequest();
        String orgDomain = Url.getOrgDomainUrl().toExternalForm();
        String endpoint = orgDomain + '/services/data/v59.0/sobjects/' + sObjectName + '/describe';
        httpReq.setEndpoint( endpoint );
        httpReq.setMethod( 'GET' );
        httpReq.setHeader( 'Content-Type', 'application/json; charset=UTF-8' );
        httpReq.setHeader( 'Accept', 'application/json' );
        String sessionId = 'Bearer ' + UserInfo.getSessionId();
        httpReq.setHeader( 'Authorization', sessionId );
        HttpResponse httpRes = http.send( httpReq );

        System.debug('@@@  httpRes: ' + httpRes);
        System.debug('@@@  httpRes: ' + httpRes.getBody());
    }
}