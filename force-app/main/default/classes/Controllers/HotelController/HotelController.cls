public class HotelController {
    
    @AuraEnabled(cacheable=true)
    public static List<Hotel__c> getHotels(){
        return [SELECT Id, Name, Email__c, Description__c, (SELECT Id, Name, Room_Address__c FROM Products__r) FROM Hotel__c];
    }

}
