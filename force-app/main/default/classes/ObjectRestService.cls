public with sharing class ObjectRestService {
  private static Map<String, Map<String, Schema.DisplayType>> objectFieldMap = new Map<String, Map<String, Schema.DisplayType>>();
  private static Map<String, List<SObject>> recordsForInsert = new Map<String, List<SObject>>();
  private static Map<String, List<SObject>> recordsForUpdate = new Map<String, List<SObject>>();

  public static ResponceWrapper insertRecords(String requestBody) {
    List<SObjectWrapper> sObjectWrappers = (List<SObjectWrapper>) JSON.deserialize(
      requestBody,
      List<SObjectWrapper>.class
    );

    for (SObjectWrapper wrapper : sObjectWrappers) {
      String sobjectName = wrapper.objectApiName;
      // ObjectRestService.getFieldsType(sobjectName);
      SObject newRecord = (SObject) Type.forName(sobjectName).newInstance();

      for (Field field : wrapper.fields) {
        if (field.fieldApiName == null) {
          continue;
        }
        Object fieldValue;
        fieldValue = ObjectRestService.getFieldValue(sobjectName, field.fieldApiName, field.fieldValue);
        newRecord.put(field.fieldApiName, fieldValue);
      }
      if (!recordsForInsert.containsKey(sobjectName)) {
        recordsForInsert.put(sobjectName, new List<SObject>());
      }
      recordsForInsert.get(sobjectName).add(newRecord);
    }

    List<SObject> preparedRecords = ObjectRestService.prepareListOfsObjects(
      recordsForInsert
    );

    List<Database.SaveResult> result = Database.insert(preparedRecords);

    ResponceWrapper responceWrapper = new ResponceWrapper();
    responceWrapper.status = 'Sucess';
    responceWrapper.dmlType = 'insert';
    responceWrapper.processedRecordsIds = getInsertedRecordsIds(result);
    System.debug('SAVE DATABASE RESULT  - ' + result);
    return responceWrapper;
  }

  public static ResponceWrapper updateRecords(String requestBody) {
    ResponceWrapper responceWrapper = new ResponceWrapper();
    responceWrapper.status = 'Sucess';
    responceWrapper.dmlType = 'update';
    responceWrapper.processedRecordsIds = new List<String>();

    return responceWrapper;
  }

  public static ResponceWrapper doSmthElse(String requestBody) {
    ResponceWrapper responceWrapper = new ResponceWrapper();
    responceWrapper.status = 'Sucess';
    responceWrapper.dmlType = 'smthElse';
    responceWrapper.processedRecordsIds = new List<String>();

    return responceWrapper;
  }

  public static void getFieldsType(String sObjType) {
    Map<String, Schema.DisplayType> innerObjectSettingsMap = new Map<String, Schema.DisplayType>();
    SObjectType sObjectType = Schema.getGlobalDescribe().get(sObjType);
    for (
      SObjectField field : sObjectType.getDescribe().fields.getMap().values()
    ) {
      Schema.DescribeFieldResult describe = field.getDescribe();
      innerObjectSettingsMap.put(describe.getName(), describe.getType());
      objectFieldMap.put(sObjType, innerObjectSettingsMap);
    }
  }

  public static Object getFieldValue(
    String sObjectName,
    String fieldName,
    String fieldValueAsString
  ) {
    Schema.DisplayType fieldType;
    Object fieldValue;
    for (String key : objectFieldMap.get(sObjectName).keySet()) {
      if (fieldName == key) {
        fieldType = objectFieldMap.get(sObjectName).get(key);
        if (
          fieldType == Schema.DisplayType.STRING ||
          fieldType == Schema.DisplayType.URL ||
          fieldType == Schema.DisplayType.JSON ||
          fieldType == Schema.DisplayType.PICKLIST ||
          fieldType == Schema.DisplayType.PHONE ||
          fieldType == Schema.DisplayType.MULTIPICKLIST
        ) {
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

  public static List<SObject> prepareListOfsObjects(
    Map<String, List<SObject>> recordsForInsert
  ) {
    List<SObject> result = new List<SObject>();
    for (List<SObject> items : recordsForInsert.values()) {
      result.addAll(items);
    }
    return result;
  }

  public static List<String> getInsertedRecordsIds(List<Database.SaveResult> results) {
    List<String> result = new List<String>();
    for (Database.SaveResult dsr: results) {
      result.add((String) dsr.getId());
    }
    return result; 
  }
  
  public class SObjectWrapper {
    public List<Field> fields;
    public String objectApiName;
  }

  public class Field {
    public String fieldApiName;
    public String fieldValue;
  }

  public class ResponceWrapper {
    public String status;
    public String dmlType;
    public String error;
    public List<String> processedRecordsIds;
  }
}
