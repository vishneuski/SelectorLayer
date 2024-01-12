// List<Lead> leads = new List<Lead>();

// for (Integer i = 0; i < 10000; i++) {
//     Lead lead = new Lead(LastName = String.valueOf(i), Company = 'Test');
//     leads.add(lead);
// }

// insert leads;

//RUN BATCH
Database.executeBatch(new PDP_Batch(), 200);


//CHANGE RECORDS DURING BATCH EXECUTION 

Set<Id> idsForDelete = new Set<Id>{
    '00Q7Q00000I3HXTUA3',
    '00Q7Q00000I3GmOUAV'
};

Set<Id> idsForUpdate = new Set<Id>{
    '00Q7Q00000I3FLmUAN',
    '00Q7Q00000I3G1wUAF',
    '00Q7Q00000I3Gc3UAF'
}; 

List<Lead> leadsForDelete = [SELECT Id FROM Lead Where Id IN: idsForDelete];
delete leadsForDelete;


List<Lead> leadsForUpdate = [SELECT Id, Company FROM Lead Where Id IN: idsForUpdate];
for (Lead l : leadsForUpdate) {
    l.Company = 'NEW VALUE';
    update l;
}
