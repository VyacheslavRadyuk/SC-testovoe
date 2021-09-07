@IsTest
public class ContactManagerTest {
    private static List<Contact> contacts;
    private static final String NAME_FIRST_NEW_CONTACT = 'Barsuk';
    private static final String NAME_SECOND_NEW_CONTACT = 'Alkash';
    private static final String NAME_THIRD_NEW_CONTACT = 'Obama';
    
    static {
        contacts = TestDataFactory.createContacts();
    }
    
    @IsTest
    private static void testGetContacts() {   
        List<Contact> contactsDb = ContactManager.getContacts(contacts);
        
        System.assertEquals(3, contactsDb.size());
        System.assertEquals(NAME_FIRST_NEW_CONTACT, contactsDb[0].Name);
        System.assertEquals(NAME_SECOND_NEW_CONTACT, contactsDb[1].Name);
        System.assertEquals(NAME_THIRD_NEW_CONTACT, contactsDb[2].Name); 
    }
    
    @IsTest
    private static void testGetContactsNullParameter() {
        List<Contact> contactsDbNull = ContactManager.getContacts(null); 
        
        System.assertEquals(true, contactsDbNull.isEmpty());
    }
}