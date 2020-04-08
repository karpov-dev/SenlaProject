({
    getAttachments : function(component) {
        let ownerId = component.get('v.ownerId');
        if(ownerId){
            component.set('v.photoAttachmentId', null);
            let action = component.get('c.getAttachmentsByOwnerId');

            action.setParams({
                'ownerId' : ownerId
            })

            action.setCallback(this, (response) => {
                let state = response.getState();
                
                if(state === 'SUCCESS'){
                    let attachments = response.getReturnValue();
                    if(attachments && attachments.length > 0){
                        component.set('v.photoAttachmentId', attachments[0].Id);
                    }
                }
            });

            $A.enqueueAction(action);
        }
    }
})
