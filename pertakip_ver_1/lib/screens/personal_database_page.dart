import 'package:flutter/material.dart';
import 'package:pertakip_ver_1/models/person.dart';
import 'package:pertakip_ver_1/models/records_data.dart';
import 'package:pertakip_ver_1/widgets/person_card.dart';
import 'package:pertakip_ver_1/widgets/record_card.dart';
import 'package:provider/provider.dart';

class PersonalDatabasePage extends StatelessWidget {
  final Person activePerson;
  PersonalDatabasePage({this.activePerson});
  //activePerson = argum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 5,
        actions: [],
        title: Row(
          children: [
            VerticalDivider(width: 55),
            Image.asset("assets/logo_5.png", fit: BoxFit.cover),
            // Icon(
            //   Icons.check_circle,
            //   color: Colors.white,
            // ),
            Text(
              "Takip",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: buildPersonalDatabaseContent(activePerson),
    );
  }

  Container buildPersonalDatabaseContent(Person activePerson) {
    return Container(
      color: Colors.deepOrange,
      child: Column(
        children: [
          // Container(
          //   height: 80,
          //   child: Card(
          //     color: Colors.white,
          //     child: Center(
          //       child: Text(
          //         "Kullanıcı Ad Soyad",
          //         style: TextStyle(
          //           color: Colors.deepOrange,
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          PersonCard(
            adSoyad: activePerson.adSoyad,
            personKey: activePerson.key,
          ),
          SizedBox(height: 10),
          //SizedBox(height: 80),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Consumer<RecordData>(
                  builder: (context, recordData, child) => Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount:
                          recordData.getRequiredLength(activePerson.adSoyad),
                      //todaysRecordData.todaysRecords.length, //sıkıntılı yer
                      itemBuilder: (context, index) => RecordCard(
                        title: Provider.of<RecordData>(context)
                            .getSpecificPersonsRecordList(
                                activePerson.adSoyad)[index]
                            .adSoyad,
                        clockGir: Provider.of<RecordData>(context)
                            .getSpecificPersonsRecordList(
                                activePerson.adSoyad)[index]
                            .clockGir,
                        clockCik: Provider.of<RecordData>(context)
                            .getSpecificPersonsRecordList(
                                activePerson.adSoyad)[index]
                            .clockCik,
                        recordKey: Provider.of<RecordData>(context)
                            .getSpecificPersonsRecordList(
                                activePerson.adSoyad)[index]
                            .recordKey,
                        recordedCalendar: Provider.of<RecordData>(context)
                            .getSpecificPersonsRecordList(
                                activePerson.adSoyad)[index]
                            .recordedCalendar,
                        removeItem: (_) => recordData.removeItem(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
