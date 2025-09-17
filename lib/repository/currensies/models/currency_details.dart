import 'package:currency_converter/utils/currency_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_details.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CurrencyDetails extends Equatable{
  const CurrencyDetails({
    required this.flag,
    required this.rate,
  });

  @HiveField(0)
  @JsonKey(name: 'value')
  final double rate;

  @HiveField(1)
  final String flag;

  factory CurrencyDetails.fromJson(Map<String, dynamic> json) => _$CurrencyDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyDetailsToJson(this);
  
  @override
  List<Object?> get props => [rate];
}