public with sharing class ObjectRestService {
    private static Map<String, Map<String, Schema.DisplayType>> objectFieldMap = new Map<String, Map<String, Schema.DisplayType>>();
    private static Map<String, List<SObject>> recordsForInsert = new Map<String, List<SObject>>();
    private static Map<String, List<SObject>> recordsForUpdate = new Map<String, List<SObject>>();

    public static String getObjectType(String objectId) {
        String sObjectType;
        if (objectId instanceof Id) {
            sObjectType = Id.valueOf(objectId).getSobjectType().getDescribe().getName();
        }
        return sObjectType;
    }

    public static List<ObjectRest.ResponseWrapper> getRecords(String jsonStr) {
        List<SObject> sObjectsList = new List<SObject>();
        List<ObjectRest.ResponseWrapper> response = new List<ObjectRest.ResponseWrapper>();
        List<ObjectRest.GetRequestWrapper> wrappers = (List<ObjectRest.GetRequestWrapper>) System.JSON.deserialize(jsonStr, List<ObjectRest.GetRequestWrapper>.class);

        for (ObjectRest.GetRequestWrapper requestWrapper : wrappers) {
            List<ObjectRest.ResponseObjectWrapper> oneTypeObjWrapper = new List<ObjectRest.ResponseObjectWrapper>();
            sObjectsList = ObjectRestService.getsObjectList(requestWrapper.objectType, requestWrapper.objectIdList);
            for (SObject sobj : sObjectsList) {
                Map<String, Object> queriedFieldValues = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(sobj));
                queriedFieldValues.remove('attributes');

                ObjectRest.ResponseObjectWrapper row = new ObjectRest.ResponseObjectWrapper();
                row.objectType = requestWrapper.objectType;

                Map<String, String> newMap = new Map<String, String>();
                for (String fieldKey : queriedFieldValues.keySet()) {
                    if (queriedFieldValues.get(fieldKey) != null) {
                        newMap.put(fieldKey, String.valueOf(queriedFieldValues.get(fieldKey)));
                    }
                }
                row.fields = newMap.clone();
                oneTypeObjWrapper.add(row);
            }

            ObjectRest.ResponseWrapper rwr = new ObjectRest.ResponseWrapper();

            rwr.objectType = requestWrapper.objectType;
            rwr.status = 'Success';
            rwr.error = 'Success';
            rwr.responseSObjects = oneTypeObjWrapper;
            response.add(rwr);
        }
        return response;
    }





























    public static List<SObject> dataWorker(String jsonString) {
        List<SObjectWrapper> sObjectWrappers = (List<SObjectWrapper>) JSON.deserialize(jsonString, List<SObjectWrapper>.class);

        for (SObjectWrapper wrapper : sObjectWrappers) {
            String sobjectName = wrapper.objectType;
            ObjectRestService.getFieldsType(sobjectName);
            SObject newRecord = (SObject) Type.forName(sobjectName).newInstance();

            for (Fields field : wrapper.fields) {
                Object fieldValue;
                fieldValue = ObjectRestService.getFieldValue(sobjectName, field.fieldApiName, field.fieldValue);
                newRecord.put(field.fieldApiName, fieldValue);
            }
            if (!recordsForInsert.containsKey(sobjectName)) {
                recordsForInsert.put(sobjectName, new List<SObject>());
            }
            recordsForInsert.get(sobjectName).add(newRecord);
        }

        List<SObject> preparedRecords = ObjectRestService.prepareListOfsObjects(recordsForInsert);
        return preparedRecords;
    }

    public static List<SObject> getsObjectList(String objectType, List<Id> idList) {
        List<ObjectField__mdt> objFields = [SELECT ObjectType__c, ObjectFields__c FROM ObjectField__mdt WHERE ObjectType__c = :objectType];
        if(!objFields.isEmpty()) {
            String fieldLis = objFields[0].ObjectFields__c;
            return ObjectRestManager.getsSpecificFields(objectType, idList, fieldLis);
        } else {
            return null;
        }
    }


    public static Map<String, List<Id>> formResponse(Map<String, List<SObject>> insertedRecords) {
        Map<String, List<Id>> responseMap = new Map<String, List<Id>>();
        for (String key : insertedRecords.keySet()) {
            if (!responseMap.containsKey(key)) {
                responseMap.put(key, new List<Id>());
            }
            for (SObject obj : insertedRecords.get(key)) {
                responseMap.get(key).add(obj.Id);
            }
        }
        return responseMap;
    }

    public static List<SObject> prepareListOfsObjects(Map<String, List<SObject>> recordsForInsert) {
        List<SObject> result = new List<SObject>();
        for (List<SObject> items : recordsForInsert.values()) {
            result.addAll(items);
        }
        return result;
    }

    public static void getFieldsType(String sObjType) {
        Map<String, Schema.DisplayType> innerObjectSettingsMap = new Map<String, Schema.DisplayType>();

        SObjectType sObjectType = Schema.getGlobalDescribe().get(sObjType);
        for (SObjectField field : sObjectType.getDescribe().fields.getMap().values()) {
            Schema.DescribeFieldResult describe = field.getDescribe();
            innerObjectSettingsMap.put(describe.getName(), describe.getType());
            objectFieldMap.put(sObjType, innerObjectSettingsMap);
        }
    }

    public static Object getFieldValue(String sObjectName, String fieldName, String fieldValueAsString) {
        Schema.DisplayType fieldType;
        Object fieldValue;
        for (String key : objectFieldMap.get(sObjectName).keySet()) {
            if (fieldName == key) {
                fieldType = objectFieldMap.get(sObjectName).get(key);
                if (fieldType == Schema.DisplayType.STRING ||
                        fieldType == Schema.DisplayType.URL ||
                        fieldType == Schema.DisplayType.JSON ||
                        fieldType == Schema.DisplayType.PICKLIST ||
                        fieldType == Schema.DisplayType.PHONE ||
                        fieldType == Schema.DisplayType.MULTIPICKLIST) {
                    fieldValue = fieldValueAsString;
                } else if (fieldType == Schema.DisplayType.INTEGER) {
                    fieldValue = Integer.valueOf(fieldValueAsString);
                } else if (fieldType == Schema.DisplayType.ID) {
                    fieldValue = Id.valueOf(fieldValueAsString);
                } else if (fieldType == Schema.DisplayType.DATE) {
                    fieldValue = Date.valueOf(fieldValueAsString);
                } else {
                    fieldValue = null;
                }
            }
        }
        return fieldValue;
    }

    public static void getObjectFieldsById(String objectType, Map<Id, List<String>> mapOfField) {
//        System.debug('Object Type: ' + objectType);
//        System.debug('Map of fields: ' + mapOfField);
//        ObjectRestManager.getsObjectList(objectType, mapOfField);
    }

    public static Map<String, List<SObject>> getSObjectsById(List<Id> idList) {
        Map<String, List<Id>> sObjectsIds = new Map<String, List<Id>>();
        Map<String, List<SObject>> sObjectsMap = new Map<String, List<SObject>>();

        for (Id idItem : idList) {
            String objectType = getObjectType(idItem);
            if (!sObjectsIds.containsKey(objectType)) {
                sObjectsIds.put(objectType, new List<Id>());
            }
            sObjectsIds.get(objectType).add(idItem);

            for (String sObjectType : sObjectsIds.keySet()) {
                List<SObject> sObjectsList = ObjectRestManager.getsObject(sObjectType, sObjectsIds.get(sObjectType));
                System.debug(sObjectsList);

                if (!sObjectsMap.containsKey(sObjectType)) {
                    sObjectsMap.put(sObjectType, new List<SObject>());
                }
                for (SObject sobj : sObjectsList) {
                    if (!sObjectsMap.get(sObjectType).contains(sobj)) {
                        sObjectsMap.get(sObjectType).add(sobj);
                    }
                }
            }
        }


//        map<SObjectType,Set<ID>>

        return sObjectsMap;
    }


    public class ResponseWrapper {
        String status;
        String error;
        List<SObject> responseSObjects;
    }

    public class SObjectWrapper {
        public List<Fields> fields;
        public String objectType;
    }

    public class Fields {
        public String fieldApiName;
        public String fieldValue;
    }
}
//}