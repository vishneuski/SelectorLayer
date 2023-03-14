global class Flow_update_lead {

    public class FlowInputs {
        @InvocableVariable public String primarySkill;
        @InvocableVariable public String experience;
        @InvocableVariable public String mascot;
        @InvocableVariable public String email;
        @InvocableVariable public String fName;
        @InvocableVariable public String lName;
    }

    @InvocableMethod
    public static void updateLeads(List<FlowInputs> request) {
        String primarySkill = request[0].primarySkill;
        String experience = request[0].experience;
        String mascot = request[0].mascot;
        String email = request[0].email;
        String fName = request[0].fName;
        String lName = request[0].lName;

        Lead lead = [SELECT Id FROM Lead WHERE Email =:email LIMIT 1];

        lead.SF_skill__c = primarySkill;
        lead.SF_expirience__c = experience;
        lead.SF_mascot__c = mascot;

        if (!String.isEmpty(fName)) {
            lead.FirstName = fName;
        }

        if (!String.isEmpty(lName)) {
            lead.LastName = fName;
        }

        update lead;
    }
}