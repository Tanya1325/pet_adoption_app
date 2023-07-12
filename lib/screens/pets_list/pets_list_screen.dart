import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/animal_model.dart';
import 'package:pet_adoption_app/screens/pet_adp_history_screen.dart';
import 'package:pet_adoption_app/utils/app_string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business_logic/fetch_pets_list.dart';
import '../../widgets/pets_tile.dart';

class PetsListScreen extends StatefulWidget {
  final int categoryIndex;

  const PetsListScreen({super.key, this.categoryIndex = 0});

  @override
  State<PetsListScreen> createState() => _PetsListScreenState();
}

class _PetsListScreenState extends State<PetsListScreen> {
  bool isLoading = true;
  Color? selectedColor;
  late int categoryIndex;

  List<Color>? categoryColor;
  AnimalDataModel animalDataModel = AnimalDataModel();
  Map<String, dynamic> adoptedPets = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryIndex = widget.categoryIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<AnimalDataModel>(
            future: readJson(_searchController.text),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                key: const Key('navHistoryButton'),
                                onTap: () async {
                                  await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PetAdoptionHistoryScreen(
                                                  categoryIndex:
                                                      widget.categoryIndex)));

                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onLongPress: () async {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  await sharedPreferences.clear();
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Image.network(
                                        "https://static.vecteezy.com/system/resources/previews/011/675/374/original/man-avatar-image-for-profile-png.png"),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text(AppStringConstants.hello,
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.white)),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text(
                            AppStringConstants.welcome,
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            controller: _searchController,

                            decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              enabled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: AppStringConstants.searchPet,
                            ),
                          )
                        ],
                      ),
                    ),
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
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStringConstants.petsCategory,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width / 8,
                                    child: ListView.builder(
                                        itemCount: snapshot
                                            .data?.petsData?.categories?.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                categoryColor?[index] =
                                                    Theme.of(context)
                                                        .primaryColor;
                                                categoryIndex = index;
                                              });
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0)),
                                              elevation: 2.0,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              color: categoryIndex == index
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Center(
                                                  child: Text(
                                                    snapshot
                                                            .data
                                                            ?.petsData
                                                            ?.categories?[index]
                                                            .name ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: (categoryIndex ==
                                                                index
                                                            ? Colors.white
                                                            : Theme.of(context)
                                                                .primaryColor)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Expanded(
                                      child: (snapshot.connectionState ==
                                                  ConnectionState.waiting) ||
                                              snapshot.hasData == false
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                  .data
                                                  ?.petsData
                                                  ?.categories
                                                  ?.first
                                                  .data
                                                  ?.length,
                                              itemBuilder: (context, index) {
                                                return PetsTile(
                                                  animalData: snapshot
                                                      .data
                                                      ?.petsData
                                                      ?.categories?[
                                                          categoryIndex]
                                                      .data?[index],
                                                  data: adoptedPets,
                                                  categoryIndex: categoryIndex,
                                                );
                                              }))
                                ],
                              ),
                            ),
                          ))),
                ],
              );
            }),
      ),
    );
  }
}
