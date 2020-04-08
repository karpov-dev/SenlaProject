trigger HotelReviewTrigger on Hotel_Review__c (before insert, after insert, before update, after update,before delete, after delete) {

    HotelReviewTriggerHandler handler = new HotelReviewTriggerHandler();
    handler.run();

}