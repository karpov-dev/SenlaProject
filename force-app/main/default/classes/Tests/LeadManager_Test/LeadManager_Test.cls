@isTest
public with sharing class LeadManager_Test {

    @isTest static void test_insertLeadAndGetId_Normal(){
        Lead lead = LeadFactory.createLead();

        Test.startTest();
            String Id = LeadManager.insertLeadAndGetId(lead);
        Test.stopTest();

        List<Lead> insertedLead = [SELECT Id FROM Lead WHERE Id = :Id];
        System.assertEquals(1, insertedLead.size());
    }

    @isTest static void test_insertLeadAndGetId_NullData(){
        Test.startTest();
            String Id = LeadManager.insertLeadAndGetId(null);
        Test.stopTest();

        List<Lead> insertedLead = [SELECT Id FROM Lead WHERE Id = :Id];
        System.assertEquals(0, insertedLead.size());
        System.assertEquals(null, Id);
    }

    @isTest static void test_insertLeadAndGetId_EmptyLead(){
        Test.startTest();
            String Id = LeadManager.insertLeadAndGetId(new Lead());
        Test.stopTest();

        List<Lead> insertedLead = [SELECT Id FROM Lead WHERE Id = :Id];
        System.assertEquals(0, insertedLead.size());
        System.assertEquals(null, Id);
    }

    @isTest static void test_getLeadIdByEmailAndPhone_Normal(){
        Lead lead = LeadFactory.createLead();
        insert lead;

        Test.startTest();
            String Id = LeadManager.getLeadIdByEmailAndPhone(lead.Email, lead.Phone);
        Test.stopTest();
        System.assertEquals(lead.Id, Id);
    }

    @isTest static void test_getLeadIdByEmailAndPhone_NullData(){
        Test.startTest();
            String Id = LeadManager.getLeadIdByEmailAndPhone(null, null);
        Test.stopTest();
        System.assertEquals(null, Id);
    }

    @isTest static void test_getLeadIdByEmailAndPhone_WrongData(){
        String wrongEmail = 'wrongEmail@mail.com';
        String wrongPhone = '369852147';

        Test.startTest();
            String Id = LeadManager.getLeadIdByEmailAndPhone(wrongEmail, wrongPhone);
        Test.stopTest();
        System.assertEquals(null, Id);
    }

    @isTest static void test_getLeadIdByEmailAndPhone_WrongEmail(){
        Lead lead = LeadFactory.createLead();
        insert lead;
        String wrongEmail = 'wrongEmail@mail.com';

        Test.startTest();
            String Id = LeadManager.getLeadIdByEmailAndPhone(wrongEmail, lead.Phone);
        Test.stopTest();
        System.assertEquals(lead.Id, Id);
    }

    @isTest static void test_getLeadEmails_Normal(){
        List<Lead> leads = new List<Lead>();
        leads.add(LeadFactory.createLead());
        insert leads;

        Test.startTest();
            List<String> emails = LeadManager.getLeadEmails(leads);
        Test.stopTest();
        System.assertEquals(leads[0].Email, emails[0]);
    }

    @isTest static void test_getLeadEmails_NullData(){
        Test.startTest();
            List<String> emails = LeadManager.getLeadEmails(null);
        Test.stopTest();
        System.assertEquals(null, null);
    }

    @isTest static void test_convertLeadToContact_Normal(){
        List<Lead> convertLeads = new List<Lead>();
        convertLeads.add(LeadFactory.createLead());
        insert convertLeads;

        Test.startTest();
            LeadManager.convertLeadToContact(convertLeads);
        Test.stopTest();

        List<Lead> leads = [SELECT Id FROM Lead];
        List<Contact> contacts = [SELECT Id FROM Contact];
        System.assertEquals(0, leads.size());
        System.assertEquals(1, contacts.size());
    }
}
