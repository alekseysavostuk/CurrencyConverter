import 'package:currency_converter/utils/utils.dart';
import 'package:flutter/material.dart';

class CurrencyWithFlagWidget extends StatelessWidget {
  const CurrencyWithFlagWidget({
    super.key,
    required this.currencyCode
    });

    final String currencyCode;
    
  
  @override
  Widget build(BuildContext context) {
    final CurrencyUtils currencyUtils = CurrencyUtils();
    return Column(
      children: [
        Image.asset(
          currencyUtils.getFlag(currencyCode),
          width: 40,
          height: 40,
          errorBuilder: (_, __, ___) => 
              const Icon(Icons.flag, size: 40, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          currencyCode,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

