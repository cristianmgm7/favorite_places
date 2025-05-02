import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return;
    }
    _selectedImage = File(pickedImage.path);
    setState(() {}); // Ensure the UI updates after selecting an image
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      label: Text('Take Picture'),
      icon: Icon(Icons.camera),
    );

    if (_selectedImage != null) {
      content = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250,
        alignment: Alignment.center,
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
