@IsTest
public class CaseManagerTest {   
    private static List<Contact> contacts;
    private static final String NAME_FIRST_CONTACT = 'Barsuk';
    private static final String NAME_SECOND_CONTACT = 'Alkash';
    private static final String NAME_THIRD_CONTACT = 'Obama';
    
    static {
        contacts = TestDataFactory.createContacts();
    }
 
    @IsTest
    private static void testGetCasesByContactIds() {   
        List<Case> casesDb = CaseManager.getCasesByContactIds(contacts);
        
        System.assertEquals(3, casesDb.size());
        System.assertEquals(NAME_FIRST_CONTACT, casesDb[0].Contact.Name);
        System.assertEquals(NAME_SECOND_CONTACT, casesDb[1].Contact.Name);
        System.assertEquals(NAME_THIRD_CONTACT, casesDb[2].Contact.Name); 
    }
    
    @IsTest
    private static void testGetCasesByContactIdsNullParameter() {
        List<Case> casesDbNull = CaseManager.getCasesByContactIds(null); 
        
        System.assertEquals(true, casesDbNull.isEmpty());
    }
}