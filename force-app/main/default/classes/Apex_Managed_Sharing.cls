global with sharing class Apex_Managed_Sharing implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id FROM Lead WHERE Phone = '12345']);
    }

    global void execute(Database.BatchableContext bc, List<Lead> leads) {
        List<LeadShare> newLeadsShare = new List<LeadShare>();
        List<LeadShare> oldLeadShare = [SELECT Id FROM LeadShare WHERE UserOrGroupId IN (SELECT Id FROM Group WHERE Name = 'apexSharingGroup')];

        LeadShare leadShare;
        Id groupId = [SELECT Id FROM Group WHERE Name = 'apexSharingGroup' LIMIT 1].Id;

        for (Lead lead: leads) {
            leadShare = new LeadShare();
            leadShare.LeadId = lead.Id;
            leadShare.LeadAccessLevel = 'Edit';
            leadShare.RowCause = 'Manual';
            leadShare.UserOrGroupId = groupId;
            newLeadsShare.add(leadShare);
        }

        try {
            delete oldLeadShare;
            Database.SaveResult[] lsr = Database.insert(newLeadsShare,false);

            for(Database.SaveResult sr : lsr){
                if(!sr.isSuccess()){
                    Database.Error err = sr.getErrors()[0];
                    if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION
                            &&  err.getMessage().contains('AccessLevel'))){
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        String[] toAddresses = new String[] {'vishneuski87@gmail.com'};
                        mail.setToAddresses(toAddresses);
                        mail.setSubject('Apex Sharing Recalculation Exception');
                        mail.setPlainTextBody(
                                'The Apex sharing recalculation threw the following exception: ' +
                                        err.getMessage());
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    }
                }
            }
        } catch(DmlException e) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'vishneuski87@gmail.com'};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Apex Sharing Recalculation Exception');
            mail.setPlainTextBody(
                    'The Apex sharing recalculation threw the following exception: ' +
                            e.getMessage());
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }

    global void finish(Database.BatchableContext bc) {
        String cronID = System.scheduleBatch(new Apex_Managed_Sharing(), 'LeadSharing', 720);
    }
}