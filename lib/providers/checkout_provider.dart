import 'package:flutter/material.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/service/service.dart';

class CheckoutProvider extends ChangeNotifier {
  bool loading = true;

  List<Province> originProvince = [];
  List<Province> destinationProvince = [];
  List<City> originCity = [];
  List<City> destinationCity = [];
  CostPrice costPrice = CostPrice(
    code: '',
    name: '',
    costs: [],
  );
  Checkout checkout = Checkout(
    paymentUrl: '',
  );

  String? provinceOriginId;
  String? provinceDestinationId;
  String? originId;
  String? destinationId;
  String? courier;
  int? cost;

  setOriginProvince(String? v) {
    provinceOriginId = null;
    provinceOriginId = v;
  }

  setDestinationProvince(String? v) {
    provinceDestinationId = null;
    provinceDestinationId = v;
  }

  setOrigin(String? v) {
    originId = null;
    originId = v;
  }

  setDestination(String? v) {
    destinationId = null;
    destinationId = v;
  }

  setCourier(String v) {
    courier = null;
    courier = v;
  }

  setCost(int v) {
    cost = null;
    cost = v;
    notifyListeners();
  }

  getOriginProvince() async {
    loading = true;
    originProvince = (await PlaceService().getProvince());
    loading = false;
    notifyListeners();
  }

  getDestinationProvince() async {
    loading = true;
    destinationProvince = (await PlaceService().getProvince());
    loading = false;
    notifyListeners();
  }

  getOriginCity(int provinceId) async {
    loading = true;
    originCity = (await PlaceService().getCity(provinceId));
    loading = false;
    notifyListeners();
  }

  getDestinationCity(int provinceId) async {
    loading = true;
    destinationCity = (await PlaceService().getCity(provinceId));
    loading = false;
    notifyListeners();
  }

  getCost({
    required int originId,
    required int destinationId,
    required int weight,
    required String courier,
  }) async {
    loading = true;
    costPrice = await PlaceService().getCost(
      originId: originId,
      destinationId: destinationId,
      weight: weight,
      courier: courier,
    );

    loading = false;
    notifyListeners();
  }

  Future<Checkout> checkoutToys({
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
    loading = true;
    checkout = await CheckoutService().checkout(
      customerId: customerId,
      name: name,
      alamat: alamat,
      kodePos: kodePos,
      noTelp: noTelp,
      ongkir: ongkir,
      pajak: pajak,
      transaksiTotal: transaksiTotal,
      transaksiStatus: transaksiStatus,
      productId: productId,
      quantity: quantity,
    );
    provinceOriginId = null;
    provinceDestinationId = null;
    originId = null;
    destinationId = null;
    courier = null;
    cost = null;
    costPrice = CostPrice(
      code: '',
      name: '',
      costs: [],
    );
    loading = false;
    notifyListeners();
    return checkout;
  }
}
