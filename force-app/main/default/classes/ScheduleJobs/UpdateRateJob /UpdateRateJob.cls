global class UpdateRateJob implements Schedulable{

    global void execute(SchedulableContext ctx){
        RateUtils.updateCurrencyRate();
    }

}
