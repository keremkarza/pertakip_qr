import 'package:json_annotation/json_annotation.dart';

import 'record.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person {
  String adSoyad;
  String key;
  String calendar;
  List<Record> allPersonalRecords = [];
  Person({
    this.adSoyad,
    this.key,
    this.calendar,
    this.allPersonalRecords,
  });

  Person.key({
    this.key,
  });

  factory Person.fromJson(Map<String, dynamic> data) => _$PersonFromJson(data);
  Map<String, dynamic> toJson() => _$PersonToJson(this);

//   factory Person.fromMap(Map<String, dynamic> map) {
//     var list = map['personalRecords'] as List;
//     List<PersonalRecord> personalRecordList = list
//         .map((personalRecord) => PersonalRecord.fromMap(personalRecord))
//         .toList();
//     return Person(
//         adSoyad: map['title'],
//         key: map['key'],
//         calendar: map['calendar'],
//         personalRecords: personalRecordList);
//   }
//
//   Map<String, dynamic> toMap() {
//     var list = map['personalRecords'] as List;
//     List<PersonalRecord> personalRecordList = list
//         .map((personalRecord) => PersonalRecord.fromMap(personalRecord))
//         .toList();
//     print("p_r: $personalRecords");
//     var personMap = {
//       'personMap': {
//         'title': adSoyad,
//         'key': key,
//         'calendar': calendar,
//         'personalRecords': {},
//       },
//     };
//     personMap['personMap']['personalRecords'] = allToMap();
//     return personMap;
//   }
//
//   // List<Map<String, String>> allToMap() {
//   //   print("p_r: $personalRecords");
//   //   for (var personalRecord in personalRecords) {
//   //     personalRecordsAsMap.add(personalRecord.toMap());
//   //   }
//   //   return personalRecordsAsMap;
//   // }
//
//   void addGiris() {
//     //personalRecord
//   }
}

// @JsonSerializable()
// class PersonalRecord {
//   String adSoyad;
//   String key;
//   String clockGir;
//   String clockCik;
//
//   PersonalRecord({this.adSoyad, this.key, this.clockGir, this.clockCik});
//
//   factory PersonalRecord.fromJson(Map<String, dynamic> data) =>
//       _$PersonalRecordFromJson(data);
//   Map<String, dynamic> toJson() => _$PersonalRecordToJson(this);
//
//   // Map<String, String> toMap() => {
//   //       'title': adSoyad,
//   //       'key': key,
//   //       'clockGir': clockGir,
//   //       'clockCik': clockCik
//   //     };
//   //
//   // factory PersonalRecord.fromMap(Map<String, dynamic> map) {
//   //   return PersonalRecord(
//   //     adSoyad: map['adSoyad'],
//   //     key: map['key'],
//   //     clockGir: map['clockGir'],
//   //     clockCik: map['clockCik'],
//   //   );
//   // }
// }
