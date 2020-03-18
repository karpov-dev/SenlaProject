public class ContactManager {
    
    public static Contact getContactByEmail(List<Contact> contacts, String email){
        for(Contact contact : contacts){
            if(contact.Email == email){
                return contact;
            }
        }
        return null;
    }

    public static List<Contact> getContactsByEmail(String email){
        List<List<sObject>> contacts = [FIND :email IN EMAIL FIELDS RETURNING Contact(Email)];
        return (List<Contact>)contacts[0];
    }

}
