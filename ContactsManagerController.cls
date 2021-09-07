public with sharing class ContactsManagerController {
    public String sortingColumn = 'Name';
    public String sortingOrder = 'ASC';
    public String column = sortingColumn;
    public String searchString {get; set;}
    public String selectedRecordID {get; set;}
    public Boolean displayPopup {get; set;}
    public String newFirstName {get; set;}
    public String newLastName {get; set;}
    public String newEmail {get; set;}
    public String newPhone {get; set;}
    public String newAccount {get; set;} 
    public String newContactLevel {get; set;}
    private final String SORT_BY_NAME = 'Name';
    private final String SORT_BY_Email = 'Email';
    private final String SORT_BY_Contact_LEVEL = 'Contact_Level__c';
    private final String SORT_BY_AccountId = 'AccountId';
    private final String SORT_BY_OWNER_ID = 'OwnerId';
    private final String SORT_BY_CREATED_BY_ID = 'CreatedById';
    private final String SORT_BY_CREATED_DATE = 'CreatedDate';
    private final String SELECT_OPTION_1 = '1';
    private final String SELECT_OPTION_5 = '5';
    private final String SELECT_OPTION_10 = '10';
    private final String SELECT_OPTION_25 = '25';
    private final String SELECT_OPTION_50 = '50';
    private final String SELECT_OPTION_100 = '100';
    private final String SORTING_ORDER_ASC = 'ASC';
    private final String SORTING_ORDER_DESC = 'DESC';
    private final String NEW_CONTACT = 'New contact';
       
    public String query = 'SELECT Id, Name, Email, Contact_Level__c, AccountId, OwnerId, CreatedById, CreatedDate ' +
        'FROM Contact ' +
        'ORDER BY ' + sortingColumn +' '+ sortingOrder;
    
    public void sortByName() {
        sortingColumn = SORT_BY_NAME;
        sortingOrder();
    }
    
    public void sortByEmail() {
        sortingColumn = SORT_BY_Email;
        sortingOrder();
    }
    
    public void sortByContactLevel() {
        sortingColumn = SORT_BY_Contact_LEVEL;
        sortingOrder();
    }
    
    public void sortByAccountId() {
        sortingColumn = SORT_BY_AccountId;
        sortingOrder();
    }
    
    public void sortByOwnerId() {
        sortingColumn = SORT_BY_OWNER_ID;
        sortingOrder();
    }
    
    public void sortByCreatedById() {
        sortingColumn = SORT_BY_CREATED_BY_ID;
        sortingOrder();
    }
    
    public void sortByCreatedDate() {
        sortingColumn = SORT_BY_CREATED_DATE;
        sortingOrder();
    }

    public void sortingOrder() {
        if (sortingColumn == column) {
            sortingOrder = (sortingOrder == SORTING_ORDER_ASC) ? SORTING_ORDER_DESC : SORTING_ORDER_ASC;
        } else {
            sortingOrder = SORTING_ORDER_ASC;
            column = sortingColumn;
        }
        queryUpdate();
    }

    public List<SelectOption> getPageSizeList() {
        List<SelectOption> options = new List<SelectOption>{
            new selectOption(SELECT_OPTION_1, SELECT_OPTION_1),
            new selectOption(SELECT_OPTION_5, SELECT_OPTION_5),
            new selectOption(SELECT_OPTION_10, SELECT_OPTION_10),
            new selectOption(SELECT_OPTION_25, SELECT_OPTION_25),
            new selectOption(SELECT_OPTION_50, SELECT_OPTION_50),
            new selectOption(SELECT_OPTION_100, SELECT_OPTION_100)    
        };
        return options;
    }
    
    public ApexPages.StandardSetController setList {
        get {
            if (setList == null) {
                setList = new ApexPages.StandardSetController(Database.query(query));
            }
            if (this.PageSize == null) {
                PageSize = 10;
            }
            setList.setPageSize(PageSize);
            return setList;
        } set;
    }
    
    public Integer PageSize {
        get; set {
            if(value != null) {
                this.PageSize = value;
            }
        }
    }

    public void search() {
        if (searchString != '') {
            String searchWorld = '\'' + searchString + '%\'';
            query = 'SELECT Id, Name, Email, Contact_Level__c, AccountId, OwnerId, CreatedById, CreatedDate ' +
                'FROM Contact ' +
                'WHERE Name like ' + searchWorld + ' ' +
                'ORDER BY ' + sortingColumn +' '+ sortingOrder;
            
            setList = new ApexPages.StandardSetController(Database.query(query));
        }
    }

    public void DeleteRecord() {
        if (selectedRecordID == null) {return;}
        
        Contact tobeDeleted = null;
        for (Contact contact : [SELECT Id FROM Contact]) {
            if (contact.Id == selectedRecordID) {
                tobeDeleted = contact;
                break;
            }
        }
        if (tobeDeleted != null) {Delete tobeDeleted;}
        
        queryUpdate();
        getContact();
    }
  
    public void popupShow(){
        displayPopup = true;
    }
    
    public void popupClose(){
        displayPopup = false;
    }   
    
    public void queryUpdate() {
        query = 'SELECT Id, Name, Email, Contact_Level__c, AccountId, OwnerId, CreatedById, CreatedDate ' +
            'FROM Contact ' +
            'ORDER BY ' + sortingColumn +' '+ sortingOrder;

        setList = new ApexPages.StandardSetController(Database.query(query));
    }
    
    public List<Contact> getContact() {
        return (List<Contact>) setList.getRecords();
    }
       
    public List<SelectOption> getContactLevel() {
        List<SelectOption> ContactLevel = new List<SelectOption>{
            new SelectOption(Constants.CONTACT_LEVEL_VALUE_PRIMARY, Constants.CONTACT_LEVEL_VALUE_PRIMARY),
            new SelectOption(Constants.CONTACT_LEVEL_VALUE_SECONDARY, Constants.CONTACT_LEVEL_VALUE_SECONDARY),
            new SelectOption(Constants.CONTACT_LEVEL_VALUE_TERTIARY, Constants.CONTACT_LEVEL_VALUE_TERTIARY)    
        };
        return ContactLevel;
    }

    public pageReference save(){            
        try {
            Account acc = new Account(Name = newAccount);
            insert acc;
            
            Contact con = new Contact(
                FirstName = newFirstName, LastName = newLastName, Email = newEmail,
                Phone = newPhone, Contact_Level__c = newContactLevel, AccountId = acc.ID);
            insert con;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, Constants.ERROR_CREATING_NEW_CONTACT));
            return null;
        }
        
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM, NEW_CONTACT + ' ' + newFirstName + ' ' + newLastName + ' ' + Constants.SUCCESSFULLY_CREATED_NEW_CONTACT));
        newFirstName = '';
        newLastName = '';
        newEmail = '';
        newPhone = '';
        newAccount = '';
        newContactLevel = Constants.CONTACT_LEVEL_VALUE_PRIMARY;
        
        return null;
    } 
}