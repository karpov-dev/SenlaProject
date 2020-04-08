public without sharing class LeadManager {

    @InvocableMethod
    public static void convertLeadToContact(List<Lead> leads){
        if(leads != null){
            List<Opportunity> oppToUpdate = new List<Opportunity>();
            List<Contact> contacts = new List<Contact>();
            List<Id> leadIds = new List<Id>();
            for(Integer i = 0; i < leads.size(); i++){
                leadIds.add(leads[i].Id);
            }
            List<Opportunity> allOpportunities = [SELECT Id, LeadId__c, Contact__c FROM Opportunity WHERE LeadId__c IN :leadIds];
            for(Integer i = 0; i < leads.size(); i++){
                contacts.add(new Contact(LastName = 'tmpName'));
            }
            insert contacts;
            for(Integer i = 0; i < leads.size(); i++){
                contacts[i].FirstName = leads[i].FirstName;
                contacts[i].LastName = leads[i].LastName;
                contacts[i].Email = leads[i].Email;
                contacts[i].Phone = leads[i].Phone;
                for(Opportunity opp : allOpportunities){
                    if(opp.LeadId__c == leads[i].Id){
                        try {
                            opp.Contact__c = contacts[i].Id;
                            opp.LeadId__c = null;
                            oppToUpdate.add(opp);
                        } catch (Exception e) {
                            
                        }
                    }
                }
            }
            update contacts;
            update oppToUpdate;
            delete leads;
        } 
    }

    public static List<String> getLeadEmails(List<Lead> leads){
        if(leads != null){
            List<String> emails = new List<String>();
            for(Lead lead : leads){
                try {
                    emails.add(lead.Email);
                } catch (Exception e) {
                    return null;
                }
            }
            return emails;
        } else {
            return null;
        }
    }

    public static String getLeadIdByEmailAndPhone(String email, String phone){
        if(email != null && phone != null){
            List<Lead> leads =  [SELECT Id FROM Lead WHERE Email = :email OR Phone = :phone LIMIT 1];
            if(leads.size() > 0){
                return leads[0].Id;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    public static String insertLeadAndGetId(Lead newLead){
        if(newLead != null){
            String email = newLead.Email;
            try {
                upsert newLead;
            } catch (DmlException e) {
                return null;
            }
            List<Lead> insertedLead = [SELECT Id FROM Lead WHERE Email = :email LIMIT 1];
            if(insertedLead.size() > 0){
                return insertedLead[0].Id;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

}
