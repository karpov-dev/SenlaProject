public class HotelManager {

    public static List<Hotel__c> getHotelsByRequestString(String requestString){
        if(requestString != null){
            return Database.query(requestString);
        } else {
            throw new NullPointerException();
        }
        
    }

}
