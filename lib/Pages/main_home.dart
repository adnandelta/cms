import 'package:flutter/material.dart';
import 'package:cms/Models/user_model.dart';
import 'package:cms/Models/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/Services/auth_service.dart';
import 'package:cms/Services/database.dart';
import 'package:cms/Wrappers/auth_wrapper.dart';
import 'package:cms/Wrappers/main_wrapper.dart';
import 'package:cms/Pages/user_profile.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
} //

class _HomeState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    UserModel userStream = Provider.of<UserModel>(context);
    // PostService _post = PostService();

    void _showEditProfile() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: EditProfile());
          });
    }

    return StreamBuilder<Object>(
        stream: DatabaseService(uid: userStream.uid).userProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserProfileData userData = snapshot.data;
            return MultiProvider(
              providers: [
                StreamProvider<List<UserProfileModel>>.value(
                    value: DatabaseService().userProfileStream),
                // StreamProvider<List<PostModel>>.value(value: PostService().postStream)
              ],
              child: Scaffold(
                // backgroundColor: Colors.blueGrey[200],
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(3, 9, 23, 1),
                  title: Text("${userData.name}"),
                  elevation: 0.0,
                  actions: [
                    FlatButton.icon(
                        onPressed: () async {
                          await _auth.signOut();
                        },
                        icon: Icon(Icons.person),
                        label: Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        )),
                    FlatButton.icon(
                        onPressed: () {
                          _showEditProfile();
                        },
                        icon: Icon(Icons.settings),
                        label: Text("Edit Profile",
                            style: TextStyle(color: Colors.white)))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Color.fromRGBO(3, 9, 23, 1),
                  onPressed: () {},
                  child: Text("Post"),
                ),
                body: Row(
                  children: [
                    Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      color: Colors.indigoAccent,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ), //SizedBox
                              Text(
                                'Attendence',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.purple[50],
                                  fontWeight: FontWeight.w500,
                                ), //Textstyle
                              ), //Text
                              SizedBox(
                                height: 10,
                              ), //SizedBox
                              Text(
                                "${userData.attendence}",

                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.purple[50],
                                ), //Textstyle
                              ), //Text
                              SizedBox(
                                height: 10,
                              ), //SizedBox
                              //SizedBox
                            ],
                          ), //Column
                        ), //Padding
                      ), //SizedBox
                    ),
                    SizedBox(width: 60),
                    Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      color: Colors.indigoAccent,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ), //SizedBox
                              Text(
                                'Exam',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.purple[50],
                                  fontWeight: FontWeight.w500,
                                ), //Textstyle
                              ), //Text
                              SizedBox(
                                height: 10,
                              ), //SizedBox
                              Text(
                                'Current exams',

                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.purple[50],
                                ), //Textstyle
                              ), //Text
                              SizedBox(
                                height: 10,
                              ), //SizedBox
                              //SizedBox
                            ],
                          ), //Column
                        ), //Padding
                      ), //SizedBox
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
