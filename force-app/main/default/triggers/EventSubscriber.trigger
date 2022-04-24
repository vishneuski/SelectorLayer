trigger EventSubscriber on Test_Event__e (after insert) {
    List<TestObject__c> testObj = [SELECT Id, TestTextField__c FROM TestObject__c LIMIT 5];
    List<TestObject__c> testObjToUpdate = new List<TestObject__c>();
    for (Test_Event__e event: Trigger.new) {
        if(event.Message_container__c == 'Cool') {
                 for(TestObject__c test: testObj) {
                     test.TestTextField__c = 'Cool!!!';
                     testObjToUpdate.add(test);
                 }
        }
    }
    insert testObjToUpdate;
}