public class ContactManager {
    
    public static List<Contact> getContacts(List<Contact> contacts) {   
        if (contacts == null || contacts.isEmpty()) {
            return new List<Contact>();
        }
        List<Contact> contactsByContacts = [
            SELECT Id,
            Name,
            OwnerId,
            Account.OwnerId, 
            Contact_Level__c
            FROM Contact
            WHERE Id IN :contacts    
        ];
        return contactsByContacts;
    }       
}