public class HotelTriggerHandler extends TriggerHandler{
    
    public override void beforeDelete(){
        delete [SELECT Id FROM Pricebook2 WHERE Hotel__c IN :Trigger.old];
        delete [SELECT Id FROM Product2 WHERE Hotel__c IN :Trigger.old];
    }
}
