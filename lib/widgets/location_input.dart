import 'dart:convert';
import 'dart:ffi';

import 'package:favorite_paces/models/places.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:location/location.dart';

import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isLoading = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }

    final lat = _pickedLocation?.latitude;
    final long = _pickedLocation?.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$long&key=AIzaSyAY6g4lejOb7raX521cRstMzzMG9SisSkg';
  }

  void getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isLoading = true;
    });

    locationData = await location.getLocation();
    final long = locationData.longitude;
    final lat = locationData.latitude;
    if (long == null || lat == null) {
      return;
    }

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationData.latitude},${locationData.longitude}&key=AIzaSyAY6g4lejOb7raX521cRstMzzMG9SisSkg',
    );
    final response = await https.get(url);

    final responseData = json.decode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: long,
        longitude: lat,
        address: address,
      );
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Center(child: Text('No Location Chosen'));
    if (_isLoading) {
      previewContent = const Center(child: CircularProgressIndicator());
    }
    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 170,
        alignment: Alignment.center,
      );
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: previewContent,
        ),
        Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: getLocation,
              label: Text('Current Location'),
              icon: Icon(Icons.location_on),
            ),
            const SizedBox(width: 10),
            TextButton.icon(
              onPressed: () {},
              label: Text('Select on Map'),
              icon: Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
