public with sharing class RateUtils {

    @future(callout=true)
    public static void updateCurrencyRate() {
        List<Currency_rate__c> allCurrency = Currency_rate__c.getall().values();
        List<CurrencyRate> currencyRates = NbRBService.getRates();

        if(allCurrency != null && currencyRates != null && allCurrency.size() > 0 && currencyRates.size() > 0){
            List<Currency_rate__c> currencyForUpdate = new List<Currency_rate__c>();
            
            for(Integer i = 0; i < allCurrency.size(); i++){
                for(Integer j = 0; j < currencyRates.size(); j++){
                    if(allCurrency[i].Name == currencyRates[j].Cur_Abbreviation){
                        Decimal newCurRate = Decimal.valueOf(currencyRates[j].Cur_OfficialRate);
                        allCurrency[i].Rate__c = newCurRate;
                        currencyForUpdate.add(allCurrency[i]);
                    }
                }
            }

            update currencyForUpdate;
        }
    }

}
