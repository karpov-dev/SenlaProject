public class LeadTriggerHandler extends TriggerHandler{
    
    public override void beforeInsert(){
        List<Lead> newLeads = (List<Lead>)Trigger.new;
        List<Lead> leads = [SELECT Id, Email 
                            FROM Lead];
        List<Contact> contacts = [SELECT Id, Email 
                                  FROM Contact];
        for(Lead lead : newLeads){
            
        }
    }

}
