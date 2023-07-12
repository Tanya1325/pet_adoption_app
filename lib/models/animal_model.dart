class AnimalDataModel {
  PetsData? petsData;

  AnimalDataModel({petsData});

  AnimalDataModel.fromJson(Map<String, dynamic> json) {
    petsData =
        json['petsData'] != null ? PetsData.fromJson(json['petsData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (petsData != null) {
      data['petsData'] = petsData!.toJson();
    }
    return data;
  }
}

class PetsData {
  List<Categories>? categories;

  PetsData({categories});

  PetsData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? name;
  List<AnimalData>? data;

  Categories({name, data});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['data'] != null) {
      data = <AnimalData>[];
      json['data'].forEach((v) {
        data!.add(AnimalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}

class AnimalData {
  int? id;
  String? name;
  int? age;
  double? price;
  String? desc;
  String? gender;
  String? imageUrl;
  bool? isAdopted = false;
  String? dateTime;

  AnimalData(
      {id, name, age, price, desc, gender, imageUrl, isAdopted, dateTime});

  AnimalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    price = json['price'];
    desc = json['desc'];
    gender = json['gender'];
    imageUrl = json['image_url'];
    isAdopted = json['is_adopted'];
    dateTime = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['price'] = price;
    data['desc'] = desc;
    data['gender'] = gender;
    data['image_url'] = imageUrl;
    data['date'] = dateTime;
    data['is_adopted'] = isAdopted;
    return data;
  }
}
