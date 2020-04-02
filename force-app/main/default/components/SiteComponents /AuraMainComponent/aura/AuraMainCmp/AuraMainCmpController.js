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

    changeCurrency : function(component, event, helper){
        let currencyType = event.getParam('currencyType');
        
    }
})
