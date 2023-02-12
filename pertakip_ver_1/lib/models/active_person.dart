import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivePerson with ChangeNotifier {
  String _activePerson;
  String _activePersonKey;
  String _activeRecordKey;
  DateTime _activeTime;
  String _activeTimeCalendar = "";
  String _activeTimeGir = "";
  String _activeTimeCik = "";

  void receivePerson(
      String activePerson, String personKey, DateTime activeTime) {
    _activeTime = activeTime;
    _activePerson = activePerson;
    _activePersonKey = personKey;
    savePersonToSharedPref(_activePerson);
    savePersonKeyToSharedPref(_activePersonKey);
    notifyListeners();
  }

  void receiveRecord(String recordKey) {
    _activeRecordKey = recordKey;
    notifyListeners();
  }

  String validPerson(String textPerson) {
    loadPersonFromSharedPref();
    if (_activePerson != null) {
      return _activePerson;
    } else {
      return textPerson;
    }
  }

  String getPerson() {
    loadPersonFromSharedPref();
    return _activePerson;
  }

  String getPersonKey() {
    loadPersonKeyFromSharedPref();
    return _activePersonKey;
  }

  void setTimeCik(DateTime activeTime) {
    //???
    _activeTime = activeTime;
  }

  void timeFormatter(DateTime activeTimeFromPersonal) {
    _activeTimeCalendar = activeTimeFromPersonal.toString().substring(0, 10);
    _activeTimeGir = activeTimeFromPersonal.toString().substring(11, 16);
  }

  // void createRecord(){
  //   Record activeRecord
  // }

  DateTime get activeTime => _activeTime;

  String get activePersonKey => _activePersonKey;

  String get activeRecordKey => _activeRecordKey;

  String get activePerson => _activePerson;

  String get activeTimeCalendar => _activeTimeCalendar;

  String get activeTimeGir => _activeTimeGir;

  var _sharedPreferences;

  Future<void> createPrefObject() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //toggletheme gibi, savePerson,saveTodaysRecord,saveRecord metodları
  // bu bölgelerde oluşturulup cagrılabilir => yapılmış olabilir

  void savePersonToSharedPref(String activePerson) {
    _sharedPreferences.setString('activePerson', activePerson);
    print(
        "loaditem activePerson:p: ${_sharedPreferences.getString('activePerson')}");
  }

  void savePersonKeyToSharedPref(String activePersonKey) {
    _sharedPreferences.setString('activePersonKey', activePersonKey);
    print(
        "loaditem activePersonKey:pk: ${_sharedPreferences.getString('activePersonKey')}");
  }

  Future<void> loadPersonFromSharedPref() async {
    //_sharedPreferences.remove('activePerson');
    await createPrefObject();
    _activePerson =
        _sharedPreferences.getString('activePerson') ?? null; //?????
    print(
        "loaditem activePerson: ${_sharedPreferences.getString('activePerson')}");
  }

  Future<void> loadPersonKeyFromSharedPref() async {
    //_sharedPreferences.clear();
    await createPrefObject();
    _activePersonKey =
        _sharedPreferences.getString('activePersonKey'); // ?? "ok";
    print(
        "loaditem activePersonKey: ${_sharedPreferences.getString('activePersonKey')}");
  }

  Future<void> loadPersonDataFromSharedPref() async {
    //_sharedPreferences.clear();
    await createPrefObject();
    _activePersonKey =
        _sharedPreferences.getString('activePersonKey'); // ?? "ok";
    print(
        "loaditem activePersonKey: ${_sharedPreferences.getString('activePersonKey')}");
    _activePerson =
        _sharedPreferences.getString('activePerson') ?? null; //?????
    print(
        "loaditem activePerson: ${_sharedPreferences.getString('activePerson')}");
  }
}
