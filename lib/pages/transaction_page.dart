import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:java_toys/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({
    super.key,
    required this.isAdmin,
  });

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckoutProvider(),
      child: _TransactionLayout(isAdmin: isAdmin),
    );
  }
}

class _TransactionLayout extends StatefulWidget {
  const _TransactionLayout({required this.isAdmin});

  final bool isAdmin;

  @override
  State<_TransactionLayout> createState() => __TransactionLayout();
}

class __TransactionLayout extends State<_TransactionLayout> {
  @override
  void initState() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (widget.isAdmin) {
      final transaction =
          Provider.of<TransactionProvider>(context, listen: false);
      transaction.getTransactionAll();
    } else {
      final transaction =
          Provider.of<TransactionProvider>(context, listen: false);
      transaction.getTransaction(auth.user.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionProvider>(context, listen: true);
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Transaksi',
        hasArrowBack: false,
      ),
      body: transaction.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Cari Berdasarkan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    widget.isAdmin
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 36,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            width: 2,
                                            color: transaction.status == ''
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                        onPressed: () async {
                                          transaction.getTransactionAll();
                                        },
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                            color: transaction.status == ''
                                                ? Colors.blue
                                                : Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SizedBox(
                                      height: 36,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            width: 2,
                                            color:
                                                transaction.status == 'PENDING'
                                                    ? Colors.orange
                                                    : Colors.grey,
                                          ),
                                        ),
                                        onPressed: () async {
                                          transaction.getTransactionAll(
                                            s: 'PENDING',
                                          );
                                        },
                                        child: Text(
                                          'Pending',
                                          style: TextStyle(
                                            color:
                                                transaction.status == 'PENDING'
                                                    ? Colors.orange
                                                    : Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SizedBox(
                                      height: 36,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            width: 2,
                                            color: transaction.status == 'GAGAL'
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                        onPressed: () async {
                                          transaction.getTransactionAll(
                                              s: 'GAGAL');
                                        },
                                        child: Text(
                                          'Gagal',
                                          style: TextStyle(
                                            color: transaction.status == 'GAGAL'
                                                ? Colors.red
                                                : Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SizedBox(
                                      height: 36,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            width: 2,
                                            color:
                                                transaction.status == 'SUKSES'
                                                    ? Colors.green
                                                    : Colors.grey,
                                          ),
                                        ),
                                        onPressed: () async {
                                          transaction.getTransactionAll(
                                              s: 'SUKSES');
                                        },
                                        child: Text(
                                          'Sukses',
                                          style: TextStyle(
                                            color:
                                                transaction.status == 'SUKSES'
                                                    ? Colors.green
                                                    : Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          )
                        : const SizedBox(),
                    ...transaction.transaction.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.nama,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          e.uuid,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'ID',
                                                  decimalDigits: 0,
                                                  symbol: 'Rp.')
                                              .format(
                                            int.parse(
                                              e.transaksiTotal,
                                            ),
                                          ),
                                        ),
                                        Text(e.tanggal),
                                      ],
                                    ),
                                    transaksi(e.transaksiStatus),
                                  ],
                                ),
                                widget.isAdmin
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 36,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.orange,
                                                    ),
                                                    onPressed: () async {
                                                      await transaction
                                                          .updateTransaction(
                                                        e.id,
                                                        'PENDING',
                                                      );
                                                      transaction
                                                          .getTransactionAll();
                                                    },
                                                    child: const Text(
                                                      'Set Pending',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 36,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                    onPressed: () async {
                                                      await transaction
                                                          .updateTransaction(
                                                        e.id,
                                                        'GAGAL',
                                                      );
                                                      transaction
                                                          .getTransactionAll();
                                                    },
                                                    child: const Text(
                                                      'Set Gagal',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 36,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                    onPressed: () async {
                                                      await transaction
                                                          .updateTransaction(
                                                        e.id,
                                                        'SUKSES',
                                                      );
                                                      transaction
                                                          .getTransactionAll();
                                                    },
                                                    child: const Text(
                                                      'Kirim',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Color color(String status) {
    switch (status) {
      case 'GAGAL':
        return Colors.red;
      case 'SUKSES':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  Widget transaksi(String status) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: color(status),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Text(
          status,
          style: TextStyle(
            color: color(status),
          ),
        ),
      ),
    );
  }
}
