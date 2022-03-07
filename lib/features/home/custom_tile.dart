import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final VoidCallback callbackFunction;
  final String imageLocation;
  final String imageText;
  const CustomTile({
    Key? key,
    required this.callbackFunction,
    required this.imageLocation,
    required this.imageText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black.withOpacity(0.3),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              imageText,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        child: Ink.image(
          height: 300,
          image: AssetImage(imageLocation),
          fit: BoxFit.fill,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: Theme.of(context).colorScheme.secondary,
            onTap: callbackFunction,
          ),
        ),
      ),
    );
  }
}
