public with sharing class LeadTriggerHandler extends TriggerHandler {
    public override void afterInsert(List<SObject> newRecords, Map<Id, SObject> newRecordsMap) {
        List<Lead> newLeads = (List<Lead>) newRecords;
        Map<Id, Lead> newLeadsMap = (Map<Id, Lead>) newRecordsMap;

        if (newLeads == null || newLeads.isEmpty()) return;
        
        Map<String, String> leadPhoneCompanyMap = new Map<String, String>();

        for (Lead lead: newLeads) {
            leadPhoneCompanyMap.put(lead.Phone, lead.Company);
        }
        LeadTriggerService.updateAccount(leadPhoneCompanyMap);
    }

    public override void afterUpdate(List<SObject> oldRecords, List<SObject> newRecords, Map<Id, Sobject> oldRecordsMap, Map<Id, Sobject> newRecordsMap) {
        Map<Id, Lead> oldLeadsMap = (Map<Id, Lead>) oldRecordsMap;
        Map<Id, Lead> newLeadsMap = (Map<Id, Lead>) newRecordsMap;

        if (newLeadsMap == null || newLeadsMap.isEmpty()) return;

        Map<String, String> leadPhoneCompanyMap = new Map<String, String>();

        for (Id leadId : newLeadsMap.keySet()) {
            if (oldLeadsMap.get(leadId).Company != newLeadsMap.get(leadId).Company ) {
                leadPhoneCompanyMap.put(newLeadsMap.get(leadId).Phone, newLeadsMap.get(leadId).Company);
            }
        }
        LeadTriggerService.updateAccount(leadPhoneCompanyMap);
    }
}