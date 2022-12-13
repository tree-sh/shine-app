
import 'package:flutter/material.dart';
import 'package:shine_app/screens/product_display/product_description.dart';

import '../../models/product.dart';

class ProductDisplay extends StatefulWidget {
  final Product product;
  const ProductDisplay(this.product);

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back)
          )
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.loose,
        children: [
          Image.asset(
            widget.product.image, 
            height: height * 0.75,
            fit: BoxFit.fill
          ),
          ProductDescription(widget.product)
        ]
      )
    );
  }
}