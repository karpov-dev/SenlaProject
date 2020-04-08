({
    doInit: function (component, event, helper) {
        helper.addOnScrollListner(component, helper);
        helper.loadData(component);
    },

    reloadData : function(component, event, helper){
        component.set('v.requestOffset', 0);
        component.set('v.recordsEnded', false);
        helper.loadData(component, true);
    }
})
