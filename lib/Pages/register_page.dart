import 'package:flutter/material.dart';
import 'package:cms/Services/auth_service.dart';

class RegisterWidget extends StatefulWidget {
  final Function toggler;
  RegisterWidget({this.toggler});

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final AuthService _authOBJ = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String errorMsg = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: () => widget.toggler(),
              icon: Icon(Icons.pages_rounded),
              label: Text("Sign-In", style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        )),
                    validator: (val) =>
                        val.isEmpty ? "Enter Valid email" : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: "Create Password",
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        )),
                    validator: (val) => val.length < 6
                        ? "Password should be 6 characters"
                        : null,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 50.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("Register"),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          dynamic result =
                              _authOBJ.emailRegister(email, password);
                          print(result.uid);
                          print(result);
                          if (result == null) {
                            setState(() {
                              errorMsg = "Unable to Register";
                            });
                          }
                        }
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    errorMsg,
                    style: TextStyle(color: Colors.red[800]),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
