({
    fireClickEvent : function(component, event, helper) {
        let clickOnRoomCardEvent = component.getEvent('changedSelectedRoomEvent');
        clickOnRoomCardEvent.setParams({'room' : component.get('v.room')});
        clickOnRoomCardEvent.fire();
    }, 
})
