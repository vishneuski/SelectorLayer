@IsTest
global class CountryCodesServiceCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"alpha3Code":"BLR"}]');
        res.setStatusCode(200);
        return res;
    }
}