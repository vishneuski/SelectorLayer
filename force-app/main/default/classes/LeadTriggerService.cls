public with sharing class LeadTriggerService {
    public static void updateAccountCompany(List<Account> accounts, Map<String, String> leadPhoneCompanyMap) {
        List <Account> accountsForUpdate = new List<Account>();
    
        for (Account acc: accounts) {
            acc.Name = leadPhoneCompanyMap.get(acc.Phone);
            accountsForUpdate.add(acc);
        }
        update accountsForUpdate;
    }
}