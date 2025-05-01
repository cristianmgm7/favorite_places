import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<String> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Center(child: Text('No places yet, start adding some!'));
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            places[index],
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () {
            // Handle place tap
          },
        );
      },
    );
  }
}
