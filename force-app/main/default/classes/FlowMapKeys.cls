public class FlowMapKeys {
    
    @InvocableMethod(label='Get all Map keys')
    public static GetKeysOutputs[] getkeys(GetKeysInputs[] input){
        string[] keySet = new string[]{};
        for(FlowMap obj : input[0].flowMap){
            keySet.add(obj.key);
        }
        GetKeysOutputs obj = new GetKeysOutputs();
        obj.keySet = keySet;
        GetKeysOutputs[] result = new GetKeysOutputs[]{};
            result.add(obj);
        return result;
    }
    /* Input(s) for Invocable method */
    public class GetKeysInputs{
        @InvocableVariable(label='Map' required=true)
        public FlowMap[] flowMap;
    }

    /* Output(s) for Invocable method */
    public class GetKeysOutputs{
        @InvocableVariable(label='Map Keyset' required=true)
        public string[] keySet;
    }

}