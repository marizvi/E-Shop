import 'package:flutter/material.dart';
import '../providers/products.dart';
import './product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    //since inside this build method we are using provider method
    //therefore only this build method will rebuilt and not the whole app
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          //whenever creating nested notifier it is better to use with .value() as it is effecient
          //without .value it will also work but still for effeciency purpose try to use .value in nested notifier
          value: products[i],
          child: ProductItem()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //In this we can define number columns we want manually
        // SliverGridDelegateWithMaxCrossAxisCount(//this will create number of columns on the basis of device size
        crossAxisCount: 2, // amount of columns
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10, // spacing between columns
        mainAxisSpacing: 10,
      ),
    );
  }
}
