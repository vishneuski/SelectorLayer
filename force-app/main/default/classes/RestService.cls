@RestResource(UrlMapping='/Orders/*')
global with sharing class RestService {

    @HttpGet
    global static OrderResponseWrapper getOrdersById() {
        RestRequest request = RestContext.request;
        String clientId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        String sobjectType = checksObjectType(clientId);
        OrderResponseWrapper orderWrapper = checkClientId(clientId, sobjectType);

        if (orderWrapper.error == 'Client not found') {
            return orderWrapper;
        } else {
            orderWrapper.clientId = clientId;
            orderWrapper.orders = new List<OrderForResponse>();
        }
        List<Order> orderList = Manager.getOrdersByClientId(clientId);
        if (!orderList.isEmpty()) {
            orderWrapper.status = 'Success';
            for (Order order : orderList) {
                OrderForResponse orderForResponse = new OrderForResponse();
                orderForResponse.id = order.Id;
                orderForResponse.startDate = order.EffectiveDate;
                orderForResponse.endDate = order.EndDate;
                orderForResponse.status = order.Status;
                orderForResponse.offersDate = order.SLA_Offers_Date__c;
                orderForResponse.cargoWeight = order.Cargo_weight__c;
                orderForResponse.cargoType = order.Cargo_type__c;
                orderForResponse.to = order.To_City__c;
                orderForResponse.froms = order.From_City__c;
                orderWrapper.orders.add(orderForResponse);
            }
        } else {
            orderWrapper.status = 'error';
            orderWrapper.error = 'Wrong parameter';
        }
        return orderWrapper;
    }

    global static String checksObjectType(String clientId) {
        if (clientId instanceof Id) {
            return Id.valueOf(clientId).getSobjectType().getDescribe().getName();
        }
        return clientId;
    }

    public static OrderResponseWrapper checkClientId(String clientId, String sobjectType) {
        OrderResponseWrapper orderResponseWrapper = new OrderResponseWrapper();
        if (clientId == null || clientId == '' || sobjectType != 'Account' && sobjectType != 'Contact') {
            orderResponseWrapper.clientId = clientId;
            orderResponseWrapper.status = 'error';
            orderResponseWrapper.error = 'Client not found';
            orderResponseWrapper.orders = null;
        }
        return orderResponseWrapper;
    }

    global class OrderResponseWrapper {
        public String clientId;
        public String status;
        public String error;
        public List<OrderForResponse> orders;
    }

    global class OrderForResponse {
        public String id;
        public Date startDate;
        public Date endDate;
        public String status;
        public Datetime offersDate;
        public Decimal cargoWeight;
        public String cargoType;
        public String to;
        public String froms;
    }
}