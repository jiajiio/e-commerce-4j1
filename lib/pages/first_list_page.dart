import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_toys/pages/pages.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:java_toys/util/util.dart';
import 'package:provider/provider.dart';

class FirstListPage extends StatefulWidget {
  const FirstListPage({super.key});

  @override
  State<FirstListPage> createState() => _FirstListPageState();
}

class _FirstListPageState extends State<FirstListPage> {
  Timer? _debounceTimer;
  @override
  void initState() {
    final toys = Provider.of<ToysProvider>(context, listen: false);
    toys.getToys();
    super.initState();
  }

  void searchToy(String value) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final toys = Provider.of<ToysProvider>(context, listen: false);
      toys.getToys(search: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final toys = Provider.of<ToysProvider>(context, listen: true);
    final add = Provider.of<AddToyProvider>(context, listen: true);
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text(
              'Java Toys',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Cari Mainan',
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  FocusScope.of(context).unfocus();
                }
                toys.getToys(search: value);
              },
            ),
            const SizedBox(height: 12),
            auth.user.admin == '1'
                ? Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => const AddToyForm(),
                          );
                        },
                        child: const Text(
                          'Tambah Mainan',
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 12),
            toys.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : !toys.loading && toys.toys.isEmpty
                    ? const Text('Mainan tidak ditemukan')
                    : auth.user.admin == '1'
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...toys.toys.map(
                                    (e) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                id: e.id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    e.gallery[0].photoUrl,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.nama,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    e.hargaFormatted,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    add.setToy(toys: e);
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              20),
                                                        ),
                                                      ),
                                                      builder: (context) =>
                                                          const AddToyForm(),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.yellow,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                GestureDetector(
                                                  onTap: () {
                                                    ConfirmationDialog
                                                        .showConfirmationDialog(
                                                      context,
                                                      () async {
                                                        await add.deleteProduct(
                                                            e.id);
                                                        if (context.mounted) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                        toys.getToys();
                                                      },
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.7,
                                  mainAxisSpacing: 12,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: toys.toys.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                            id: toys.toys[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 170,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                toys.toys[index].gallery[0]
                                                    .photoUrl,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              toys.toys[index].nama,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              toys.toys[index].hargaFormatted,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}
