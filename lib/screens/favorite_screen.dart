import 'package:flutter/material.dart';

import '../provider/fav_provider.dart';
import 'ProductDetailScreen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final words = provider.words;

    return  Scaffold(
      appBar: AppBar(title: const Text("ListView.builder")),
      body: ListView.builder(
          itemCount: words.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              trailing: IconButton(
                onPressed: () {
                  // provider.toggleFavorite(snapshot.data![index]);
                },
                icon:const Icon(Icons.favorite, color: Colors.red)

              ),
              title: Text(words![index].title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              subtitle: Text('\$${words![index].price.toString()}',style: TextStyle(color: Colors.blue),),
              leading: Hero(
                tag: words![index].id,
                child: Image.network(
                  words![index].image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: words![index]),
                  ),
                );
              },
            );
          }),
    );;
  }
}
