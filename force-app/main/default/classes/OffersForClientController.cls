public with sharing class OffersForClientController {
    
    @AuraEnabled
    public static List<Offer__c> getOffers(String recordId) {
        System.debug(recordId);
        return Manager.getOffers(recordId);
    }

    @AuraEnabled
    public static void selectOffer(String offer, Id recordId) {
        if(String.isBlank(offer) || recordId == null) {
            return;
        }
        System.debug(JSON.deserialize(offer, List<Offer__c>.class));
        List<Offer__c> offers = (List<Offer__c>) JSON.deserialize(offer, List<Offer__c>.class);
        Offer__c selectedOffer = offers[0];
        Order order = Manager.getOrder(recordId);
        User user = Manager.getUser(order);

        createContract(selectedOffer, order.AccountId, user.Id, recordId);
        changeWonOfferStatus(selectedOffer);
        changeLoseOffersStatus(recordId);
        changeOpportunityStatus(order);
    }

    private static void createContract(Offer__c offer, Id accountId, Id clientId, Id orderId) {
        System.debug(offer);
        Contract contract = new Contract(
                AccountId = accountId,
                OwnerId = UserInfo.getUserId(),
                Status = 'Draft',
                SpecialTerms = offer.Special_Terms__c,
                CustomerSignedDate = offer.Closed_Date__c.date(),
                Price__c = (offer.Max_Price__c + offer.Min_Price__c) / 2,
                Client_User__c = clientId,
                Order__c = orderId,
                Shipping_Company_User__c = offer.Shipping_Company_Owner__c,
                StartDate = Date.today()
        );
        insert contract;
    }


    private static void changeWonOfferStatus(Offer__c offer) {
        offer.Status__c = 'Winner';
        List<Offer__c> offers = new List<Offer__c>{offer};
        Manager.updateSObjects(offers);
    }

    private static void changeLoseOffersStatus(Id recordId) {
        List<Offer__c> offers = Manager.getLooseOffers(recordId);
        List<Offer__c> loserOffers = new List<Offer__c>();
        for (Offer__c offer: offers) {
            offer.Status__c = 'Loser';
            loserOffers.add(offer);
        }
        Manager.updateSObjects(loserOffers);
    }

    private static void changeOpportunityStatus(Order order) {
        Opportunity opportunity = Manager.getOpportunity(order);
        opportunity.StageName = 'Price Quote';
        List<Opportunity> opportunities = new List<Opportunity>{opportunity};
        Manager.updateSObjects(opportunities);
    }
}