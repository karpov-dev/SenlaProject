public class BookingCardManager {

    public static void convertToHistoryCard(List<BookingCard__c> cards){
        if(cards != null){
            for(BookingCard__c card : cards){
                card.Hotel_History__c = card.Hotel__r.Name;
                card.Product_History__c = card.Product__r.Name;
                card.Product__c = null;
                card.Hotel__c = null;
            }
        }
    }

    public static BookingCard__c createBookingCard(Lead lead, Hotel__c hotel, Product2 room, DateTime startBooking, DateTime endBooking){
        if(lead != null && hotel != null && room != null && startBooking != null && endBooking != null){
            
        } else {
            throw new NullPointerException();
        }
    }

}
