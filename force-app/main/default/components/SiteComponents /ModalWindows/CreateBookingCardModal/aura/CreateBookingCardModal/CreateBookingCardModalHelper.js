({
    checkContactInformation: function (component, email, phone) {
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

    checkBookingDate: function (component, startDate, endDate, roomId) {
        if (startDate && endDate) {
            let action = component.get('c.roomIsFree');

            action.setParams({
                'startDate': startDate,
                'endDate': endDate,
                'roomId': roomId
            });

            action.setCallback(this, (response) => {
                let state = response.getState();

                if (state === 'SUCCESS') {

                    if (response.getReturnValue()) {
                        component.set('v.nextButtonDisabled', true);
                        let errorMessage = 'На данный промежуток времени комната занята';
                        component.set('v.errorMessage', errorMessage);
                    } else {
                        let currentStep = component.get('v.creationStep');
                        currentStep++;
                        component.set('v.creationStep', currentStep);
                    }

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

    createOpportunity: function (component) {
        let opportunity = component.get('v.newOpportunity');  //в лейбе сделать дефолтное значение первого элимента из stage for opportunity
        opportunity.StageName = 'Open - not processed';
        opportunity.Name = 'Opportunity: ';
        opportunity.Open_Date__c = component.get('v.startBooking');
        opportunity.CloseDate = component.get('v.endBooking');
        opportunity.Product__c = component.get('v.roomId');
        opportunity.Price__c = component.get('v.pricebookEntry.UnitPrice');
        return opportunity;
    },

    createLeadWithOpportunity: function (component, opportunity) {
        if (opportunity) {
            component.set('v.dataWaiting', true);
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
                    opportunity.LeadId__c = response.getReturnValue();
                    this.insertOpportunity(component, opportunity);

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

    insertOpportunity: function (component, opportunity) {
        if (opportunity) {
            component.set('v.dataWaiting', true);
            let action = component.get('c.insertOpportunity');

            action.setParams({
                'newOpportunity': opportunity
            })

            action.setCallback(this, (response) => {
                let state = response.getState();

                if (state === 'SUCCESS') {
                    component.set('v.createCardResult', 'Заявка на комнату успешно создана');

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
    }
})
