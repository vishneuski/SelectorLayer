public class FlowMapCreator {
    
    @InvocableMethod(label='Create Standard Id-Record Map')
    public static CreateMapOutputs[] createMap(CreateMapInputs[] input){
        
        FlowMap[] flowMap = new FlowMap[]{};
        for(sObject sObj : input[0].records){
            FlowMap obj = new FlowMap();
            obj.key = (string)sObj.get('Id');
            obj.record = sObj;
            flowMap.add(obj);
        }
        CreateMapOutputs obj = new CreateMapOutputs();
        obj.flowMap = flowMap;
        
        CreateMapOutputs[] result = new CreateMapOutputs[]{};
            result.add(obj);
        return result;
    }
    
    /* Input(s) for Invocable method */
    public class CreateMapInputs{
        @InvocableVariable(label='List of records')
        public sObject[] records;
    }
    
    /* Output(s) for Invocable method */
    public class CreateMapOutputs{
        @InvocableVariable(label='Map')
        public FlowMap[] flowMap;
    }

}