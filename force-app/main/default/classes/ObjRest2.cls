//@RestResource(UrlMapping='/Objects/*')
global with sharing class ObjRest2 {
//    private static Map<String, List<SObject>> recordsForInsert = new Map<String, List<SObject>>();
//    private static Map<String, List<SObject>> recordsForUpdate = new Map<String, List<SObject>>();

//    @HttpGet
//    global static Map<String, List<SObject>> get() {
//        RestRequest request = RestContext.request;
//        String jsonStr = request.requestBody.toString();
//        List<GetRequestWrapper> wrappers = (List<GetRequestWrapper>) System.JSON.deserialize(jsonStr, List<GetRequestWrapper>.class);
//        System.debug('Get wrappers' + wrappers);
//
//        for(GetRequestWrapper requestWrapper: wrappers) {
//            Map<Id, List<String>> mapOfFields = new Map<Id, List<String>>();
//            for(ObjectRecords item: requestWrapper.objectRecords) {
//                if (!mapOfFields.containsKey(item.ID)) {
//                    mapOfFields.put(item.ID, new List<String>());
//                }
//                for (String fieldItem: item.fields) {
//                    mapOfFields.get(item.ID).add(fieldItem);
//                }
//            }
//            ObjectRestService.getObjectFieldsById(requestWrapper.objectType, mapOfFields);
//        }


//        List<Id> idList = (List<Id>) System.JSON.deserialize(jsonStr, List<Id>.class);
//        return ObjectRestService.getSObjectsById(idList);
//        return null;
//    }
//
//    @HttpPost
//    global static Map<String, List<Id>> push() {
//        RestRequest request = RestContext.request;
//        String jsonStr = request.requestBody.toString();

//        List<SObject> sObjects = ObjectRestService.dataWorker(jsonStr);


//        List<SObjectWrapper> sObjectWrappers = (List<SObjectWrapper>) JSON.deserialize(jsonStr, List<SObjectWrapper>.class);
//
//        for (SObjectWrapper wrapper : sObjectWrappers) {
//            String sobjectName = wrapper.objectType;
//            ObjectRestService.getFieldsType(sobjectName);
//            SObject newRecord = (SObject) Type.forName(sobjectName).newInstance();
//
//            for (Fields field : wrapper.fields) {
//                Object fieldValue;
//                fieldValue = ObjectRestService.getFieldValue(sobjectName, field.fieldApiName, field.fieldValue);
//                newRecord.put(field.fieldApiName, fieldValue);
//            }
//            if (!recordsForInsert.containsKey(sobjectName)) {
//                recordsForInsert.put(sobjectName, new List<SObject>());
//            }
//            recordsForInsert.get(sobjectName).add(newRecord);
//        }
//
//        List<SObject> preparedRecords = ObjectRestService.prepareListOfsObjects(recordsForInsert);
//        ObjectRestManager.insertSObject(sObjects);

//        return ObjectRestService.formResponse(recordsForInsert);
//        return null;
//    }

//    @HttpPatch
//    global static Map<String, List<Id>> updateRecords() {
//
//        RestRequest request = RestContext.request;
//        String jsonStr = request.requestBody.toString();
//        List<SObjectWrapper> sObjectWrappers = (List<SObjectWrapper>) JSON.deserialize(jsonStr, List<SObjectWrapper>.class);
//
//        for (SObjectWrapper wrapper : sObjectWrappers) {
//            String sobjectName = wrapper.objectType;
//            ObjectRestService.getFieldsType(sobjectName);
//            SObject newRecord = (SObject) Type.forName(sobjectName).newInstance();
//
//            for (Fields field : wrapper.fields) {
//                Object fieldValue;
//                fieldValue = ObjectRestService.getFieldValue(sobjectName, field.fieldApiName, field.fieldValue);
//                newRecord.put(field.fieldApiName, fieldValue);
//            }
//
//            if (!recordsForUpdate.containsKey(sobjectName)) {
//                recordsForUpdate.put(sobjectName, new List<SObject>());
//            }
//            recordsForUpdate.get(sobjectName).add(newRecord);
//        }
//
//        List<SObject> prepareRecords = ObjectRestService.prepareListOfsObjects(recordsForUpdate);
//        ObjectRestManager.updateSObjects(prepareRecords);
//
//        return ObjectRestService.formResponse(recordsForUpdate);
//    }

//    public class SObjectWrapper {
//        public List<Fields> fields;
//        public String objectType;
//    }
//
//    public class Fields {
//        public String fieldApiName;
//        public String fieldValue;
//    }
//
//    public class ResponseWrapper {
//        String status;
//        String error;
//        List<SObject> responseSObjects;
//    }
//
//    public class GetRequestWrapper {
//        String objectType;
//        List<ObjectRecords> objectRecords;
//    }
//
//    public class ObjectRecords {
//        String ID;
//        List<String> fields;
//    }
}