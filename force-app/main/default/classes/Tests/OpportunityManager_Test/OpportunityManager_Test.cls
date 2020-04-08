@isTest
public with sharing class OpportunityManager_Test {
    @isTest static void test_insertOpportunity_WrongDML(){
        Opportunity opp = new Opportunity();

        Test.startTest();
            OpportunityManager.insertOpportunity(opp);
        Test.stopTest();

        List<Lead> leads = [SELECT Id FROM Lead];
        System.assertEquals(0, leads.size());
    }

    @isTest static void test_insertOpportunity_NullData(){
        Test.startTest();
            OpportunityManager.insertOpportunity(null);
        Test.stopTest();

        List<Lead> leads = [SELECT Id FROM Lead];
        System.assertEquals(0, leads.size());
    }

    @isTest static void test_hasOpportunityByDateForProduct_Normal(){
        Opportunity opp = OpportunityFactory.getOpportunity();
        Product2 product = ProductFactory.getProduct();
        insert product;
        opp.Product__c = product.Id;
        insert opp;

        Test.startTest();
            Boolean result = OpportunityManager.hasOpportunityByDateForProduct(opp.Open_Date__c, opp.CloseDate, product.Id);
        Test.stopTest();
        System.assertEquals(true, result);
    } 

    @isTest static void test_hasOpportunityByDateForProduct_NullData(){
        Test.startTest();
            Boolean result = OpportunityManager.hasOpportunityByDateForProduct(null, null, null);
        Test.stopTest();
        System.assertEquals(false, result);
    } 

}
