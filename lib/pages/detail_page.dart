import 'package:flutter/material.dart';
import 'package:java_toys/pages/pages.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:java_toys/util/image_url.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.id,
    this.fromCart = false,
  });

  final int id;
  final bool fromCart;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    final toys = Provider.of<ToysProvider>(context, listen: false);
    toys.getToys(productId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final t = Provider.of<ToysProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: t.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 270,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  t.toys[0].gallery[0].photoUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 40,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                t.clearAmount();
                                t.getToys();
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.toys[0].nama),
                            Text(
                              t.toys[0].deskripsi,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              t.toys[0].hargaFormatted,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                auth.user.admin == '1'
                    ? const SizedBox()
                    : widget.fromCart
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutPage(
                                        id: t.toys[0].id,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Checkout',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      cart.addCart(
                                        t.toys[0].copyWith(
                                          amount: t.amount,
                                        ),
                                      );
                                      t.clearAmount();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CartPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Tambah Ke Keranjang',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CheckoutPage(
                                            id: t.toys[0].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Checkout',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
              ],
            ),
    );
  }
}
