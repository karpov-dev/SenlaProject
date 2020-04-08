({
    doInit: function (component, event, helper) {
        helper.loadData(component, component.get('v.sqlRequest'));
    },

    divOnScroll: function (component, event, helper) {
        const PIXELS_TO_START_DATA_LOAD = 5;

        if (!component.get('v.dataWaiting') && !component.get('v.recordsEnded')) {
            component.set('v.dataWaiting', true);
            let div = component.find('container');

            if (div) {
                div = div.getElement();

                if ((div.scrollHeight - div.clientHeight) - PIXELS_TO_START_DATA_LOAD >= div.scrollTop) {
                    setTimeout($A.getCallback(function () {
                        helper.loadData(component, component.get('v.sqlRequest'));
                    }), 500);
                }
            }

        }
    }


})
