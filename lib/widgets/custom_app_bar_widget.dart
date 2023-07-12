import 'package:flutter/material.dart';

import '../screens/pets_list/pets_list_screen.dart';

class CustomAppBar extends StatelessWidget {
  final int categoryIndex;

  const CustomAppBar({super.key, this.categoryIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(key: const Key('backToHome'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PetsListScreen(
                        categoryIndex: categoryIndex,
                      )));
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
    );
  }
}
