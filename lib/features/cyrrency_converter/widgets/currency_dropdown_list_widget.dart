
import 'package:currency_converter/repository/currensies/models/models.dart';
import 'package:currency_converter/utils/utils.dart';
import 'package:flutter/material.dart';

class CurrencyDropdownWidget extends StatelessWidget {
  const CurrencyDropdownWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    required this.currencies,
    required this.isLoading});


    final String value;
    final ValueChanged<String?> onChanged;
    final String label;
    final List<Currency> currencies;
    final bool isLoading;


  @override
  Widget build(BuildContext context) {
    final CurrencyUtils currencyUtils = CurrencyUtils();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (currencies.isEmpty) {
      return const Text('no data');
    }

    return DropdownButtonFormField<String>(
      initialValue: value,
      items: currencies.map((currency) {
        return DropdownMenuItem<String>(
          value: currency.code,
          child: Row(
            children: [
              Image.asset(
                currencyUtils.getFlag(currency.code),
                width: 32,
                height: 32,
                errorBuilder: (_, __, ___) => 
                    const Icon(Icons.flag, size: 32, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency.code,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
      
      onChanged: onChanged,
      
      selectedItemBuilder: (BuildContext context) {
        return currencies.map((currency) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset(
                  currencyUtils.getFlag(currency.code),
                  width: 28,
                  height: 28,
                  errorBuilder: (_, __, ___) => 
                      const Icon(Icons.flag, size: 28, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Text(
                  currency.code,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
      
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down, size: 24),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
