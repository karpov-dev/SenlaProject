public without sharing class LeadManager {

    @InvocableMethod
    public static void convertLeadToContact(List<Lead> leads){
        if(leads != null){
            ObjectsManager.checkEmailIsUniqueEnabled = false;
            List<Opportunity> oppForUpdate = new List<Opportunity>();
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            for(Lead lead : leads){
                List<Opportunity> leadOpp = [SELECT Id, Contact__c, LeadId__c FROM Opportunity WHERE LeadId__c =:lead.Id];
                Database.LeadConvert converter = new Database.LeadConvert();
                converter.setLeadId(lead.Id);
                converter.setConvertedStatus(convertStatus.MasterLabel);
                Database.LeadConvertResult result = Database.convertLead(converter);
                Id newContactId = result.getContactId();
                for(Opportunity opp : leadOpp){
                    opp.Contact__c = newContactId;
                    opp.LeadId__c = null;
                    oppForUpdate.add(opp);
                }
                System.assert(result.isSuccess());
            }
            update oppForUpdate;
            ObjectsManager.checkEmailIsUniqueEnabled = true;
        } else {
            throw new NullPointerException();
        }
    }

    public static List<String> getLeadEmails(List<Lead> leads){
        if(leads != null){
            List<String> emails = new List<String>();
            for(Lead lead : leads){
                emails.add(lead.Email);
            }
            return emails;
        } else {
            throw new NullPointerException();
        }
    }

    public static String getLeadIdByEmailAndPhone(String email, String phone){
        List<Lead> leads =  [SELECT Id FROM Lead WHERE Email = :email OR Phone = :phone LIMIT 1];
        if(leads.size() > 0){
            return leads[0].Id;
        } else {
            return null;
        }
    }

    public static String insertLeadAndGetId(Lead newLead){
        if(newLead != null){
            String email = newLead.Email;
            insert newLead;
            List<Lead> insertedLead = [SELECT Id FROM Lead WHERE Email = :email LIMIT 1];
            if(insertedLead.size() > 0){
                return insertedLead[0].Id;
            } else {
                return null;
            }
        } else {
            throw new NullPointerException();
        }
    }

}
