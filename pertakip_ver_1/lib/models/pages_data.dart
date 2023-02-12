import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageData with ChangeNotifier {
  bool _isPersonalPage = false;
  static SharedPreferences _sharedPreferences;
  final List<String> _itemsAsString = [];

  void toggleStatus(bool state) {
    print("togglechange");
    print(state);
    _isPersonalPage = state;
    //saveItemsToSharedPref(_isPersonalPage);
    notifyListeners();
  }

  bool get isPersonalPage => _isPersonalPage;
  // void addItem(String text) {
  //   //_items.add(Item(title: text));
  //   //saveItemsToSharedPref(_items);
  //   notifyListeners();
  // }
  //
  // void removeItem(int index) {
  //   //_items.removeAt(index);
  //   //saveItemsToSharedPref(_items);
  //   notifyListeners();
  // }

  //Share pref metodları
  // Future<void> createPrefObject() async {
  //   _sharedPreferences = await SharedPreferences.getInstance();
  // }
  //
  // void saveItemsToSharedPref(bool state) {
  //
  //   //sharedpref kaydetsin
  //   _sharedPreferences.setBool('state', state);
  // }
  //
  // void loadItemsFromSharedPref() {
  //   //direkt olarak çektğimiz listeyi map'e çeviremiyoruz ,bunu tek tek yapmamız lazım bu yuzden asagıda for dongusu ile hallettik.
  //   List<String> tempList =
  //       (_sharedPreferences.getBool('state')) ?? [];
  //   //_items.clear();
  // }

}
