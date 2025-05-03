import 'package:favorite_paces/models/places.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick a Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(icon: const Icon(Icons.check), onPressed: () {}),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 13,
        ),
        onTap:
            widget.isSelecting
                ? (latLng) {
                  Navigator.of(context).pop(
                    PlaceLocation(
                      latitude: latLng.latitude,
                      longitude: latLng.longitude,
                    ),
                  );
                }
                : null,
        markers:
            widget.isSelecting
                ? {}
                : {
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: LatLng(
                      widget.location.latitude,
                      widget.location.longitude,
                    ),
                  ),
                },
      ),
    );
  }
}
