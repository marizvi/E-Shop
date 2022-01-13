import 'package:flutter/material.dart';
import '../widgets/producs_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;

  void selectPage(BuildContext ctx) {
    Navigator.of(context).pushNamed('/cart_screen');
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    //not using provider here because if we make changes in Products classes
    // then whole app will get affected as suppose if at another screen we want to display
    //all products but if filter has been applied to Products class then we can't display
    //all memebers at any screen of our page
    //We have still used this provider in branch named appwidestate just to see how it is implemented
    //, go there and have a look at it
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: [
            PopupMenuButton(
              onSelected: (selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    print(selectedValue);
                    _showOnlyFavorite = true;
                  } else {
                    _showOnlyFavorite = false;
                  }
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: FilterOptions.All,
                )
              ],
              icon: Icon(Icons.more_vert),
            ),
            Badge(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => selectPage(context),
                ),
                value: cart.itemCount.toString(),
                color: Colors.red),
          ],
        ),
        drawer: AppDrawer(),
        body: ProductsGrid(_showOnlyFavorite));
  }
}
