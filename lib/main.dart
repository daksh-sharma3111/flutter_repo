import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tezda_assignment/provider/fav_provider.dart';
import 'dart:convert';

import 'package:tezda_assignment/screens/product_listing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child:  MaterialApp(
        home: ProductListingScreen(),
      ),
    );
  }
}



