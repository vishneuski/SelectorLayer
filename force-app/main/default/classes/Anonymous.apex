// delete [SELECT Id FROM Lead LIMIT 10000];

List<Lead> lds = new List<Lead>();
for (Integer i = 0; i < 1000; i++) {
    Lead lead = new Lead(LastName = 'Name' + i,  Company = 'TestCompany');
    lds.add(lead);
}

insert lds;

List<Lead> leads = [SELECT Id, Fax FROM Lead];

List<Lead> lds = new List<Lead>();
for (Lead l : leads) {
    l.Fax = '555';
    lds.add(l);
}

update lds;

//ROLL-UP
MasterRecord__c mr = new MasterRecord__c(Name = 'MasterRecordTest');
insert mr;


List<DetailRecord__c> detailRecords = new List<DetailRecord__c>();
for (Integer i = 0; i < 10; i++) {
    DetailRecord__c detailRecord = new DetailRecord__c(Name = 'DetailRecord ' + i, MasterRecord__c = 'a017Q00001M6a7ZQAR', NumberField__c = i);
    detailRecords.add(detailRecord);
}

insert detailRecords;

List<DetailRecord__c> detailRecordsForUpd = new List<DetailRecord__c>();


List<DetailRecord__c> detailRecords = [SELECT Id FROM DetailRecord__c];
delete detailRecords;



for (DetailRecord__c dr : detailRecords) {
    dr.NumberField__c = 10;
    detailRecordsForUpd.add(dr);
}

update detailRecordsForUpd;