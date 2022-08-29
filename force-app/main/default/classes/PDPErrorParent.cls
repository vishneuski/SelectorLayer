public with sharing class PDPErrorParent {
    public static void updateLeads() {
        try {
            List<Lead> leads = new List<Lead>();

            for (Integer i=0; i < 10; i++) {
                Lead lead = new Lead(FirstName='test'+i, LastName='test'+i, Company='errorCompany');
                leads.add(lead);
            }
            insert leads;
            PDPErrorHandling.checkErrorHandling(leads);
        } catch (Exception ex) {
            System.debug(ex.getMessage());
        }
    }
}
