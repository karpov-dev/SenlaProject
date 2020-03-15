public class LeadManager {

    @InvocableMethod
    public static void convertToContact(List<Lead> leads){
        if(leads != null){
            List<Contact> contacts = copyInfoFromLead(leads);   
            List<String> leadsEmail = getLeadsEmail(leads);      
            insert contacts;
            contacts = [SELECT Id, Email FROM Contact WHERE Email IN :leadsEmail];
            leads = [SELECT Id, Email, (SELECT Contact__c FROM Booking_Cards__r) FROM Lead WHERE Id IN: getLeadsId(leads)];
            connectBookingCardsAndContact(leads, contacts);
            update contacts;
            delete leads;
        } else {
            throw new NullPointerException();
        }
    }

    public static void createLead(List<String> firstName, List<String> lastName, List<String> email, List<String> phone){
        if(checkInfoForCreateLeads(firstName, lastName, email, phone)){
            List<Lead> newLeads = new List<Lead>();
            for(Integer i = 0; i < firstName.size(); i++){
                Boolean f = true;
            }
        } else {
            throw new NullPointerException();
        }
    }

    public static void checkEmailsForCreateLeads(List<String> emails){
        
    }



    private static void connectBookingCardsAndContact(List<Lead> leads, List<Contact> contacts){

        if(leads != null && contacts != null){
            List<BookingCard__c> cardsForUpdate = new List<BookingCard__c>();
            for(Contact contact : contacts){
                Lead lead = getLeadByEmail(leads, contact.Email);
                if(lead != null){
                    for(BookingCard__c card : lead.Booking_Cards__r){
                        card.Contact__c = contact.Id;
                        cardsForUpdate.add(card);
                    }
                }
            }
            update cardsForUpdate;
        }
    }

    private static List<Contact> copyInfoFromLead(List<Lead> leads){
        if(leads != null){
            List<Contact> contacts = new list<Contact>();
            for(Lead lead : leads){
                contacts.add(new Contact(FirstName = lead.FirstName, LastName = lead.LastName, Phone = lead.Phone, Email = lead.Email));
            }
            return contacts;
        }
        return null;
    }

    private static List<String> getLeadsEmail(List<Lead> leads){
        if(leads != null){
            List<String> emails = new List<String>();
            for(Lead lead : leads){
                emails.add(lead.Email);
            }
            return emails;
        }
        return null;
    }

    private static Lead getLeadByEmail(List<Lead> leads, String Email){
        if(leads != null && Email != null){
            for(Lead lead : leads){
                if(lead.Email == Email){
                    return lead;
                }
            }
        }
        return null;
    }

    private static List<Id> getLeadsId(List<Lead> leads){
        if(leads != null){
            List<Id> Ids = new List<Id>();
            for(Lead lead : leads){
                Ids.add(lead.Id);
            }
            return Ids;
        }
        return null;
    }

    private static Boolean checkInfoForCreateLeads(List<String> firstName, List<String> lastName, List<String> email, List<String> phone){
        if(firstName != null && lastName != null && email != null && phone != null){
            List<Integer> sizes = new List<Integer>();
            sizes.add(firstName.size());
            sizes.add(lastName.size());
            sizes.add(email.size());
            sizes.add(phone.size());
            for(Integer i = 0; i < sizes.size(); i++){
                for(Integer j = i + 1; j < sizes.size(); j++){
                    if(sizes[i] != sizes[j]){
                        return false;
                    }
                }
            }
            return true;
        }
        return false;
    }

}
