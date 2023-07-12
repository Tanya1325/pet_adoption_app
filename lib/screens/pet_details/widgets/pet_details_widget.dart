import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/animal_model.dart';

import '../../../utils/app_string_constants.dart';

class PetDetailsWidget extends StatelessWidget {
  final AnimalData? animalData;

  const PetDetailsWidget({super.key, required this.animalData});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                animalData?.name ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 8.0,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: AppStringConstants.gender,
                    style: Theme.of(context).textTheme.labelMedium),
                TextSpan(
                    text: " : ",
                    style: Theme.of(context).textTheme.labelMedium),
                TextSpan(
                    text: animalData?.gender == "M"
                        ? AppStringConstants.male
                        : AppStringConstants.female,
                    style: Theme.of(context).textTheme.labelSmall)
              ])),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey)),
                    child: Text(
                      "${AppStringConstants.age} : ${animalData?.age} Months",
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey)),
                    child: Text(
                      "${AppStringConstants.price} : Rs.${animalData?.price}",
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                AppStringConstants.description,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                animalData?.desc ?? "",
                maxLines: 5,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ));
  }
}
