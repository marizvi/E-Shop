import 'package:flutter/material.dart';
import '../providers/orders.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderElement extends StatefulWidget {
  final OrderItem order;
  OrderElement(this.order);

  @override
  _OrderElementState createState() => _OrderElementState();
}

class _OrderElementState extends State<OrderElement> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                  DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime)),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                padding: EdgeInsets.all(10),
                height: min(widget.order.products.length * 20.0 + 40, 180.0),
                child: ListView.builder(
                    itemCount: widget.order.products.length,
                    itemBuilder: (ctx, i) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.order.products[i].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.order.products[i].quantity} x ${widget.order.products[i].price}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        )),
              )
          ],
        ));
  }
}
