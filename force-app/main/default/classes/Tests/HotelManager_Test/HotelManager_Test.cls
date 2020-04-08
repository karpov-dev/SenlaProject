@isTest
public with sharing class HotelManager_Test {
    
    @isTest static void test_getHotelsByRequestString_GoodRequestString(){
        Hotel__c hotel = HotelFactory.getHotel();
        insert hotel;
        String requestString = 'SELECT Id FROM Hotel__c';

        Test.startTest();
            List<Hotel__c> hotels = HotelManager.getHotelsByRequestString(requestString);
        Test.stopTest();
        System.assertEquals(hotel.Id, hotels[0].Id);
    }

    @isTest static void test_getHotelsByRequestString_WrongRequestString(){
        Hotel__c hotel = HotelFactory.getHotel();
        insert hotel;
        String wrongRequestString = 'SELECT Id FROM Hotel__';

        Test.startTest();
            List<Hotel__c> hotels = HotelManager.getHotelsByRequestString(wrongRequestString);
        Test.stopTest();
        System.assertEquals(null, hotels);
    }

    @isTest static void test_getHotelsByRequestString_NullRequestString(){
        Hotel__c hotel = HotelFactory.getHotel();
        insert hotel;
        String nullRequestString = null;

        Test.startTest();
            List<Hotel__c> hotels = HotelManager.getHotelsByRequestString(nullRequestString);
        Test.stopTest();
        System.assertEquals(null, hotels);
    }


}
