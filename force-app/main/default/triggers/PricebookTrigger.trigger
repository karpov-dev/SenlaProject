trigger PricebookTrigger on Pricebook2 (before insert, after insert, before update, after update,before delete, after delete) {

    PricebookTriggerHandler handler = new PricebookTriggerHandler();
    handler.run();

}