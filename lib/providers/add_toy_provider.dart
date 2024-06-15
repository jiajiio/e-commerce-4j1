import 'dart:io';
import 'dart:math';

import 'package:cloudinary/cloudinary.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/service/service.dart';
import 'package:path/path.dart';

class AddToyProvider extends ChangeNotifier {
  final nama = TextEditingController();
  final kode = TextEditingController();
  final deskripsi = TextEditingController();
  final harga = TextEditingController();
  final berat = TextEditingController();

  bool isLoading = false;

  final key = GlobalKey<FormState>();

  File? photo;

  bool update = false;
  int toyId = 0;

  String message = '';

  setToy({Toys? toys}) {
    if (toys != null) {
      update = true;
      toyId = toys.id;
      nama.text = toys.nama;
      kode.text = toys.kode;
      deskripsi.text = toys.deskripsi;
      harga.text = toys.harga;
      berat.text = toys.berat;
    }
    notifyListeners();
  }

  setPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    photo = File(image!.path);
    notifyListeners();
  }

  Future<String> addProduct() async {
    isLoading = true;
    final cloudinary = Cloudinary.signedConfig(
      apiKey: '391338387979366',
      apiSecret: '-qVcxZVinGacE-uw0T7kZ46nV2Q',
      cloudName: 'deewqrawe',
    );
    final response = await cloudinary.upload(
      file: photo!.path,
      fileBytes: photo!.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'toys',
      fileName:
          '${Random().nextInt(9999)}${basename(photo!.path)}'.replaceFirst(
        '.jpg',
        '',
      ),
    );
    print(response.publicId);
    print(response.url);
    if (response.isSuccessful) {
      var formData = FormData.fromMap({
        'nama': nama.text,
        'kode': kode.text,
        'deskripsi': deskripsi.text,
        'harga': harga.text,
        'berat': berat.text,
        'gambar': response.url,
      });
      message = await AdminToyService().addProduct(formData);
      notifyListeners();
      isLoading = false;
      return message;
    } else {
      return 'Error';
    }
  }

  Future<String> updateProduct() async {
    isLoading = true;
    message = await AdminToyService().updateProduct(
      id: toyId,
      data: {
        'nama': nama.text,
        'kode': kode.text,
        'deskripsi': deskripsi.text,
        'harga': harga.text,
      },
    );
    notifyListeners();
    isLoading = false;
    return message;
  }

  Future<String> deleteProduct(int id) async {
    isLoading = true;
    message = await AdminToyService().deleteProduct(
      id: id,
    );
    notifyListeners();
    isLoading = false;
    return message;
  }
}
