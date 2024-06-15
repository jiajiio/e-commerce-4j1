import 'package:flutter/material.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/service/toy_service.dart';

class ToysProvider extends ChangeNotifier {
  List<Toys> toys = [];
  bool loading = false;

  int amount = 1;

  getToys({
    String search = '',
    int? productId,
  }) async {
    loading = true;
    toys.clear();
    toys = (await ToyService().getToys(search, productId: productId));
    loading = false;

    notifyListeners();
  }

  void incrementAmount() {
    amount = amount + 1;
    notifyListeners();
  }

  void decrementAmount() {
    if (amount > 1) {
      amount = amount - 1;
    }
    notifyListeners();
  }

  void clearAmount() {
    amount = 1;
    notifyListeners();
  }
}
