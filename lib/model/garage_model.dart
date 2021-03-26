class GarageModel {
  String id;
  String idUser;
  String nameUser;
  String nameGarage;
  String idCar;
  String modelCar;
  String amount;
  String rating;

  GarageModel(
      {this.id,
      this.idUser,
      this.nameUser,
      this.nameGarage,
      this.idCar,
      this.modelCar,
      this.amount,
      this.rating});

  GarageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    nameUser = json['NameUser'];
    nameGarage = json['NameGarage'];
    idCar = json['idCar'];
    modelCar = json['ModelCar'];
    amount = json['Amount'];
    rating = json['Rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUser'] = this.idUser;
    data['NameUser'] = this.nameUser;
    data['NameGarage'] = this.nameGarage;
    data['idCar'] = this.idCar;
    data['ModelCar'] = this.modelCar;
    data['Amount'] = this.amount;
    data['Rating'] = this.rating;
    return data;
  }
}

