trigger MasterRecordTrigger on MasterRecord__c (before update, after update, before insert, after insert) {

    System.debug('!!!! INVOKE MasterRecord__c TRIGGER!!!');

}