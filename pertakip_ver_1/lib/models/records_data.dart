import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'record.dart';

class RecordData with ChangeNotifier {
  final List<Record> _records = [];
  static SharedPreferences _sharedPreferences;
  final List<String> _recordsAsString = [];

  List<Record> getSpecificPersonsRecordList(String activePerson) {
    loadItemsFromSharedPref();
    List<Record> specificList = [];
    //for dongusu ile tüm records listesini gez
    for (int i = 0; i < _records.length; i++) {
      if (activePerson == _records[i].adSoyad) {
        specificList.add(_records[i]);
      }
    }
    return specificList;
  }

  int getRequiredLength(String activePerson) {
    loadItemsFromSharedPref();
    int length = getSpecificPersonsRecordList(activePerson).length;
    return length;
  }

  void addRecord(Record receivedRecord) {
    _records.add(receivedRecord);
    saveRecordsToSharedPref(_records);
    notifyListeners();
  }

  void setTodaysRecord(Record lastRecord) {
    _records.last = lastRecord;
    saveRecordsToSharedPref(_records);
    notifyListeners();
  }

  void removeItem(int index) {
    _records.removeAt(index);
    saveRecordsToSharedPref(_records);
    notifyListeners();
  }

  UnmodifiableListView<Record> get records => UnmodifiableListView(_records);

  //Share pref metodları
  Future<void> createPrefObject() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveRecordsToSharedPref(List<Record> records) {
    // List<Item> --> List<String>
    _recordsAsString.clear();

    for (var record in records) {
      _recordsAsString.add(json.encode(record.toMap()));
    }
    print("r_as_string: $_recordsAsString");
    //sharedpref kaydetsin
    _sharedPreferences.setStringList('recordData', _recordsAsString);
    print(
        "loaditems templist:r: ${_sharedPreferences.getStringList('recordData')}");
  }

  //void find

  void loadItemsFromSharedPref() async {
    //_sharedPreferences.clear();
    await createPrefObject();
    //direkt olarak çektğimiz listeyi map'e çeviremiyoruz ,bunu tek tek yapmamız lazım bu yuzden asagıda for dongusu ile hallettik.
    List<String> tempList =
        (_sharedPreferences.getStringList('recordData')) ?? [];
    _records.clear();
    for (var item in tempList) {
      _records.add(Record.fromMap(json.decode(item)));
    }
  }
}
