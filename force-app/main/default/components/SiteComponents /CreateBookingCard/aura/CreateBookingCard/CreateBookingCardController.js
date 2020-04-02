({
    createBookingCard: function(component, event, helper) {
        let roomId = component.get('v.roomId');
        if(roomId){
            $A.createComponent(
                'c:CreateBookingCardModal',{
                    'roomId' : roomId,
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
})
