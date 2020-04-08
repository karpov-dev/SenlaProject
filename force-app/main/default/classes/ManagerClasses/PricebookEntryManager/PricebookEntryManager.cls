public without sharing class PricebookEntryManager {
    
    public static Map<String,Decimal> getCurrencyRates(){
        List<Currency_rate__c> allCurrency = Currency_rate__c.getall().values();
        Map<String,Decimal> currencyRate = new Map<String, Decimal>();

        if(allCurrency != null && currencyRate != null){
            for(Currency_rate__c cur : allCurrency){
                currencyRate.put(cur.Name , cur.Rate__c);
            }
            return currencyRate;
        } else {
            return null;
        }

    }

}
