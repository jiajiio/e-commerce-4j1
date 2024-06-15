import 'package:flutter/material.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/service/service.dart';

class CartProvider with ChangeNotifier {
  List<Cart> cart = [];
  List<Map<String, dynamic>> c = [];

  bool loading = true;
  var isAdd = true;

  void getCart() async {
    loading = true;
    final res = await CartService.instance.queryAll();
    c.clear();
    c.addAll(res);
    loading = false;
    notifyListeners();
  }

  void addCart(Toys toys) {
    var add = true;

    for (int i = 0; i < c.length; i++) {
      if (c[i]['id'] == toys.id) {
        add = false;
        break;
      }
    }
    if (add) {
      CartService.instance.insert({
        'id': toys.id,
        'name': toys.nama,
        'amount': toys.amount,
        'price': toys.harga,
        'image': toys.gallery[0].photoUrl,
      });
    }

    isAdd = add;
    notifyListeners();
  }

  void incrementCart(int i, Map<String, dynamic> toys) {
    final t = Map.of(toys);
    t['amount'] = t['amount'] + 1;
    CartService.instance.update(t);
    notifyListeners();
  }

  void decrementCart(int i, Map<String, dynamic> toys) {
    if (toys['amount'] > 1) {
      final t = Map.of(toys);
      t['amount'] = t['amount'] - 1;
      CartService.instance.update(t);
    }
    notifyListeners();
  }

  void removeCart(int id) {
    CartService.instance.delete(id);
    notifyListeners();
  }

  void removeAllCart() {
    CartService.instance.deleteAll();
    notifyListeners();
  }
}
