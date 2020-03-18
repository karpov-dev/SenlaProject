public class ProductTriggerHandler extends TriggerHandler{
    
    public override void beforeDelete(){
        List<BookingCard__c> bookingCards = [SELECT Product__c, Product__r.Name, Hotel__c, Hotel__r.Name, Product_History__c, Hotel_History__c
                                             FROM BookingCard__c  
                                             WHERE Product__c IN :Trigger.old];
        List<PricebookEntry> pricebookEntrys = [SELECT Id 
                                                FROM PricebookEntry 
                                                WHERE Product2Id IN :Trigger.old];
        BookingCardManager.convertToHistoryCard(bookingCards);
        update bookingCards;
        delete pricebookEntrys;
    }

}
