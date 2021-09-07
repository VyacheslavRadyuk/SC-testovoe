@IsTest
private class ContactsManagerControllerTest {
    private static List<Contact> insertContacts;
    private static List<Contact> getContacts;
    
    static {
        insertContacts = TestDataFactory.createContacts();  
    }
    
    @IsTest
    private static void testSortByContactFields() {
        ContactsManagerController controller = new ContactsManagerController();  
        
        controller.sortByName();
        String sortingOrder = controller.sortingOrder; 
        
        System.assertEquals('DESC', sortingOrder);
        
        controller.sortByContactLevel();   
        sortingOrder = controller.sortingOrder;
        
        System.assertEquals('ASC', sortingOrder);
        
        controller.sortByEmail();   
        sortingOrder = controller.sortingOrder;
        
        System.assertEquals('ASC', sortingOrder);
        
        controller.sortByAccountId();   
        sortingOrder = controller.sortingOrder;
        
        System.assertEquals('ASC', sortingOrder);
        
        controller.sortByOwnerId();   
        sortingOrder = controller.sortingOrder;
        
        System.assertEquals('ASC', sortingOrder);
        
        controller.sortByCreatedById();   
        sortingOrder = controller.sortingOrder;
        
        System.assertEquals('ASC', sortingOrder);
        
        controller.sortByCreatedDate();   
        sortingOrder = controller.sortingOrder;
        
        System.assertEquals('ASC', sortingOrder);    
    }
    
    @IsTest
    private static void testPopup() {
        ContactsManagerController controller = new ContactsManagerController();  
        
        controller.popupShow();   
        Boolean displayPopup = controller.displayPopup;
        System.assertEquals(true, displayPopup);
            
        controller.popupClose();
        displayPopup = controller.displayPopup;
        System.assertEquals(false, displayPopup);      
    }
    
    @IsTest
    private static void testDeleteSelectRecord() {
        ContactsManagerController controller = new ContactsManagerController(); 
        
        controller.selectedRecordID = getContacts()[0].Id;
        controller.DeleteRecord();
        
        System.assertEquals(2, getContacts().size());    
    }
    
    @IsTest
    private static void testDeleteSelectRecordNull() {
        ContactsManagerController controller = new ContactsManagerController();  
        
        String selectedRecordID = controller.selectedRecordID = null;
        controller.DeleteRecord();
         
        System.assertEquals(3, getContacts().size());    
    }
    
    @IsTest
    private static void testSearch() {
        ContactsManagerController controller = new ContactsManagerController();
        
        List<Contact> contacts = getContacts();       
        controller.searchString = contacts[0].Name;
        controller.search();
        String query = controller.query;
        List<Contact> contactsByName = Database.query(query);
        
        System.assertEquals(contactsByName[0].Name, contacts[0].Name);
        System.assertEquals(1, contactsByName.size()); 
    }
    
    @IsTest
    private static void testSaveError() {
        ContactsManagerController controller = new ContactsManagerController(); 
        
        controller.newAccount = '';             
        controller.save();
        
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR));   
              
        controller.newAccount = 'Sussess Craft';
        controller.newFirstName = 'Vyacheslav';
        controller.newLastName = '';
        controller.newEmail = 'vyacheslavradyuk@gmail.com';
        controller.newContactLevel = Constants.CONTACT_LEVEL_VALUE_PRIMARY;
        controller.newPhone = '+375295268203';
        controller.save();
        
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR)); 
        
        controller.newAccount = 'Sussess Craft';
        controller.newFirstName = 'Vyacheslav';
        controller.newLastName = 'Radyuk';
        controller.newEmail = '';
        controller.newContactLevel = Constants.CONTACT_LEVEL_VALUE_PRIMARY;
        controller.newPhone = '+375295268203';
        controller.save();
        
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR));
    }
    
    @IsTest
    private static void testSave() {
        ContactsManagerController controller = new ContactsManagerController(); 
        controller.newAccount = 'Sussess Craft';
        controller.newFirstName = 'Vyacheslav';
        controller.newLastName = 'Radyuk';
        controller.newEmail = 'vyacheslavradyuk@gmail.com';
        controller.newContactLevel = Constants.CONTACT_LEVEL_VALUE_PRIMARY;
        controller.newPhone = '+375295268203';
        
        Test.startTest();      
        controller.save();
        Test.stopTest();
     
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.CONFIRM)); 
        System.assertEquals(4, getContacts().size());           
    }

    @IsTest
    private static void testSortingOrder() {
        ContactsManagerController controller = new ContactsManagerController(); 
        controller.sortingColumn = 'Name';
        controller.sortingOrder = 'ASC';
        controller.sortingColumn = controller.column;          
        controller.sortingOrder();
        
        System.assertEquals('DESC', controller.sortingOrder); 
        
        controller.sortingColumn = 'Name';
        controller.sortingOrder = 'DESC';
        controller.sortingColumn = controller.column;        
        controller.sortingOrder();
        
        System.assertEquals('ASC', controller.sortingOrder); 
        
        controller.sortingColumn = 'Email'; 
        controller.sortingOrder = 'ASC';
        controller.column = 'Name';          
        controller.sortingOrder();
        
        System.assertEquals('ASC', controller.sortingOrder);
        System.assertEquals(controller.column, controller.sortingColumn);
    }
    
    @IsTest
    private static void testGetContact() {
        ContactsManagerController controller = new ContactsManagerController(); 
        List<Contact> contacts = controller.getContact();
        
        System.assertEquals(3, contacts.size());
    }
    
    @IsTest
    private static void testGetContactLevel() {
        ContactsManagerController controller = new ContactsManagerController(); 
        List<SelectOption> options = controller.getContactLevel();
        
        System.assertNotEquals(null, options);
        System.assert(!options.isEmpty());
    }     
    
    @IsTest
    private static void testGetPageSizeList() {
        ContactsManagerController controller = new ContactsManagerController(); 
        List<SelectOption> options = controller.getPageSizeList();
        
        System.assertNotEquals(null, options);
        System.assert(!options.isEmpty());
    }   
    
    private static List<Contact> getContacts() {
        return getContacts = [
        	SELECT Id,
            Name
            FROM Contact
        ];
    }
}