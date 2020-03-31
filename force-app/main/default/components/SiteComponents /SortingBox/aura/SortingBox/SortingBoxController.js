({
  updateRequestString: function (component, event, helper) {
    let productQuery = 'SELECT Id, Bads__c, Conveniences__c, Description, Name, Rating__c, Room_Address__c, Hotel__c FROM Product2',
      priceQuery = 'SELECT UnitPrice FROM PricebookEntries',
      priceCondition = 'SELECT Product2Id FROM PricebookEntry',
      startBooking = component.get('v.startBookingDate'),
      endBooking = component.get('v.endBookingDate'),
      isString = true;

    productQuery = helper.insertSubquery(productQuery, priceQuery, 'Product2');

    priceCondition = helper.addWhereFilter(priceCondition, 'UnitPrice', ' <= ', component.get('v.maxPriceFilter'));

    productQuery = helper.addWhereFilter(productQuery, 'Bads__c', ' = ', component.get('v.amountBadsFilter'));
    productQuery = helper.addWhereFilter(productQuery, 'Rating__c', ' >= ', component.get('v.minimalRating'));
    productQuery = helper.addWhereFilter(productQuery, 'Hotel__c ', ' = ', component.get('v.hotelIdFilter'), isString);
    productQuery = helper.addWhereFilter(productQuery, 'Id', ' IN ', ' (' + priceCondition + ') ');

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
      productQuery = helper.addWhereFilter(productQuery, 'Id', 'NOT IN', ' ( ' + opportunityQuery + ' ) ');
    }
    
    component.set('v.sqlRequestString', productQuery);

    let requestChangedEvent = component.getEvent('sqlRequestChanged');
    requestChangedEvent.setParams({ 'sqlRequest': productQuery });
    requestChangedEvent.fire();

  },
})
