@isTest
public with sharing class HotelManager_Test {
    
    @isTest static void test_getHotelsByRequestString_GoodRequestString(){
        Hotel__c hotel = HotelFactory.getHotel();
        insert hotel;
        String requestString = 'SELECT Id FROM Hotel__c';

        List<Hotel__c> hotels = HotelManager.getHotelsByRequestString(requestString);
        System.assertEquals(hotel.Id, hotels[0].Id);
    }

    @isTest static void test_getHotelsByRequestString_WrongRequestString(){
        Hotel__c hotel = HotelFactory.getHotel();
        insert hotel;
        String wrongRequestString = 'SELECT Id FROM Hotel__';

        List<Hotel__c> hotels = HotelManager.getHotelsByRequestString(wrongRequestString);
        System.assertEquals(null, hotels);
    }

    @isTest static void test_getHotelsByRequestString_NullRequestString(){
        Hotel__c hotel = HotelFactory.getHotel();
        insert hotel;
        String nullRequestString = null;

        List<Hotel__c> hotels = HotelManager.getHotelsByRequestString(nullRequestString);
        System.assertEquals(null, hotels);
    }


}
