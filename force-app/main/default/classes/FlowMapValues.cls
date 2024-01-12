public class FlowMapValues {
    
    @InvocableMethod(label='Get all Map values')
    public static GetValuesOutputs[] getValues(GetValuesInputs[] input){
        sObject[] records = new sObject[]{};
        for(FlowMap obj : input[0].flowMap){
            records.add(obj.record);
        }
        GetValuesOutputs obj = new GetValuesOutputs();
        obj.records = records;
        GetValuesOutputs[] result = new GetValuesOutputs[]{};
            result.add(obj);
        return result;
    }

    /* Input(s) for Invocable method */
    public class GetValuesInputs{
        @InvocableVariable(label='Map' required=true)
        public FlowMap[] flowMap;
    }

    /* Output(s) for Invocable method */
    public class GetValuesOutputs{
        @InvocableVariable(label='Map Values' required=true)
        public sObject[] records;
    }
}