({
    init: function (component, event, helper) {
        helper.loadData(component, component.get('v.sqlRequest'));
    },

    handleMarkerSelect: function (component, event, helper) {
        let selectedHotelId = event.getParam("selectedMarkerValue"),
            hotels = component.get('v.hotels');
        let selectedHotel = helper.getSelectedHotel(selectedHotelId, hotels);
        if (selectedHotel) {
            let clickOnHotelCardEvent = component.getEvent('changeSelectedHotelEvent');
            clickOnHotelCardEvent.setParams({ 'hotel': selectedHotel });
            clickOnHotelCardEvent.fire();
        }
    }
});

