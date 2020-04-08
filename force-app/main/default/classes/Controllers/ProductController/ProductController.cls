public without sharing class ProductController {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductsByRequestString(String requestString){
        return ProductManager.getProductsByRequestString(requestString);
    }

    @AuraEnabled(cacheable=true)
    public static Integer getFieldMaxValue(String fieldName){
        return ProductManager.getMaxFieldInternalValue(fieldName);
    }

    @AuraEnabled(cacheable=true)
    public static Decimal getMaxUnitPrice(){
        return ProductManager.getMaxUnitPrice();
    }

}
