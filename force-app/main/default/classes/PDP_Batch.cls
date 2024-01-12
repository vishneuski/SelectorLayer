public with sharing class PDP_Batch implements Database.Batchable<sObject>, Database.Stateful {
  public Integer i = 0;

  public Database.QueryLocator start(Database.BatchableContext BC) {
    
	Integer counter = Database.countQuery('SELECT count() FROM Lead WHERE Company = \'Test\'');
	System.debug('!!!DATABASE RECORDS SIZE : ' + counter);
	Database.QueryLocator locator = Database.getQueryLocator(
      [SELECT Id, Phone FROM Lead WHERE Company = 'Test']
    );


    Long timestamp = DateTime.now().getTime();
      while (DateTime.now().getTime() < timestamp + 25000) {
    }

    return locator;
  }

  public void execute(Database.BatchableContext BC, List<Lead> leads) {
    System.debug('!!!EXECUTE - RECORDS PROCESSING');
    System.debug('!!!NUMBER OF PROCESSED RECORDS: ' + i);
    for (Lead lead : leads) {
        lead.phone = '808080';
        i++;
    }
    update leads;
  }

  public void finish(Database.BatchableContext BC) {
    System.debug('!!!Number of processed records :' + i);
    Id batchJobId = Database.executeBatch(new PDP_Batch(), 200);
  }
}