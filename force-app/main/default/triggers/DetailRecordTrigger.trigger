trigger DetailRecordTrigger on DetailRecord__c (before update, after update, before insert, after insert) {

System.debug('!!!! INVOKE DetailRecord__c TRIGGER!!!');

}