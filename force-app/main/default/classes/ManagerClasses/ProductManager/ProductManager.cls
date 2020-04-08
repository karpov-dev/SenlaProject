public without sharing class ProductManager {
    
    public static List<Product2> getProductsByRequestString(String requestString){
        if(requestString != null){
            return Database.query(requestString);
        } else {
            throw new NullPointerException();
        }
    }

    public static Integer getMaxFieldInternalValue(String fieldName){
        if(fieldName != null){
            String request = 'SELECT ' + fieldName + ' FROM Product2 ORDER BY ' + fieldName + ' DESC LIMIT 1';
            List<Product2> products = ProductManager.getProductsByRequestString(request);
            if(products.size() > 0){
                try {
                    Object obj = products[0].get(fieldName);
                    return Integer.valueOf(obj);
                } catch (Exception exp) {
                    return -2;
                }
        
            } else {
                return -1;
            }
        } else {
            throw new NullPointerException();
        }
    }

    public static Decimal getMaxUnitPrice(){
        List<PricebookEntry> prices = [SELECT UnitPrice FROM PricebookEntry ORDER BY UnitPrice DESC LIMIT 1];
        if(prices.size() > 0){
            return prices[0].UnitPrice;
        } else {
            return -1;
        }
    }


}
