class ImageGalleryModel {
  String id;
  String idCar;
  String pathImage;

  ImageGalleryModel({this.id, this.idCar, this.pathImage});

  ImageGalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCar = json['idCar'];
    pathImage = json['pathImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idCar'] = this.idCar;
    data['pathImage'] = this.pathImage;
    return data;
  }
}

