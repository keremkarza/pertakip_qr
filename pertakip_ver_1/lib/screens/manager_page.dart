//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:pertakip_ver_1/models/pages_data.dart';
import 'package:pertakip_ver_1/models/person.dart';
import 'package:pertakip_ver_1/models/persons_data.dart';
import 'package:pertakip_ver_1/models/record.dart';
import 'package:pertakip_ver_1/models/records_data.dart';
import 'package:pertakip_ver_1/models/todays_records_data.dart';
import 'package:pertakip_ver_1/widgets/record_card.dart';
import 'package:provider/provider.dart';

import '../routing_constants.dart';

class ManagerPage extends StatelessWidget {
  const ManagerPage({Key key, this.title}) : super(key: key);
  final String title;
  static const String _routeName = '/manager';
  static String barcodeScanRes = "bos";
  String get routeName => _routeName;
  @override
  Widget build(BuildContext context) {
    bool value = Provider.of<PageData>(context).isPersonalPage;
    print("çalıştı: $value");
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 5,
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
              Future.delayed(Duration(seconds: 1), () {
                if (state == true) {
                  Provider.of<PageData>(context, listen: false)
                      .toggleStatus(state);
                  Navigator.pushNamed(context, PersonalPageRoute);
                  _showMyDialog(
                      context,
                      "Uyarı!",
                      "Aşağıdaki alanda 5 haneli bir kullanıcı adı giriniz ve her yeni kayıt zamanı aynı adı yazıp tekrarlayınız",
                      "Tamam",
                      "Bilgilendirme");
                }
              });
            },
          ),
        ],
        title: Row(
          children: [
            Image.asset("assets/logo_5.png", fit: BoxFit.cover),
            // Icon(
            //   Icons.check_circle,
            //   color: Colors.white,
            // ),
            Text(
              "Takip",
              style: Theme.of(context).textTheme.headline6,
            ),
            VerticalDivider(width: 13),
          ],
        ),
      ),
      body: buildManagerContent(context),
      floatingActionButton: buildRowOfFABs(context),
    );
  }

  // listview inşa ederken sharedprefload
  Column buildManagerContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Consumer2<TodaysRecordData, RecordData>(
                  builder: (context, todaysRecordData, recordData, child) {
                DateTime bugun = DateTime.now();
                print(bugun);
                String todaysCalendar = bugun.toString().substring(0, 10);
                print(todaysCalendar);

                print(
                    "todaysrecords: ${Provider.of<TodaysRecordData>(context).todaysRecords}");
                return Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: todaysRecordData.todaysRecords.length,
                    itemBuilder: (context, index) => Dismissible(
                      onDismissed: (_) {
                        todaysRecordData.removeItem(index);
                        recordData.removeItem(index);
                      },
                      key: UniqueKey(),

                      //stackoverflow dakiler çözüm olarak unique key ver dedi.
                      // Key(Provider.of<TodaysRecordData>(context)
                      //     .todaysRecords[index]
                      //     .recordKey),
                      child: RecordCard(
                        //sharedprefload
                        title: Provider.of<TodaysRecordData>(context)
                            .todaysRecords[index]
                            .adSoyad,
                        clockGir: Provider.of<TodaysRecordData>(context)
                            .todaysRecords[index]
                            .clockGir,
                        clockCik: Provider.of<TodaysRecordData>(context)
                            .todaysRecords[index]
                            .clockCik,
                        recordedCalendar: Provider.of<TodaysRecordData>(context)
                            .todaysRecords[index]
                            .recordedCalendar,
                        recordKey: Provider.of<TodaysRecordData>(context)
                            .todaysRecords[index]
                            .recordKey,
                        removeItem: (_) => todaysRecordData.removeItem(index),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }

  // kontrol olaylarını sharedpref ile yapacağız + sharedprefsave
  Row buildRowOfFABs(BuildContext context) {
    //sharedPref Nesnelerimizi yüklüyoruz
    // Provider.of<TodaysRecordData>(context, listen: false)
    //     .loadItemsFromSharedPref();
    // Provider.of<RecordData>(context, listen: false).loadItemsFromSharedPref();
    // Provider.of<PersonsData>(context, listen: false).loadItemsFromSharedPref();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Consumer3<PersonsData, RecordData, TodaysRecordData>(builder:
            (context, personsData, recordsData, todaysRecordData, child) {
          todaysRecordData.loadItemsFromSharedPref();
          recordsData.loadItemsFromSharedPref();
          personsData.loadItemsFromSharedPref();
          return FloatingActionButton(
            heroTag: "btn1",
            onPressed: () async {
              await _showMyDialog(
                  context,
                  "Uyarı! Bu buton giriş kaydı alma butonudur !",
                  "Kayıt alınan kişi ismini girip kaydetmesi gerekmekte ve her yeni kayıt zamanı aynı adı yazıp tekrarlamalıdır",
                  "Tamam",
                  "Bilgilendirme");
              await _showMyDialog(
                  context,
                  "Uyarı!",
                  "İlk defa kaydı alınan kişi mutlaka kendine özel 5 haneli bir isim seçmeli,ve kaydettikten sonra yöneticiye kaydını yaptırmalıdır.",
                  "Tamam",
                  "Bilgilendirme");
              print(barcodeScanRes);
              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                "#181215",
                "Geri Gel",
                true,
                ScanMode.QR,
              );
              print("barcodescanres: $barcodeScanRes");
              //if(barcodeScanRes.length != 0){ // decode of barcodeScanRes //refactor
              String receivedRecordKey = barcodeScanRes.substring(32, 40);
              String receivedAdSoyad = barcodeScanRes.substring(9, 14);
              String receivedClock = barcodeScanRes.substring(15, 20);
              String receivedCalendar = barcodeScanRes.substring(21, 31);
              String receivedPersonKey = barcodeScanRes.substring(0, 8);
              //print(receivedKey + receivedAdSoyad + receivedClock);

              // işlem kolaylığı için yerel nesnelerimizi initialize ediyoruz
              List<Record> newPersonalRecordList = [];
              // Record newGirisPersonalRecord = Record(
              //   adSoyad: receivedAdSoyad,
              //   key: receivedKey,
              //   clockGir: receivedClock,
              //   recordedCalendar: receivedCalendar,
              //);
              //List<Record> newRecordList = [];
              Record newGirisRecord = Record(
                adSoyad: receivedAdSoyad,
                recordKey: receivedRecordKey,
                clockGir: receivedClock,
                recordedCalendar: receivedCalendar,
              );

              // sadece islem oldugu zaman asagıdaki kaydetme gereklidir
              //Personu kaydetmesi lazım sharedprefe, sonra cikistan cekilecek.
              // unique person durumunda yeni bir person oluşturulur
              //zaten her person, başlangıcta bu duruma düşecek

              //unique person ve unique record tetkiki + person ve record kayıtları
              if (Provider.of<PersonsData>(context, listen: false)
                  .isSecondRecord(receivedPersonKey)) {
                //ilk defa gelmeyen adam bugunki ?. gelişi
                // kişi providerla veritabanından kişi çekildi
                //herseferinde recordkey degişiyo o yüzden her seferinde işleme giriyor:hata:
                //isimden kontrol edelim, kullanıcı ismi herkese unique olsun
                if (Provider.of<TodaysRecordData>(context, listen: false)
                    .isSecondRecordByPerson(receivedAdSoyad)) {
                  //ilk defa gelmeyen adam ama bugun ikinci kaydı => hata
                  //sharedpref ile kontrolü yapmak dışında kullanılmayacak
                  print(
                      "ilk defa gelmeyen adam ama bugun ikinci kaydı => hata");
                  //hata mesajı
                } //ilk defa gelmeyen adam ama bugun ikinci kaydı => hata
                else {
                  //ilk defa gelmeyen adam ve bugun ilk kaydı
                  print("ilk defa gelmeyen adam ve bugun ilk kaydı => işlem");
                  //yerel person nesnemizi providerdan personumuzu bularak oluşturuyoruz
                  Person oldPerson =
                      Provider.of<PersonsData>(context, listen: false)
                          .findPerson(receivedPersonKey);
                  //burada provider ve sharedpref kayıt işlemi girPerson
                  //personsData.persons.add(oldPerson);
                  Provider.of<PersonsData>(context, listen: false)
                      .addPerson(oldPerson);
                  //burada provider ve sharedpref kayıt işlemi girTodaysRecord
                  //todaysRecordData.addRecord(newGirisRecord);
                  Provider.of<TodaysRecordData>(context, listen: false)
                      .addRecord(newGirisRecord);
                  //burada provider ve sharedpref kayıt işlemi girRecord
                  //recordsData.addRecord(newGirisRecord);
                  Provider.of<RecordData>(context, listen: false)
                      .addRecord(newGirisRecord);
                } //ilk defa gelmeyen adam ve bugun ilk kaydı
              } else {
                //ilk defa gelen adam bugunki ?. gelişi
                //burada issSecondRecord fonk. işe yarayabilir, cunku ilk defa gelen adam her zaman kayıt yapabilir.
                //ama hata çıkarsa isSecondRecordByPerson kullanalım.
                if (Provider.of<TodaysRecordData>(context, listen: false)
                    .isSecondRecord(receivedRecordKey)) {
                  //ilk defa gelen adam ama bugun ikinci kaydı => hata
                  //sharedpref ile kontrolü yapmak dışında kullanılmayacak
                  print("ilk defa gelen adam ama bugun ikinci kaydı => hata");
                  //hata mesajı
                } //ilk defa gelen adam ama bugun ikinci kaydı => hata
                else {
                  //ilk defa gelen person ve bugunki ilk recordu => işlem
                  print(
                      "ilk defa gelen person ve bugunki ilk recordu => işlem");
                  // burada provider ve sharedpref kayıt işlemi girRecord
                  //gelen bilgilerle yerel bir recordList nesnesi oluşturuyoruz
                  newPersonalRecordList.add(newGirisRecord);
                  //gelen bilgilerle yerel bir person nesnesi oluşturuyoruz
                  Person newPerson = Person(
                    //çıkıp girdiğinde aynı key olmaması için sharedpref
                    key: receivedPersonKey,
                    adSoyad: receivedAdSoyad,
                    //calendar verisini kontrol etmemiz lazım,bir kere girilecek birdaha yok
                    calendar: receivedCalendar,
                    allPersonalRecords: newPersonalRecordList,
                  );
                  //burada provider ve sharedpref kayıt işlemi girPerson
                  //personsData.persons.add(newPerson);
                  Provider.of<PersonsData>(context, listen: false)
                      .addPerson(newPerson);
                  //burada provider ve sharedpref kayıt işlemi girTodaysRecord
                  //todaysRecordData.addRecord(newGirisRecord);
                  Provider.of<TodaysRecordData>(context, listen: false)
                      .addRecord(newGirisRecord);
                  //burada provider ve sharedpref kayıt işlemi girRecord
                  // recordsData.addRecord(newGirisRecord);
                  Provider.of<RecordData>(context, listen: false)
                      .addRecord(newGirisRecord);
                  //ikinci if statement sonu
                } //else sonu => ilk defa gelen person ve bugunki ilk recordu => işlem
              }
              // Person oldPerson =
              //     Provider.of<PersonsData>(context, listen: false)
              //         .findPerson(receivedKey);
              // print(oldPerson);
            },
            //}//onpressed sonu
            tooltip: 'Giriş Yap',
            child: Icon(Icons.qr_code_scanner_rounded,
                color: Colors.orangeAccent.shade400),
          );
        }),

        //sonra
        Consumer3<PersonsData, RecordData, TodaysRecordData>(builder:
            (context, personsData, recordsData, todaysRecordData, child) {
          todaysRecordData.loadItemsFromSharedPref();
          recordsData.loadItemsFromSharedPref();
          personsData.loadItemsFromSharedPref();
          return FloatingActionButton(
            heroTag: "btn2",
            onPressed: () async {
              await _showMyDialog(
                  context,
                  "Uyarı! Bu buton çıkış kaydı alma butonudur !",
                  "Kayıt alınan kişi ismini girip kaydetmesi gerekmekte ve her yeni kayıt zamanı aynı adı yazıp tekrarlamalıdır",
                  "Tamam",
                  "Bilgilendirme");
              await _showMyDialog(
                  context,
                  "Uyarı!",
                  "İlk defa kaydı alınan kişi mutlaka kendine özel 5 haneli bir isim seçmeli,ve kaydettikten sonra yöneticiye kaydını yaptırmalıdır.",
                  "Tamam",
                  "Bilgilendirme");
              print(barcodeScanRes);
              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                "#181215",
                "Geri gel",
                true,
                ScanMode.QR,
              );
              // decode of barcodeScanRes
              String receivedPersonKey = barcodeScanRes.substring(0, 8);
              String receivedAdSoyad = barcodeScanRes.substring(9, 14);
              String receivedClock = barcodeScanRes.substring(15, 20);
              String receivedCalendar = barcodeScanRes.substring(21, 31);
              String receivedRecordKey = barcodeScanRes.substring(32, 40);
              print(receivedRecordKey + "<-- recordkey");

              //List<Record> newRecordList = [];
              Record newGirisRecord = Record(
                adSoyad: receivedAdSoyad,
                recordKey: receivedRecordKey,
                clockCik: receivedClock,
                recordedCalendar: receivedCalendar,
              );
              //sabahki kaydı geri çekip burada düzenlemek
              print(Provider.of<TodaysRecordData>(context, listen: false)
                  .todaysRecords
                  .last
                  .clockGir);
              Record settedOldGirisRecord =
                  Provider.of<RecordData>(context, listen: false)
                      .getSpecificPersonsRecordList(receivedAdSoyad)
                      .last;
              settedOldGirisRecord = Record(
                adSoyad: receivedAdSoyad,
                recordKey: receivedRecordKey,
                clockGir: settedOldGirisRecord.clockGir,
                clockCik: receivedClock,
                recordedCalendar: receivedCalendar,
              );
              //unique record tetkiki ve record kayıtları
              //ilk defa gelen adam kabul edilmez
              //ilk defa gelmeyen adam bugunki ?. gelişi
              // kişi providerla veritabanından kişi çekildi

              //burada her record farklı bir key ile geldiği için yalnızca bir kere çıkış kaydı yapılabiiyor
              //burada problem cıkabilir, şimdilik sıkıntı yok gibi, bakarsın ilerde.
              //update: issecond daha genel bir fonksiyon direk string alıyor,gene recordKey vericez yukarıdaki gibi çalışacak
              //bu hali de sıkıntılı: her seferinde yeni key i bu teste atıyoruz..!!(şimdilik problem yok)
              if (Provider.of<TodaysRecordData>(context, listen: false)
                  .isSecondRecordByPerson(receivedAdSoyad)) {
                //ilk defa gelmeyen adam ama bugun ikinci kaydı => işlem
                print("ilk defa gelmeyen adam ve bugun ikinci kaydı => işlem");
                Person oldPerson =
                    Provider.of<PersonsData>(context, listen: false)
                        .findPerson(receivedPersonKey);
                //bu kişinin recordu providerla düzenlendi
                Provider.of<PersonsData>(context, listen: false)
                    .setTodaysRecord(oldPerson, settedOldGirisRecord);
                //record veritabanları düzenleme işlemleri
                Provider.of<TodaysRecordData>(context, listen: false)
                    .setTodaysRecord(settedOldGirisRecord);
                Provider.of<RecordData>(context, listen: false)
                    .setTodaysRecord(settedOldGirisRecord);
              } //ilk defa gelmeyen adam ama bugun ikinci kaydı => işlem
              else {
                //ilk defa gelmeyen adam ve bugun ilk kaydı => hata: burası çıkış yeri
                print(
                    "ilk defa gelmeyen adam ama bugun ilk kaydı => hata: burası çıkış yeri");
              } //ilk defa gelmeyen adam ve bugun ilk kaydı => hata: burası çıkış yeri
            },
            tooltip: 'Çıkış Yap',
            child: Icon(Icons.qr_code_rounded,
                color: Colors.orangeAccent.shade400),
          );
        }),

        FloatingActionButton(
          heroTag: "btn3",
          onPressed: () {
            Navigator.pushNamed(context, AllDatabasePageRoute);
          },
          tooltip: 'Çıkış Yap',
          child: Icon(Icons.contact_mail_rounded,
              color: Colors.orangeAccent.shade400),
        ),
        Consumer<TodaysRecordData>(
          builder: (context, todaysRecordData, child) => FloatingActionButton(
            heroTag: "btn4",
            onPressed: () async {
              await _showMyDialog(
                  context,
                  "Uyarı!",
                  "Şimdiye kadarki biriken geçici kayıt listesi temizlendi! Bu kayıtları soldan 3. buton ile veritabanlarına ulaşarak bulabilirsiniz.",
                  "Tamam",
                  "Bilgilendirme");
              //burada bir show dialog ile onay alınır
              // DateTime saat23check = DateTime.now();
              // timeFormatter(saat23check);
              // if( int.parse(timeGir) > 23 ) {
              Provider.of<TodaysRecordData>(context, listen: false)
                  .removeDailySharedPref();
              //}
            },
            tooltip: 'Yenile',
            child: Icon(Icons.refresh_rounded,
                color: Colors.orangeAccent.shade400),
          ),
        ),
      ],
    );
  }

  //String timeCalendar, timeGir;
  // void timeFormatter(DateTime activeTimeFromPersonal) {
  //   timeCalendar = activeTimeFromPersonal.toString().substring(0, 10);
  //   timeGir = activeTimeFromPersonal.toString().substring(11, 13);
  // }
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
