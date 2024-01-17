public with sharing class RTFlowBulkifyChecker {
   
    @InvocableMethod
    public static void loopBulkChecker(List<InputParams> inputs) {
        System.debug('!!! Input size IN LOOP : ' + inputs.size());
        System.debug('!!! Input IN LOOP : ' + inputs);
        System.debug('!!!******** IN LOOP ********** !');
    }

    public class InputParams {
        @InvocableVariable(label='List of records')
        public List<sObject> records;
    }
}