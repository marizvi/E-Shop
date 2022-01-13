import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<Products>(context);
    return Dismissible(
      background: Container(
        padding: EdgeInsets.only(right: 15),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      confirmDismiss: (direction) {
        return showDialog(
            //show dialogue itself returns a future
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(
                    'Are You Sure?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold),
                  ),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('No')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Yes')),
                  ],
                ));
      },
      onDismissed: (direction) {
        prod.deleteProduct(id);
      },
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage:
              NetworkImage(imageUrl), //here Image.network(url) won't work
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/edit_product', arguments: id);
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                onPressed: () {
                  prod.deleteProduct(id);
                },
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
