class ShowroomModel {
  String id;
  String chooseType;
  String showroomName;
  String urlImage;

  ShowroomModel({this.id, this.chooseType, this.showroomName, this.urlImage});

  ShowroomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chooseType = json['ChooseType'];
    showroomName = json['ShowroomName'];
    urlImage = json['URLImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ChooseType'] = this.chooseType;
    data['ShowroomName'] = this.showroomName;
    data['URLImage'] = this.urlImage;
    return data;
  }
}

