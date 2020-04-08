public with sharing class OpportunityFactory {

    public static Opportunity getOpportunity() {
        Date openDate = Date.newInstance(2020, 10, 17);
        return new Opportunity(Open_Date__c = openDate, CloseDate=openDate.addDays(5), Price__c = 100, Name='Name', StageName='Open - not processed');
    }

}
