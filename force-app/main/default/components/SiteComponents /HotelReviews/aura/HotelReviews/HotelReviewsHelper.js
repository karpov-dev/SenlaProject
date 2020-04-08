({
    addOnScrollListner: function (component, helper) {

        document.addEventListener('scroll', () => {
            const PIXELS_TO_START_DATA_LOAD = 5;

            if (!component.get('v.dataWaiting') && !component.get('v.recordsEnded')) {    
                let windowRelativeBottom = document.documentElement.getBoundingClientRect().bottom;
    
                if (windowRelativeBottom < document.documentElement.clientHeight + PIXELS_TO_START_DATA_LOAD) {
                    component.set('v.dataWaiting', true);
                    setTimeout($A.getCallback( () => {
                        helper.loadData(component);
                    }), 500);
                }
    
            } 

        });

    },

    loadData : function(component, reset=false){
        let action = component.get('c.getHotelReviewsByOffset'),
        recordsOffset = component.get('v.requestOffset'),
        hotelId = component.get('v.hotelId'),
        recordsLimit = component.get('v.loadStep');
        
        action.setParams({
            'recordsOffset' : recordsOffset,
            'hotelId' : hotelId,
            'recordsLimit' : recordsLimit
        });

        action.setCallback(this, (response) => {
            let state = response.getState();

            if(state === 'SUCCESS'){
                let returnedReviews = response.getReturnValue(),
                allReviews = component.get('v.reviews'),
                amountReviews = 0;
                
                if(reset){
                    allReviews = returnedReviews;
                } else {
                    allReviews = allReviews.concat(returnedReviews);
                }

                if(!returnedReviews || returnedReviews.length == 0){
                    component.set('v.recordsEnded', true);
                }

                if(returnedReviews){
                    amountReviews = returnedReviews.length;
                }

                component.set('v.reviews', allReviews);
                component.set('v.requestOffset', component.get('v.requestOffset') + amountReviews);

            } else{
                let errors = response.getError();
                alert(errors[0].message);
            }
            component.set('v.dataWaiting', false);
        });

        $A.enqueueAction(action);
    }
}) 
