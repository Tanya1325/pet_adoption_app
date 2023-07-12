import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/animal_model.dart';
import 'package:pet_adoption_app/screens/pet_details/widgets/pet_details_widget.dart';
import 'package:pet_adoption_app/screens/pet_details/widgets/pet_image.dart';
import 'package:pet_adoption_app/widgets/custom_alert_dialog.dart';
import 'package:pet_adoption_app/widgets/custom_app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_string_constants.dart';

class PetsDetailScreen extends StatefulWidget {
  final AnimalData? animalData;
  final Map<String, dynamic>? adoptedAnimals;
  final int categoryIndex;

  const PetsDetailScreen(
      {super.key,
      required this.animalData,
      required this.adoptedAnimals,
      required this.categoryIndex});

  @override
  State<PetsDetailScreen> createState() => _PetsDetailScreenState();
}

class _PetsDetailScreenState extends State<PetsDetailScreen> {
  ConfettiController _controller = ConfettiController();
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  PetImageView(
                      id: widget.animalData?.id ?? 0,
                      imgUrl: widget.animalData?.imageUrl ?? ""),
                  CustomAppBar(categoryIndex: widget.categoryIndex),
                  Positioned(
                      bottom: 8.0,
                      right: 8.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor:
                                Colors.transparent.withOpacity(0.4)),
                        onPressed: (widget.animalData?.isAdopted == true)
                            ? () => {}
                            : () async {
                                _adoptAPet();
                                isPlay = !isPlay;
                                _controller.play();
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Align(
                                          alignment: Alignment.center,
                                          child: ConfettiWidget(
                                            blastDirectionality:
                                                BlastDirectionality.explosive,
                                            confettiController: _controller,
                                            blastDirection: 200,
                                            colors: [
                                              Theme.of(context).primaryColor,
                                              Colors.white,
                                              Colors.black
                                            ],
                                            gravity: 0.3,
                                            emissionFrequency: 0.1,
                                            child: CustomDialogBox(
                                              title: AppStringConstants.success,
                                              descriptions:
                                                  "${AppStringConstants.youHaveNowAdopted} ${widget.animalData?.name}",
                                            ),
                                          ));
                                    });
                                _controller.stop();
                              },
                        child: Text((widget.animalData?.isAdopted != true
                                ? AppStringConstants.adoptMe
                                : AppStringConstants.adopted)
                            .toUpperCase()),
                      ))
                ],
              ),
              PetDetailsWidget(animalData: widget.animalData)
            ],
          ),
        ),
      ),
    );
  }

  _adoptAPet() async {
    setState(() {
      widget.animalData?.isAdopted = true;
    });
    widget.animalData?.dateTime = DateTime.now().toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? adoptedPetsData;
    Map decodedData;
    try {
      adoptedPetsData = sharedPreferences.getString("adoptedPetsData");
      decodedData = json.decode(adoptedPetsData ?? "");
    } catch (e) {
      adoptedPetsData = null;
      decodedData = {};
    }
    var newData = decodedData.entries.map((e) => e.key).toList();

    if (!newData.contains(widget.animalData?.id)) {
      decodedData!.putIfAbsent((widget.animalData?.id).toString(),
          () => widget.animalData ?? AnimalData());
    }
    String data = json.encode(decodedData);
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("adoptedPetsData", data);
  }
}
