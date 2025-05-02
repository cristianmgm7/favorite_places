import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  final double latitude;
  final double longitude;
  final String? address;
}

class Place {
  Place({required this.title, required this.image}) : id = uuid.v4();

  final String title;
  final String id;
  final File? image;
  //final PlaceLocation? location;
}
