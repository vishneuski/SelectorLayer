@IsTest
private class CountryCodesServiceTest {
    @IsTest
    static void test() {
        String prefix = '375';
        System.Test.setMock(HttpCalloutMock.class, new CountryCodesServiceCalloutMock());
        HttpResponse response = CountryCodesService.getCountryCode(prefix);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        String expectedValue = '[{"alpha3Code":"BLR"}]';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    }
}