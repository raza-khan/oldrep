({
	getProductInfo : function(component, productId, country) {
      
		var action=component.get("c.getProductInfo");
        action.setParams({
            productId:productId,
            country:country
            
        });
        
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result= response.getReturnValue();
                component.set("v.productInfo", result);
                component.set("v.showLoader", false);
            } else if (state === "ERROR") {
                helper.showPageMessage(component, "Error getting product info.", "error");
            }
        });
        $A.enqueueAction(action);
	},
    
    
    showPageMessage: function(component, message, type){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            message: message,
            type: type
        });
        toastEvent.fire();
        if(type == 'error'){
            component.set('v.showLoader', false);
        }
    }
})