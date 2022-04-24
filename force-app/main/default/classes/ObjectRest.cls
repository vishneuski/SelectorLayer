@RestResource(UrlMapping='/Objects/*')
global with sharing class ObjectRest {
//    private static Map<String, List<SObject>> recordsForInsert = new Map<String, List<SObject>>();
//    private static Map<String, List<SObject>> recordsForUpdate = new Map<String, List<SObject>>();

    @HttpGet
    global static List<ResponseWrapper> getRecords() {
        List<ResponseWrapper> response = new List<ResponseWrapper>();
        RestRequest request = RestContext.request;
        String jsonStr = request.requestBody.toString();

        try {
            response = ObjectRestService.getRecords(jsonStr);
        } catch (Exception ex) {
            System.debug('Exception' + ex);
        }
        return response;
    }

    @HttpPost
    global static Map<String, List<Id>> push() {
        RestRequest request = RestContext.request;
        String jsonStr = request.requestBody.toString();

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
        return null;
    }

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

    global class ResponseWrapper {
        public String status;
        public String objectType;
        public String error;
        public List<ResponseObjectWrapper> responseSObjects;
    }

    global class ResponseObjectWrapper {
        public String objectType;
        public Map<String, String> fields;
    }

    public class SObjectWrapper {
        public List<Fields> fields;
//        public String objectType;
    }

    public class Fields {
        public String fieldApiName;
        public String fieldValue;
    }

    public class GetRequestWrapper {
        public String objectType;
        public List<Id> objectIdList;
    }
}