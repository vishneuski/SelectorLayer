public with sharing class ETE_BatchUpdateE2EDataObject implements Database.Batchable<sObject> {
    static final String QUERY = 'SELECT Id, E2E_Data_Object__c FROM Opportunity WHERE E2E_Data_Object__c != null';

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(QUERY);
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> opportunities) {
        try {
            List<E2E_Data_Object__c> dataObjectsForUpdate = new List<E2E_Data_Object__c>();
            for (Opportunity opportunity : opportunities) {
                dataObjectsForUpdate.add(new E2E_Data_Object__c(Id = opportunity.E2E_Data_Object__c, Opportunity__c = opportunity.Id));
            }
            update dataObjectsForUpdate;

            for (Opportunity opportunity : opportunities) {
                opportunity.E2E_Data_Object__c = null;
            }
            update opportunities;
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR + e.getMessage());
        }
    }

    public void finish(Database.BatchableContext bc) {
    }
}
