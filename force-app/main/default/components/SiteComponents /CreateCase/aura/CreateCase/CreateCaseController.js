({
    createCase : function(component, event, helper) {
        $A.createComponent(
            'c:CreateCaseModalWindow', 
            {},
            (modalWindow, status, errorMessage) => {
                let body = component.find('modalWindowPlace').get('v.body');
                body.push(modalWindow);
                component.find('modalWindowPlace').set('v.body', body);
            }
        )
    }
})
