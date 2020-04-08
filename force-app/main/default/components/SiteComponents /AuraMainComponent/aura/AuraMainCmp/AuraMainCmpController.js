({
    doInit : function(component, event, helper){
        let defaultRate = component.get('v.currentRate');
        defaultRate.key = 'BYN';
        defaultRate.value = '1';
        component.set('v.currentRate', defaultRate);
    },

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

    setNewRate : function(component, event, helper){
        let currentRate = component.get('v.currentRate');
        currentRate.key = event.getParam('currency');
        currentRate.value = event.getParam('rate');
        component.set('v.currentRate', currentRate);
    },

    showToast : function(component, event, helper){
        helper.showToast(component, event);
    }, 

    setMapMarker : function(component, event, helper){
        let hotelsViewComponent = component.find('HotelsView');
        hotelsViewComponent.set('v.mapEnabled', true);
        hotelsViewComponent.set('v.selectedHotelIdMarker', event.getParam('hotelId'));
    }
})
