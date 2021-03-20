class UserProfileModel {
  final String name;
  final String department;
  final String semester;
  final String section;

  final String email;
  final int attendence;

  UserProfileModel(
      {this.name,
      this.department,
      this.semester,
      this.section,
      this.email,
      this.attendence});
}

class UserProfileData {
  final uid;
  final String name;
  final String department;
  final String semester;
  final String section;

  final String email;
  final int attendence;

  UserProfileData(
      {this.uid,
      this.name,
      this.department,
      this.semester,
      this.section,
      this.email,
      this.attendence});
}
