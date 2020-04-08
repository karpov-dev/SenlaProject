({
    getRooms : function(component, event, helper){
        if(!component.get('v.dataWaiting')){
            component.set('v.dataWaiting', true);
            helper.loadData(component, component.get('v.roomsSqlRequestString'));
        }
    },

    loadLastRequest : function(component, event, helper){
        if(!component.get('v.dataWaiting')){
            helper.loadData(component, component.get('v.roomsSqlRequestString'));
        }
    },

    closeComponent : function(component, event, helper){
        let componentClosed = component.getEvent('changeSelectedHotelEvent');
        componentClosed.setParams({'hotel' : null});
        componentClosed.fire();
    },

    openMap : function(component, event, helper){
        let openInMap = component.getEvent('openHotelInMap');
        openInMap.setParams({'hotelId' : component.get('v.hotel').Id});
        openInMap.fire();
    }
})
