import 'package:flutter/material.dart';
import 'package:pet_adoption_app/screens/pet_details/pet_detail_screen.dart';

import '../models/animal_model.dart';

class PetsTile extends StatelessWidget {
  final AnimalData? animalData;
  final Map<String, dynamic>? data;
  final int categoryIndex;

  const PetsTile(
      {super.key, this.animalData, this.data, required this.categoryIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PetsDetailScreen(
                      animalData: animalData,
                      adoptedAnimals: data,
                      categoryIndex: categoryIndex)));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.deepPurpleAccent.withOpacity(0.5)
                  : animalData?.isAdopted == true?Colors.grey.shade200:Colors.white,
              elevation: 8.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: animalData?.isAdopted == true
                        ? Banner(
                            message: "Adopted",
                            location: BannerLocation.topStart,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width / 2.5,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Hero(
                                tag: "heroTag${animalData?.id}",
                                child: Image.network(
                                  animalData?.imageUrl ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Hero(
                              tag: "heroTag${animalData?.id}",
                              child: Image.network(
                                animalData?.imageUrl ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          animalData?.name ?? "",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "${animalData?.age} Months",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Gender: ${animalData?.gender ?? ""}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
