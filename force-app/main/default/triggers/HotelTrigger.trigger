trigger HotelTrigger on Hotel__c (before insert, after insert, before update, after update,before delete, after delete) {
    
    HotelTriggerHandler handler = new HotelTriggerHandler();
    handler.run();
    
}