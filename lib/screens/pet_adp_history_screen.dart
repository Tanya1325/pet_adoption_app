import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/adopted_pets_data_model.dart';
import 'package:pet_adoption_app/models/animal_model.dart';
import 'package:pet_adoption_app/utils/app_string_constants.dart';
import 'package:pet_adoption_app/widgets/pets_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetAdoptionHistoryScreen extends StatefulWidget {
  final int categoryIndex;

  const PetAdoptionHistoryScreen({super.key, required this.categoryIndex});

  @override
  State<PetAdoptionHistoryScreen> createState() =>
      _PetAdoptionHistoryScreenState();
}

class _PetAdoptionHistoryScreenState extends State<PetAdoptionHistoryScreen> {
  List<AdoptedDataModels>? animalData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<AdoptedDataModels>?> getData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? data = sharedPref.getString("adoptedPetsData");
    isLoading = true;
    Map responseData;
    try {
      responseData = json.decode(data ?? "");
    } catch (e) {
      responseData = {};
    }
    var newData = responseData.entries.map((e) =>
        AdoptedDataModels(id: e.key, animalData: AnimalData.fromJson(e.value)));
    animalData?.addAll(newData);
    setState(() {
      isLoading = false;
    });
    return animalData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(key: const Key('backToHome'),
                            onTap: () {
                            Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.white24,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.network(
                                  "https://static.vecteezy.com/system/resources/previews/011/675/374/original/man-avatar-image-for-profile-png.png"),
                            ),
                          )
                        ],
                      ),
                      const Text(
                        AppStringConstants.adoptedPetsHistory,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  )),
            ),

            Positioned(
                top: 200.0,
                bottom: 0.0,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).cardColor,
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : animalData!.isEmpty
                              ? const Center(child: Text("No Pets adopted."))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: animalData?.length,
                                  itemBuilder: (context, index) {
                                    return PetsTile(
                                        animalData:
                                            animalData?[index].animalData,
                                        categoryIndex: widget.categoryIndex);
                                  }),
                    ))),
          ],
        ),
      ),
    );
  }
}
