import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    // final loadedProduct = Provider.of<Products>(
    //         context) // we can use provider here because its parent is MyApp in main.dart where we have already made connections with Provider
    //     .items
    //     .firstWhere((element) => element.id == productId);
    //OR
    final loadedProduct = Provider.of<Products>(context).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        //for animation
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true, //appbar should be visible after scroll
            flexibleSpace: FlexibleSpaceBar(
                title: Container(
                    width: 130, height: 30, child: Text(loadedProduct.title)),
                background: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  child: Hero(
                    tag: loadedProduct.id,
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      child: Image.network(loadedProduct.imageUrl,
                          fit: BoxFit.cover),
                    ),
                  ), //this is to be displayed when expanded
                )), // what shud be inside appbar
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                '\u{20B9}${loadedProduct.price}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: double.infinity,
                child: Text(
                  '''Lorem ipsum dolor sit amet consectetu eius laborum atque officia. Minus nulla eveniet asperiores facilis amet perferendis, voluptates saepe harum magni at, ad quos cumque eius praesentium soluta ducimus hic provident commodi neque odit maiores necessitatibus, excepturi eos nisi. Quam ''',
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 500, // to make it scrollable to see animation
              ),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          loadedProduct.isFavorite ? Icons.star : Icons.star_border_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          loadedProduct.toggleFavoriteStatus();
          setState(() {
            print("hellll");
          });
        },
      ),
    );
  }
}
