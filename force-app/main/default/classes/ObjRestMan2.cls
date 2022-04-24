/**
 * Created by user on 9/8/21.
 */

public with sharing class ObjRestMan2 {

}
//public with sharing class ObjectRestManager {
//
//
//    public static List<SObject> getsObject(String objectType, List<Id> idList) {
//        List<SObject> sObjectsList;
//        if (!idList.isEmpty()) {
//            String queryString = ('SELECT Id, Name FROM ' + objectType + ' WHERE Id IN: idList');
//            sObjectsList = Database.query(queryString);
//        }
//        return sObjectsList;
//    }
//
//    public static List<SObject> getsObjectList(String objectType, Map<Id, List<String>> fieldList) {
//        List<RestMetadata__mdt> restList = [SELECT AccountFields__c, ContactFields__c FROM RestMetadata__mdt];
//
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
//        System.debug('IdList: ' + idList);
//        System.debug('Result String : ' + joinedString);
//
//        String queryString = ('SELECT ' + joinedString + ' FROM ' + objectType + ' WHERE Id IN: idList');
//        sObjectsList = Database.query(queryString);
//        System.debug('Result List: ' + sObjectsList);
//
//
////        String queryString = ('SELECT Id, Name FROM ' + objectType + ' WHERE Id IN: idList');
////        if (!idList.isEmpty()) {
////        }
////        return sObjectsList;
//        return null;
//    }
//
//    public static void insertSObject(List<SObject> sObjects) {
//        if (!sObjects.isEmpty() && sObjects != null) {
//            insert sObjects;
//        }
//    }
//
//    public static void updateSObjects(List<SObject> sObjects) {
//        if (!sObjects.isEmpty() && sObjects != null) {
//            update sObjects;
//        }
//    }
//}