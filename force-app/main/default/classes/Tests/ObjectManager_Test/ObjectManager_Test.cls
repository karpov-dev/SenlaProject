@isTest
public with sharing class ObjectManager_Test {
    
    @isTest static void test_emailIsUnique_NoUniqueLead(){
        String email = 'email@email.com';
        Lead lead = LeadFactory.createLead();
        lead.Email = email;
        List<String> emails = new List<String>();
        emails.add(email);
        insert lead;

        Boolean isUnique = ObjectsManager.emailIsUnique(emails);

        System.assertEquals(false, isUnique);
    }

    @isTest static void test_emailIsUnique_NoUniqueContact(){
        String email = 'email@email.com';
        Contact contact = ContactFactory.createContact();
        contact.Email = email;
        List<String> emails = new List<String>();
        emails.add(email);
        insert contact;

        Boolean isUnique = ObjectsManager.emailIsUnique(emails);

        System.assertEquals(false, isUnique);
    }

    @isTest static void test_emailIsUnique_Unique(){
        String email = 'email@email.com';
        Contact contact = ContactFactory.createContact();
        List<String> emails = new List<String>();
        emails.add(email);
        insert contact;

        Boolean isUnique = ObjectsManager.emailIsUnique(emails);

        System.assertEquals(true, isUnique);
    }
}
