
import 'package:flutter/material.dart';

import 'models/product.dart';

class ProductDisplay extends StatefulWidget {
  final Product product;
  const ProductDisplay(this.product);

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {

    bool isFavorite = false;
    bool isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

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
                  height: _height * 0.75,
                  fit: BoxFit.fill
                ),
                SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: _height * 0.45),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                          ),
                          width: _width * 0.95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: _width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.product.name,
                                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                                    ),
                                    Row(children: [
                                      GestureDetector(
                                        onTap: (){
                                          setState(() { isFavorite = !isFavorite; });
                                        },
                                        child: isFavorite ? Icon(Icons.favorite, size: 32, color: Colors.red) :  Icon(Icons.favorite_outline, size: 32)
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: (){
                                          setState((){ isAddedToCart = !isAddedToCart; }); 
                                        },
                                        child: isAddedToCart ? Icon(Icons.add_shopping_cart, size: 32, color: Colors.green) : Icon(Icons.add_shopping_cart, size: 32)
                                      ),
                                    ],),
                                  ],
                                )
                              ),
                              SizedBox(height: 5, width: 10),
                              Container(
                                width: _width,
                                child: Text(
                                  "₱${widget.product.price}",
                                  style: TextStyle(fontSize: 21, color: Colors.orange, fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(height: 20, width: 10),
                              Container(
                                width: _width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sizes:'),
                                    Row(
                                      children: const [
                                        Chip(
                                          label: Text('XS'),
                                        ),
                                        Chip(
                                          label: Text('S'),
                                        ),
                                        Chip(
                                          label: Text('M'),
                                        ),
                                        Chip(
                                          label: Text('L'),
                                        ),
                                        Chip(
                                          label: Text('XL'),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ),
                            ],
                          )
                        )
                      ],
                    )
                ),
              ]
            ),
      //)
    );
  }
}