public without sharing class ContactManager {

    public static List<String> getContactEmails(List<Contact> contacts){
        if(contacts != null){
            List<String> emails = new List<String>();
            for(Contact contact : contacts){
                emails.add(contact.Email);
            }
            return emails;
        } else {
            throw new NullPointerException();
        }
    }

    public static String getContactIdByEmailAndPhone(String email, String phone){
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Email = :email OR Phone = :phone LIMIT 1];
        if(contacts.size() > 0){
            return contacts[0].Id;
        } else {
            return null;
        }
        
    }
}
