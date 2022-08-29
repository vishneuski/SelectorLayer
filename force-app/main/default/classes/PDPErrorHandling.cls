public with sharing class PDPErrorHandling {
    public static void checkErrorHandling(List<Lead> leads) {
        Boolean exceptionOccurred = false;
        try {
            List<Lead> leadsForFirstUpdate = new List<Lead>();
            for (Lead lead: leads) {
                lead.Phone = '12345';
                leadsForFirstUpdate.add(lead);
            }
            update leadsForFirstUpdate;

            List<Lead> leadsForSecondUpdate = new List<Lead>();
            for (Lead lead: leadsForFirstUpdate) {
                lead.Id = '123';
                leadsForSecondUpdate.add(lead);
            }
            update leadsForSecondUpdate;

        } catch (Exception ex) {
            exceptionOccurred = true;
            throw new CustomException(ex.getMessage());
        }

        finally {
            String result = exceptionOccurred ? 'Operation failed' : 'Operation success';
        }
    }

    public class CustomException extends Exception {}
}