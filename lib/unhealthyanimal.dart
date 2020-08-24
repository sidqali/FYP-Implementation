import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FypProject/login.dart';

class UnhealthyAnimal extends StatefulWidget {
  @override
  _UnhealthyAnimalState createState() => _UnhealthyAnimalState();
}

class _UnhealthyAnimalState extends State<UnhealthyAnimal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('UnHealthy Animals'),
        backgroundColor: Colors.amber[700],)
      
    );
  }
}