import 'dart:async';

import 'package:currency_converter/repository/currensies/currency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'currency_converter_event.dart';
part 'currency_converter_state.dart';



class CurrencyConverterBloc extends Bloc<CurrencyConverterEvent, CurrencyConverterState>{
  final AbstractCurrencyRepository currencyRepository;

  CurrencyConverterBloc(this.currencyRepository) : super(CurrencyConverterInitial()){
    on<CurrencyConverterLoad>((event, emit) async {
      try{
        if(state is! CurrencyConverterLoaded){
          emit(CurrencyConverterLoading());
        }
        final currencies = await currencyRepository.getCurrenciesList();
        emit(CurrencyConverterLoaded(currencies: currencies));
      } catch(e, st){
        emit(CurrencyConverterLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
  }
}