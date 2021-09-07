@IsTest
public class TestDataFactory {
	
    public static List<Account> createAccounts() {
        List<Account> accountsToInsert = new List<Account>{
            new Account(Name = 'Belgee', Rating = 'Hot', AccountNumber = '12345678'),
            new Account(Name = 'Mts', Rating = 'Hot', AccountNumber = '12345678'),
            new Account(Name = 'Belaz', Rating = 'Hot', AccountNumber = '12345678')  
        };
        insert accountsToInsert;
        return accountsToInsert;
    }
    
    public static List<Contact> createContacts() {
        List<Account> accountsToInsert = createAccounts();
        List<Contact> contactToInsert = new List<Contact>{
            new Contact(LastName = 'Barsuk', AccountId = accountsToInsert.get(0).Id, Contact_Level__c = Constants.CONTACT_LEVEL_VALUE_PRIMARY),
            new Contact(LastName = 'Alkash', AccountId = accountsToInsert.get(1).Id, Contact_Level__c = Constants.CONTACT_LEVEL_VALUE_SECONDARY),
            new Contact(LastName = 'Obama', AccountId = accountsToInsert.get(2).Id, Contact_Level__c = Constants.CONTACT_LEVEL_VALUE_TERTIARY)     
        };
        insert contactToInsert;
        return contactToInsert;
    }
}