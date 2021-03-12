class CarModel {
  String id;
  String idShowroom;
  String brandName;
  String modelName;
  String pathImage;

  CarModel(
      {this.id,
      this.idShowroom,
      this.brandName,
      this.modelName,
      this.pathImage});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShowroom = json['idShowroom'];
    brandName = json['BrandName'];
    modelName = json['ModelName'];
    pathImage = json['PathImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShowroom'] = this.idShowroom;
    data['BrandName'] = this.brandName;
    data['ModelName'] = this.modelName;
    data['PathImage'] = this.pathImage;
    return data;
  }
}

