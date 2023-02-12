import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'record.dart';

class TodaysRecordData with ChangeNotifier {
  final List<Record> _todaysRecords = [];
  static SharedPreferences _sharedPreferences;
  final List<String> _todaysRecordsAsString = [];

  void toggleStatus(int index) {
    _todaysRecords[index].toggleStatus();
    saveItemsToSharedPref(_todaysRecords);
    notifyListeners();
  }

  //tüm recordları uygun bir metne çevirip maile uygun hale getirecek fonksiyon!!!

  bool isSecondRecord(String key) {
    loadItemsFromSharedPref();
    bool control;
    control = false;
    for (int i = 0; i < _todaysRecords.length; i++) {
      control = _todaysRecords[i].recordKey == key;
      return control == true ? true : false;
    }
    return control;
    //return _todaysRecords.contains(Record.key(key: key));
  }

  bool isSecondRecordByPerson(String isim) {
    loadItemsFromSharedPref();
    bool control;
    control = false;
    for (int i = 0; i < _todaysRecords.length; i++) {
      control = _todaysRecords[i].adSoyad == isim;
      return control == true ? true : false;
    }
    return control;
    //return _todaysRecords.contains(Record.key(key: key));
  }

  //record vericez, o record
  void findTodaysSameRecord() {}

  void addRecord(Record receivedRecord) {
    _todaysRecords.add(receivedRecord);
    saveItemsToSharedPref(_todaysRecords);
    notifyListeners();
  }

  void setTodaysRecord(Record lastRecord) {
    _todaysRecords.last = lastRecord;
    saveItemsToSharedPref(_todaysRecords);
    notifyListeners();
  }

  bool isUnique(Record receivedRecord) {
    loadItemsFromSharedPref();
    bool control;
    control = false;
    for (int i = 0; i < _todaysRecords.length; i++) {
      control = _todaysRecords[i].recordKey == receivedRecord.recordKey;
      return control == true ? true : false;
    }
    return control;
  }

  void removeItem(int index) {
    _todaysRecords.removeAt(index);
    saveItemsToSharedPref(_todaysRecords);
    notifyListeners();
  }

  UnmodifiableListView<Record> get todaysRecords =>
      UnmodifiableListView(_todaysRecords);

  //Share pref metodları
  Future<void> createPrefObject() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //toggletheme gibi, savePerson,saveTodaysRecord,saveRecord metodları
  // bu bölgelerde oluşturulup cagrılabilir => yapılmış olabilir

  void saveItemsToSharedPref(List<Record> todaysRecords) {
    // List<Item> --> List<String>
    _todaysRecordsAsString.clear();

    for (var record in todaysRecords) {
      _todaysRecordsAsString.add(json.encode(record.toMap()));
    }

    //sharedpref kaydetsin
    _sharedPreferences.setStringList(
        'todaysRecordsData', _todaysRecordsAsString);
  }

  void loadItemsFromSharedPref() async {
    //_sharedPreferences.clear();
    //await createPrefObject();
    //direkt olarak çektğimiz listeyi map'e çeviremiyoruz ,bunu tek tek yapmamız lazım bu yuzden asagıda for dongusu ile hallettik.
    List<String> tempList =
        (_sharedPreferences.getStringList('todaysRecordsData')) ?? [];
    // null hatası varmı
    _todaysRecords.clear();
    for (var record in tempList) {
      _todaysRecords.add(Record.fromMap(json.decode(record)));
    }
  }

  void removeDailySharedPref() async {
    await createPrefObject();
    _todaysRecords.clear();
    _sharedPreferences.remove('todaysRecordsData');
    notifyListeners();
  }
}
