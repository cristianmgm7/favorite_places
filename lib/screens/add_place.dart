import 'dart:io';

import 'package:favorite_paces/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_paces/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    final title = _titleController.text;
    if (title.isEmpty || _selectedImage == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(title, _selectedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a New Place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style: Theme.of(context).textTheme.titleMedium,
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            const SizedBox(height: 20),
            ImageInput(
              onSelectImage: (pickedImage) {
                _selectedImage = pickedImage;
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
              onPressed: _savePlace,
            ),
          ],
        ),
      ),
    );
  }
}
