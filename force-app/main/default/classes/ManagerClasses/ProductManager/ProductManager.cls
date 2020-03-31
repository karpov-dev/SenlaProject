public without sharing class ProductManager {
    
    public static List<SObject> getProductsByRequestString(String requestString){
        if(requestString != null){
            return Database.query(requestString);
        } else {
            throw new NullPointerException();
        }
    }
}
