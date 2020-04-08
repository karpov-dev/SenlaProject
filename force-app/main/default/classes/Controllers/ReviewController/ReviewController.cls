public with sharing class ReviewController {
    
    @AuraEnabled(cacheable=true)
    public static List<Hotel_Review__c> getHotelReviewsByOffset(Integer recordsOffset, String hotelId, Integer recordsLimit){
        if(recordsOffset != null && hotelId != null && recordsLimit != null){
            return ReviewManager.getHotelReviewsByOffset(recordsOffset, hotelId, recordsLimit);
        } else {
            return null;
        }
    }

}
