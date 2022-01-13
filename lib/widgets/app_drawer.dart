import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hellloo!!!!!"),
            automaticallyImplyLeading: false,
          ),
          Divider(), // will add nice horizontal line
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Orders',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/orders_screen');
            },
          ),
          Divider(), // will add nice horizontal line
          ListTile(
            leading: Icon(Icons.edit),
            title:
                Text('Manage Products', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/user_products');
            },
          ),
        ],
      ),
    );
  }
}
