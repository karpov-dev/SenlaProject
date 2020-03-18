public class BookingCardTriggerHandler extends TriggerHandler{
    
    public override void beforeInsert(){
        if(validateParams((List<BookingCard__c>)Trigger.new)){
            
        } else {
            
        }
    }


    private static Boolean validateParams(List<BookingCard__c> cards){
        for(BookingCard__c card : cards){
            if(card.Lead__c == null && card.Contact__c == null){
                card.addError('Set the owner booking card.');
                return false;
            }
            if(card.Lead__c != null && card.Contact__c != null){
                card.addError('Card must have one owner.');
                return false;
            }
            if(card.Start_Booking__c >= card.End_Booking__c){
                card.addError('Uncorrect date.');
                return false;
            }
        }
        return true;
    }

}
