import 'package:flutter/material.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:provider/provider.dart';

class AddToyForm extends StatelessWidget {
  const AddToyForm({super.key, this.toy});

  final Toys? toy;

  @override
  Widget build(BuildContext context) {
    return _AddToyForm(key: key, toy: toy);
  }
}

class _AddToyForm extends StatelessWidget {
  const _AddToyForm({
    super.key,
    this.toy,
  });

  final Toys? toy;

  @override
  Widget build(BuildContext context) {
    final add = Provider.of<AddToyProvider>(context, listen: true);
    final toys = Provider.of<ToysProvider>(context, listen: true);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Builder(
        builder: (context) {
          return Form(
            key: add.key,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Center(
                            child: Text(
                              add.update ? 'Ubah Mainan' : 'Tambah Mainan',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: add.nama,
                            decoration: const InputDecoration(
                              hintText: 'Nama',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Masukkan nama';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: add.kode,
                            decoration: const InputDecoration(
                              hintText: 'Kode',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Masukkan kode';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: add.deskripsi,
                            decoration: const InputDecoration(
                              hintText: 'Deskripsi',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Masukkan deskripsi';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: add.harga,
                            decoration: const InputDecoration(
                              hintText: 'Harga',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Masukkan harga';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: add.berat,
                            decoration: const InputDecoration(
                              hintText: 'Berat',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Masukkan berat';
                              }
                              return null;
                            },
                          ),
                          Visibility(
                            visible: !add.update,
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Text(add.photo?.path ?? ''),
                                ElevatedButton(
                                  onPressed: () {
                                    add.setPhoto();
                                  },
                                  child: const Text(
                                    'Upload Foto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        String message = '';
                        if (add.key.currentState!.validate()) {
                          if (add.update) {
                            final r = await add.updateProduct();
                            message = r;
                          } else {
                            final r = await add.addProduct();
                            message = r;
                          }
                          if (message != '') {
                            if (context.mounted) {
                              toys.getToys();
                              Navigator.pop(context);
                            }
                          }
                        }
                      },
                      child: Text(add.update ? 'Ubah Data' : 'Tambah Data'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
