import 'package:flutter/material.dart';
import 'package:pertakip_ver_1/models/person.dart';
import 'package:pertakip_ver_1/models/persons_data.dart';
import 'package:pertakip_ver_1/widgets/person_card.dart';
import 'package:provider/provider.dart';

import '../routing_constants.dart';

class AllDatabasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: buildAllDatabaseContent(),
    );
  }

  Column buildAllDatabaseContent() {
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
              child: Consumer<PersonsData>(
                builder: (context, personsData, child) => Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: personsData.persons.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        String activePerson =
                            personsData.persons[index].adSoyad;
                        String activePersonKey = personsData.persons[index].key;
                        Person activeArgs =
                            Person(adSoyad: activePerson, key: activePersonKey);
                        Navigator.pushNamed(context, PersonalDatabasePageRoute,
                            arguments: activeArgs);
                      },
                      child: PersonCard(
                        adSoyad: personsData.persons[index].adSoyad,
                        personKey: personsData.persons[index].key,
                        removeItem: (_) => personsData.removePerson(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
