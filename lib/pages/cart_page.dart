import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:java_toys/constant/constant.dart';
import 'package:java_toys/pages/pages.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:java_toys/util/util.dart';
import 'package:java_toys/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    this.hasArrowBack = true,
  });

  final bool hasArrowBack;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cart = Provider.of<CartProvider>(context, listen: false);
      cart.getCart();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Keranjang',
        hasArrowBack: widget.hasArrowBack,
      ),
      body: Column(
        children: [
          cart.c.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Belum ada barang di keranjang',
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ...cart.c
                            .asMap()
                            .map((i, e) {
                              return MapEntry(
                                i,
                                cartList(e, cart, i),
                              );
                            })
                            .values
                            .toList(),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget cartList(
    Map<String, dynamic> e,
    CartProvider cart,
    int i,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                id: e['id'],
                fromCart: true,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.grey[200]!,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            e['image'],
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e['name']),
                        Text(
                          NumberFormat.currency(
                                  locale: 'ID', decimalDigits: 0, symbol: 'Rp.')
                              .format(
                            int.parse(e['price']),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    ConfirmationDialog.showConfirmationDialog(
                      context,
                      () {
                        cart.removeCart(e['id']);
                        cart.getCart();
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
