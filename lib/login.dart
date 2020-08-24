import 'signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/authentication.dart';
import 'services/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {'email': '', 'password': ''};
  void _showErrorDialog(String Msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured.'),
              content: Text(Msg),
              actions: <Widget>[
                FlatButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    })
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
    try {
      await Provider.of<Authentication>(context, listen: false)
          .LoginPage(_authData['email'], _authData['password']);
    } catch (error) {
      var errormessage = 'Authentication failed, please try again';
      _showErrorDialog(errormessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.amber[700],
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[Text('SignUp'), Icon(Icons.person_add)],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Text(
            "Login To Your Acount",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          SizedBox(
            height: 20,
          ),
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
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
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
                        SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 24),
                          ),
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
