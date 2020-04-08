public without sharing class ContactManager {

    public static List<String> getContactEmails(List<Contact> contacts){
        if(contacts != null){
            List<String> emails = new List<String>();
            for(Contact contact : contacts){
                emails.add(contact.Email);
            }
            return emails;
        } else {
            return null;
        }
    }

    public static String getContactIdByEmailAndPhone(String email, String phone){
        if(email != null && phone != null){
            List<Contact> contacts = [SELECT Id FROM Contact WHERE Email = :email OR Phone = :phone LIMIT 1];
            if(contacts.size() > 0){
                return contacts[0].Id;
            } else {
                return null;
            }
        } else {
            return null;
        }
        
    }

    @InvocableMethod
    public static void sendReviewEmails(List<Contact> contacts){
        if(contacts != null){
            System.debug('Started');
            EmailTemplate template = [SELECT Id FROM  Emailtemplate WHERE Name = 'Room Review Email' LIMIT 1];
            System.debug('Template: ' + template);
            List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
            for(Contact contact : contacts){
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.toaddresses = new String[]{contact.Email};
                message.setTemplateId(template.Id);
                message.setTargetObjectId(contact.Id);
                emailsToSend.add(message);
            }
            System.debug(emailsToSend);
            Messaging.sendEmail(emailsToSend);
        } else {
            throw new NullPointerException();
        }
    }
}
