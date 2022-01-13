import 'package:flutter/material.dart';
import 'package:myapp/providers/orders.dart';
import 'package:myapp/screens/Cart_Screen.dart';
import 'package:myapp/screens/edit_product_scree.dart';
import 'package:myapp/screens/product_detail_screen.dart';
import 'package:myapp/screens/products_overview_screen.dart';
import 'package:myapp/screens/user_products.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato",
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontSize: 20, fontFamily: 'Anton', color: Colors.white),
                body1: TextStyle(fontFamily: "Lato"),
                body2: TextStyle(fontFamily: "Lato", color: Colors.white))),
        // home: ProductsOverviewScreen(),
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          '/product_detail_screen': (ctx) => ProductDetailScreen(),
          '/cart_screen': (ctx) => CartScreen(),
          '/orders_screen': (ctx) => OrdersScreen(),
          '/user_products': (ctx) => UserProductScreen(),
          '/edit_product':(ctx)=>EditProductScreen(),
        },
      ),
    );
  }
}
