import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter/material.dart';
import '../models/animal_model.dart';

Future<AnimalDataModel> readJson(String name) async {
  final String response = await rootBundle.loadString('assets/pets_data.json');
  final data = await json.decode(response);
  AnimalDataModel animalDataModel = AnimalDataModel.fromJson(data);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  List? newData;
  try {
    String? adoptedPetsData = sharedPreferences.getString("adoptedPetsData");
    final Map decodedData = json.decode(adoptedPetsData ?? "");
    newData = decodedData.entries.map((e) => e.key).toList();
  } catch (e) {
    newData = null;
  }
  final Iterable<Categories>? result =
      animalDataModel.petsData?.categories?.map((element) {
    final Iterable<AnimalData>? animalResult = element.data?.map((animal) {
      animal.isAdopted = newData?.contains(animal.id.toString());
      return animal;
    });
    final Iterable<AnimalData>? animalFilterResult;
    if (name.isNotEmpty) {
      animalFilterResult = animalResult?.where((element) =>
          element.name?.toLowerCase().contains(name.toLowerCase()) ?? false);
    } else {
      animalFilterResult = animalResult;
    }
    element.data = animalFilterResult?.toList();
    return element;
  });
  animalDataModel.petsData?.categories = result?.toList();
  return animalDataModel;
}

Future getPetsData(String name) async {
  AnimalDataModel animalDataModel = AnimalDataModel();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? adoptedPetsData = sharedPreferences.getString("adoptedPetsData");
  final Map decodedData = json.decode(adoptedPetsData ?? "");
  var newData = decodedData.entries.map((e) => e.key).toList();
  debugPrint("Adopt-->$newData");
  final Iterable<Categories>? result =
      animalDataModel.petsData?.categories?.map((element) {
    final Iterable<AnimalData>? animalResult = element.data?.map((animal) {
      animal.isAdopted = newData.contains(animal.id.toString());
      return animal;
    });
    final Iterable<AnimalData>? animalFilterResult;
    if (name.isNotEmpty) {
      animalFilterResult = animalResult?.where((element) =>
          element.name?.toLowerCase().contains(name.toLowerCase()) ?? false);
    } else {
      animalFilterResult = animalResult;
    }
    element.data = animalFilterResult?.toList();
    return element;
  });
  animalDataModel.petsData?.categories = result?.toList();
  return animalDataModel;
}
