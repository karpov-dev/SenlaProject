@isTest
public with sharing class ContactManager_Test {
    
    @isTest static void test_GetContactEmails_Normal(){
        List<Contact> contacts = new List<Contact>();
        contacts.add(ContactFactory.createContact());
        insert contacts;

        List<String> emails = ContactManager.getContactEmails(contacts);
        System.assertEquals(1, emails.size());
        System.assertEquals(contacts[0].Email, emails[0]);
    }

    @isTest static void test_GetContactEmails_NullContact(){
        List<String> emails = ContactManager.getContactEmails(null);
        System.assertEquals(null, emails);
    }

    @isTest static void test_getContactIdByEmailAndPhone_Normal(){
        Contact contact = ContactFactory.createContact();
        insert contact;

        Id contactId = ContactManager.getContactIdByEmailAndPhone(contact.Email, contact.Phone);
        System.assertEquals(contact.Id, contactId);
    }

    @isTest static void test_getContactIdByEmailAndPhone_WrongPhone(){
        String wrongPhone = ContactFactory.getWrongPhone();
        Contact contact = ContactFactory.createContact();
        insert contact;

        Id contactId = ContactManager.getContactIdByEmailAndPhone(contact.Email, wrongPhone);
        System.assertEquals(contact.Id, contactId);
    }

    @isTest static void test_getContactIdByEmailAndPhone_WrongEmail(){
        String wrongEmail = ContactFactory.getWrongEmail();
        Contact contact = ContactFactory.createContact();
        insert contact;

        Id contactId = ContactManager.getContactIdByEmailAndPhone(wrongEmail, contact.Phone);
        System.assertEquals(contact.Id, contactId);
    }

    @isTest static void test_getContactIdByEmailAndPhone_WrongData(){
        String wrongEmail = ContactFactory.getWrongEmail();
        String wrongPhone = ContactFactory.getWrongPhone();
        Contact contact = ContactFactory.createContact();
        insert contact;

        Id contactId = ContactManager.getContactIdByEmailAndPhone(wrongEmail, wrongPhone);
        System.assertEquals(null, contactId);
    }

    @isTest static void test_getContactIdByEmailAndPhone_NullData(){
        Id contactId = ContactManager.getContactIdByEmailAndPhone(null, null);
        System.assertEquals(null, contactId);
    }

}
