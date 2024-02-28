import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tezda_assignment/screens/favorite_screen.dart';

import '../models/products.dart';
import 'package:http/http.dart' as http;

import '../provider/fav_provider.dart';
import 'ProductDetailScreen.dart';
class ProductListingScreen extends StatefulWidget {
  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response =
    await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final words = provider.words;

    debugPrint("the fav list is ${words}");

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoriteScreen(),
            ),
          );        }, icon: Icon(Icons.shopping_bag))],
        centerTitle: true,
        title: Text('Product Listing'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          debugPrint("snapshot ${snapshot.data}");
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final id=snapshot.data![index].title;
                return ListTile(
                  trailing: IconButton(
                    onPressed: () {
                      provider.toggleFavorite(snapshot.data![index]);
                    },
                    icon: provider.isExist(id)
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border),
                  ),
                  title: Text(snapshot.data![index].title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  subtitle: Text('\$${snapshot.data![index].price.toString()}',style: TextStyle(color: Colors.blue),),
                  leading: Hero(
                    tag: snapshot.data![index].id,
                    child: Image.network(
                      snapshot.data![index].image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
