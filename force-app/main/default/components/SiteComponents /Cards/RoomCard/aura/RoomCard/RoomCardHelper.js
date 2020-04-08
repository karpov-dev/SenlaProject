({
    updateVisablePrice : function(component) {
        const CHARACTERS = 2;

        let pricebookEnrty = component.get('v.priceBookEntry'),
        rate = component.get('v.currentRate');

        if(pricebookEnrty && rate){
            let newPrice = pricebookEnrty.UnitPrice / rate.value;
            component.set('v.visablePrice', newPrice.toFixed(CHARACTERS));
        }
    }
})
