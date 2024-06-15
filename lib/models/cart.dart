import 'package:java_toys/models/models.dart';

class Cart {
  final Toys toys;
  int amount;

  Cart({
    required this.toys,
    this.amount = 0,
  });
}
