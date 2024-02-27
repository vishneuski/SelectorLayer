({
    getDataFromController : function(cmp, event, helper) {
        var action = cmp.get("c.getData");
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('!!!STATE - ', state);

            if (state === "SUCCESS") {
                console.log('!!!RESULT 1 - ', response);
                console.log('!!!RESULT 2 - ', response.getReturnValue());
                cmp.set("v.result", response.getReturnValue());
            }
        });
	 $A.enqueueAction(action);
    },

    getLeadsFromController : function(cmp, event, helper) {
        var action = cmp.get("c.getLeads");
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('!!!STATE - ', state);

            if (state === "SUCCESS") {
                console.log('!!!RESULT 1 - ', response);
                console.log('!!!RESULT 2 - ', response.getReturnValue());
                cmp.set("v.leads", response.getReturnValue());
            }
        });
	 $A.enqueueAction(action);
    },
     
    changeParentAttr : function(cmp, event, helper) {
        cmp.set("v.result", "Updated Parent Attr");
    },

    handleChildEvent : function(cmp, event, helper) {
        // console.log('!!!PARAMS - ', event.getParams().message);
        // cmp.set("v.messageFromChild", event.getName());
        cmp.set("v.messageFromChild", event.getParams().message);
    },

    scriptsLoaded : function(cmp, event, helper) {
        console.log('!!!SCRIPT LOADED!!!');
        window.sayHello();
    },
})