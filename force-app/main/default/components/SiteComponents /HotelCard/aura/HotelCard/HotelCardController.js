({
    getMoreInfo : function(component, event, helper) {
        let clickOnHotelCardEvent = component.getEvent('clickOnHotelCard'),
            hotel = component.get('v.hotel');
        clickOnHotelCardEvent.setParams({'hotel':hotel});
        clickOnHotelCardEvent.fire();
    }
})
