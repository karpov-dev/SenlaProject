public class BookingCardManager {

    public static void deleteRelationships(List<BookingCard__c> cards){
        if(cards != null){
            for(BookingCard__c card : cards){
                card.Product__c = null;
                card.Hotel__c = null;
            }
        }
    }

    public static void convertToHistoryCard(List<BookingCard__c> cards){
        if(cards != null){
            for(BookingCard__c card : cards){
                card.Hotel_History__c = card.Hotel__r.Name;
                card.Product_History__c = card.Product__r.Name;
            }
        }
    }

}
