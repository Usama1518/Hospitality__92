class User {
  int userId;
  String name;
  String email;
  String phone;
  String jobtitle;
  String dob;
  String gender;

  User({required this.userId, required this.name, required this.email, required this.phone, required this.jobtitle, required this.dob, required this.gender});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      name: responseData['name'],
      email: responseData['email'],
      phone: responseData['mobile'],
      jobtitle: responseData['jobtitle'],
      dob: responseData['dob'],
      gender: responseData['gender'],

    );
  }
}