class MyGarageModel {
  String id;
  String idGarage;
  String nameGarage;
  String idCar;
  String modelCar;

  MyGarageModel(
      {this.id, this.idGarage, this.nameGarage, this.idCar, this.modelCar});

  MyGarageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idGarage = json['idGarage'];
    nameGarage = json['NameGarage'];
    idCar = json['idCar'];
    modelCar = json['ModelCar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idGarage'] = this.idGarage;
    data['NameGarage'] = this.nameGarage;
    data['idCar'] = this.idCar;
    data['ModelCar'] = this.modelCar;
    return data;
  }
}

