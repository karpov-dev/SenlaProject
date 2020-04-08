({
    updateRequestString: function (component) {
        let productQuery = 'SELECT Id, Name, Rating__c FROM Product2',
            priceQuery = 'SELECT UnitPrice FROM PricebookEntries',
            priceCondition = 'SELECT Product2Id FROM PricebookEntry',
            startBooking = component.get('v.startBookingDate'),
            endBooking = component.get('v.endBookingDate'),
            isString = true;

        productQuery = this.insertSubquery(productQuery, priceQuery, 'Product2');

        priceCondition = this.addWhereFilter(priceCondition, 'UnitPrice', ' <= ', component.get('v.maxPriceFilter') * component.get('v.currentRate').value);

        productQuery = this.addWhereFilter(productQuery, 'Bads__c', ' = ', component.get('v.amountBadsFilter'));
        productQuery = this.addWhereFilter(productQuery, 'Rating__c', ' >= ', component.get('v.minimalRating'));
        productQuery = this.addWhereFilter(productQuery, 'Hotel__c ', ' = ', component.get('v.hotelIdFilter'), isString);
        productQuery = this.addWhereFilter(productQuery, 'Id', ' IN ', ' (' + priceCondition + ') ');

        if (startBooking && endBooking) {
            let opportunityQuery = 'SELECT Product__c FROM Opportunity',
                oppEndBooking = 'CloseDate',
                oppStartBooking = 'Open_Date__c',
                expressions = [
                    [' ( ' + oppStartBooking + ' > ' + startBooking + ' AND ' + oppStartBooking + ' < ' + endBooking + ' ) '],
                    [' ( ' + oppEndBooking + ' >= ' + startBooking + ' AND ' + oppEndBooking + ' < ' + endBooking + ' ) '],
                    [' ( ' + oppStartBooking + ' <= ' + startBooking + ' AND ' + oppEndBooking + ' >= ' + endBooking + ' ) ']
                ];
            opportunityQuery += ' WHERE ' + expressions[0] + ' OR ' + expressions[1] + ' OR ' + expressions[2] + ' ';

            productQuery = this.addWhereFilter(productQuery, 'Id', 'NOT IN', ' ( ' + opportunityQuery + ' ) ');
            productQuery += ' ORDER BY Name';
        }

        let requestChangedEvent = component.getEvent('sqlRequestChanged');
        component.set('v.sqlRequestString', productQuery);
        requestChangedEvent.setParams({ 'sqlRequest': productQuery });
        requestChangedEvent.fire();
    },

    addWhereFilter: function (queryString, fieldName, relationSign, fieldValue, isString=false) {
        if (queryString && fieldName && relationSign && fieldValue && fieldValue != 0) {

            if (!queryString.includes('WHERE')) {
                queryString += ' WHERE ';
            } else {
                queryString += ' AND ';
            }

            if (isString) {
                queryString += " " + fieldName + " " + relationSign + " '" + fieldValue + "' ";
            } else {
                queryString += ' ' + fieldName + ' ' + relationSign + ' ' + fieldValue + ' ';
            }

            return queryString;
        } else {
            return queryString;
        }
    },

    insertSubquery: function (query, subquery, mainElement) {
        if (query, subquery) {
            let fromLastIndexOf = query.lastIndexOf(mainElement),
                firstSubstring = query.slice(0, fromLastIndexOf - 5),
                secondSubstring = query.slice(fromLastIndexOf - 5);
            firstSubstring += ', (' + subquery + ') ';
            firstSubstring += secondSubstring;
            return firstSubstring;
        } else {
            return null;
        }
    },

    createExpression: function (firstCondition, sign, secondCondition, withoutBrackets=false) {
        if (firstCondition && sign && secondCondition) {
            if (withoutBrackets) {
                return ' ' + firstCondition + ' ' + sign + ' ' + secondCondition + ' ';
            } else {
                return ' ( ' + firstCondition + ' ' + sign + ' ' + secondCondition + ' ) ';
            }
        }
        return ' ';
    },

    setMaxPriceValue: function (component) {
        let action = component.get('c.getMaxUnitPrice');
        action.setCallback(this, (response) => {
            let state = response.getState();
            if (state === 'SUCCESS') {
                component.set('v.defaultMaxPriceValue', response.getReturnValue());
                this.updateVisableMaxPrice(component);
            } else if (state === 'ERORR') {
                alert('error');
            }
        });
        $A.enqueueAction(action);
    },

    setInternalFieldMaxValue: function (component, fieldName, attributeName) {
        if (fieldName && attributeName) {
            let action = component.get('c.getFieldMaxValue');
            action.setParams({
                'fieldName': fieldName
            });
            action.setCallback(this, (response) => {
                let state = response.getState();
                if (state === 'SUCCESS') {
                    component.set(attributeName, response.getReturnValue());
                } else if (state === 'ERROR') {
                    alert('error');
                }
            });
            $A.enqueueAction(action);
        }
    },

    updateVisableMaxPrice: function (component) {
        const CHARACTERS = 0;

        let newRate = component.get('v.currentRate'),
            defaultMaxPriceValue = component.get('v.defaultMaxPriceValue'),
            newPriceValue = defaultMaxPriceValue / newRate.value;
        component.find('maxPriceSlider').set('v.max', newPriceValue.toFixed(CHARACTERS));
    }
})
