@IsTest
private class RestServiceTest {
    @IsTest
    static void testAccountWithOrders() {
        Account account = new Account(
                Name = 'TestApexRestAccount'
        );
        insert account;
        Id accountId = account.Id;
        Order order = new Order(AccountId = accountId, Status = 'New', EffectiveDate = Date.newInstance(2019, 12, 31), EndDate = Date.newInstance(2020, 12, 31));
        insert order;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://AP24.salesforce.com/services/apexrest/Orders/' + accountId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestService.OrderResponseWrapper orderResWrap = RestService.getOrdersById();
        System.assert(orderResWrap != null);
        System.assertEquals(Date.newInstance(2019, 12, 31), orderResWrap.orders[0].startDate);
        System.assertEquals(Date.newInstance(2020, 12, 31), orderResWrap.orders[0].endDate);
    }

    @IsTest
    static void testInvalidClientId() {
        Lead lead = new Lead(
                LastName = 'TestLastName',
                Company = 'TestCompany'
        );
        insert lead;
        Id leadId = lead.Id;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://AP24.salesforce.com/services/apexrest/Orders/' + leadId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestService.OrderResponseWrapper orderResWrap = RestService.getOrdersById();
        System.assert(orderResWrap != null);
        System.assertEquals('Client not found', orderResWrap.error);
        System.assertEquals('error', orderResWrap.status);
        System.assertEquals(null, orderResWrap.orders);
    }

    @IsTest
    static void testAccountWithoutOrders() {
        Account account = new Account(
                Name = 'TestApexRestAccount'
        );
        insert account;
        Id accountId = account.Id;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://AP24.salesforce.com/services/apexrest/Orders/' + accountId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestService.OrderResponseWrapper orderResWrap = RestService.getOrdersById();
        System.assert(orderResWrap != null);
        System.assertEquals('Wrong parameter', orderResWrap.error);
        System.assertEquals('error', orderResWrap.status);
    }
}