public with sharing class HotelController {
    
    @AuraEnabled
    public static List<Hotel__c> getHotels(){
        return [SELECT Id, Name, Email__c, Country__c, State_Province__c, Street__c, Building_Address__c, Description__c, (SELECT Id, Name, Room_Address__c FROM Products__r) FROM Hotel__c];
    }

}
