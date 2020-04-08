public class HotelManager {

    public static List<Hotel__c> getHotelsByRequestString(String requestString){
        if(requestString != null){
            try {
                return Database.query(requestString);
            } catch (Exception e) {
                return null;
            }
        } else {
            return null;
        }
    }

}
