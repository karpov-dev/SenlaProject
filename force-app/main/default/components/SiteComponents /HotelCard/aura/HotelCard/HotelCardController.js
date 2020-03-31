({
    getMoreInfo : function(component, event, helper) {
        let clickOnHotelCardEvent = component.getEvent('changeSelectedHotelEvent');
        clickOnHotelCardEvent.setParams({'hotel' : component.get('v.hotel')});
        clickOnHotelCardEvent.fire();
    }
})
