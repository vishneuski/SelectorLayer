public with sharing class ContractSharingHandler {
    public static void executeSharing(List<Contract> contracts) {

//        System.debug(contracts[0].Shipping_Company_User__c);
//        List<Account> accs = [SELECT Id FROM Account WHERE Id = :contracts[0].AccountId];
//        System.debug(accs);

        List<AccountShare> accShList = new List<AccountShare>();

        for (Contract con : contracts) {
            AccountShare accountShare = new AccountShare();
            accountShare.AccountId = con.AccountId;
            accountShare.UserOrGroupId = con.Shipping_Company_User__c;
            accountShare.AccountAccessLevel = 'Edit';
            accountShare.ContactAccessLevel = 'Edit';
            accountShare.CaseAccessLevel = 'Edit';
            accountShare.OpportunityAccessLevel = 'Edit';
            accShList.add(accountShare);
        }
        insert accShList;
    }
}