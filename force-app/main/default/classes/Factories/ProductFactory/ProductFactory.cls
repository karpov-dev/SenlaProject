public with sharing class ProductFactory {
    
    public static Product2 getProduct(){
        Hotel__c hotel = HotelFactory.getHotel();
        insert hotel;
        return new Product2(Name='Test', Rating__c=5, Room_Address__c=1, Hotel__c=hotel.Id, Bads__c=3);
    }

}
