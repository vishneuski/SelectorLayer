public with sharing class OfferController {
    @AuraEnabled
    public static List<Offer__c> getOffers(String recordId) {
        return Manager.getOffers(recordId);
    }

    @AuraEnabled
    public static void selectOffer(String offer, String recordId) {
        List<Offer__c> offers = (List<Offer__c>) JSON.deserialize(offer, List<Offer__c>.class);
        List<Opportunity> opportunities = [SELECT AccountId FROM Opportunity WHERE Id =: recordId];
        Id accountId = opportunities[0].AccountId;

        Order order = createOrder(accountId, opportunities[0]);
        createContract(offers[0], accountId);

//        System.debug(offers);
//        System.debug(recordId);
//        System.debug(opportunities);
    }

    private static Order createOrder(Id accountId, Opportunity opportunity) {
        Order order = new Order(
                AccountId = accountId,
                Status = 'New',
                Opportunity = opportunity,
                EndDate = opportunity.CloseDate
        );
        insert order;
        return order;
    }

    private static void createContract(Offer__c offer, Id accountId) {
        Contract contract = new Contract(
                AccountId = accountId,
                OwnerId = UserInfo.getUserId(),
                Status = 'Draft',
                SpecialTerms = offer.Special_Terms__c,
                CustomerSignedDate = offer.Closed_Date__c.date(),
                Price__c = (offer.Max_Price__c + offer.Min_Price__c) / 2
        );
        insert contract;
    }
}