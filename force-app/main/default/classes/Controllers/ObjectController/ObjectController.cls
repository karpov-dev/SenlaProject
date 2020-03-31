public without sharing class ObjectController {

    @AuraEnabled(cacheable=true)
    public static Map<String,String> getContactInformationOwner(String email, String phone){
        if(email != null && phone != null){
            return ObjectsManager.getContactInformationOwner(email, phone);
        } else {
            throw new NullPointerException();
        }
    }

    @AuraEnabled
    public static Boolean roomIsFree(Date startDate, Date endDate, String roomId){
        if(startDate != null && endDate != null && roomId != null){
            return OpportunityManager.hasOpportunityByDateForProduct(startDate, endDate, roomId);
        } else {
            throw new NullPointerException();
        }
    }

    @AuraEnabled
    public static String insertLeadAndGetId(Lead newLead){
        if(newLead != null){
            return LeadManager.insertLeadAndGetId(newLead);
        } else {
            throw new NullPointerException();
        }
    }

    @AuraEnabled
    public static void insertOpportunity(Opportunity newOpportunity){
        if(newOpportunity != null){
            OpportunityManager.insertOpportunity(newOpportunity);
        } else {
            throw new NullPointerException();
        }
    }

    @AuraEnabled
    public static void insertCase(Case newCase){
        if(newCase != null){
            insert newCase;
        } else {
            throw new NullPointerException();
        }
    }

}
