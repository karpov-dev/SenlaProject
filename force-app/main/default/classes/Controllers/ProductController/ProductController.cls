public without sharing class ProductController {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductsByRequestString(String requestString){
        return ProductManager.getProductsByRequestString(requestString);
    }

}
