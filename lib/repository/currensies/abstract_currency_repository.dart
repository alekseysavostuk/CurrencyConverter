import 'models/models.dart';

abstract class AbstractCurrencyRepository {
  Future<List<Currency>> getCurrenciesList();
  Future<double> convertCurrency({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  });
}