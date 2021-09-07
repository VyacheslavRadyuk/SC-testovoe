@IsTest
public class ContactTriggerTest {  
    private static List<Contact> contacts;
    private static List<Case> cases;
    
    static {
        contacts = TestDataFactory.createContacts();
    }
    
    @IsTest
    private static void testOnAfterInsert() {         
        Test.startTest(); 
        Database.SaveResult[] result = Database.insert(contacts, false);
        Test.stopTest();      
        
        System.assertEquals(3, getCases().size());
        System.assertNotEquals(true, getCases().isEmpty());
        System.assertEquals(Constants.CASE_PRIORITY_VALUE_HIGH, getCases()[0].Priority);
        System.assertEquals(Constants.CASE_PRIORITY_VALUE_MEDIUM, getCases()[1].Priority);
        System.assertEquals(Constants.CASE_PRIORITY_VALUE_LOW, getCases()[2].Priority);   
    }  
    
    @IsTest
    private static void testOnBeforeDelete() {         
        Test.startTest(); 
        Database.DeleteResult[] result = Database.delete(contacts, false);
        Test.stopTest();       
        
        System.assert(result[0].isSuccess());
        System.assert(result[1].isSuccess());
        System.assert(result[2].isSuccess());
        System.assertEquals(true, getCases().isEmpty());  
    }  
    
    private static List<Case> getCases() {
        List<Case> cases = [
            SELECT Id, 
            Status, 
            Origin, 
            OwnerId, 
            Priority, 
            ContactId 
            FROM Case
        ];
        return cases;
    }
}