({
    mapEnable : function(component, event, helper) {
        component.set('v.mapEnabled', true);
    },

    mapDisable : function(component, event, helper){
        component.set('v.mapEnabled', false);
    },

    refreshMapMarker : function(component, event, helper){
        if(!component.get('v.mapEnabled')){
            component.set('v.selectedHotelIdMarker', null);
        }
    }
})
