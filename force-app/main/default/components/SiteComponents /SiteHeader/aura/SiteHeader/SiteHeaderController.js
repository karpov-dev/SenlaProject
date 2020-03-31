({
    fireCreateCaseEvent : function(component, event, helper) {
        let createCaseEvent = component.getEvent('createCaseEvent');
        createCaseEvent.fire();
    }
})
