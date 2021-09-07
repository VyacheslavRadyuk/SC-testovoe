public class CaseManager {
    
    public static List<Case> getCasesByContactIds(List<Contact> contactIds) {
        if (contactIds == null || contactIds.isEmpty()) {
            return new List<Case>();
        }
        List<Case> caseByContactId = [
            SELECT ContactId,
            Contact.Name
            FROM Case 
            WHERE ContactId IN :contactIds
        ];
        return caseByContactId;
    }
}