part of 'currency_converter_bloc.dart';

abstract class CurrencyConverterState extends Equatable{}

class CurrencyConverterInitial extends CurrencyConverterState{
  @override
  List<Object?> get props => [];
}

class CurrencyConverterLoading extends CurrencyConverterState{
  @override
  List<Object?> get props => [];
}

class CurrencyConverterLoaded extends CurrencyConverterState{
  CurrencyConverterLoaded({
    required this.currencies
  });

  final List<Currency> currencies;

  @override
  List<Object?> get props => [currencies];
}

class CurrencyConverterLoadingFailure extends CurrencyConverterState{
  CurrencyConverterLoadingFailure({
    this.exception
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}