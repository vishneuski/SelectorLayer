public with sharing class CountryAbbreviation {

    @Future(Callout=true)
    public static void setCountryCodeByPhone(List<Id> IdList, String sObjectType) {
        List<SObject> sObjectsForUpdate = new List<SObject>();
        Map<String, String> phoneCodes = new Map<String, String>();
        List<CountryCode> countryCodes;
        System.debug('Future: ' + Limits.getLimitFutureCalls());
        System.debug('Queue: ' + Limits.getLimitQueueableJobs());
        
        for (SObject sobjectItem : Manager.getSObjectsList(IdList, sObjectType)) {
            String prefix = CountryPhoneCode.getPhonePrefix((String) sobjectItem.get('Phone'));
            if (prefix != null && !phoneCodes.containsKey(prefix)) {
                HttpResponse response = CountryCodesService.getCountryCode(prefix);
                System.debug(response);
                if (response.getStatusCode() == 200) {
                    countryCodes = (List<CountryCode>) JSON.deserializeStrict(response.getBody(), List<CountryCode>.class);
                }
                phoneCodes.put(prefix, countryCodes[0].alpha3Code);
             }
            sobjectItem.put('Country_from_Phone__c', phoneCodes.get(prefix));
            sObjectsForUpdate.add(sobjectItem);
        }
        Manager.updateSObjects(sObjectsForUpdate);
    }
    public class CountryCode {
        public String alpha3Code;
    }
}