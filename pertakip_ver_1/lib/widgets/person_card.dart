import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String adSoyad;
  final String personKey;
  final Function removeItem;
  PersonCard({
    this.adSoyad,
    this.personKey,
    this.removeItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black38,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.white),
        title: Row(
          children: [
            Text(
              "$adSoyad",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            VerticalDivider(
              width: 15,
            ),
            Text(
              "$personKey",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ],
        ),
        trailing: Image.asset(
          "assets/logo_5.png",
          fit: BoxFit.cover,
          color: Colors.white,
        ),

        // IconButton(
        //   icon: Icon(Icons.android),
        //   color: Colors.white,
        //   onPressed: () {},
        // ),
      ),
    );
  }
}
