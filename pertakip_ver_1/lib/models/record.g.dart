// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) {
  return Record(
    adSoyad: json['adSoyad'] as String,
    recordKey: json['key'] as String,
    clockGir: json['clockGir'] as String,
    clockCik: json['clockCik'] as String,
    recordedCalendar: json['recordedCalendar'] as String,
  );
}

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'adSoyad': instance.adSoyad,
      'recordKey': instance.recordKey,
      'clockGir': instance.clockGir,
      'clockCik': instance.clockCik,
      'recordedCalendar': instance.recordedCalendar,
    };
