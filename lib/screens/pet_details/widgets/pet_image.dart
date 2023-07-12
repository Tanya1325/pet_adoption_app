import 'package:flutter/material.dart';

class PetImageView extends StatelessWidget {
  final int id;
  final String imgUrl;

  const PetImageView({super.key, required this.id, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)),
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Hero(
            tag: "heroTag$id",
            child: InteractiveViewer(
              panEnabled: false,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 1,
              maxScale: 2.5,
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }
}
