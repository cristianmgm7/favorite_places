import 'package:favorite_paces/models/places.dart';
import 'package:favorite_paces/screens/place_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Center(child: Text('No places yet, start adding some!'));
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(places[index].image!),
          ),
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            places[index].location?.address ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailScreen(place: places[index]),
              ),
            );
          },
        );
      },
    );
  }
}
