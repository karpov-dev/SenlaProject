public without sharing class OpportunityManager {

    public static Boolean hasOpportunityByDateForProduct(Date startDate, Date endDate, String roomId){
        if(startDate != null && endDate != null && roomId !=null){
            List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE (Product__c = :roomId) AND (( Open_Date__c > :startDate AND Open_Date__c < :endDate ) OR ( CloseDate >= :startDate AND CloseDate < :endDate ) OR ( Open_Date__c <= :startDate AND CloseDate >= :endDate ))];
            if(opps.size() > 0){
                return true;
            }
            return false;
        } else {
            return false;
        }
    }

    public static void insertOpportunity(Opportunity opportunity){
        if(opportunity != null){
            try {
                insert opportunity;
            } catch (DmlException e) {
                
            }
        } 
    }

}
