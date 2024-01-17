public with sharing class AutolaunchFlowLogger {
     
    @InvocableMethod
    public static void logFlowInvocation(List<InputParams> inputs) {
        System.debug('!!! Input size BEFORE LOOP : ' + inputs.size());
        System.debug('!!! Input BEFORE LOOP : ' + inputs);
        System.debug('!!! ***** BEFORE LOOP ******** !');
    }


    public class InputParams {
        @InvocableVariable(label='List of records')
        public List<sObject> records;
    }
}