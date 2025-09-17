part of 'currency_converter_bloc.dart';

abstract class CurrencyConverterEvent extends Equatable{}

class CurrencyConverterLoad extends CurrencyConverterEvent {
  CurrencyConverterLoad({
    this.completer
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}