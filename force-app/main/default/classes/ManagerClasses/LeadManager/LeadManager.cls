public class LeadManager {

    @InvocableMethod
    public static void convertToContact(List<Lead> leads){
        if(leads != null){
            List<Contact> contacts = copyInfoFromLeads(leads);        
            insert contacts;
            leads = [SELECT Id, Email, (SELECT Contact__c FROM Booking_Cards__r) FROM Lead WHERE Id IN: getLeadsId(leads)];
            connectBookingCardsWithContact(leads, contacts);
            update contacts;
            delete leads;
        } else {
            throw new NullPointerException();
        }
    }

    public static Lead createNewLead(String firstName, String lastName, String email, String phone){
        if(firstName != null && lastName != null && email != null && phone != null){
            List<List<SObject>> searchList = [FIND :email IN EMAIL FIELDS RETURNING Contact(Email)];
            List<Contact> searchContacts = (List<Contact>)searchList[0];
            if(searchContacts == null || searchContacts.size() == 0){
                Lead newLead = new Lead(FirstName = firstName, LastName = lastName, Email = email, Phone = phone, Company = 'User');
                return newLead;
            } else {
                return null;
            }
        } else {
            throw new NullPointerException();
        }
    }

    public static Lead getLeadByEmail(List<Lead> leads, String email){
        for(Lead lead : leads){
            if(lead.Email == email){
                return lead;
            }
        }
        return null;
    }



    private static Contact getContactByEmail(List<Contact> contacts, String email){
        if(contacts != null && email != null){
            for(Contact contact : contacts){
                if(contact.Email == email){
                    return contact;
                }
            }
            return null;
        } else {
            throw new NullPointerException();
        }
    }

    private static Lead getLeadByEmail(List<Lead> leads, String Email){
        if(leads != null && Email != null){
            for(Lead lead : leads){
                if(lead.Email == Email){
                    return lead;
                }
            }
            return null;
        } else {
            throw new NullPointerException();
        }
        
    }

    private static void connectBookingCardsWithContact(List<Lead> leads, List<Contact> contacts){

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

    private static List<Contact> copyInfoFromLeads(List<Lead> leads){
        if(leads != null && lead.FirstName != null && lead.LastName != null && lead.Phone != null && lead.Email != null){
            List<Contact> contacts = new list<Contact>();
            List<Contact> contactEmails = [SELECT Id, Email FROM Contact];
            for(Lead lead : leads){
                Contact contact = getContactByEmail(contactEmails, lead.Email);
                if(contact == null){
                    contacts.add(new Contact(FirstName = lead.FirstName, LastName = lead.LastName, Email = lead.Email, Phone = lead.Phone));
                }
            }
            return contacts;
        } else {
            throw new NullPointerException();
        }
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
}
