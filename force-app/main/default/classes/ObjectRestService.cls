public with sharing class ObjectRestService {
  private static Map<String, Map<String, Schema.DisplayType>> objectFieldMap = new Map<String, Map<String, Schema.DisplayType>>();
  private static Map<String, List<SObject>> recordsForInsert = new Map<String, List<SObject>>();
  private static Map<String, List<SObject>> recordsForUpdate = new Map<String, List<SObject>>();
  private static final String SUCESS_DML_RECORDS_IDS = 'recordIds';
  private static final String DML_ERRORS = 'dmlErrors';
  private static final String INSERT_DML = 'insert';
  private static final String UPDATE_DML = 'update';
  private static final String SUCCESS_STATUS = 'Success';
  private static final String ERROR_STATUS = 'Error';

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

    List<SObject> preparedRecords = prepareListOfsObjects(recordsForInsert);
    List<Database.SaveResult> result = Database.insert(preparedRecords, false);

    ResponceWrapper responceWrapper = new ResponceWrapper();
    responceWrapper.status = SUCCESS_STATUS;
    responceWrapper.dmlType = INSERT_DML;

    Map<String, List<String>> dmlResult = getDmlResult(result); 

    responceWrapper.processedRecordsIds = dmlResult.get(SUCESS_DML_RECORDS_IDS);
    responceWrapper.unprocessedRecordsErrors = dmlResult.get(DML_ERRORS);

    return responceWrapper;
  }

  public static ResponceWrapper updateRecords(String requestBody) {
    ResponceWrapper responceWrapper = new ResponceWrapper();
    responceWrapper.status = SUCCESS_STATUS;
    responceWrapper.dmlType = UPDATE_DML;
    responceWrapper.processedRecordsIds = new List<String>();
    responceWrapper.unprocessedRecordsErrors = new List<String>();

    return responceWrapper;
  }

  public static ResponceWrapper doSmthElse(String requestBody) {
    ResponceWrapper responceWrapper = new ResponceWrapper();
    responceWrapper.status = ERROR_STATUS;
    responceWrapper.dmlType = 'smthElse';
    responceWrapper.processedRecordsIds = new List<String>();
    responceWrapper.unprocessedRecordsErrors = new List<String>();

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
    Object fieldValue;
    for (String key : objectFieldMap.get(sObjectName).keySet()) {
      if (fieldName == key) {
        Schema.DisplayType fieldType = objectFieldMap.get(sObjectName).get(key);
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

  public static Map<String, List<String>> getDmlResult(List<Database.SaveResult> results) {
    Map<String, List<String>> result = new Map<String, List<String>> {
      SUCESS_DML_RECORDS_IDS => new List<String>(),
      DML_ERRORS => new List<String>()
    };

    for (Database.SaveResult sr: results) {
      if (sr.isSuccess()) {
        result.get(SUCESS_DML_RECORDS_IDS).add((String) sr.getId());
      } else {
        for(Database.Error err : sr.getErrors()) {
          result.get(DML_ERRORS).add(err.getStatusCode() + ': ' + err.getMessage());
        }
      }
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
    public List<String> unprocessedRecordsErrors;
  }
}