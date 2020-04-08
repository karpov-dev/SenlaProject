public without sharing class PricebookEntryController {
    
    @AuraEnabled(cacheable=true)
    public static Map<String,Decimal> getRates(){
        return PricebookEntryManager.getCurrencyRates();
    }

}
