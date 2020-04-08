public with sharing class ReviewManager {

    public static List<Hotel_Review__c> getHotelReviewsByOffset(Integer recordsOffset, String hotelId, Integer recordsLimit){
        if(recordsOffset != null && hotelId != null && recordsLimit != null){
            return [SELECT Title__c, Review__c, Personal_Rating__c, Hotel_Rating__c FROM Hotel_Review__c WHERE Hotel__c=:hotelId LIMIT :recordsLimit OFFSET :recordsOffset];
        } else {
            return null;
        }
    }

    public static void updateAllRating(List<Hotel_Review__c> reviews){
        if(reviews != null){
            Set<Id> hotelIdsForUpdate = new Set<Id>();
            Set<Id> productIdsForUpdate = new Set<Id>();
            for(Hotel_Review__c review : reviews){
                hotelIdsForUpdate.add(review.Hotel__c);
                productIdsForUpdate.add(review.Product__c);
            }
            List<Hotel__c> hotels = [SELECT Id, Average_Hotel_Rating__c, Average_Personal_Rating__c
                                     FROM Hotel__c 
                                     WHERE Id IN :hotelIdsForUpdate];
            List<Product2> products = [SELECT Id, Rating__c 
                                       FROM Product2 
                                       WHERE Id IN :productIdsForUpdate];
            List<Hotel_Review__c> connectedReview = [SELECT Id, Product_Rating__c, Personal_Rating__c, Hotel_Rating__c, Hotel__c, Product__c
                                                     FROM Hotel_Review__c 
                                                     WHERE Hotel__c IN :hotelIdsForUpdate];
            for(Integer i = 0; i < hotels.size(); i++){
                Integer amountReviews = 0;
                Decimal newPersonalRating = 0;
                Decimal newHotelRating = 0;
                for(Integer j = 0; j < connectedReview.size(); j++){
                    if(hotels[i].Id == connectedReview[j].Hotel__c){
                        newPersonalRating = connectedReview[j].Personal_Rating__c;
                        newHotelRating = connectedReview[j].Hotel_Rating__c;
                        amountReviews++;
                    }
                    hotels[i].Average_Hotel_Rating__c = newHotelRating / amountReviews;
                    hotels[i].Average_Personal_Rating__c = newPersonalRating / amountReviews;                  
                }
                hotels[i].Average_Hotel_Rating__c = newHotelRating;
                hotels[i].Average_Personal_Rating__c = newPersonalRating;
            }

            for(Integer i = 0; i < products.size(); i++){
                Integer amountReviews = 0;
                Decimal newRating = 0;
                for(Integer j = 0; j < connectedReview.size(); j++){
                    if(products[i].Id == connectedReview[j].Product__c){
                        amountReviews++;
                        newRating += connectedReview[j].Product_Rating__c;
                    }
                    products[i].Rating__c = newRating / amountReviews;
                }
            }         
            update hotels;
            update products;
        } else {
            throw new NullPointerException();
        }
    }
}
