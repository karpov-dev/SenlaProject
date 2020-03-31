public without sharing class LeadTriggerHandler extends TriggerHandler{

    public override void beforeInsert(){
        List<Lead> newLeads = (List<Lead>)Trigger.new;
        List<String> leadEmails = LeadManager.getLeadEmails(newLeads);
        if(ObjectsManager.emailIsUnique(leadEmails)){
            
        } else {
            leadsBeforeInsert[0].addError('Email must be unique');
        }
    }

}
