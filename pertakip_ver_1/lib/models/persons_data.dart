import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pertakip_ver_1/models/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'person.dart';

class PersonsData with ChangeNotifier {
  static SharedPreferences _sharedPreferences;
  final List<String> _personsAsString = [];
  final List<Person> _persons = [];

  void addPerson(Person receivedPerson) {
    print("önce person: $_persons");
    print("persons length: ${persons.length}");
    int i = 0;
    // bu döngüyü baştan tasarla
    //problemimiz dissmissten sonra yeni eklenen person if else den geçemiyor cunku persons.length 0
    do {
      if (persons.length != 0) {
        if (receivedPerson.key == _persons[i].key) {
          print("aynı person zaten database de var!");
        } else {
          _persons.add(receivedPerson);
          print("sonra person: $_persons");
        }
      } else {
        _persons.add(receivedPerson);
        print("sonra person: $_persons");
      }

      i++;
    } while (i < _persons.length);

    saveItemsToSharedPref(_persons);
    notifyListeners();
  }

  //bu method giriş FAB'ı içindir
  void addNewRecord(Person receivedPerson, Record receivedRecord) {
    receivedPerson.allPersonalRecords.add(receivedRecord);
    saveItemsToSharedPref(_persons);
    notifyListeners();
  }

  bool isSecondRecord(String key) {
    loadItemsFromSharedPref();
    bool control;
    control = false;
    for (int i = 0; i < _persons.length; i++) {
      control = _persons[i].key == key;
      return control == true ? true : false;
    }
    return control;
    //return _todaysRecords.contains(Record.key(key: key));
  }

  //bu kod hatalı: şuanda kendisini de silebilir durumda.
  // void cleanSamePerson(){
  //   for( var person in persons){
  //     for(var index = 0; index<persons.length;index++) {
  //       if (person.key == persons[index].key) {
  //         removePerson(index);
  //       }
  //     }
  //   }
  // }

  // bu method çıkış FAB'ı içindir !!
  void setTodaysRecord(Person receivedPerson, Record lastRecord) {
    int i = _persons.indexOf(receivedPerson);
    _persons[i].allPersonalRecords.last = lastRecord;
    saveItemsToSharedPref(_persons);
    notifyListeners();
  }

  bool isUnique(Record receivedRecord) {
    loadItemsFromSharedPref();
    bool control;
    control = false;
    for (int i = 0; i < _persons.length; i++) {
      control = _persons[i].key == receivedRecord.recordKey;
      if (control == true) return true;
    }
    return control;
  }

  bool isUniqueNameByPerson(String isim) {
    loadItemsFromSharedPref();
    bool control;
    control = false;
    for (int i = 0; i < _persons.length; i++) {
      control = _persons[i].adSoyad == isim;
      return control == true ? true : false;
    }
    return control;
    //return _todaysRecords.contains(Record.key(key: key));
  }

  Person findPerson(String key) {
    print("önce: $_persons");
    loadItemsFromSharedPref();
    print("sonra: $_persons");
    return _persons.firstWhere((element) => element.key == key);
  }

  void removePerson(int index) {
    _persons.removeAt(index);
    saveItemsToSharedPref(_persons);
    notifyListeners();
  }

  UnmodifiableListView<Person> get persons => UnmodifiableListView(_persons);
  // UnmodifiableListView<PersonalRecord> get personalRecords =>
  //     UnmodifiableListView(_personalRecords);
  //Share pref metodları
  Future<void> createPrefObject() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //toggletheme gibi, savePerson,saveTodaysRecord,saveRecord metodları
  // bu bölgelerde oluşturulup cagrılabilir => yapılmış olabilir

  void saveItemsToSharedPref(List<Person> persons) {
    // List<Item> --> List<String>
    _personsAsString.clear();
    print("persons in saveitems: $persons");
    for (var person in persons) {
      print("for içinde person: $person");
      _personsAsString.add(json.encode(person.toJson()));
    }
    print("p_as_string: $_personsAsString");
    //sharedpref kaydetsin
    _sharedPreferences.setStringList('personsData', _personsAsString);
    print(
        "loaditems templist:p: ${_sharedPreferences.getStringList('personsData')}");
  }

  void loadItemsFromSharedPref() async {
    //_sharedPreferences.clear();
    await createPrefObject();
    //direkt olarak çektğimiz listeyi map'e çeviremiyoruz ,bunu tek tek yapmamız lazım bu yuzden asagıda for dongusu ile hallettik.
    List<String> tempList =
        _sharedPreferences.getStringList('personsData') ?? [];
    print(
        "loaditems templist: ${_sharedPreferences.getStringList('personsData')}");
    //null hatası varmı
    _persons.clear();
    for (var person in tempList) {
      _persons.add(Person.fromJson(json.decode(person)));
    }
  }

  // void savePersonalRecordsToSharedPref(List<PersonalRecord> personalRecords) {
  //   // List<Item> --> List<String>
  //   _personalRecords.clear();
  //
  //   for (var personalRecord in personalRecords) {
  //     _todaysRecordsAsString.add(json.encode(personalRecord.toMap()));
  //   }
  //   print("p_r_as_string: $_todaysRecordsAsString");
  //   //sharedpref kaydetsin
  //   _sharedPreferences.setStringList(
  //       'personalRecordsData', _todaysRecordsAsString);
  //   print(
  //       "loadpersonalrecords templist:p: ${_sharedPreferences.getStringList('personalRecordsData')}");
  // }
  //
  // void loadPersonalRecordsFromSharedPref() async {
  //   await createPrefObject();
  //   //direkt olarak çektğimiz listeyi map'e çeviremiyoruz ,bunu tek tek yapmamız lazım bu yuzden asagıda for dongusu ile hallettik.
  //   List<String> tempList =
  //       _sharedPreferences.getStringList('personalRecordsData') ?? [];
  //   print(
  //       "loadpersonalrecords templist: ${_sharedPreferences.getStringList('personalRecordsData')}");
  //   //null hatası varmı
  //   _personalRecords.clear();
  //   for (var personalRecord in tempList) {
  //     _personalRecords.add(PersonalRecord.fromMap(json.decode(personalRecord)));
  //   }
  // }
}
