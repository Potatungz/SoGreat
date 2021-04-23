class MyGarageModel {
  String id;
  String idGarage;
  String idCar;
  String modelCar;
  String pathImage;
  String brandImage;

  MyGarageModel(
      {this.id, this.idGarage, this.idCar, this.modelCar, this.pathImage, this.brandImage});

  MyGarageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idGarage = json['idGarage'];
    idCar = json['idCar'];
    modelCar = json['ModelCar'];
    pathImage = json['pathImage'];
    brandImage = json['brandImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idGarage'] = this.idGarage;
    data['idCar'] = this.idCar;
    data['ModelCar'] = this.modelCar;
    data['pathImage'] = this.pathImage;
    data['brandImage'] = this.brandImage;
    return data;
  }
}
