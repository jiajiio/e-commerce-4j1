import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:java_toys/pages/pages.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:java_toys/util/image_url.dart';
import 'package:java_toys/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    super.key,
    required this.id,
    this.fromCart = false,
  });

  final int id;
  final bool fromCart;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckoutProvider(),
      child: _CheckoutLayout(id: id, fromCart: fromCart),
    );
  }
}

class _CheckoutLayout extends StatefulWidget {
  const _CheckoutLayout({
    required this.id,
    this.fromCart = false,
  });

  final int id;
  final bool fromCart;

  @override
  State<_CheckoutLayout> createState() => __CheckoutLayoutState();
}

class __CheckoutLayoutState extends State<_CheckoutLayout> {
  @override
  void initState() {
    final toys = Provider.of<ToysProvider>(context, listen: false);
    final checkout = Provider.of<CheckoutProvider>(context, listen: false);
    toys.getToys(productId: widget.id);
    checkout.getOriginProvince();
    checkout.getDestinationProvince();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final t = Provider.of<ToysProvider>(context);
    final checkout = Provider.of<CheckoutProvider>(context);
    return Scaffold(
      appBar: const CustomAppbar(title: 'Checkout'),
      body: t.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey[200]!,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          t.toys[0].gallery[0].photoUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          t.toys[0].nama,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          t.toys[0].deskripsi,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          t.toys[0].hargaFormatted,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  t.decrementAmount();
                                                },
                                                child: const Text('-'),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: SizedBox(
                                                width: 17,
                                                child: Center(
                                                  child: Text(
                                                    t.amount.toString(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  t.incrementAmount();
                                                },
                                                child: const Text('+'),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            value: checkout.provinceOriginId,
                            hint: const Text('Pilih Asal Provinsi'),
                            items: [
                              ...checkout.originProvince.map(
                                (e) => DropdownMenuItem(
                                  value: e.provinceId,
                                  child: Text(
                                    e.province,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              checkout.setOriginProvince(value.toString());
                              checkout
                                  .getOriginCity(int.parse(value.toString()));
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            value: checkout.originId,
                            hint: const Text('Pilih Asal Kota'),
                            items: [
                              ...checkout.originCity.map(
                                (e) => DropdownMenuItem(
                                  value: e.cityId,
                                  child: Text(
                                    e.cityName,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              checkout.setOrigin(value.toString());
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            value: checkout.provinceDestinationId,
                            hint: const Text('Pilih Provinsi Tujuan'),
                            items: [
                              ...checkout.destinationProvince.map(
                                (e) => DropdownMenuItem(
                                  value: e.provinceId,
                                  child: Text(
                                    e.province,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              checkout.setDestinationProvince(value.toString());
                              checkout.getDestinationCity(
                                  int.parse(value.toString()));
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            value: checkout.destinationId,
                            hint: const Text('Pilih Kota Tujuan'),
                            items: [
                              ...checkout.destinationCity.map(
                                (e) => DropdownMenuItem(
                                  value: e.cityId,
                                  child: Text(
                                    e.cityName,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              checkout.setDestination(value.toString());
                            },
                          ),
                          const SizedBox(height: 16),
                          IgnorePointer(
                            ignoring: checkout.provinceDestinationId == null &&
                                checkout.provinceOriginId == null &&
                                checkout.originId == null &&
                                checkout.destinationId == null,
                            child: DropdownButtonFormField(
                              hint: const Text('Pilih Kurir'),
                              items: [
                                ...['jne', 'pos', 'tiki'].map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                checkout.setCourier(value.toString());
                                checkout.getCost(
                                  originId: int.parse(checkout.originId!),
                                  destinationId:
                                      int.parse(checkout.destinationId!),
                                  weight: 10000,
                                  courier: checkout.courier!,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          checkout.costPrice.costs.isEmpty
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pilih Ongkos Kirim',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ...checkout.costPrice.costs.map(
                                      (e) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ListTile(
                                          title: Text(e.service),
                                          subtitle: Text(e.description),
                                          trailing: Text(NumberFormat.currency(
                                                  locale: 'ID',
                                                  decimalDigits: 0,
                                                  symbol: 'Rp.')
                                              .format(e.cost[0].value)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          onTap: () {
                                            checkout.setCost(e.cost[0].value);
                                          },
                                          tileColor:
                                              e.cost[0].value == checkout.cost
                                                  ? Colors.green
                                                  : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total'),
                            Text(
                              NumberFormat.currency(
                                      locale: 'ID',
                                      decimalDigits: 0,
                                      symbol: 'Rp.')
                                  .format(checkout.cost == null
                                      ? int.parse(t.toys[0].harga) * t.amount
                                      : int.parse(t.toys[0].harga) * t.amount +
                                          checkout.cost!),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              final c = await checkout.checkoutToys(
                                customerId: auth.user.id,
                                name: auth.user.nama,
                                alamat: '-',
                                kodePos: '-',
                                noTelp: '-',
                                ongkir: checkout.cost.toString(),
                                pajak: '10000',
                                transaksiTotal:
                                    int.parse(t.toys[0].harga) * t.amount,
                                transaksiStatus: 'PENDING',
                                productId: t.toys[0].id.toString(),
                                quantity: t.amount.toString(),
                              );
                              if (c.paymentUrl != '') {
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WebView(url: c.paymentUrl),
                                    ),
                                  );
                                }
                              }
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
                ),
              ],
            ),
    );
  }
}
