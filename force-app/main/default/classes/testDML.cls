public with sharing class testDML {
    public static void dmlSobjects() {
        list<SObject> objects = new List<SObject>();
        for (Integer i = 0; i < 50; i++) {
            objects.add(new Account(Name = 'DMLTest'));
            objects.add(new Lead(LastName='DMLTest', Company='DMLTest', Phone='43231'));
        }
//         List<SObject> objs = sortChunks(objects);
        objects.sort();
        insert objects;
    }

    public static List<SObject> sortChunks(List<SObject> objects) {
        Map<String, List<SObject>> sortMap = new Map<String, List<SObject>>();
    
        for ( SObject obj: objects ) {
            String keyPrefix = obj.getSObjectType().getDescribe().getName();
            if (!sortMap.containsKey(keyPrefix)) {
                sortMap.put(keyPrefix, new List<SObject>());
            }
            sortMap.get(keyPrefix).add(obj);
        }
        
        List<SObject> flattenedList = new List<SObject>();
        for (String key: sortMap.keySet()) {
            flattenedList.addAll(sortMap.get(key) );
        }
        return flattenedList;
    }
}
