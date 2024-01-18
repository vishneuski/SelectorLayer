trigger LeadTrigger on Lead (before update, after update) {

    Set<Id> ids = new Set<Id>();

    for (Lead lead : Trigger.newMap.values()) {
        ids.add(lead.Id);
    }

    List<Lead> lds = [SELECT ID, Phone FROM Lead WHERE Id IN: ids WITH SECURITY_ENFORCED]; 

    System.debug('!!! lds : ' + lds.size());

}