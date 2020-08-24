import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FypProject/login.dart';
import 'addanimal.dart';
import 'package:FypProject/youranimal.dart';
import 'package:firebase_database/firebase_database.dart';

import 'data.dart';

import 'animalrecord.dart';

class DeleteAnimal extends StatefulWidget {
  @override
  _DeleteAnimalState createState() => _DeleteAnimalState();
}

class _DeleteAnimalState extends State<DeleteAnimal> {
  final ref = FirebaseDatabase.instance.reference();
  List<data> mydata = [];

  void initState() {
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
        title: Text('Tap To Delete'),
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

  // Future<String> CreateDialog(BuildContext context) {
  //   TextEditingController ed = TextEditingController();
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Update Vaccination Date'),
  //           content: TextField(
  //             controller: ed,
  //           ),
  //           actions: <Widget>[
  //             MaterialButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(ed.text.toString());
  //               },
  //              // child: Text('Update'),
  //             )
  //           ],
  //         );
  //       });
  // }

  deleteData(BuildContext context, String key) {
    Widget okbutton = FlatButton(
      child: Text('Yes'),
      onPressed: () {
        setState(() {
          ref.child(key).remove();
          Navigator.of(context).pop();
        });
      },
    );
    Widget nobutton = FlatButton(
      child: Text('No'),
      onPressed: () {
        setState(() {
          Navigator.of(context).pop();
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text('Delete Record'),
      content: Text('Do You Want To Delete Data?'),
      actions: [okbutton, nobutton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget UI(String AimalId, String AnimalWeight, String VaccinationName,
      String InseminationDate, String VaccinationDate) {
    String key;
    return new GestureDetector(
      // onLongPress: () {
      //   // CreateDialog(context).then((value) {
      //   //   if (value != null) {
      //   //     Map<String, Object> createdoc = new HashMap();
      //   //     createdoc['VacciantionDate'] = value;
      //   //     ref.child(Key).update(createdoc);
      //   //   }
      //   // });
      // },
      onTap: () {
        deleteData(context, key);
      },
      child: Card(
        color: Colors.amber[100],
        elevation: 30.0,
        child: new Container(
          padding: new EdgeInsets.all(30.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Aimal Id : $AimalId',
                style: Theme.of(context).textTheme.title,
              ),
              new Text(
                'Animal Weight : $AnimalWeight',
              ),
              new Text('Vaccination Name : $VaccinationName'),
              new Text('Vaccination Date : $VaccinationDate'),
              new Text('Insemination Date : $InseminationDate'),
            ],
          ),
        ),
      ),
    );
  }
}
