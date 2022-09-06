public virtual with sharing class TriggerHandler {

    public void run() {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                this.beforeInsert(Trigger.new);
            }
            when BEFORE_UPDATE {
                this.beforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
            }
            when BEFORE_DELETE {
                this.beforeDelete(Trigger.old, Trigger.oldMap);
            }
            when AFTER_INSERT {
                this.afterInsert(Trigger.new, Trigger.newMap);
            }
            when AFTER_UPDATE {
                this.afterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
            }
            when AFTER_DELETE {
                this.afterDelete(Trigger.old, Trigger.oldMap);
            }
            when AFTER_UNDELETE {
                this.afterUndelete(Trigger.new, Trigger.newMap);
            }
        }
    }

    public virtual void beforeInsert(List<SObject> newRecords) {}

    public virtual void beforeUpdate(List<SObject> oldRecords, List<SObject> newRecords, Map<Id, SObject> oldRecordsMap, Map<Id, SObject> newRecordsMap) {}

    public virtual void beforeDelete(List<SObject> deletedRecords, Map<Id, SObject> deletedRecordsMap) {}

    public virtual void afterInsert(List<SObject> newRecords, Map<Id, SObject> newRecordsMap) {}

    public virtual void afterUpdate(List<SObject> oldRecords, List<SObject> newRecords, Map<Id, SObject> oldRecordsMap, Map<Id, SObject> newRecordsMap) {}

    public virtual void afterDelete(List<SObject> deletedRecords, Map<Id, SObject> deletedRecordsMap) {}

    public virtual void afterUndelete(List<SObject> newRecords, Map<Id, SObject> newRecordsMap) {}
}