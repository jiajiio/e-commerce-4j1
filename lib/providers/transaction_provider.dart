import 'package:flutter/material.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/service/service.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> transaction = [];

  bool loading = false;

  String message = '';

  String status = '';

  getTransaction(int id) async {
    loading = true;
    transaction = (await TransactionService().getTransaction(id));
    loading = false;
    notifyListeners();
  }

  getTransactionAll({String? s}) async {
    loading = true;
    status = s ?? '';
    transaction = (await TransactionService().getTransactionAll(status: s));
    loading = false;
    notifyListeners();
  }

  updateTransaction(int id, String status) async {
    loading = true;
    message = (await TransactionService().updateTransaction(id, status));
    loading = false;
    notifyListeners();
  }
}
