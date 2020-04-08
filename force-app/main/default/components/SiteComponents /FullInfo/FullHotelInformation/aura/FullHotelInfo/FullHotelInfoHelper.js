({
    loadData : function(component, sqlRequestString) {
        let action = component.get('c.getProductsByRequestString');

        action.setParams({'requestString' :sqlRequestString});

        action.setCallback(this, (response) =>{
            let state = response.getState(),
                errorMessage = '';

            if(state === 'SUCCESS'){
                let responseResult = response.getReturnValue();
                component.set('v.rooms', responseResult);

            } else if(state === 'INCOMPLETE'){
                errorMessage = 'response in INCOMPLETE';

            } else if(state === 'ERROR'){
                let errors = response.getError(),
                errorText = '';
                if(errors){
                    if(errors[0] && errors[0].message){
                        errorText = errors[0].message;
                    } else {
                        errorText = 'Unknown error';
                    }
                }
                component.set('v.errorMessage', "'Response has error. '" + errorText);
            }
            component.set('v.dataWaiting', false);
        })

        $A.enqueueAction(action);
    }
})
