
import 'package:currency_converter/repository/currensies/models/currency_details.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'currency.g.dart';

@HiveType(typeId: 2)
class Currency extends Equatable{
  const Currency({
    required this.code,
    required this.details
  });

  @HiveField(0)
  final String code;

  @HiveField(1)
  final CurrencyDetails details;
  
  @override
  List<Object?> get props => [code, details];
}