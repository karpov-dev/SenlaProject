public class ContactTriggerHandler extends TriggerHandler{
    
    public override void beforeInsert(){
        List<Contact> newContacts = (List<Contact>)Trigger.new;
        List<String> newContactsEmails = ContactManager.getContactEmails(newContacts);
        if(ObjectsManager.emailIsUnique(newContactsEmails)){
            
        } else {
            newContacts[0].addError('Email must be unique.');
        }
    }

}
