import 'package:flutter/material.dart';
import 'package:myapp/providers/product.dart';
import 'package:myapp/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  void selection(BuildContext ctx, String id) {
    Navigator.of(ctx).pushNamed(
      '/product_detail_screen', arguments: id,
      //through id we can fetch other details later
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    // attention: here we have used <Product> and not <Products>
    //parent of product_item is products_grid and there we have initialised a new Notifier
    // so now it won't look for further parent notifiers it will stop there only,
    //and in product_grid class we have specified notifier as products[i] so we will be accessing particular
    //product at a time.
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            // because Image do not have onTap Property
            onTap: () => selection(context, product.id),
            child: Hero(
              tag: product.id, // this tag should be unique per image
              child: FadeInImage(
                placeholder: AssetImage('assets/images/place.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            )),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              product.toggleFavoriteStatus();
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              print(product.id);
              Scaffold.of(context)
                  .hideCurrentSnackBar(); //will hide if there already exist some snackbar
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Added items to cart",
                ),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              )); //will reach out to nearest scaffold widget (i.e of product_overview_screen)
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
