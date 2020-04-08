({
    doInit : function(component, event, helper){
        helper.changeDisplayedHotelDescription(component);
    },
    
    changeDisplayedDescription : function(component, event, helper){
        helper.changeDisplayedHotelDescription(component);
    },

    getMoreInfo : function(component, event, helper) {
        let clickOnHotelCardEvent = component.getEvent('changeSelectedHotelEvent');
        clickOnHotelCardEvent.setParams({'hotel' : component.get('v.hotel')});
        clickOnHotelCardEvent.fire();
    }
})
