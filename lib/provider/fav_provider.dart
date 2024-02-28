import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezda_assignment/models/products.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Product> _words = [];
  List<Product> get words => _words;

  void toggleFavorite(Product id) {
    final isExist = _words.contains(id);
    if (isExist) {
      _words.remove(id);
    } else {
      _words.add(id);
    }
    notifyListeners();
  }

  bool isExist(String word) {
    final isExist = _words.contains(word);
    debugPrint("words is ${isExist}");
    return isExist;
  }

  void clearFavorite() {
    _words = [];
    notifyListeners();
  }

  static FavoriteProvider of(
      BuildContext context, {
        bool listen = true,
      }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
