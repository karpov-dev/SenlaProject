({
    updateSortingBoxRequestResult : function(component, event, helper) {
        component.set('v.sortingBoxRequestResult', event.getParam('sqlRequest'));
    },

    updateSelectedRoom : function(component, event, helper){
        component.set('v.selectedRoom', event.getParam('room'));
    },

    updateHotel : function(component, event, helper){
        component.set('v.selectedRoom', null);
    },

})
