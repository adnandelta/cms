import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cms/Models/user_model.dart';
import 'package:cms/Models/user_profile_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cms/Services/auth_service.dart';
import 'package:cms/Services/database.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();
  final List<String> depList = ['CSE', 'ISE', 'ECE', 'Mech', 'Civil'];

  //Form Vars
  String _currentDept;
  String _currentName;
  String _currentSemester;
  String _currentSection;
  String _currentEmail;
  int _currentAttendence;
  @override
  Widget build(BuildContext context) {
    UserModel userStream = Provider.of<UserModel>(context);

    return StreamBuilder<UserProfileData>(
        stream: DatabaseService(uid: userStream.uid).userProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserProfileData userData = snapshot.data;

            return Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      'Update your User Profile.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 10.0),
                    DropdownButtonFormField(
                      value: _currentDept ?? 'CSE',
                      // decoration: textInputDecoration,
                      items: depList.map((lang) {
                        return DropdownMenuItem(
                            value: lang, child: Text('$lang'));
                      }).toList(),
                      onChanged: (val) => setState(() => _currentDept = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.semester,
                      validator: (val) => val.isEmpty ? 'Enter Url' : null,
                      onChanged: (val) =>
                          setState(() => _currentSemester = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.section,
                      validator: (val) => val.isEmpty ? 'Enter Url' : null,
                      onChanged: (val) => setState(() => _currentSection = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.email,
                      validator: (val) => val.isEmpty ? 'Enter Url' : null,
                      onChanged: (val) => setState(() => _currentEmail = val),
                    ),
                    SizedBox(height: 10.0),

/*IF (user.isProf == true){TextFormField(
                      initialValue: userData.attendence,
                      validator: (val) => val.isEmpty ? 'Enter Attendence' : null,
                      onChanged: (val) =>
                          setState(() => _currentAttendence = val),
                    ),}
                    
*/

                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            await DatabaseService(uid: userStream.uid)
                                .updateUserData(
                                    _currentName ?? snapshot.data.name,
                                    _currentDept ?? snapshot.data.department,
                                    _currentSemester ?? snapshot.data.semester,
                                    _currentSection ?? snapshot.data.section,
                                    _currentEmail ?? snapshot.data.email,
                                    _currentAttendence);
                            print("updated");
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ));
          }
        });
  }
}
