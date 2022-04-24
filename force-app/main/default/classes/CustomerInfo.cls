public with sharing class   CustomerInfo {

    @AuraEnabled
    public String companyName;

    @AuraEnabled
    public String companyEmail;

    @AuraEnabled
    public String companyPhone;

    @AuraEnabled
    public String companyType;

    @AuraEnabled
    public String contactFirstName;

    @AuraEnabled
    public String contactLastName;

    @AuraEnabled
    public String contactEmail;

    @AuraEnabled
    public String contactMobilePhone;

    @AuraEnabled
    public String shippingName;

    @AuraEnabled
    public Integer cargoWeight;

    @AuraEnabled
    public String cargoType;

    @AuraEnabled
    public String fromCity;

    @AuraEnabled
    public String toCity;

    @AuraEnabled
    public Date shippingDate;

    @AuraEnabled
    public String customerComments;
}