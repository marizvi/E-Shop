import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    // by tapping once it will go true and tapping again it will go false and so on
    notifyListeners(); //necessary because it works like setState(), without it we can't reflect change on screen,
    // that is then it won't rerun the widget from where it is called
  }
}
