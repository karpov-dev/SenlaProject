public without sharing class HotelController {
    
    @AuraEnabled
    public static List<Hotel__c> getHotelsByRequestString(String requestString){
        return HotelManager.getHotelsByRequestString(requestString);
    }

}
