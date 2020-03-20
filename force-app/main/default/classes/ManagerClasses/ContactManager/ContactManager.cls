public class ContactManager {

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
}
