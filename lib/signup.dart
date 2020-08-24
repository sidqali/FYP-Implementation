import 'package:flutter/material.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'model/authentication.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();
  Map<String, String> _authData = {'email': '', 'password': ''};
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    await Provider.of<Authentication>(context, listen: false)
        .SignUp(_authData['email'], _authData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
        backgroundColor: Colors.amber[700],
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[Text('Login'), Icon(Icons.person)],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
               Colors.amber,
              Colors.yellow[600],
            ])),
          ),
          Center(
            child: Card(
              color: Colors.amber[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                height: 360,
                width: 360,
                padding: EdgeInsets.all(36),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Invalid Email ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value.isEmpty || value.length <= 5) {
                              return 'Invalid Password ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty ||
                                value != _passwordController.text) {
                              return 'Invalid Password ';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          child: Text('Sign Up',
                          style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 24),),
                          onPressed: () {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(230),
                          ),
                          color: Colors.amberAccent,
                          textColor: Colors.black87,
                          
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
