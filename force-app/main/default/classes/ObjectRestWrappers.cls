public with sharing class ObjectRestWrappers {

    public class GetRequestWrapper {
        String objectType {get; set;}
        List<ObjectRecords> objectRecords {get; set;}
    }

    public class ObjectRecords {
        List<RecordItem> record;
    }

    public class RecordItem {
        String ID;
        List<String> fields;
    }
}