public class PricebookTriggerHandler extends TriggerHandler {
    
    public override void beforeDelete(){
        delete [SELECT Id FROM PricebookEntry WHERE Pricebook2Id IN :Trigger.old];
    }

}
