public with sharing class PickListService {
    public static List<SObjectQueryResult> getPickListValues
            (String objectName,
            String fieldAPINames,
            String filterFieldAPIName,
            String strInput) {
        List<SObjectQueryResult> lstReturnResult = new List<SObjectQueryResult>();
        if(strInput.equals('*')){
            strInput = '';
        }
        String str = strInput + '%';
        String strQueryField = '';
        List<String> fieldList = fieldAPINames.split(',');

        //check if Id is already been passed
        if(!fieldList.contains('Id')){
            fieldList.add('Id');
            strQueryField = String.join(fieldList, ',');
        }else {
            strQueryField = fieldAPINames;
        }

        String strQuery = 'SELECT ' + String.escapeSingleQuotes(strQueryField)
                + ' FROM '
                + String.escapeSingleQuotes(objectName)
                + ' WHERE ' + filterFieldAPIName + '  LIKE \'' + str + '%\''
                + ' ORDER BY ' + filterFieldAPIName
                + ' LIMIT 50';

        System.debug('strQuery=' + strQuery);

        List<SObject> lstResult = database.query(strQuery);
        //create list of records that can be easily be parsable at js controller.
        for(String strField:fieldList){
            for(SObject sobj:lstResult){
                if(strField != 'Id'){
                    SObjectQueryResult result = new SObjectQueryResult();
                    result.recordId = (String) sobj.get('Id');
                    result.recordName = (String) sobj.get(strField);
                    lstReturnResult.add(result);
                }
            }
        }
        return lstReturnResult;
    }

    public static List<sObject> getRecordList(String sObjectType) {
        String queryString = ('SELECT Id, Name FROM ' + sObjectType + ' LIMIT 10');
        List<sObject> sObjList = Database.query(queryString);
        return sObjList;
    }

    public static List<Contact> getContacts() {
        return [SELECT Id, Name FROM Contact LIMIT 10];
    }

    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account LIMIT 10];
    }

    public static List<Contact> validateInput(String strForValidation) {
        List<Contact> contacts;
        if (String.isBlank(strForValidation) || strForValidation.startsWith(' ') || strForValidation == null) {
            throw new AuraHandledException('Something wrong');
        } else {
            contacts = [SELECT Id, LastName FROM Contact WHERE LastName = :strForValidation];
        }
        return contacts;
    }
}