@isTest
public with sharing class ObjectManager_Test {
    
    @isTest static void test_emailIsUnique_NoUniqueLead(){
        String email = 'emaill@email.com';
        Lead lead = LeadFactory.createLead();
        lead.Email = email;
        List<String> emails = new List<String>();
        emails.add(email);
        insert lead;

        Test.startTest();
            Boolean isUnique = ObjectsManager.emailIsUnique(emails);
        Test.stopTest();

        System.assertEquals(false, isUnique);
    }

    @isTest static void test_emailIsUnique_NoUniqueContact(){
        String email = 'emaill@email.com';
        Contact contact = ContactFactory.createContact();
        contact.Email = email;
        List<String> emails = new List<String>();
        emails.add(email);
        insert contact;

        Test.startTest();
            Boolean isUnique = ObjectsManager.emailIsUnique(emails);
        Test.stopTest();

        System.assertEquals(false, isUnique);
    }

    @isTest static void test_emailIsUnique_Unique(){
        String email = 'emaill@email.com';
        Contact contact = ContactFactory.createContact();
        List<String> emails = new List<String>();
        emails.add(email);
        insert contact;

        Test.startTest();
            Boolean isUnique = ObjectsManager.emailIsUnique(emails);
        Test.stopTest();

        System.assertEquals(true, isUnique);
    }

    @isTest static void test_getContactInformationOwner_Lead(){
        Lead lead =LeadFactory.createLead();
        insert lead;

        Test.startTest();
            Map<String,String> result = ObjectsManager.getContactInformationOwner(lead.Email, lead.Phone);
        Test.stopTest();
        System.assertEquals(lead.Id, result.get('LEAD'));
    }

    @isTest static void test_getContactInformationOwner_Contact(){
        Contact contact = ContactFactory.createContact();
        insert contact;

        Test.startTest();
            Map<String,String> result = ObjectsManager.getContactInformationOwner(contact.Email, contact.Phone);
        Test.stopTest();
        System.assertEquals(contact.Id, result.get('CONTACT'));
    }

    @isTest static void test_getContactInformationOwner_NotFound(){
        String email = '123@mail.com';
        String phone = '789654123';

        Test.startTest();
            Map<String,String> result = ObjectsManager.getContactInformationOwner(email, phone);
        Test.stopTest();
        System.assertEquals('NULL', result.get('NULL'));
    }

    @isTest static void test_getContactInformationOwner_NullData(){
        Test.startTest();
            Map<String,String> result = ObjectsManager.getContactInformationOwner(null, null);
        Test.stopTest();
        System.assertEquals(null, result);
    }
}
