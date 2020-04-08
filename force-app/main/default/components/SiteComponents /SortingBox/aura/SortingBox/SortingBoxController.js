({
  doInit : function(component, event, helper){
    helper.updateRequestString(component);
    helper.setMaxPriceValue(component);
    helper.setInternalFieldMaxValue(component, 'Bads__c', 'v.defaultMaxBadsValue');
  },

  updateRequestString: function (component, event, helper) {
    helper.updateRequestString(component);
  },

  updateVisableMaxPrice : function(component, event, helper){
    helper.updateVisableMaxPrice(component);
  }
})
