class CarModel {
  String id;
  String idShowroom;
  String brandName;
  String modelName;
  String pathImage;
  String brandImage;
  String detail;

  CarModel(
      {this.id,
      this.idShowroom,
      this.brandName,
      this.modelName,
      this.pathImage,
      this.brandImage,
      this.detail});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShowroom = json['idShowroom'];
    brandName = json['BrandName'];
    modelName = json['ModelName'];
    pathImage = json['PathImage'];
    brandImage = json['brandImage'];
    detail = json['Detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShowroom'] = this.idShowroom;
    data['BrandName'] = this.brandName;
    data['ModelName'] = this.modelName;
    data['PathImage'] = this.pathImage;
    data['brandImage'] = this.brandImage;
    data['Detail'] = this.detail;
    return data;
  }
}

