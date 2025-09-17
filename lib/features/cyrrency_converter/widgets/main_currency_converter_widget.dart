import 'package:currency_converter/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../repository/currensies/currency.dart';
import 'widgets.dart';



class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final AbstractCurrencyRepository repository = GetIt.I<AbstractCurrencyRepository>();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  final CurrencyUtils _currencyUtils = CurrencyUtils();

  double amount = 0.0;
  String fromCurrency = 'BYN';
  String toCurrency = 'PLN';
  double convertedAmount = 0.0;
  bool isLoading = false;
  List<Currency> currencies = [];


  @override
  void initState() {
    super.initState();
    _amountController.text = amount.toString();
    Future.delayed(const Duration(seconds: 1), () {
      _loadCurrencies();
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_amountFocusNode);
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }
  
  Future<void> _loadCurrencies() async {
  setState(() => isLoading = true);
  try {
    final loadedCurrencies = await repository.getCurrenciesList();
    
    final filteredCurrencies = loadedCurrencies.where((currency) {
      return _currencyUtils.hasFlag(currency.code); 
    }).toList();

    setState(() {
      currencies = filteredCurrencies;
      if (currencies.isNotEmpty) {
        fromCurrency = currencies.first.code;
        toCurrency = currencies.length > 1 ? currencies[1].code : 'PLN';
      }
    });
    _convertAutomatically();
  } catch (e, st) {
      if(kDebugMode){
        debugPrint('Error loading currencies: $e');
        GetIt.I<Talker>().handle(e, st);
      }
  } finally {
    setState(() => isLoading = false);
  }
}


  void _convertAutomatically() async {
  

    if (amount <= 0 || fromCurrency.isEmpty || toCurrency.isEmpty) {
      setState(() => convertedAmount = 0.0);
      return;
    }

    setState(() => isLoading = true);
    
    try {
      final result = await repository.convertCurrency(
        amount: amount,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      );
      
      setState(() => convertedAmount = result);
    } catch (e, st) {
      if(kDebugMode){
        debugPrint('Conversion error: $e');
        GetIt.I<Talker>().handle(e, st);
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _swapCurrencies() {
    setState(() {
      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
    _convertAutomatically();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_amountFocusNode);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 100,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _amountController,
              focusNode: _amountFocusNode,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Sum',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_exchange),
              ),
              onChanged: (e) {
                final newAmount = double.tryParse(e) ?? 0;
                if (newAmount != amount) {
                  setState(() => amount = newAmount);
                  _convertAutomatically();
                }
                
              },
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: CurrencyDropdownWidget(
                    value: fromCurrency,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => fromCurrency = value);
                        _convertAutomatically();
                      }
                    },
                    label: 'From',
                    isLoading: isLoading,
                    currencies: currencies,
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  icon: const Icon(Icons.swap_horiz, size: 30),
                  onPressed: _swapCurrencies,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                    padding: const EdgeInsets.all(12),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: CurrencyDropdownWidget(
                    value: toCurrency,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => toCurrency = value);
                        _convertAutomatically();
                      }
                    },
                    label: 'To',
                    isLoading: isLoading,
                    currencies: currencies,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            isLoading
                ? const CircularProgressIndicator()
                : Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CurrencyWithFlagWidget(currencyCode: fromCurrency),
                            const SizedBox(width: 16),
                            const Icon(Icons.arrow_forward, size: 20, color: Colors.green),
                            const SizedBox(width: 16),
                            CurrencyWithFlagWidget(currencyCode: toCurrency),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${amount.toStringAsFixed(2)} $fromCurrency =',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${convertedAmount.toStringAsFixed(2)} $toCurrency',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

 
}