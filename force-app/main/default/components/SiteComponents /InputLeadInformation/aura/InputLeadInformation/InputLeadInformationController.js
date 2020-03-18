({
    nextButtonDisabled : function(component, event, helper) {
        let firstName = component.find('firstName').get('v.value'),
            lastName = component.find('lastName').get('v.value'),
            phone = component.find('phone').get('v.value'),
            email = component.find('email').get('v.value'),
            isDisabled = true;
        if(firstName != '' && lastName != '' && phone != '' && email != ''){
            isDisabled = false;
        }
        component.set('v.nextButtonDisabled', isDisabled);

    },

    createLead : function(component, event, helper) {
        
    }
})
