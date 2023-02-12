// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
      adSoyad: json['adSoyad'] as String,
      key: json['key'] as String,
      calendar: json['calendar'] as String,
      allPersonalRecords: (json['allPersonalRecords'] as List)
          ?.map((e) =>
              e == null ? null : Record.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'adSoyad': instance.adSoyad,
      'key': instance.key,
      'calendar': instance.calendar,
      'allPersonalRecords':
          instance.allPersonalRecords?.map((e) => e?.toJson())?.toList(),
    };
