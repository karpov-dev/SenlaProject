public with sharing class HotelReviewTriggerHandler extends TriggerHandler{
        
    public override void afterInsert(){
        ReviewManager.updateAllRating((List<Hotel_Review__c>)Trigger.new);
    }

}
