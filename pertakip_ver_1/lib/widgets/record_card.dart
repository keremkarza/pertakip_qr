import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final String recordKey;
  final String title;
  final String clockGir;
  final String clockCik;
  final String recordedCalendar;
  final Function removeItem;
  RecordCard({
    this.recordKey,
    this.title,
    this.removeItem,
    this.clockGir,
    this.clockCik,
    this.recordedCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      shadowColor: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        //contentPadding: EdgeInsets.zero,
        //leading: Icon(Icons.person, color: Colors.white),
        leading: Container(
          width: 35,
          child: Text(
            "$clockGir",
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Container(
          child: Center(
            child: Text(
              "$recordedCalendar $title $recordKey",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
        //subtitle: calendar verilebilir,
        trailing: Container(
          width: 35,
          child: Text(
            "$clockCik",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
