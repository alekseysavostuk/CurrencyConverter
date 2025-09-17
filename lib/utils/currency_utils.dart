

class CurrencyUtils {

  static const Set<String> currencyMap = {
    'USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'CHF', 'CNY', 'HKD', 'NZD',
    'SEK', 'KRW', 'SGD', 'NOK', 'MXN', 'INR', 'RUB', 'ZAR', 'TRY', 'BRL',
    'PLN', 'TWD', 'THB', 'CZK', 'ILS', 'CLP', 'PHP', 'AED', 'COP', 'SAR',
    'MYR', 'RON', 'AFN', 'ALL', 'AMD', 'ANG', 'AOA', 'ARS', 'AZN', 'BAM',
    'BBD', 'BDT', 'BGN', 'BHD', 'BIF', 'BOB', 'BSD', 'BTN', 'BWP', 'BYN',
    'BZD', 'CDF', 'DKK', 'DOP', 'DZD', 'EGP', 'ETB', 'FJD', 'GEL', 'GHS',
    'GMD', 'GNF', 'GTQ', 'GYD', 'HNL', 'HRK', 'HUF', 'IDR', 'IQD', 'IRR',
    'ISK', 'JMD', 'JOD', 'KES', 'KGS', 'KHR', 'KMF'
  };

  String getFlag(String currencyCode) => 'assets/flags/$currencyCode.png';

  bool hasFlag(String currencyCode) {
    return currencyMap.contains(currencyCode);
  }

}