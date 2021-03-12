class UserModel {
  String id;
  String name;
  String user;
  String password;
  String urlImage;
  String phone;
  String gender;
  String country;

  UserModel({this.id, this.name, this.user, this.password, this.urlImage,this.phone,this.gender,this.country});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    user = json['User'];
    password = json['Password'];
    urlImage = json['URLImage'];
    phone = json['Phone'];
    gender = json['Gender'];
    country = json['Country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['User'] = this.user;
    data['Password'] = this.password;
    data['URLImage'] = this.urlImage;
    data['Phone'] = this.phone;
    data['Gender'] = this.gender;
    data['Country'] = this.country;
    return data;
  }
}

