import 'package:favorite_paces/screens/add_place.dart';
import 'package:favorite_paces/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_paces/providers/user_places.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const AddPlaceScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: PlacesList(places: userPlaces),
    );
  }
}
