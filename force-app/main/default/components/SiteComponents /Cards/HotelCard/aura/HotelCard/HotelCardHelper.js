({
    changeDisplayedHotelDescription : function(component) {
        let subDescription = component.get('v.hotel.Description__c').slice(0, 200);
        component.set('v.displayedHotelDescription', subDescription + '...');
    }
})
