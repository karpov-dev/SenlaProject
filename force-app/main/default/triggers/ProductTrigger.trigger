trigger ProductTrigger on Product2 (before insert, after insert, before update, after update,before delete, after delete) {

    ProductTriggerHandler handler = new ProductTriggerHandler();
    handler.run();

}