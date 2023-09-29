@RestResource(urlMapping='/Objects/*')
global with sharing class DynamicRestPDP {
  @HttpPost
  global static String doPost() {
    System.debug('!!! Post start');
    String jsonStr = RestContext.request.requestBody.toString();
    System.debug('!!! Request Body ' + jsonStr);

    List<SObject> sObjects = ObjectRestService.processRecords(jsonStr);
    System.debug('!!!sObjects List' + sObjects);
    return 'Yes';

    // switch on RestContext.request.requestURI.substringAfterLast('/') {
    //   when 'accounts' {
    //     doAccountsPost();
    //   }
    //   when 'contacts' {
    //     doContactsPost();
    //   }
    //   when else {
    //     doObjectsPost();
    //   }
    // }
  }
}