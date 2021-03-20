import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/Models/user_profile_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userProfileCollection =
      FirebaseFirestore.instance.collection('userProfiles');

  Future updateUserData(String name, String department, String semester,
      String section, String email, int attendencec) async {
    return await userProfileCollection.doc(uid).set({
      'name': name,
      'department': department,
      'semester': semester,
      'section': section,
      'email': email,
      'attendence': attendencec
    });
  }

//user profile from snapshort
  UserProfileData _userProfileFromSnapshot(DocumentSnapshot snapshot) {
    return UserProfileData(
        uid: uid,
        name: snapshot.data()['name'],
        department: snapshot.data()['department'],
        semester: snapshot.data()['semester'],
        section: snapshot.data()['section'],
        email: snapshot.data()['email'],
        attendence: snapshot.data()['attendence']);
  }

  List<UserProfileModel> _userPfromSnap(QuerySnapshot userSnapshot) {
    return userSnapshot.docs.map((e) {
      return UserProfileModel(
          name: e.data()['name'] ?? "",
          department: e.data()['department'] ?? "CSE",
          semester: e.data()['semester'] ?? "First ",
          section: e.data()['section'] ?? "A",
          email: e.data()['email'] ?? "test@gmail.com",
          attendence: e.data()['attemdence'] ?? 100);
    }).toList();
  }

  // Streams
  Stream<List<UserProfileModel>> get userProfileStream {
    return userProfileCollection.snapshots().map(_userPfromSnap);
  }

  Stream<UserProfileData> get userProfileData {
    return userProfileCollection
        .doc(uid)
        .snapshots()
        .map(_userProfileFromSnapshot);
  }
}
