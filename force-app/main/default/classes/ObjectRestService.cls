public with sharing class ObjectRestService {
  private static Map<String, Map<String, Schema.DisplayType>> objectFieldMap = new Map<String, Map<String, Schema.DisplayType>>();
  private static Map<String, List<SObject>> recordsForInsert = new Map<String, List<SObject>>();
  private static Map<String, List<SObject>> recordsForUpdate = new Map<String, List<SObject>>();

  public static List<SObject> processRecords(String jsonString) {
    List<SObjectWrapper> sObjectWrappers = (List<SObjectWrapper>) JSON.deserialize(
      jsonString,
      List<SObjectWrapper>.class
    );

    for (SObjectWrapper wrapper : sObjectWrappers) {
      String sobjectName = wrapper.objectType;
      ObjectRestService.getFieldsType(sobjectName);
      SObject newRecord = (SObject) Type.forName(sobjectName).newInstance();

      for (Fields field : wrapper.fields) {
        Object fieldValue;
        fieldValue = ObjectRestService.getFieldValue(
          sobjectName,
          field.fieldApiName,
          field.fieldValue
        );
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
    return preparedRecords;
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

  public class SObjectWrapper {
    public List<Fields> fields;
    public String objectType;
  }

  public class Fields {
    public String fieldApiName;
    public String fieldValue;
  }
}