public with sharing class CountryCodesService {
    public static HttpResponse getCountryCode(String prefix) {
        HttpRequest request = new HttpRequest();
        String endpoint = 'https://restcountries.eu/rest/v2/callingcode/' + prefix + '?fields=alpha3Code';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = new Http().send(request);
        return response;
    }
}