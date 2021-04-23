class UserModel {
  String id;
  String name;
  String user;
  String password;
  String phone;
  String gender;
  String country;
  String urlImage;
  String nameGarage;

  UserModel(
      {this.id,
      this.name,
      this.user,
      this.password,
      this.phone,
      this.gender,
      this.country,
      this.urlImage,
      this.nameGarage});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    user = json['User'];
    password = json['Password'];
    phone = json['Phone'];
    gender = json['Gender'];
    country = json['Country'];
    urlImage = json['URLImage'];
    nameGarage = json['NameGarage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['User'] = this.user;
    data['Password'] = this.password;
    data['Phone'] = this.phone;
    data['Gender'] = this.gender;
    data['Country'] = this.country;
    data['URLImage'] = this.urlImage;
    data['NameGarage'] = this.nameGarage;
    return data;
  }
}

