// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyDetailsAdapter extends TypeAdapter<CurrencyDetails> {
  @override
  final int typeId = 1;

  @override
  CurrencyDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyDetails(
      rate: fields[0] as double,
      flag: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyDetails obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.rate)
      ..writeByte(1)
      ..write(obj.flag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyDetails _$CurrencyDetailsFromJson(Map<String, dynamic> json) =>
    CurrencyDetails(
      flag: CurrencyUtils().getFlag(json['code'] as String),
      rate: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyDetailsToJson(CurrencyDetails instance) =>
    <String, dynamic>{'rate': instance.rate, 'flag': instance.flag};


