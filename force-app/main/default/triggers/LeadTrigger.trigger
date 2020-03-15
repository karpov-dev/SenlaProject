trigger LeadTrigger on Lead (before insert, after insert, before update, after update,before delete, after delete) {

    LeadTriggerHandler handler = new LeadTriggerHandler();
    handler.run();

}