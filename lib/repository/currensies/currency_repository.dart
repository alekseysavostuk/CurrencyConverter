import 'package:currency_converter/repository/currensies/models/currency_details.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'currency.dart';
import 'package:dio/dio.dart';


class CurrencyRepository implements AbstractCurrencyRepository {
 
//  CurrencyRepository({Dio? dio}) : dio = dio ?? Dio();

 CurrencyRepository({
  required this.dio,
  required this.currenciesBox
});

  final Dio dio;
  final Box<Currency> currenciesBox;

  

  @override
  Future<List<Currency>> getCurrenciesList() async {
    try {
      final response = await dio.get(
        'https://api.currencyapi.com/v3/latest?apikey=cur_live_He4nzYF6Wzi782qAsFsQAJj1PM9eVzFx4iU4ff5M',
      );

      final data = response.data as Map<String, dynamic>;
      final rates = data['data'] as Map<String, dynamic>;
      
      final currencies = rates.entries.map((e) {
        final value = e.value as Map<String, dynamic>;
        final currencyCode =  value['code'] as String;
        final details = CurrencyDetails.fromJson(value);
        return Currency(
          code: currencyCode,
          details: details 
          // rate: (value['value'] as num).toDouble(),
          // flag: CurrencyUtils().getFlag(currencyCode)
         // flag: CurrencyUtils().getFlagUrl(value['code'] as String),
        );
      }).toList();

      final currenciesMap = {for(var e in currencies) e.code: e};
      currenciesBox.putAll(currenciesMap);

      currencies.sort((a, b) => a.code.compareTo(b.code));
      return currencies;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      throw Exception('Failed to load currencies: $e');
    }
  }

  @override
  Future<double> convertCurrency({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {

    if (amount == 0) {
      return 0.0;
    }

    if (fromCurrency == toCurrency) {
      return amount;
    }
    final currencies = await getCurrenciesList();
    
    final fromRate = currencies.firstWhere(
      (c) => c.code == fromCurrency,
    ).details.rate;

    final toRate = currencies.firstWhere(
      (c) => c.code == toCurrency,
    ).details.rate;
      return (amount / fromRate) * toRate;
  }    
}