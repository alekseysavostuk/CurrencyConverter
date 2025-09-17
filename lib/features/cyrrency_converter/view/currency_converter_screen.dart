import 'dart:async';

import 'package:currency_converter/features/cyrrency_converter/bloc/currency_converter_bloc.dart';
import 'package:currency_converter/features/cyrrency_converter/widgets/main_currency_converter_widget.dart';
import 'package:currency_converter/repository/currensies/currency.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/features/cyrrency_converter/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final _currencyConventerBloc = CurrencyConverterBloc(GetIt.I<AbstractCurrencyRepository>());

   @override
  void initState() {
    _currencyConventerBloc.add(CurrencyConverterLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _currencyConventerBloc.add(CurrencyConverterLoad(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CurrencyConverterBloc, CurrencyConverterState>(
          bloc: _currencyConventerBloc,
          builder: (context, state) {
            if(state is CurrencyConverterLoaded){
              return Center(
                child: SingleChildScrollView(
                  child: CurrencyConverter(), 
                ),
              );
            }
            if(state is CurrencyConverterLoadingFailure){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Please try again later',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: (){
                        _currencyConventerBloc.add(CurrencyConverterLoad());
                      },
                      child: Text('Try again')
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ), 
      ),
    );
  }
}
