public with sharing class LeadFactory {
    
    public static Lead createLead(){
        return new Lead(FirstName='FirstName', LastName='LastName', Company='Company', Email='Email@email.com', Phone='+123456789');
    }

}
