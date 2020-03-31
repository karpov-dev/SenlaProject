({
    loadData : function(component, baseRequestString, reset=false){
        let action = component.get('c.getHotelsByRequestString'),
            fullRequestString = '';

        if(reset){
            component.set('v.requestOffset', 0);
            fullRequestString = baseRequestString + ' LIMIT ' + component.get('v.requestStep') + ' OFFSET 0';
        } else{
            fullRequestString = baseRequestString + ' LIMIT ' + component.get('v.requestStep') + ' OFFSET ' + component.get('v.requestOffset');
        }

        action.setParams({'requestString' : fullRequestString});

        action.setCallback(this, (response) =>{
            let state = response.getState(),
                errorMessage = '';
            if(state === 'SUCCESS'){
                let serverResponse = response.getReturnValue(),
                    allHotels = component.get('v.hotels');

                if(reset){
                    allHotels = serverResponse;
                } else {
                    allHotels = allHotels.concat(serverResponse);
                }

                if(serverResponse.length === 0){
                    component.set('v.recordsEnded', true);
                }

                component.set('v.hotels', allHotels);
                component.set('v.requestOffset', component.get('v.requestOffset') + serverResponse.length);
                component.set('v.dataWaiting', false);
                component.set('v.requestIsLocked', false);

            } else if(state === 'INCOMPLETE'){
                component.set('v.errorMessage', "'Response is INCOMPLETE'");

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
        });
        
        $A.enqueueAction(action);
    }
})
