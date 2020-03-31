({
    loadData: function (component, sqpRequest) {
        let action = component.get('c.getHotelsByRequestString');

        action.setParams({ 'requestString': sqpRequest });

        action.setCallback(this, (response) => {
            let state = response.getState(),
                errorMessage = '';

            if (state === 'SUCCESS') {
                let markers = component.get('v.mapMarkers'),
                    hotels = response.getReturnValue();
                component.set('v.hotels', hotels);
                for (let i = 0; i < hotels.length; i++) {
                    markers.push({
                        'location': {
                            'Latitude': hotels[i].Geolocation__Latitude__s,
                            'Longitude': hotels[i].Geolocation__Longitude__s
                        },
                        'title': hotels[i].Name,
                        'description': 'Email: ' + hotels[i].Email__c,
                        'value': hotels[i].Id
                    });
                }
                component.set('v.mapMarkers', markers);

            } else if (state === 'INCOMPLETE') {
                errorMessage = 'response in INCOMPLETE';

            } else if (state === 'ERROR') {
                let errors = response.getError(),
                    errorText = '';
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorText = errors[0].message;
                    } else {
                        errorText = 'Unknown error';
                    }
                }
                component.set('v.errorMessage', "'Response has error. '" + errorText);
            }

        });
        $A.enqueueAction(action);
    },

    getSelectedHotel: function (selectedHotelId, hotels) {
        if (selectedHotelId && hotels) {
            for (let i = 0; i < hotels.length; i++) {
                if (hotels[i].Id == selectedHotelId) {
                    return hotels[i];
                }
            }
        }
        return null;
    }
})
