({
    doInit : function(component, event, helper) {
        let action = component.get('c.getRates');

        action.setCallback(this, (response) => {
            let state = response.getState();

            if(state === 'SUCCESS'){
                let rates = response.getReturnValue(),
                currency = component.get('v.currencyNameList');

                for(let key in rates){
                    currency.push(key);
                }

                component.set('v.rates', rates);
                component.set('v.currencyNameList', currency);

            } else if(state === 'ERROR'){
                
            }
        });

        $A.enqueueAction(action);
    },

    fireCurrencyRate : function(component, event, helper){
        let selectedCurrecny = event.getParam('value'),
        chengedCurrencyEvent = component.getEvent('chengedCurrency'),
        rates = component.get('v.rates');

        chengedCurrencyEvent.setParams({
            'currency' : selectedCurrecny,
            'rate' : rates[selectedCurrecny]
        });

        chengedCurrencyEvent.fire();

    }
})
