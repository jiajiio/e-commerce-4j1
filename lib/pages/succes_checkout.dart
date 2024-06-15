import 'package:flutter/material.dart';
import 'package:java_toys/pages/pages.dart';

class SuccessCheckoutPage extends StatelessWidget {
  const SuccessCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline_outlined,
              size: 100,
            ),
            const SizedBox(height: 12),
            const Text('Pembelian Berhasil'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Text(
                'Kembali',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
