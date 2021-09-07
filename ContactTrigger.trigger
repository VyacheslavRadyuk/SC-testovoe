trigger ContactTrigger on Contact (after insert, before delete) {
    
    if (ContactTriggerHandler.wasExecuted) {
        ContactTriggerHandler.wasExecuted = false;
    }
    
    switch on Trigger.operationType {    
        when AFTER_INSERT {
            ContactTriggerHandler.OnAfterInsert(Trigger.new);
        }
        when BEFORE_DELETE {
            ContactTriggerHandler.OnBeforeDelete(Trigger.Old);
        }
    }
}