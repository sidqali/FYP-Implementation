import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FypProject/login.dart';
import 'addanimal.dart';
import 'package:FypProject/youranimal.dart';

import 'animalrecord.dart';

class YourAnimal extends StatefulWidget {
  @override
  _YourAnimalState createState() => _YourAnimalState();
}

class _YourAnimalState extends State<YourAnimal> {
  @override
 
    Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('View Animals'),
        backgroundColor: Colors.amber[700],),
        
      body: SafeArea(
        
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          color: Colors.amber[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                
                  // Text(
                  //   " We Welcome You",
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   "Please Select From Below  ",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(color: Colors.grey[700], fontSize: 20),
                  // )
                ],
              ),
              SizedBox(
                height: 40,

              ),
              
              Column(
                children: <Widget>[
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnimalRecord()));
                    },
                    color: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(500)),
                    child: Text(
                      "Your Animals",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
             
                
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
