trigger BookingCardTrigger on BookingCard__c(before insert, after insert, before update, after update,before delete, after delete) {

    BookingCardTriggerHandler handler = new BookingCardTriggerHandler();
    handler.run();

}