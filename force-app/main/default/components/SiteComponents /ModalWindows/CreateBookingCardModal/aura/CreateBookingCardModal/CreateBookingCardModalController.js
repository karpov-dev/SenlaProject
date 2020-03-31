({
   closeWindow: function (component, event, helper) {
      component.destroy();
   },

   goToNextStep: function (component, event, helper) {
      let currentStep = component.get('v.creationStep');
      component.set('v.nextButtonDisabled', true);
      component.set('v.errorMessage', null);
      switch (currentStep) {

         case 1:
            component.set('v.dataWaiting', true);
            let email = component.get('v.email'),
               phone = component.get('v.phone');
            helper.checkContactInformation(component, email, phone);
            break;

         case 2:
            currentStep++;
            break;

         case 3:
            component.set('v.dataWaiting', true);
            let startDate = component.get('v.startBooking'),
               endDate = component.get('v.endBooking'),
               roomId = component.get('v.roomId');
            helper.checkBookingDate(component, startDate, endDate, roomId);
            component.set('v.nextButtonDisabled', false);
            break;

         case 4:
            let userInfo = component.get('v.userInfo'),
            opportunity = helper.createOpportunity(component);
            switch (userInfo[0].key) {
               case 'LEAD':
                  opportunity.LeadId__c = userInfo[0].value;
                  helper.insertOpportunity(component, opportunity);
                  break;
               case 'CONTACT':
                  opportunity.Contact__c = userInfo[0].value;
                  helper.insertOpportunity(component, opportunity);
                  break;
               default:
                  helper.createLeadWithOpportunity(component, opportunity);
                  break;
            }
            currentStep++;
            break;
      }
      component.set('v.creationStep', currentStep);
   },

   fieldsValidity: function (component, event, helper) {
      component.set('v.nextButtonDisabled', false);
      let step = component.get('v.creationStep'),
         buttonDisabled = false;
      switch (step) {
         case 1:
            let email = component.get('v.email'),
               phone = component.find('phone').get('v.validity'),
               mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            if (!email) {
               email = ' ';
            }
            if (!phone.valid || !email.match(mailformat)) {
               buttonDisabled = true;
            }
            break;

         case 2:
            let firstName = component.find('firstName').get('v.validity'),
               lastName = component.find('lastName').get('v.validity');
            if (!firstName.valid || !lastName.valid) {
               buttonDisabled = true;
            }
            break;

         case 3:
            let startBooking = component.find('startBooking').get('v.validity'),
               endBooking = component.find('endBooking').get('v.validity'),
               startBookingDate = new Date(component.get('v.startBooking')),
               endBookingDate = new Date(component.get('v.endBooking'));
            if (endBookingDate <= startBookingDate || startBookingDate < Date.now() || !startBooking.valid || !endBooking.valid) {
               buttonDisabled = true;
            }
            break;
      }
      component.set('v.nextButtonDisabled', buttonDisabled);
   }
})
