import 'package:java_toys/constant/constant.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/util/util.dart';

class TransactionService {
  Future<List<Transaction>> getTransaction(int id) async {
    List<Transaction> result;
    result = [];
    try {
      final response = await Api.createDio().get(
        '${baseUrl}transaksi-user/$id/',
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final data = item['data'];
        final t =
            data.map<Transaction>((e) => Transaction.fromJson(e)).toList();
        result = t;
      } else {}
    } catch (e) {}
    return result;
  }

  Future<List<Transaction>> getTransactionAll({String? status}) async {
    List<Transaction> result;
    result = [];
    try {
      final response = await Api.createDio().get(
        '${baseUrl}transaksi',
        queryParameters: {
          'status': status,
        },
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final data = item['data'];
        final t =
            data.map<Transaction>((e) => Transaction.fromJson(e)).toList();
        result = t;
      } else {}
    } catch (e) {}
    return result;
  }

  Future<String> updateTransaction(int id, String status) async {
    try {
      final response =
          await Api.createDio().post('${baseUrl}update-transaksi/$id', data: {
        'status': status,
      });
      if (response.statusCode == 200) {
        return 'Success';
      } else {}
    } catch (e) {
      return e.toString();
    }
    return '';
  }
}
