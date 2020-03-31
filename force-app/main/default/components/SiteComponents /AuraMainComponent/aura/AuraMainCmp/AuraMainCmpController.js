({
    updateSelectedHotel : function(component, event, helper){
        let selectedHotel = event.getParam('hotel');
        component.set('v.selectedHotel', selectedHotel);
        if(selectedHotel){
            component.set('v.additionalInformationSize', 7);
            component.set('v.mainInformationSize', 5);
        } else {
            component.set('v.additionalInformationSize', 0);
            component.set('v.mainInformationSize', 12);
        }
    }, 

    showBookingModalWindow : function(component, event, helper){
        let room = event.getParam('room');
        if(room){
            $A.createComponent(
                'c:CreateBookingCardModal',{
                    'roomId' : room.Id,
                    'isOpen' : true
                },
                (modalWindow, status, errorMessage) => {
                    let body = component.find('modalWindowsPlace').get('v.body');
                    body.push(modalWindow);
                    component.find('modalWindowsPlace').set('v.body', body);
                }
            )
        }
    },

    showCaseCreateModalWindow : function(component, event, helper){
        $A.createComponent(
            'c:CreateCase', 
            {},
            (modalWindow, status, errorMessage) => {
                let body = component.find('modalWindowsPlace').get('v.body');
                body.push(modalWindow);
                component.find('modalWindowsPlace').set('v.body', body);
            }
        )
    }
})
