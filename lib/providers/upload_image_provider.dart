import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';

class UploadImageProvider extends ChangeNotifier {
  bool isSuccess = false;

  final cloudinary = Cloudinary.signedConfig(
    apiKey: '391338387979366',
    apiSecret: '-qVcxZVinGacE-uw0T7kZ46nV2Q',
    cloudName: 'deewqrawe',
  );

  void upload(File file) async {
    final response = await cloudinary.upload(
      file: file.path,
      fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'toys',
      fileName: 'some-name',
    );
    if (response.isSuccessful) {
      isSuccess = true;
      notifyListeners();
    }
  }

  void delete(String publicId) async {
    final response = await cloudinary.destroy(
      'public_id',
      url: '',
      resourceType: CloudinaryResourceType.image,
      invalidate: false,
    );
    if (response.isSuccessful) {
      isSuccess = true;
      notifyListeners();
    }
  }
}
