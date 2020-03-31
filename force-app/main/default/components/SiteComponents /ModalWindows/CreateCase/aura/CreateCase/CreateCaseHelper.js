({
    checkContactInformation: function (component) {
        let email = component.get('v.email'),
            phone = component.get('v.phone');

        if (email && phone) {
            let action = component.get('c.getContactInformationOwner');

            action.setParams({
                'email': email,
                'phone': phone
            });

            action.setCallback(this, (response) => {
                let state = response.getState();

                if (state === 'SUCCESS') {
                    let responseValue = response.getReturnValue(),
                        currentStep = component.get('v.creationStep'),
                        responseMap = [];

                    for (let key in responseValue) {
                        responseMap.push({ value: responseValue[key], key: key });
                    }

                    switch (responseMap[0].key) {
                        case 'LEAD':
                            currentStep += 2;
                            break;
                        case 'CONTACT':
                            currentStep += 2;
                            break
                        default:
                            currentStep++;
                            break;
                    }

                    component.set('v.userInfo', responseMap);
                    component.set('v.creationStep', currentStep);

                } else if (state === 'INCOMPLETE' || state === 'ERROR') {
                    this.createErrorMessage(component, response);
                }

                component.set('v.dataWaiting', false);
            });

            $A.enqueueAction(action);
        } else {
            this.createErrorMessage(component);
        }
    },

    setInfoAndCreateCase: function (component) {
        let caseOwner = component.get('v.userInfo'),
            newCase = component.get('v.newCase');

        newCase.Subject = component.get('v.description');
        newCase.Description = component.get('v.caseText');

        switch (caseOwner[0].key) {
            case 'LEAD':
                newCase.Lead__c = caseOwner[0].value;
                this.insertNewCase(component, newCase);
                break;
            case 'CONTACT':
                newCase.ContactId = caseOwner[0].value;
                this.insertNewCase(component, newCase);
                break;
            default:
                this.createNewLeadWithCase(component, newCase);
                break;
        }
    },

    createNewLeadWithCase: function (component, newCase) {
        if (newCase) {

            let lead = component.get('v.newLead');
            lead.FirstName = component.get('v.firstName');
            lead.LastName = component.get('v.lastName');
            lead.Email = component.get('v.email');
            lead.Phone = component.get('v.phone');
            lead.Company = 'Hotel Guest';

            let action = component.get('c.insertLeadAndGetId');

            action.setParams({
                'newLead': lead
            });

            action.setCallback(this, (response) => {
                let state = response.getState();

                if (state === 'SUCCESS') {
                    newCase.Lead__c = response.getReturnValue();
                    this.insertNewCase(component, newCase);

                } else if (state === 'INCOMPLETE' || state === 'ERROR') {
                    this.createErrorMessage(component, response);
                }

            });

            $A.enqueueAction(action);

        } else {
            this.createErrorMessage(component);
        }
    },

    insertNewCase: function (component, newCase) {
        if (newCase) {
            let newCase = component.get('v.newCase'),
                action = component.get('c.insertCase');

            action.setParams({
                'newCase': newCase
            });

            action.setCallback(this, (response) => {
                let state = response.getState();

                if (state === 'SUCCESS') {
                    let currentStep = component.get('v.creationStep');
                    currentStep++;
                    component.set('v.creationStep', currentStep);

                } else if (state === 'INCOMPLETE' || state === 'ERROR') {
                    this.createErrorMessage(component, response);
                }
                component.set('v.dataWaiting', false);
            });

            $A.enqueueAction(action);
        } else {
            this.createErrorMessage(component);
        }
    },

    createErrorMessage: function (component, response=null) {
        let errorMessage = 'При создании запроса возникла ошибка. Перезагрузите страницу или обратитесь в системному администратору. Текст ошибки: ';
        if (response != null) {
            let errors = response.getError();
            if (errors) {
                if (errors[0] && errors[0].message) {
                    errorMessage += errors[0].message;
                } else {
                    errorMessage += 'Unknown error.';
                }
            }
        }
        component.set('v.errorMessage', errorMessage);
    },

})
