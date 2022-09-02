public without sharing class ETECreditEngineService implements CreditEngineService {

CE_CreditRequest__c creditRequest;
List<CE_BusinessOwner__c> businessOwners;
E2E_Data_Object__c dataObj;
String implKey;
String businessType;
ETEUserModel userModel;

public ETECreditEngineService(E2E_Data_Object__c dataObject, ETEUserModel userModelFromRequest, String implementationKey, String currentBusinessType) {
    dataObj = dataObject;
    implKey = implementationKey;
    userModel = userModelFromRequest;
    businessType = currentBusinessType;
}

/**
* @description  Convert E2EDataObject__c and ETEUserModel into request body object.
* Also we get CE_CreditRequest__c and List<CE_BusinessOwner__c> records to save after Http request.
*/
public virtual String convertDataForRequest() {
    CreditEngineDataConverter converter = new ETECreditEngineDataConverter(dataObj, userModel, businessType);
    Map<String, Object> convertResult = converter.convertData();

    if (convertResult?.containsKey(ETECreditEngineConstants.CREDIT_REQUEST)) {
        creditRequest = (CE_CreditRequest__c) convertResult.get(ETECreditEngineConstants.CREDIT_REQUEST);

        if (convertResult?.containsKey(ETECreditEngineConstants.BUSINESS_OWNERS)) {
            businessOwners = (List<CE_BusinessOwner__c>) convertResult.get(ETECreditEngineConstants.BUSINESS_OWNERS);
        }
        return String.valueOf(convertResult.get('requestBody'));
    } else {
        return '';
    }
}

/**
* @description Send Http Request to new Credit Engine Service. Http endpoint stored in custom metadata.
* Save Credit Engine objects after getting response.
*/
public virtual Map<String, Object> sendRequest(String requestBody) {
    Map<String, Object> filteredOffers = new Map<String, Object>();
    HttpResponse response;
    Http http = new Http();
    HttpRequest request = new HttpRequest();

    switch on implKey {
        when 'AllstarOne' {
            request.setHeader('Client_id', Credit_Engine_Setting__mdt.getInstance(implKey).MulesoftClientId__c);
            request.setHeader('Client_secret', Credit_Engine_Setting__mdt.getInstance(implKey).MulesoftClientSecret__c);
            request.setHeader('Content-Type', 'application/json');
            request.setEndpoint(Credit_Engine_Setting__mdt.getInstance(implKey).ServiceRestEndpoint__c);
            request.setMethod('POST');
            request.setBody(requestBody);
            response = http.send(request);

            if (creditRequest != null) {
                if (response.getStatusCode() == 200) {
                    creditRequest.Status__c = ETECreditEngineConstants.CREDIT_REQUEST_SUBMITTED_STATUS;
                    filteredOffers = processRequestResults(response);
                } else {
                    creditRequest.Status__c = ETECreditEngineConstants.CREDIT_REQUEST_ERROR_STATUS;
                    filteredOffers = processRequestResults(response);

                    Map<String, Object> responseBodyMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    throw new ETECreditEngineServiceException(ETECreditEngineConstants.CREDIT_ENGINE_ERROR + responseBodyMap.get('errorMessage'));
                }
            }
        }
        when else {
            return new Map<String, Object>();
        }
    }
    return filteredOffers;
}

/**
* @description Based on prohibited credit decision types provided by custom metadata, we  filter offers getting from Credit Engine service and then  asynchronously upsert Credit Engine objects records .
*/
public virtual Map<String, Object> processRequestResults(HttpResponse response) {
    CreditEngineResultsProcessor resultsProcessor = new ETECreditEngineResultsProcessor(response, creditRequest, businessOwners, Credit_Engine_Setting__mdt.getInstance(implKey).ProhibitedOfferTypes__c, dataObj.Id);
    Map<String, Object> filteredOffers = resultsProcessor.filterCreditEngineResults();

    return filteredOffers;
}

public class ETECreditEngineServiceException extends Exception {}
}