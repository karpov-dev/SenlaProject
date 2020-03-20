({
    getRooms : function(component, event, helper) {
        let action = component.get('c.getProducts');
        action.setParams({hotel : component.get("v.hotel")});
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === 'SUCCESS'){
                component.set('v.rooms', response.getReturnValue());
            } else if (state === 'INCOMPLETE'){
                console.log('Response has some problems. Response state is INCOMPLETE');
            } else if(state === 'ERROR'){
                let errors = response.getError();
                if(errors){
                    if(errors[0] && errors[0].message){
                        console.log('Response has errors: ' + errors[0].message);
                    }
                }
            }
        });
        $A.enqueueAction(action);
    }
})
