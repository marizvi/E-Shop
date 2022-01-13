import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/providers/product.dart';
import 'package:myapp/widgets/producs_grid.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageFocus = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  final _imageUrlController = TextEditingController();

  void updateImage() {
    if (!_imageFocus.hasFocus) {
      if (!_imageUrlController.text.isEmpty &&
          (!_imageUrlController.text.startsWith('http') &&
                  !_imageUrlController.text.startsWith('https') ||
              !_imageUrlController.text.endsWith('.png') &&
                  !_imageUrlController.text.endsWith('.jpg') &&
                  !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _imageFocus.addListener((updateImage));
  }

  var isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  void didChangeDependencies() {
    //didChangeDepen runs multiple times, whereas initState only runs for the first time.
    // didChangeDepend runs before build is executed
    if (isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productId as String);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl':
              '', // because we cannot set initial values to a TextFormField if we have controller as well
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // _imageFocus = FocusNode();

    void dispose() {
      //good practice to dispose focus node after use to prevent memory leak
      _imageFocus.removeListener((updateImage));
      _imageFocus.dispose();
      priceFocusNode.dispose();
      _descFocusNode.dispose();
      _imageUrlController.dispose();
      super.dispose();
    }

    void _saveForm() {
      final isValid = _form.currentState?.validate();
      if (isValid == false) return;

      _form.currentState?.save();

      if (_editedProduct.id != '') {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
        print(_editedProduct.id);
      } else {
        Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      }
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _initValues['title'] as String,
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction
                      .next, //will decide the bottom right most key of our keyboard.
                  onFieldSubmitted: (_) {
                    //will be invoked when bottom right key of keyboard is pressed
                    FocusScope.of(context).requestFocus(priceFocusNode);
                  },
                  validator: (value) {
                    // return null; // means everything is perfectno error
                    if (value!.isEmpty) {
                      return 'Please provide the Title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: value as String,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  }, //value will store the text entered by user
                ),
                TextFormField(
                  initialValue: _initValues['price'] as String,
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  //since price is in numbers so we want to display number keyboard
                  keyboardType: TextInputType.number,
                  focusNode: priceFocusNode, //to make .next work
                  onFieldSubmitted: (_) {
                    //will be invoked when bottom right key of keyboard is pressed
                    FocusScope.of(context).requestFocus(_descFocusNode);
                  },
                  validator: (value) {
                    // return null; // means everything is perfectno error
                    if (value!.isEmpty) {
                      return 'Please enter a Price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please Enter a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please Enter a number greater than 0';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value as String),
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'] as String,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType
                      .multiline, //multiline keyboard itself gives enter button at bottom right of keyboard
                  focusNode: _descFocusNode,

                  validator: (value) {
                    // return null; // means everything is perfectno error
                    if (value!.isEmpty) {
                      return 'Please provide the description';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters long';
                    }
                    return null;
                  },

                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: value as String,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter Url')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                              ),
                              fit: BoxFit.contain,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initValues['imageUrl'],
                        decoration: InputDecoration(labelText: 'Image Url'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller:
                            _imageUrlController, //to store url into variable _imageUrlController
                        focusNode: _imageFocus,
                        validator: (value) {
                          // return null; // means everything is perfectno error
                          if (value!.isEmpty) {
                            return 'Please provide Image Url here';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return "please Enter a valid url";
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg'))
                            return 'Please enter a image valid url';
                          return null;
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onFieldSubmitted: (_) {
                          //will be accessed when we press done button bottom right keyboard
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value as String);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
