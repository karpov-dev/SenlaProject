public class ObjectsManager {
    
    public static Boolean checkEmailIsUniqueEnabled = true;

    public static Boolean emailIsUnique(List<String> emails){
        if(emails != null){
            if(checkEmailIsUniqueEnabled){
                List<Lead> leads = [SELECT Id FROM Lead WHERE Email IN :emails LIMIT 1];
                List<Contact> contacts = [SELECT Id FROM Contact WHERE Email IN :emails LIMIT 1];
                if(leads.size() == 0 && contacts.size() == 0){
                    return true;
                }
                return false;
            } else {
                return true;
            }
        } else{
            throw new NullPointerException();
        }
    }

}
