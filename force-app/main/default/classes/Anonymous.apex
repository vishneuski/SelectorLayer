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


Account account = [];