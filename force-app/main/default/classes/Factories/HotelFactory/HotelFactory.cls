public with sharing class HotelFactory {
    
    public static Hotel__c getHotel(){
        return new Hotel__c(Name='TestHotel', Phone__c='123456789', Email__c='testEmail@mail.com', Description__c='TestDescription', Average_Personal_Rating__c=2, Average_Hotel_Rating__c=8);
    }

}
