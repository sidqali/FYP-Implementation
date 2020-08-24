import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FypProject/login.dart';
import 'package:firebase_database/firebase_database.dart';

class AddAnimal extends StatefulWidget {
  @override
  _AddAnimalState createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  String AimalId;
  String AnimalWeight;
  String VaccinationName;
  String VaccinationDate;
  String InseminationDate;
  //String _calories;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildAimalId() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Animal Id'),
      maxLength: 5,
      validator: (String value) {
        if (value.isEmpty) {
          return 'ID is Required';
        }

        return null;
      },
      onSaved: (String value) {
        AimalId = value;
      },
    );
  }

  Widget _buildAnimalWeight() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Animal Weight'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Weight is Required';
        }
      },
      onSaved: (String value) {
        AnimalWeight = value;
      },
    );
  }

  Widget _buildVaccinationName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Vaccination Name'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Vaccination Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        VaccinationName = value;
      },
    );
  }

  Widget _buildInseminationDate() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Inssemination Date'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Inssemination Date is Required';
        }

        return null;
      },
      onSaved: (String value) {
        InseminationDate = value;
      },
    );
  }

  Widget _buildVaccinationDate() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Vaccination Date'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Vaccination Date is Required';
        }

        return null;
      },
      onSaved: (String value) {
        VaccinationDate = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Animal'),
        backgroundColor: Colors.amber[700],
      ),
      body: Container(
        margin: EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildAimalId(),
              _buildAnimalWeight(),
              _buildVaccinationName(),
              _buildInseminationDate(),
              _buildVaccinationDate(),
              SizedBox(height: 40),
              RaisedButton(
                child: Text(
                  'Add Animal',
                  style: TextStyle(color: Colors.blueGrey[700], fontSize: 20),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    DatabaseReference ref =
                        FirebaseDatabase.instance.reference();
                    var data = {
                      "Animal Id": AimalId,
                      "Aimal Weight": AnimalWeight,
                      "Inssemination Date": InseminationDate,
                      "Vaccination Date": VaccinationDate,
                      "Vaccination Name": VaccinationName
                      
                    };
                    ref.child('MedicalRecord').push().set(data).then((v) {
                      _formKey.currentState.reset();
                    });
                  }

                //    print(AimalId);
                //    print(AnimalWeight);
                //    print(VaccinationName);

                //  print(InseminationDate);
                //    print(VaccinationDate);

                  //Send to API
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
