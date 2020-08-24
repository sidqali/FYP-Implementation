import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FypProject/login.dart';
import 'addanimal.dart';
import 'package:FypProject/youranimal.dart';
import 'package:firebase_database/firebase_database.dart';

import 'data.dart';

import 'animalrecord.dart';

class AnimalHistory extends StatefulWidget {
  @override
  _AnimalHistoryState createState() => _AnimalHistoryState();
}

class _AnimalHistoryState extends State<AnimalHistory> {
  List<data> mydata = [];

  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('MedicalRecord').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var datas = snap.value;
      mydata.clear();
      for (var key in keys) {
        data d = new data(
            datas[key]['AimalId'],
            datas[key]['AnimalWeight'],
            datas[key]['VaccinationName'],
            datas[key]['VaccinationDate'],
            datas[key]['InseminationDate']);

        mydata.add(d);
      }
      setState(() {
        print('Length : ${mydata.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Animals'),
        backgroundColor: Colors.amber[700],
      ),
    body: new Container(
      color: Colors.amber[200],
          child: mydata.length == 0
              ? new Text(' No Data is Available')
              : new ListView.builder(
                  itemCount: mydata.length,
                  itemBuilder: (_, index) {
                    return UI(
                      mydata[index].AimalId,
                      mydata[index].AnimalWeight,
                      mydata[index].VaccinationName,
                      mydata[index].VaccinationDate,
                      mydata[index].InseminationDate,
                    );
                  },
                )),
    );
  }

  Widget UI(String AimalId, String AnimalWeight, String VaccinationName,
      String InseminationDate, String VaccinationDate) {
    return new Card(
      color: Colors.amber[100],
      elevation: 30.0,
      child: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'AimalId : $AimalId',
              style: Theme.of(context).textTheme.title,
            ),
            new Text('AnimalWeight : $AnimalWeight',),
            new Text('VaccinationName : $VaccinationName'),
            new Text('VaccinationDate : $VaccinationDate'),
            new Text('InseminationDate : $InseminationDate'),
          ],
        ),
      ),
    );
  }
}
