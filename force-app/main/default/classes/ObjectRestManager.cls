public with sharing class ObjectRestManager {


    public static List<SObject> getsObject(String objectType, List<Id> idList) {
        List<SObject> sObjectsList;
        if (!idList.isEmpty()) {
            String queryString = ('SELECT Id, Name FROM ' + objectType + ' WHERE Id IN: idList');
            sObjectsList = Database.query(queryString);
        }
        return sObjectsList;
    }

    public static List<SObject> getsSpecificFields(String objectType, List<Id> idList, String fields) {
        List<SObject> sObjectsList;
        if (!idList.isEmpty()) {
            String queryString = ('SELECT ' + fields + ' FROM ' + objectType + ' WHERE Id IN: idList');
            System.debug(queryString);
            sObjectsList = Database.query(queryString);
        }
        return sObjectsList;
    }


//    public static List<SObject> getsObjectList(String objectType, Map<Id, List<String>> fieldList) {
//        Map <String, List<String>> mapOfFields = new Map<String, List<String>>();
//        List<ObjectField__mdt> objFields = [SELECT ObjectType__c, ObjectFields__c FROM ObjectField__mdt];
//            for (ObjectField__mdt ofmdt: objFields) {
//                if(!mapOfFields.containsKey(ofmdt.ObjectType__c)) {
//                    mapOfFields.put(ofmdt.ObjectType__c, new List<String>());
//                }
//                mapOfFields.get(ofmdt.ObjectType__c).add(ofmdt.ObjectFields__c);
//            }
//        System.debug('Custom Metadata Obj: ' + objFields);
//        System.debug('Map of fields Obj: ' + mapOfFields);
//
//        for(String key: mapOfFields.keySet()) {
//
//        }

//        List<RestMetadata__mdt> restList = [SELECT Account__c, Contact__c FROM RestMetadata__mdt];
//        System.debug('Account Fields: ' + restList[0].Account__c);
//        System.debug('Contact Fields: ' + restList[0].Contact__c);
//        Map<String, List<String>> objectFieldsMap = new Map<String, List<String>>();

//        for(RestMetadata__mdt rdt: restList) {
//            System.debug('metadataItem: ' + rdt);
//            System.debug('M : ' + m);
//            objectFieldsMap.put()
//        }


//        List<SObject> sObjectsList;
//        List<Id> idList = new List<Id>();
//        Set<String> fullFieldSet = new Set<String>();
//        for (List<String> listOfString: fieldList.values()) {
//            fullFieldSet.addAll(listOfString);
//        }
//        String joinedString = String.join(new List<String>(fullFieldSet), ',');
//        for(Id id: fieldList.keySet()) {
//            idList.add(id);
//        }

//        String queryString = ('SELECT ' + restList[0].Account__c + ' FROM Account WHERE Id IN: idList');
//        sObjectsList = Database.query(queryString);

//        System.debug('SObjectList: ' + sObjectsList);


//        System.debug('IdList: ' + idList);
//        System.debug('Result String : ' + joinedString);

//        sObjectsList = Database.query(queryString);
//        System.debug('Result List: ' + sObjectsList);


//        String queryString = ('SELECT Id, Name FROM ' + objectType + ' WHERE Id IN: idList');
//        if (!idList.isEmpty()) {
//        }
//        return sObjectsList;
//        return null;
//    }

    public static void insertSObject(List<SObject> sObjects) {
        if (!sObjects.isEmpty() && sObjects != null) {
            insert sObjects;
        }
    }

    public static void updateSObjects(List<SObject> sObjects) {
        if (!sObjects.isEmpty() && sObjects != null) {
            update sObjects;
        }
    }
}