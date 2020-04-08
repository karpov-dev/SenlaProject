public without sharing class ObjectsManager {
    
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
            return null;
        }
    }

    public static Map<String,String> getContactInformationOwner(String email, String phone){
        if(email != null && phone != null){
            Map<String,String> searchResult = new Map<String,String>();
            String leadId = LeadManager.getLeadIdByEmailAndPhone(email, phone);
            if(leadId != null){
                searchResult.put('LEAD', leadId);
            } else {
                String contactId = ContactManager.getContactIdByEmailAndPhone(email, phone);
                if(contactId != null){
                    searchResult.put('CONTACT', contactId);
                } else {
                    searchResult.put('NULL', 'NULL');
                }
            }
            return searchResult;
        } else {
            return null;
        }
    }

}
