public with sharing class LeadTriggerHandler {
    public static void publishLeadPlatformEvent(List<Lead> leads) {
        List<Event_Field__mdt> mdtEventFields = Event_Field__mdt.getAll().values();
        List<Lead_Platform_Event__e> leadPlatformEvents = new List<Lead_Platform_Event__e>();

        for (Lead lead: leads) {
            Map<String, Object> populatedFields = lead.getPopulatedFieldsAsMap();
            Map<String, Object> fieldsForEvent = new Map<String, Object>();

            for (Event_Field__mdt mdtField: mdtEventFields) {
                if (populatedFields.containsKey(mdtField.Field_Name__c)) {
                    fieldsForEvent.put(mdtField.Field_Name__c, populatedFields.get(mdtField.Field_Name__c));
                }       
            }

            Lead_Platform_Event__e leadEvent = new Lead_Platform_Event__e(Lead_Fields__c = JSON.serialize(fieldsForEvent));
            leadPlatformEvents.add(leadEvent);
        }

        List<Database.SaveResult> results = EventBus.publish(leadPlatformEvents);

        for (Database.SaveResult sr : results) {
            if (sr.isSuccess()) {
                System.debug('Successfully published event!');
            } else {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('!!!Error returned: ' + err.getStatusCode() + ' - ' + err.getMessage());
                }
            }       
        }
    }
}