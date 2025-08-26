class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;

  UserModel.fromJson(Map<String,dynamic> userData) {
    email = userData['email'];
    firstName = userData['firstName'];
    lastName = userData['lastName'];
    mobile = userData['mobile'];
    photo = userData['photo'];
  }

  Map<String, dynamic> toJSON() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": photo,
    };
  }
}