({
	doInit : function(component, event, helper) {
        var action=component.get("c.getCaseInfo");
        action.setParams({
            caseId:component.get("v.recordId")
        });
        
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result= response.getReturnValue();
                component.set("v.caseInfo", result);
                helper.getProductInfo(component, result.Contact.Product__c,result.Contact.Home_Country__c); //Passing the contact object
            } else if (state === "ERROR") {
                helper.showPageMessage(component, "Error processing your request.", "error");
            }
        });
        $A.enqueueAction(action);
	}
})