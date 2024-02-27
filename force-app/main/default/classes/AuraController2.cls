public with sharing class AuraController2 {
    @AuraEnabled
    public static void createCases(List<Case> cases){
        System.debug('!!! START : ' + cases);
        try {
            System.debug('!!! cases' + cases);
            if (cases.size() > 0) {
                insert cases;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}