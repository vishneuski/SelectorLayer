@RestResource(urlMapping='/Objects/*')
global with sharing class DynamicRestPDP {
  @HttpPost
  global static void doPost() {
    String jsonStr = RestContext.request.requestBody.toString();
    ObjectRestService.ResponceWrapper result;
    RestResponse response = RestContext.response;

    switch on RestContext.request.requestURI.substringAfterLast('/') {
      when 'insert' {
        try {
          result = ObjectRestService.insertRecords(jsonStr);
          response = getOperationResponse(result);
        } catch (Exception e) {
          response = handleError(e.getMessage());
        }
      }
      when 'update' {
        try {
          result = ObjectRestService.updateRecords(jsonStr);
          response = getOperationResponse(result);
        } catch (Exception e) {
          response = handleError(e.getMessage());
        }
      }
      when else {
        try {
          result = ObjectRestService.doSmthElse(jsonStr);
          response = getOperationResponse(result);
        } catch (Exception e) {
          response = handleError(e.getMessage());
        }
      }
    }
  }

  private static RestResponse handleError(String errorMessage) {
    ObjectRestService.ResponceWrapper result = new ObjectRestService.ResponceWrapper();
    result.status = 'Error';
    result.error = errorMessage;
    return getOperationResponse(result);
  }

  private static RestResponse getOperationResponse(ObjectRestService.ResponceWrapper result) {
    RestResponse res = RestContext.response;
    res.addHeader('Content-Type', 'application/json');
    res.responseBody = Blob.valueOf(JSON.serialize(result));
    res.statusCode = result.status == 'Success' ? 201 : 400;

    return res;
  }
}
