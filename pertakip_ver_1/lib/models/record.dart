import 'package:json_annotation/json_annotation.dart';

import 'person.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  String adSoyad;
  String recordKey;
  String clockGir;
  String clockCik;
  String recordedCalendar;
  Record({
    this.adSoyad,
    this.recordKey,
    this.clockGir,
    this.clockCik,
    this.recordedCalendar,
  });
  Record.key({
    this.recordKey,
  });
  factory Record.fromJson(Map<String, dynamic> data) => _$RecordFromJson(data);
  Map<String, dynamic> toJson() => _$RecordToJson(this);

  Record.fromMap(Map<String, dynamic> map) {
    adSoyad = map['title'];
    recordKey = map['key'];
    clockGir = map['clockGir'];
    clockCik = map['clockCik'];
    recordedCalendar = map['recordedCalendar'];
  }
  Map<String, String> toMap() => {
        'title': adSoyad,
        'key': recordKey,
        'clockGir': clockGir,
        'clockCik': clockCik,
        'recordedCalendar': recordedCalendar,
      };
  void forPersonalRecords(Person person) {}
  void toggleStatus() {
    //isDone = !isDone;
  }
}
