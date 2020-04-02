global class NbRBService {

    public static List<CurrencyRate> getRates(){

        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        request.setEndpoint('http://www.nbrb.by/API/ExRates/Rates?Periodicity=0');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept','application/json');
        request.setTimeout(60000);

        response = new Http().send(request);

        if(response.getStatusCode() == 200 && response.getBody() != null){
            List<CurrencyRate> rates = (List<CurrencyRate>)JSON.deserialize(response.getBody(), List<CurrencyRate>.class);
            System.debug(rates);
            return rates;
        } else {
            return null;
        }
        
    }

}
