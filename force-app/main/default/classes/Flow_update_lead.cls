global class Flow_update_lead {

    public class FlowInputs {
        @InvocableVariable public String primarySkill;
        @InvocableVariable public String experience;
        @InvocableVariable public String mascot;
        @InvocableVariable public String email;
        @InvocableVariable public String fName;
        @InvocableVariable public String lName;
        @InvocableVariable public String recordId;
        @InvocableVariable public String controlingPicklistValue;
        @InvocableVariable public String dependingPicklistValue;
    }

    @InvocableMethod
    public static void updateLeads(List<FlowInputs> request) {
        String primarySkill = request[0].primarySkill;
        String experience = request[0].experience;
        String mascot = request[0].mascot;
        String email = request[0].email;
        String fName = request[0].fName;
        String lName = request[0].lName;
        String recordId = request[0].recordId;
        String controlingValue = request[0].controlingPicklistValue;
        String dependingValue = request[0].dependingPicklistValue;

        List<Lead> leads = [SELECT Id FROM Lead WHERE Id =:recordId];
        
        if (!leads.isEmpty()) {
            Lead lead = leads.get(0);
            lead.Email = email;
            lead.SF_skill__c = primarySkill;
            lead.SF_expirience__c = experience;
            lead.SF_mascot__c = mascot;
            lead.Description = 'Controling Value: ' + controlingValue + '.' +
                               'Depending Value: ' + dependingValue + '.';

            if (!String.isEmpty(fName)) {
                lead.FirstName = fName;
            }

            if (!String.isEmpty(lName)) {
                lead.LastName = lName;
            }

            update lead;
        }
    }
}