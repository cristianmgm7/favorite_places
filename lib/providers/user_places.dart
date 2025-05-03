import 'dart:io';

import 'package:favorite_paces/models/places.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

import 'package:riverpod/riverpod.dart';

Future<sql.Database> _getDb() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, long REAL, address TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDb();
    final data = await db.query('user_places');
    final places =
        data
            .map(
              (e) => Place(
                id: e['id'] as String,
                title: e['title'] as String,
                image: File(e['image'] as String),
                location: PlaceLocation(
                  latitude: e['lat'] as double,
                  longitude: e['long'] as double,
                  address: e['address'] as String,
                ),
              ),
            )
            .toList();

    state = places;
  }

  void addPlace(String title, File? image, PlaceLocation location) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image!.path);
    final savedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = Place(title: title, image: savedImage, location: location);

    final db = await _getDb();

    await db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image?.path,
      'lat': newPlace.location?.latitude,
      'long': newPlace.location?.longitude,
      'address': newPlace.location?.address,
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
      (ref) => UserPlacesNotifier(),
    );
