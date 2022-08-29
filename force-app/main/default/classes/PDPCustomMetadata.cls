public with sharing class PDPCustomMetadata {

    @testVisible static List<PDPCustomMetadata__mdt> metadataMapping {
        get {
            if (metadataMapping == NULL){
                metadataMapping = [SELECT pdpNumber__c, pdpString__c FROM PDPCustomMetadata__mdt];
            }
            return metadataMapping;
        }
        set;
    }

    public static Map<String, String> checkMetadata(List<PDPCustomMetadata__mdt> mdt) {
        Map<String, String> mdtLists = new Map<String, String>();

        String pdpStr = mdt[0].get('pdpString__c').toString();
        Integer pdpNum = Integer.valueOf(mdt[0].get('pdpNumber__c'));

        mdtLists.put(String.valueOf(pdpNum), pdpStr);
        System.debug(mdtLists);

        return mdtLists;
    }
}