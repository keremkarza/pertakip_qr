import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:pertakip_ver_1/models/active_person.dart';
import 'package:pertakip_ver_1/models/pages_data.dart';
import 'package:pertakip_ver_1/models/persons_data.dart';
import 'package:pertakip_ver_1/widgets/person_card.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  TextEditingController _searchController;

  @override
  void initState() {
    Provider.of<ActivePerson>(context, listen: false)
        .loadPersonDataFromSharedPref();
    // TODO: implement initState
    (context as Element).markNeedsBuild();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    DateTime activeTime;
    String activeTimeClock;
    String activeTimeCalendar;
    String activePerson;
    String activePersonKey;
    String recordKey;
    //
    Provider.of<ActivePerson>(context, listen: false)
        .loadPersonFromSharedPref();
    Provider.of<ActivePerson>(context, listen: false)
        .loadPersonKeyFromSharedPref();
    //
    activePerson = Provider.of<ActivePerson>(context).activePerson;
    activePersonKey = Provider.of<ActivePerson>(context).activePersonKey;
    recordKey = Provider.of<ActivePerson>(context).activeRecordKey;
    activeTime = Provider.of<ActivePerson>(context).activeTime;
    activeTimeCalendar = Provider.of<ActivePerson>(context).activeTimeCalendar;
    activeTimeClock = Provider.of<ActivePerson>(context).activeTimeGir;
    //
    String activeRecord =
        "$activePersonKey:$activePerson:$activeTimeClock:$activeTimeCalendar:$recordKey";
    //
    bool value = Provider.of<PageData>(context).isPersonalPage;

    // return FutureBuilder<void>(
    //     future: Provider.of<ActivePerson>(context, listen: false)
    //         .loadPersonDataFromSharedPref(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return Scaffold(
    //           appBar: AppBar(
    //             elevation: 5,
    //             actions: [
    //               LiteRollingSwitch(
    //                 colorOn: Colors.orangeAccent.shade200,
    //                 colorOff: Colors.orangeAccent.shade700,
    //                 iconOn: Icons.contact_page_rounded,
    //                 iconOff: Icons.stream,
    //                 textOff: "Yönetici",
    //                 textOn: "Personel",
    //                 value: value,
    //                 onChanged: (bool state) {
    //                   if (state == false) {
    //                     print("personchange");
    //                     print(state);
    //                     // bu route u kaldırırken, bir şekilde alt routtaki manager
    //                     // sayfasının stateini bir şekilde yenilememiz lazım.
    //                     Provider.of<PageData>(context, listen: false)
    //                         .toggleStatus(state);
    //                     Navigator.pop(context);
    //                   }
    //                 },
    //               ),
    //             ],
    //             title: Row(
    //               children: [
    //                 Icon(
    //                   Icons.check_circle,
    //                   color: Colors.white,
    //                 ),
    //                 Text(
    //                   "Pertakip",
    //                   style: Theme.of(context).textTheme.headline6,
    //                 ),
    //                 VerticalDivider(width: 13),
    //                 // Text(
    //                 //   "#17.01.2021",
    //                 //   style: Theme.of(context).textTheme.subtitle2,
    //                 // ),
    //               ],
    //             ),
    //           ),
    //           body: Column(
    //             children: [
    //               Expanded(
    //                 child: Container(
    //                   color: Colors.white,
    //                   child: Center(
    //                     child: QrImage(
    //                       data: '$activeRecord',
    //                       //key: activeKey,
    //                       version: QrVersions.auto,
    //                       size: 320,
    //                       gapless: true,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(height: 20),
    //               Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.all(
    //                     Radius.circular(10.0),
    //                   ),
    //                 ),
    //                 child: Consumer2<PersonsData, ActivePerson>(builder:
    //                     (context, personsData, activePersonData, child) {
    //                   return TextField(
    //                     cursorColor: Colors.orange.shade400,
    //                     controller: _searchController,
    //                     onSubmitted: (textPerson) {
    //                       //kaydetme onayı iste
    //                       //_showMyDialog(context);
    //                       //eğer loadkeyfromsharedpref nullsa yeni unique key oluştur yoksa eskiyi çek
    //                       activePerson =
    //                           Provider.of<ActivePerson>(context, listen: false)
    //                               .validPerson(textPerson);
    //                       activePersonKey =
    //                           Provider.of<ActivePerson>(context, listen: false)
    //                               .getPersonKey();
    //                       print(
    //                           "person: $activePerson type: ${activePerson.runtimeType} olarak unique testine girdi");
    //                       print(
    //                           "personkey: $activePersonKey type: ${activePersonKey.runtimeType} olarak unique testine girdi");
    //                       if (activePersonKey == null) {
    //                         activePersonKey = UniqueKey().toString();
    //                         print(
    //                             "personkey: $activePersonKey yeni oluşturuldu");
    //                         //ilk tarih alabiliriz buradan.
    //                         //sharedprefe yükle
    //                         activePersonData
    //                             .savePersonKeyToSharedPref(activePersonKey);
    //                       } else {
    //                         print("personkey: $activePersonKey yenilenmedi");
    //                         // sharedpreften yükle?
    //
    //                       }
    //                       //bu kısmı tekrar düşün
    //                       //if (recordKey == null) {
    //                       //her seferinde yeni key record için
    //                       recordKey = UniqueKey().toString();
    //                       //   //sharedprefe yükle
    //                       //   //activePersonData.savePersonToSharedPref(activePerson);
    //                       // } else {
    //                       //   print("recordkey yenilenmedi");
    //                       //   // sharedpreften yükle
    //                       // }
    //
    //                       DateTime activeTime = DateTime.now();
    //                       print("qr time: $activeTime");
    //                       print("qr person: $activePerson");
    //                       print("qr personkey: $activePersonKey");
    //                       print("qr recordkey: $recordKey");
    //                       print("qr calendar: $activeTimeCalendar");
    //                       print("qr clockgir: $activeTimeClock");
    //                       print("qr clockcik: $activeTimeClock");
    //                       print("qr record(hepsi): $activeRecord");
    //
    //                       //bu üç provider metodu ile activepersondaki tüm değişkenleri doldurduk
    //                       Provider.of<ActivePerson>(context, listen: false)
    //                           .timeFormatter(activeTime);
    //
    //                       Provider.of<ActivePerson>(context, listen: false)
    //                           .receivePerson(
    //                               activePerson, activePersonKey, activeTime);
    //
    //                       Provider.of<ActivePerson>(context, listen: false)
    //                           .receiveRecord(recordKey);
    //                       //textfield disable et
    //                       activePerson =
    //                           Provider.of<ActivePerson>(context, listen: false)
    //                               .getPerson();
    //                       activePersonKey =
    //                           Provider.of<ActivePerson>(context, listen: false)
    //                               .getPersonKey();
    //                     },
    //                     decoration: InputDecoration(
    //                       labelStyle: TextStyle(color: Colors.black),
    //                       labelText: "Kullanıcı Adı",
    //                       hintText: "Kullanıcı Adı",
    //                       prefixIcon: Icon(
    //                         Icons.search,
    //                         color: Colors.orange.shade400,
    //                       ),
    //                       suffixIcon: IconButton(
    //                           icon: Icon(Icons.clear), onPressed: () {}),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(10.0),
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 }),
    //               ),
    //               Consumer<ActivePerson>(
    //                   builder: (context, activePersonData, child) => PersonCard(
    //                       adSoyad: activePerson, personKey: activePersonKey)),
    //             ],
    //           ),
    //         );
    //       } else {
    //         return CircularProgressIndicator();
    //       }
    //     });
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          LiteRollingSwitch(
            colorOn: Colors.orangeAccent.shade200,
            colorOff: Colors.orangeAccent.shade700,
            iconOn: Icons.contact_page_rounded,
            iconOff: Icons.stream,
            textOff: "Yönetici",
            textOn: "Personel",
            value: value,
            onChanged: (bool state) {
              if (state == false) {
                print("personchange");
                print(state);
                // bu route u kaldırırken, bir şekilde alt routtaki manager
                // sayfasının stateini bir şekilde yenilememiz lazım.
                Provider.of<PageData>(context, listen: false)
                    .toggleStatus(state);
                Navigator.pop(context);
              }
            },
          ),
        ],
        title: Row(
          children: [
            Image.asset("assets/logo_mini.png", fit: BoxFit.cover),
            // Icon(
            //   Icons.check_circle,
            //   color: Colors.white,
            // ),
            Text(
              "Takip",
              style: Theme.of(context).textTheme.headline6,
            ),
            VerticalDivider(width: 13),
            // Text(
            //   "#17.01.2021",
            //   style: Theme.of(context).textTheme.subtitle2,
            // ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: QrImage(
                  data: '$activeRecord',
                  //key: activeKey,
                  version: QrVersions.auto,
                  size: 320,
                  gapless: true,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Consumer2<PersonsData, ActivePerson>(
                builder: (context, personsData, activePersonData, child) {
              return TextField(
                cursorColor: Colors.orange.shade400,
                controller: _searchController,
                onSubmitted: (textPerson) {
                  //kaydetme onayı iste
                  //_showMyDialog(context);
                  //eğer loadkeyfromsharedpref nullsa yeni unique key oluştur yoksa eskiyi çek
                  // && Provider.of<PersonsData>(context, listen: false).isUniqueNameByPerson(textPerson)
                  //buradaki ve operatorunu test et, aynı ismi başka hesapta girince ne oluyor
                  if (textPerson.length == 5) {
                    activePerson = activePersonData.validPerson(textPerson);
                    activePersonKey = activePersonData.getPersonKey();
                    print(
                        "person: $activePerson type: ${activePerson.runtimeType} olarak unique testine girdi");
                    print(
                        "personkey: $activePersonKey type: ${activePersonKey.runtimeType} olarak unique testine girdi");
                    if (activePersonKey == null) {
                      activePersonKey = UniqueKey().toString();
                      print("personkey: $activePersonKey yeni oluşturuldu");
                      //ilk tarih alabiliriz buradan.
                      //sharedprefe yükle
                      activePersonData
                          .savePersonKeyToSharedPref(activePersonKey);
                    } else {
                      print("personkey: $activePersonKey yenilenmedi");
                      // sharedpreften yükle?

                    }
                    //bu kısmı tekrar düşün
                    //if (recordKey == null) {
                    //her seferinde yeni key record için
                    recordKey = UniqueKey().toString();
                    //   //sharedprefe yükle
                    //   //activePersonData.savePersonToSharedPref(activePerson);
                    // } else {
                    //   print("recordkey yenilenmedi");
                    //   // sharedpreften yükle
                    // }

                    DateTime activeTime = DateTime.now();
                    print("qr time: $activeTime");
                    print("qr person: $activePerson");
                    print("qr personkey: $activePersonKey");
                    print("qr recordkey: $recordKey");
                    print("qr calendar: $activeTimeCalendar");
                    print("qr clockgir: $activeTimeClock");
                    print("qr clockcik: $activeTimeClock");
                    print("qr record(hepsi): $activeRecord");

                    //bu üç provider metodu ile activepersondaki tüm değişkenleri doldurduk
                    Provider.of<ActivePerson>(context, listen: false)
                        .timeFormatter(activeTime);

                    Provider.of<ActivePerson>(context, listen: false)
                        .receivePerson(
                            activePerson, activePersonKey, activeTime);

                    Provider.of<ActivePerson>(context, listen: false)
                        .receiveRecord(recordKey);
                    //textfield disable et
                    activePerson =
                        Provider.of<ActivePerson>(context, listen: false)
                            .getPerson();
                    activePersonKey =
                        Provider.of<ActivePerson>(context, listen: false)
                            .getPersonKey();
                  } else {
                    _showMyDialog(
                      context,
                      "Uyarı !",
                      "Lütfen yalnızca 5 karakterden oluşan başka bir isim veya ilk girdiğiniz eşsiz isminizi giriniz.",
                      "Tamam",
                      "Bilgilendirme",
                    );
                  }
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 13),
                  labelText: "Lütfen her seferinde bir defa veri girin",
                  hintText: "Kullanıcı Adı",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.orange.shade400,
                  ),
                  // suffixIcon: IconButton(
                  //     icon: Icon(Icons.clear),
                  //     onPressed: () {
                  //       _searchController.clear();
                  //     }),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              );
            }),
          ),
          Consumer<ActivePerson>(
              builder: (context, activePersonData, child) => PersonCard(
                  adSoyad: activePersonData.getPerson(),
                  personKey: activePersonData.getPersonKey())),
        ],
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context, String text1, String text2,
    String butonText, String title) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text1),
              Text(text2),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(butonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
