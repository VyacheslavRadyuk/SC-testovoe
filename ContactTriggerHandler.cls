public class ContactTriggerHandler {
    public static Boolean wasExecuted = true;
    
    public static void OnAfterInsert(List<Contact> createdContacts) {
        String priority;
        List<Case> caseToInsert = new List<Case>();
        List<Contact> newContactsFromDB = ContactManager.getContacts(createdContacts);
        
        for (Contact contact : newContactsFromDB) {
            if (contact.Contact_Level__c == Constants.CONTACT_LEVEL_VALUE_PRIMARY) {
                priority = Constants.CASE_PRIORITY_VALUE_HIGH;
            } else if (contact.Contact_Level__c == Constants.CONTACT_LEVEL_VALUE_SECONDARY) {
                priority = Constants.CASE_PRIORITY_VALUE_MEDIUM;
            } else if (contact.Contact_Level__c == Constants.CONTACT_LEVEL_VALUE_TERTIARY) {
                priority = Constants.CASE_PRIORITY_VALUE_LOW;
            }
            
            Case newCase = new Case(
                Status = Constants.CASE_STATUS_VALUE_WORKING,
                Origin = Constants.CASE_ORIGIN_VALUE_NEW_CONTACT,
                OwnerId = contact.Account.OwnerId,
                Priority = priority,
                ContactId = contact.Id
            );
            caseToInsert.add(newCase);
        } 
        
        insert caseToInsert;        
    }
    
    public static void OnBeforeDelete(List<Contact> deletedContacts) {
        List<Case> caseByContactId = CaseManager.getCasesByContactIds(deletedContacts);
        delete caseByContactId;
    }
}