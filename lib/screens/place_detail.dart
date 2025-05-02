import 'package:flutter/material.dart';

import 'package:favorite_paces/models/places.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(
              place.image!,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            // Text(
            //   place.location!.address,
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(fontSize: 20),
            // ),
          ],
        ),
      ),
    );
  }
}
