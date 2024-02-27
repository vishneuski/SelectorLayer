({
    addCase : function(component, event, helper) {
        var newCase = component.get("v.case");
        var allCases = component.get("v.cases");
        var item = JSON.parse(JSON.stringify(newCase));

        allCases.push(item);
        component.set("v.cases", allCases);
        component.set("v.case", {'Comments': 'add comment', 'Description':'add description'});
    },

    createC :  function(cmp, event, helper) {
        $A.createComponent(
            "lightning:button",
            {
                "aura:id": "findableAuraId",
                "label": "Press Me",
                "onclick": cmp.getReference("c.handlePress")
            },
            function(newButton, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    var body = cmp.get("v.body");
                    body.push(newButton);
                    cmp.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
            }
        );

        var compEvent = cmp.getEvent("testEvent");
        compEvent.setParam("message", "Event message from child");
        compEvent.fire();

        var action = cmp.get("c.createCases");
        action.setParams({cases : cmp.get("v.cases")});
        action.setCallback(this, function(response){
        });
	 $A.enqueueAction(action);
    },
    
    handlePress : function(cmp) {
        // Find the button by the aura:id value
        console.log("button: " + cmp.find("findableAuraId"));
        console.log("button pressed");
}
})