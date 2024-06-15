import 'package:java_toys/constant/url_constant.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/util/util.dart';

class CheckoutService {
  Future<Checkout> checkout({
    required int customerId,
    required String name,
    required String alamat,
    required String kodePos,
    required String noTelp,
    required String ongkir,
    required String pajak,
    required int transaksiTotal,
    required String transaksiStatus,
    required String productId,
    required String quantity,
  }) async {
    Checkout result;
    result = Checkout(
      paymentUrl: '',
    );
    try {
      final response = await Api.createDio().post(
        '${baseUrl}checkout',
        data: {
          'customer_id': customerId,
          'nama': name,
          'alamat': alamat,
          'kode_pos': kodePos,
          'no_telpon': noTelp,
          'ongkir': ongkir,
          'pajak': pajak,
          'transaksi_total': transaksiTotal,
          'transaksi_status': 'PENDING',
          'transaksi_details': {
            'transaction': [productId, quantity]
          }
        },
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final data = item['data'];
        final c = Checkout.fromJson(data);
        result = c;
      } else {}
    } catch (e) {}
    return result;
  }
}
