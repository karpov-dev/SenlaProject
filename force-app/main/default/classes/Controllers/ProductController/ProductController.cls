public class ProductController {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProducts(Hotel__c hotel){
        if(hotel != null){
            return [SELECT Id, Name, Room_Address__c, Bads__c, (SELECT UnitPrice FROM PricebookEntries LIMIT 1) FROM Product2 WHERE Hotel__c =: hotel.Id];
        } else {
            throw new NullPointerException();
        }
    }

}
