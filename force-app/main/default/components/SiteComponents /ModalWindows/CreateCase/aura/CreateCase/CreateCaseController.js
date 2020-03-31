({
    closeWindow: function (component, event, helper) {
        component.destroy();
    },

    goToNextStep: function (component, event, helper) {
        let currentStep = component.get('v.creationStep');
        component.set('v.nextButtonDisabled', false);

        switch (currentStep) {
            case 1:
                component.set('v.dataWaiting', true);
                helper.checkContactInformation(component);
                break;
            case 2:
                currentStep++;
                break;
            case 3:
                component.set('v.dataWaiting', true);
                helper.setInfoAndCreateCase(component);
                component.set('v.nextButtonHidden', true);
                break;
        }

        component.set('v.creationStep', currentStep);
    },

    checkValidation: function (component, event, helper) {
        let currentStep = component.get('v.creationStep'),
            nextButtonDisabled = false;
        component.set('v.nextButtonDisabled', true);

        switch (currentStep) {
            case 1:
                let mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
                    email = component.get('v.email'),
                    description = component.get('v.description'),
                    caseText = component.get('v.caseText'),
                    phone = component.get('v.phone');

                if (!email) {
                    email = '';
                }

                if ((!description || description.length < 10) || (!caseText || caseText.length < 25) || (!email.match(mailformat)) || !phone) {
                    nextButtonDisabled = true;
                }
                break;
            case 2:
                let firstName = component.get('v.firstName'),
                    lastName = component.get('v.lastName');

                if (!firstName || firstName.length < 2 || !lastName || lastName.length < 2) {
                    nextButtonDisabled = true;
                }
                break;
        }
        component.set('v.nextButtonDisabled', nextButtonDisabled);
    }
})
