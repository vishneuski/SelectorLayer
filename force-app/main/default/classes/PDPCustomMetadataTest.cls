@IsTest
private class PDPCustomMetadataTest {
    @IsTest
    static void testBehavior() {
        List<PDPCustomMetadata__mdt> mdtMapping = (List<PDPCustomMetadata__mdt>)JSON.deserialize('[{"pdpNumber__c":"1", "pdpString__c":"testStr"}]', List<PDPCustomMetadata__mdt>.class);

        System.Test.startTest();
        PDPCustomMetadata.metadataMapping = mdtMapping;
        Map<String, String> result = PDPCustomMetadata.checkMetadata(PDPCustomMetadata.metadataMapping);
        System.Test.stopTest();

        System.debug('!!!Result - ' + result);
    }
}