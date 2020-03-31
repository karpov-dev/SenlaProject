({
    fireClickEvent : function(component, event, helper) {
        let clickOnRoomCardEvent = component.getEvent('changedSelectedRoomEvent');
        clickOnRoomCardEvent.setParams({'room' : component.get('v.room')});
        clickOnRoomCardEvent.fire();
    }, 

    fireBookingEvent : function(component, event, helper){
        let showBookingModalWindowEvent = component.getEvent('showBookingModalWindowEvent');
        showBookingModalWindowEvent.setParams({'room' : component.get('v.room')});
        showBookingModalWindowEvent.fire();
    }
})
