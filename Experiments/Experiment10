import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      home: MediaPickerPage(),
    );
  }
}

class MediaPickerPage extends StatefulWidget {
  @override
  _MediaPickerPageState createState() => _MediaPickerPageState();
}

class _MediaPickerPageState extends State<MediaPickerPage> {
  File? _image;
  String _imageSize = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int fileSize = await imageFile.length();
      String size = fileSize < 1024
          ? '${fileSize}B'
          : fileSize < 1048576
              ? '${(fileSize / 1024).toStringAsFixed(2)} KB'
              : '${(fileSize / 1048576).toStringAsFixed(2)} MB';

      setState(() {
        _image = imageFile;
        _imageSize = size;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Image and Show Size'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Column(
                    children: [
                      Image.file(_image!, width: 200, height: 200),
                      SizedBox(height: 10),
                      Text('Size: $_imageSize', style: TextStyle(fontSize: 16)),
                    ],
                  )
                : Text('No image selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick an Image'),
            ),
          ],
        ),
      ),
    );
  }
}
