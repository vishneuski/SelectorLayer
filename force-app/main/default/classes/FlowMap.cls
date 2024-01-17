public class FlowMap {
    
    @AuraEnabled
    public string key; //Map key
        
    @AuraEnabled
    public sObject record; //sObject attribute for sObject Map type

    @AuraEnabled
    public string value; //sObject attribute for sObject Map type
}